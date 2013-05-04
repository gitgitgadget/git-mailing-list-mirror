From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Pitfalls in auto-fast-forwarding heads that are not checked out?
Date: Sat, 4 May 2013 11:51:46 -0700
Message-ID: <20130504185146.GD25863@elie.Belkin>
References: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
 <5184B9F9.2010708@kdbg.org>
 <CACPiFCK=8KFX++Bg+LhymorSMnWgrj5Js+-f=UYyZnNY=n9WiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 20:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYhYr-0005Ib-Hx
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 20:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762033Ab3EDSvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 14:51:52 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42356 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761937Ab3EDSvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 14:51:52 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so1389436pbc.9
        for <git@vger.kernel.org>; Sat, 04 May 2013 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xJajLKz+8WiHak79DlOyiS2FPBwbchhdUfk9lme7CBU=;
        b=aV+IKHuu8ActkXrUcJ+lvrVrYPiyK6D1nB+FLW1QL83/Ppzjdr6yqrAPHWSb/1qQBv
         e1utVx3kx2heacBB7QfMHzysi78w28LuwXeH4RuPtGXhH3d7mWgeDotJtIg45J3BJAay
         BHV8/4ke73w1zIE844mvSOS1ojh+MUS7d5yQRDVf6N6MF480H+SeRfYsEqxLed9Ax3RN
         sJYJuvqhy2CFCDOsC8u1xtMW1Lu/1ggTKeY5sfY1XMSWBicaJ+a0jW+L8z3rFyIDHwlv
         4hR4dZ3DC8nUBe/ps9oxDskaV9boz+M+qsK9YsOOcp8z9q0P+DUI3TVlFwWukdxFxU1q
         3nhg==
X-Received: by 10.68.176.37 with SMTP id cf5mr19082521pbc.173.1367693511590;
        Sat, 04 May 2013 11:51:51 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id qb1sm16699778pbb.33.2013.05.04.11.51.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 11:51:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACPiFCK=8KFX++Bg+LhymorSMnWgrj5Js+-f=UYyZnNY=n9WiA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223371>

Martin Langhoff wrote:
> On Sat, May 4, 2013 at 3:34 AM, Johannes Sixt <j6t@kdbg.org> wrote:

>> Since git 1.8.0 you can express this check as
>>
>>     if git merge-base --is-ancestor $production_sha1 refs/heads/master
>
> Ah, that's great! Unfortunate it's not there in earlier / more widely
> used releases of git.

Another trick is to use "git push":

	git push . $production_sha1:refs/heads/master

This advances the "master" branch if

 (1) it is not the current branch, and
 (2) that update is a fast-forward

It can be convenient sometimes.

Hope that helps,
Jonathan
