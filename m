From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCHv2 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Thu, 8 Sep 2011 05:08:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109080458500.12564@debian>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vaaah6zx0.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1109062136350.12564@debian> <7vzkifzol6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:08:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1aaw-0005dc-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422Ab1IHJIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:08:20 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:59313 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932278Ab1IHJIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 05:08:19 -0400
Received: by vws10 with SMTP id 10so868489vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=DcUvO6CLtum9QdfGQyrB27Vibyclo3/UZ28jgLsOlgA=;
        b=pJ9CpwRiUrGjbKRODDLmNLRaXGy4xZ/x3Ly+XdJtLKGaazjU/BkCjMh75PTRU4Xrr6
         eb0+/SGNEQ+Auw3tc7tEmGZQuzDUOm405fq3sXFy8ZDmYjz0/wgxJBo4ty5vF5RR0TIY
         fTIaw0gDJwA1dJvFAehblh30Ps45r2XPUqdxg=
Received: by 10.52.97.102 with SMTP id dz6mr82713vdb.294.1315472899135;
        Thu, 08 Sep 2011 02:08:19 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id bi11sm2198197vdb.13.2011.09.08.02.08.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 02:08:18 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vzkifzol6.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180954>

On Wed, 7 Sep 2011, Junio C Hamano wrote:

> Later in the same mv() function, the other one renames refs/remotes/$OLD/
> to refs/remotes/$NEW/, even when you did not find any fetch refspec that
> stores under "refs/remotes/$OLD/<anything>" in the earlier logic.

Ah, of course. Sorry for being slow and thanks for the explanation. So
if there are two configured refspecs with RHSs "refs/remotes/$OLD/foo"
and "refs/remotes/$OLD/bar/*", we should remember that we updated
those and only update refs that match the same patterns. I will see
what I can do and will hopefully soon get back with a "patch 4/2".


Martin
