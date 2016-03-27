From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a
 file
Date: Sun, 27 Mar 2016 13:27:41 -0400
Message-ID: <20160327172741.GA4005@flurp.local>
References: <CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
 <1459085245-20658-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Mar 27 19:27:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akETi-0005oB-3e
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 19:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbcC0R1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 13:27:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35962 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcC0R1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 13:27:48 -0400
Received: by mail-io0-f194.google.com with SMTP id e3so5671549ioa.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d6vcA7/5dVWv4JQZU25RK1ITItqBgG2CdYnMFIatwj0=;
        b=OTiOlvdBxxxWqztboWUkiUs9DxcIxkb6HCnZWpnOLMm1UR6lH634B4OSDfr5Ipy542
         9j9POXXUHxAK+AqEH/P6NW9wcUl2Ipjpbi4DeQ5uy/wU25NQQXP4oFxdhHvZzpMb/Bgd
         RbgPNXmHSkOMMo3Ij+ccS9DjhL0NR0DH6iB4uaDiIoz5DOhSZ/VpHGs+kDPr4rdysdbD
         b3FGVA0X0flESXjyswEGjKV0Derw2GoTmo0OSs6RN1y78TVzC7OsnKDBnoeEEe0GUM6E
         /ai21lqjCrNhx2fbs7h+E/O7gS/2rWIgzHfkImPQMUUDD+Ismr1dO4qJctsddYzRMXwJ
         tiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d6vcA7/5dVWv4JQZU25RK1ITItqBgG2CdYnMFIatwj0=;
        b=FkgqaD68GdTr6DAohkY4WA87VXCX5k5FwQBBv9Rj06V776p4vY3OO144tnJ739TmdB
         R9b3VKeG3Lkv1VKkV61BK9wHCVrmXnooDCvcCiZd+DeJ4tkjlP55XiR9n9x42pG+c52l
         9AiAJrw36ormH4PdfpjmAvwwhrLWaG/lCE4NY7P3NgUUJWguZj0PLtK0iD8QlUjDoegg
         3X1TO1I2oA3sSuATWs08Fb2ZN3Jy/GFZZGKsxwrVJzm5L13Z3vV+Bc4R/+bitOu3aQxu
         Q6dOMQFlalxqN2mecnU5eBsrV1fSYoy0ZUSKG10EShiC5CREGG+ghisCGsKe3tt92a4y
         VQUg==
X-Gm-Message-State: AD7BkJLZ8EiyfxTFGu7NmUU9f3aygdaWZ8YQwfgDYUIxo9On+4q3srEijC+tLzpgmQryKQ==
X-Received: by 10.107.2.148 with SMTP id 142mr21547416ioc.128.1459099667891;
        Sun, 27 Mar 2016 10:27:47 -0700 (PDT)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id 99sm8885501ior.16.2016.03.27.10.27.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2016 10:27:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459085245-20658-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290018>

On Sun, Mar 27, 2016 at 03:27:25PM +0200, SZEDER G=E1bor wrote:
> > > +! test -s out ||
> > > +rm out &&
> >=20
> > Why not just "rm -f out"? But, more importantly, why do you need to
> > remove the file at all? The '>' redirection operator (used below) w=
ill
> > overwrite the file, so no need to remove it beforehand.
> >=20
> > > +! grep '^diff --git' "$1" ||
> > > +grep '^diff --git' "$1" >out
> >=20
> > Um, what? Why two greps? I would have expected you to simply re-use
> > the existing grep (minus the backslash) while adding the redirectio=
n:
> >=20
> >     -exec grep '^diff --git' "\$1"
> >     +exec grep '^diff --git' "$1" >out
> >=20
> > Am I missing something obvious?
>=20
> In the non-verbose cases no diff is included in the commit message
> template, thus the pattern looking for it doesn't match anything, gre=
p
> exits with error code, which in turn becomes the editor's exit
> code, ultimately making 'git commit' fail.  Not good.
>=20
> I suppose both the explicit 'rm out' and the '! grep ... || ...' is
> there to deal with this situation.

Sure, I understand that, but that's not what I meant. What I wanted
to know was why Pranit didn't just use the simpler:

    grep '^diff --git' "$1" >out
    exit 0

and then, in tests:

    test_line_count =3D n out

where 'n' is 0, 1, or 2 as expected by the test.

Unfortunately, you missed the rest of the discussion since Pranit
(presumably) accidentally dropped the mailing list when he replied,
and I didn't notice the omission when replying to him with the above
suggestion, which would have saved you the bother of going through
this, as well.

> I think we could:
>=20
>   - either revive the idea of two editor scripts: one for the
>     non-verbose case checking with '! grep ...' that there are no
>     diffs in the commit message template, and one for all verbose
>     cases storing those diff lines in a file to be counted later.
>=20
>   - or use a fake editor that merely copies the whole commit message
>     template to a separate file, and we do the greping in the tests
>     themselves as well.
>=20
>   - or simply stick a 'true' at the end of the editor script ensuring
>     that it returns success even when grep can't find the pattern, bu=
t
>     I kind of feel ashamed of myself for even mentioning this
>     possibility ;)
>=20
> I would go for the second possibility, but don't feel strong about it=
=2E

Your #3 is effectively what I had suggested, as well (which is
reproduced above). I had already made this change locally along with
some other changes I suggested in other responses, and those changes
look like this (atop Pranit's two patches), which isn't too bad:

--- 8< ---
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 569fd8b..ea26b57 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -4,12 +4,9 @@ test_description=3D'verbose commit template'
 . ./test-lib.sh
=20
 write_script "check-for-diff" <<'EOF' &&
-! test -s out ||
-rm out &&
-! grep '^diff --git' "$1" ||
 grep '^diff --git' "$1" >out
+exit 0
 EOF
-chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
=20
 cat >message <<'EOF'
@@ -101,11 +98,12 @@ test_expect_success 'verbose diff is stripped out =
with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
=20
+test_expect_success 'setup -v -v' '
+	echo dirty >file
+'
+
 test_expect_success 'commit.verbose true and --verbose omitted' '
-	echo content >file2 &&
-	echo content >>file &&
-	git add file2 &&
-	git -c commit.verbose=3Dtrue commit -F message &&
+	git -c commit.verbose=3Dtrue commit --amend &&
 	test_line_count =3D 1 out
 '
=20
@@ -121,7 +119,7 @@ test_expect_success 'commit.verbose true and -v -v'=
 '
=20
 test_expect_success 'commit.verbose true and --no-verbose' '
 	git -c commit.verbose=3Dtrue commit --amend --no-verbose &&
-	! test -s out
+	test_line_count =3D 0 out
 '
=20
 test_expect_success 'commit.verbose false and --verbose' '
@@ -136,12 +134,12 @@ test_expect_success 'commit.verbose false and -v =
-v' '
=20
 test_expect_success 'commit.verbose false and --verbose omitted' '
 	git -c commit.verbose=3Dfalse commit --amend &&
-	! test -s out
+	test_line_count =3D 0 out
 '
=20
 test_expect_success 'commit.verbose false and --no-verbose' '
 	git -c commit.verbose=3Dfalse commit --amend --no-verbose &&
-	! test -s out
+	test_line_count =3D 0 out
 '
=20
 test_expect_success 'status ignores commit.verbose=3Dtrue' '
--=20
