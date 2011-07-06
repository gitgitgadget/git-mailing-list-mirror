From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 07/31] rebase: stricter check of standalone sub
 command
Date: Tue, 5 Jul 2011 21:48:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1107052131410.7799@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-8-git-send-email-martin.von.zweigbergk@gmail.com> <20110701035503.GA9818@elie>
 <alpine.DEB.2.00.1107010833310.580@debian> <20110701222919.GA11258@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 03:49:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeHEs-0005uQ-KW
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 03:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab1GFBs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 21:48:26 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44538 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab1GFBsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 21:48:25 -0400
Received: by vxb39 with SMTP id 39so4601400vxb.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=g6a2lHYGnwMMaOAXvXhvtJKkSfEMBBfFqMUUd04oppU=;
        b=CcMdmqTNWuQnVRUjGcEw+/fx71wMd8ODSGGPXHjNl5CW89RPxMBHctDJ4PwyJlGxr7
         X9zs64wXrX0QJfPBYJ2vA1pK07kCl+Ki9jUSQdiHJ1EYsS9V1O5ysjYx6vbWzS5s2TdQ
         r819TrlbPspO61UK/yVR9nlm9BzAw6sJ6xers=
Received: by 10.52.96.1 with SMTP id do1mr6551517vdb.53.1309916902993;
        Tue, 05 Jul 2011 18:48:22 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id b9sm2678099vdk.25.2011.07.05.18.48.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 18:48:21 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <20110701222919.GA11258@elie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176634>

On Fri, 1 Jul 2011, Jonathan Nieder wrote:

> Martin von Zweigbergk wrote:
> 
> > Is the below patch what you had in mind?
> 
> No, but it looks good to me ("rebase usage: subcommands can not be
> combined with -i").
> 
> >> Ah, it seems you already wrote a patch at [1].  The commit message
> >> says it fails for "-i --continue" but I don't any code doing that;
> >> what am I missing?
> >
> > That patch was never accepted, but 95135b0 (rebase: stricter check of
> > standalone sub command, 2011-02-06) was.
> >
> >> [1] http://thread.gmane.org/gmane.comp.version-control.git/164241/focus=166684
> 
> I'll play around with [1] and try to revive it.  Thanks.

I'm not sure I understand what you want to achieve. Do you want to
revive [1] but also make it allow "-i --continue"? If so, is one of
the following your goal when used with "--continue"?

 1. Always accept "-i", but ignore it (the behavior before 1.7.6)

 2. Only accept "-i" if the rebase was already interactive

 3. Always accept "-i" and transform a non-interactive rebase to an
 interative one

Just curious. Thanks for working on it.


Martin
