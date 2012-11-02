From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Fri, 2 Nov 2012 07:55:55 -0700
Message-ID: <20121102145555.GA14774@elie.Belkin>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
 <20121102131255.GB2598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIfV-0005Qh-8r
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab2KBO4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:56:07 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41736 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab2KBO4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 10:56:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2511253pad.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=moYGQOAplAwJqoh5VYYOE79e+M2KFdutRJ+QeJljmHo=;
        b=u5CoxSaM+iqSvn2gkk1qrSRb3l15aOdFK4ZgH5TlpL4DN/VddJgKHghzThpGY0nVD8
         3ojjzSgtMCXm2zeqR4SHSKmvko5t9xv3Pfyk5E+NkI0/3/Yosm5qsb/zIK6DZQjYUcvQ
         sIMPuiSvHoJVQiZ16vbCYHR3Cx1Ng/jW2GpqFlCYY7X5bNCePe8rNtZYeJPdmd379x6+
         4WhzlNKJ20cygekGrnUSNo89iyW49NvAneVJB93SxW+P7B72I9pEPBKQUWzM4LoIjLIW
         z8Wq5irkD4G9lArpNr/GeJ8aqgm7/z68KiMhNXQXl4qasV6dbfvtfZFmLwpHfhFehdSy
         7bFw==
Received: by 10.66.76.98 with SMTP id j2mr5899860paw.65.1351868163947;
        Fri, 02 Nov 2012 07:56:03 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o10sm5836230paz.37.2012.11.02.07.56.01
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 07:56:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121102131255.GB2598@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208943>

Jeff King wrote:

> If so, then this series isn't regressing behavior; the only downside is
> that it's an incomplete fix. In theory this could get in the way of the
> full fix later on, but given the commit messages and the archive of this
> discussion, it would be simple enough to revert it later in favor of a
> more full fix. Is that accurate?
>
> Sorry if I am belaboring the discussion. I just want to make sure I
> understand the situation before deciding what to do with the topic. It
> sounds like the consensus at this point is "not perfect, but good enough
> to make forward progress".

Patch 1, 2, and 4 are good modulo their descriptions.  They should
work fine without patch 3.

Patch 3 is a regression in comprehensibility.  I think we can do
better.  Maybe all it would take is a less confusing description, and
tweaks to the code (to loop over revs->cmdline instead of
revs->pending) could come on top.
