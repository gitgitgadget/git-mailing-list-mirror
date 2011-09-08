From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCHv2 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Wed, 7 Sep 2011 21:40:57 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109062136350.12564@debian>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vaaah6zx0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 03:41:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Tc4-0003OR-JV
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 03:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854Ab1IHBlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 21:41:01 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41122 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab1IHBlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 21:41:01 -0400
Received: by vxj15 with SMTP id 15so244770vxj.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=mBz7QJLEKz9GpHRs1zXg4v60yWRTI8gcgK1p60cwzng=;
        b=nhlVWblCxIlyVM0VSglZg5X1ygnFp4NtP/xkOHo+0Yfgp1WRyJ559JBzSNQ7r6j8Sg
         IKbLobRkUWnlptrWj1825KsdQswOFRcbSuwhYn/560klzalRNQwAuhzRxd5ZbmXDzXUT
         Qnhd1tuiddJZ8EzBw+MmVMjikBfllDRUEbmqY=
Received: by 10.52.68.177 with SMTP id x17mr99850vdt.148.1315446059769;
        Wed, 07 Sep 2011 18:40:59 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id ch2sm1550522vdc.19.2011.09.07.18.40.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Sep 2011 18:40:58 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vaaah6zx0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180932>

On Tue, 6 Sep 2011, Junio C Hamano wrote:

> It is somewhat bothering that we do not say "we didn't do any magic" here
> when we did not move the tracking branch specifications, but that is not a
> new problem, so I am OK with this change.

If I understand you correctly, this is the same concern that Jeff had
and that I tried to address in patch 3/2.

> I however suspect that you would want to keep the record of what you
> changed here, so that the renaming of actual refs done in [PATCH 2/2] is
> limited to those that you updated the specifications for, no?

Sorry, I don't think I really understand. Are you worried that we
might rename too many refs, i.e. unrelated ones? We match exactly the
same pattern both when updating refspecs and when renaming refs. Of
course, we can never be certain that a ref "refs/remotes/origin/foo"
is really related to the remote called "origin". The user could have
simply created the ref manually. Is that what you are getting at?


Martin
