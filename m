From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: use case: keep the output of a markup (TeX) file under revision control
Date: Thu, 17 Feb 2011 04:19:12 -0800 (PST)
Message-ID: <m362si97n4.fsf@localhost.localdomain>
References: <1297939020.3959.12.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Paul Menzel <paulepanter@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2ro-0006nr-TN
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab1BQMVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 07:21:49 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab1BQMVr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 07:21:47 -0500
Received: by fxm20 with SMTP id 20so2522283fxm.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 04:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=fPDw3IsrYW1Y/Vzi2DJulS1KTkGh3NSrVBLMYUYtsUA=;
        b=ry7vN4XvGnTrsI3nj60ZJ1CselIvq3fDFQBqZD0bsE/4Lq36btKF1By8lM2qPSd+EL
         NUbQDtyXxU2DH5rbwwaG/6gH8aTolIYHIAXR8yhFj+Tg2VsZnb9wUHoNXx6+uwkYCTEO
         6nZG0t7tbn4xPaSSX2FwVSJ7CWD6c0wnBF2x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=N+3VDiY42qT/stQUJnynqoeQeXRJWkN/xONvFtL3o54Cy5uRkOB02ocRjJq21I+1M3
         L8ejN6P9mq1uUqZcY+EmLcha8qBQRHYluwsQeg4vEB+MvKcPZhtXOVHT8chrcbtkCn2K
         k9Ni+Pd2iEN2HeLcPqXDhB7ro6bGz5+QTSE6c=
Received: by 10.223.98.197 with SMTP id r5mr2265692fan.68.1297945153386;
        Thu, 17 Feb 2011 04:19:13 -0800 (PST)
Received: from localhost.localdomain (abwj70.neoplus.adsl.tpnet.pl [83.8.233.70])
        by mx.google.com with ESMTPS id 11sm396388faw.44.2011.02.17.04.19.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 04:19:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1HCIdZn022914;
	Thu, 17 Feb 2011 13:18:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1HCINhg022910;
	Thu, 17 Feb 2011 13:18:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1297939020.3959.12.camel@mattotaupa>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167074>

Paul Menzel <paulepanter@users.sourceforge.net> writes:

> I have the following use case and need an advise from you professiona=
ls.
>=20
> A friend and I are writing a paper using TeX=B9 and keep the files un=
der
> revision control using Git. This works fine so far. But I want to als=
o
> have the output (PDF) of the markup file under revision control to be
> able to access the PDF files even if for example no TeX installation =
is
> available on a system.
>=20
> The problem now is, since the output is no plain text file, that
> merging/rebasing always shows conflicts which Git, of course, cannot
> solve.
>=20
> Is there a way to set that up so that there are no conflicts? Would a
> pre-commit hook work which generates the PDF file prior to committing=
?
> And if no TeX installation is available it would just ignore the PDF
> files?
>=20
> I could not find anything on the Web because having PDF as search str=
ing
> would just show up how to generate documentation about Git.

As an alternative to Stefan Naewe solution of using separate "orphan"
(unrelated) branch to store PDF files, like Git project does with
generated documentation (manpages in 'man' branch, HTML version in
'html' branch), you can try the following:

1. Mark PDF files as binary, if they are not already considered binary.

2. Create custom merge driver for PDF files, which would compile
   source *.tex file to PDF, provided that TeX is installed, and that
   source file itself is not in merge conflict

3. Creating pre-commit hook would ensure that you have refershed PDF
   files during ordinary commit.  Note that this hook is not always ran
   (you can force running it with --verify option to git-commit).

HTH
--=20
Jakub Narebski
Poland
ShadeHawk on #git
