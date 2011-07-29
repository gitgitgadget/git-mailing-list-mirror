From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 05:57:02 -0700 (PDT)
Message-ID: <m3tya5qm86.fsf@localhost.localdomain>
References: <1311934832699-6632987.post@n2.nabble.com>
	<4E329EDB.6040007@hupie.com>
	<1311940877783-6633274.post@n2.nabble.com>
	<4E32A2D2.9060007@hupie.com>
	<1311941774976-6633332.post@n2.nabble.com>
	<m3y5zhqnlv.fsf@localhost.localdomain>
	<1311943481799-6633412.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: llucianf <llucianf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 14:57:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmmcq-0002oP-M4
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435Ab1G2M5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 08:57:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39206 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab1G2M5E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 08:57:04 -0400
Received: by fxh19 with SMTP id 19so2274786fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=c9ZnQSN1Ww2+3OtXQfGLxoBjpCv3xbIZEknzOhrV5Ek=;
        b=Mm1T1hyKfDcjVPSIrIiJ39K7UyS0shB92L+hwNBfk1yB77Q9CndGCWo8EIZZd3U/G/
         yL6reQ3dV5sRYzLtLrgImkyGik8ICvUUqG8vlt+COd6tcGmDXp1abpBDjt1FXHjAOhik
         IJws73aShN4pQQO1fpDlfCvK675NQxSlG3B/o=
Received: by 10.223.29.133 with SMTP id q5mr841357fac.102.1311944223703;
        Fri, 29 Jul 2011 05:57:03 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id j18sm258131faa.22.2011.07.29.05.57.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 05:57:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6TCuan6010718;
	Fri, 29 Jul 2011 14:56:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6TCuP5V010714;
	Fri, 29 Jul 2011 14:56:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1311943481799-6633412.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178145>

llucianf <llucianf@gmail.com> writes:

> im sure cvs doesnt require you to remove files from repo in order to =
ignore
> them. i used cvs for years and its ingonre policy is simple and effec=
tive.
> you just put the files/patterns into ignore file and things happen ak=
a they
> are ignored.

_Untracked_ files are ignored.  Tracked files are not, even with CVS.

  $ echo file2.txt >>.cvsignore
  $ echo "3 line"  >>file2.txt

Now 'cvs status' shows file as=20

  File: file2.txt         Status: Locally Modified

and 'cvs diff' shows changes.

CVS 1.11.19

[And damn, how hard it was to check this in CVS as compared to
 checking similar things with Git].

> with this very intelligent git this simple thing is not so simple. of=
 course
> there are workarounds (like the template example you gave) but they a=
re
> clumsy.

They are correct and better solutions than ignoring changes.

Ignoring changes to tracked files is much more rare than having broad
ignore file, and tracking some files that match ignore patterns (but
note that you must use "git add --force" to add/track ignored file).

> im just trying to understand why git ignore mechanism cant just read =
the
> .gitignore file and obey to those ignore rules without asking you to =
do
> fancy voodoo operations such removing those files from repo.

Please read carefully: I mentioned 'ASSUME-UNCHANGED' mechanism in
both of my posts, haven't I?

--=20
Jakub Nar=EAbski
