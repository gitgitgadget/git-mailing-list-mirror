From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 05:27:13 -0700 (PDT)
Message-ID: <m3y5zhqnlv.fsf@localhost.localdomain>
References: <1311934832699-6632987.post@n2.nabble.com>
	<4E329EDB.6040007@hupie.com>
	<1311940877783-6633274.post@n2.nabble.com>
	<4E32A2D2.9060007@hupie.com>
	<1311941774976-6633332.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ferry Huberts <mailings@hupie.com>
To: llucianf <llucianf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 14:27:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmm9x-00050t-Ab
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab1G2M1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 08:27:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54555 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab1G2M1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 08:27:15 -0400
Received: by fxh19 with SMTP id 19so2251382fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=LW3QBpC32gGY2iyUIqEXetijEu202BCF07jG/Xmq2oU=;
        b=ueLHU8mSd+VgCvzwgo2eIHb0z1FMKhTUXVuMWnTGEvsG3mkg+Tx4Z4/RfCNGu9VZl7
         i6Wc6uB3dB9eEFp4G7XkarmZoyHu8rVZete8K+ojacExIO1BMUOaR0nJiLMm2EOgWrjE
         3JFyjFuSQ6U8TSbOIha6tpcjDUiNehXiMf40g=
Received: by 10.223.16.210 with SMTP id p18mr1727166faa.71.1311942434748;
        Fri, 29 Jul 2011 05:27:14 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id h9sm1063705faa.39.2011.07.29.05.27.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 05:27:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6TCQkZG010241;
	Fri, 29 Jul 2011 14:26:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6TCQaYD010237;
	Fri, 29 Jul 2011 14:26:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1311941774976-6633332.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178143>

llucianf <llucianf@gmail.com> writes:

> is not a contradiction. i need project files into repo so whenever i =
clone
> the project on diff machine i need them there.
> but during development i dont need them to be 'taken into account' by=
 git.=20

The usual solution is to put _template_ under version control (for
example <projfile>.sample), and have build system create initial
custom version during first build.  Local project file is untracked
and ignored, and project file template is tracked.

> the purpose of this topic is for me to understand why git dont use th=
e
> simple cvs approach on this matter.

Are you sure that is how CVS does it?  Because from what I read in CVS
manual, CVS and Git approach to ignore files are the same wrt. already
tracked files.

> why i cant just enumerate some files into .gitignore file and have gi=
t
> simply ignore them without removing them from repo?

There is assume-unchanged mechanism... which is _explicitely_
mentioned in "Notes" section of gitignore(7) manpage.  RTFM, please.

--=20
Jakub Nar=EAbski
