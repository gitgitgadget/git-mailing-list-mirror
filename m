Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFED33985A
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426651; cv=pass; b=FEwSYlja+6pPkLk9we0xtjkaWtk7/Jt1Qj2cqiMwjXgQ3VzWoOemjxk86hq8LMk9uca5HYjCIj/9wRqX31KfLwO95giXDP1QuxzO7+IWL0SfqIRQ32nkQMVqOFHJU064tIR4uMQJiRxVbCaN3HoyKDeWY+ibHw5uZRi5RVZD3T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426651; c=relaxed/simple;
	bh=e/i5Z5sowFvl5lRNUTq5O3X7Q5jvWT1hCRWMm2lkUQw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcEze8HC0sPRz8IBfHJUrkWVN3omlXZg+ApKmEpdMd9WnYTuF3zEta/8rHjfgVQhRb0bJgIIq8M/XlPfV1OLUQ3+x733VHsin7rsfSSoxAP3VTPh7iA+O3qPL95nKAMNCXO6Xtt+rLZjf2BwS93W1esWX2X7M9gHsa2sCAYz5IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al4Jb8A7; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al4Jb8A7"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6055a0414d7so1055129137.2
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 15:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775426649; cv=none;
        d=google.com; s=arc-20240605;
        b=Hj8pzqcKlU6QRTAUFGa3WICsJGctOGdIeK+DRNE35NSaXnzsABWC23b45TVzQVZ8qr
         qKoDhfoqOwGD/M5HCjgrcblFvK735H3t6ERGKn9ySjELJTYCTGFqClCNhDa6K8BVDOH6
         MxjjGrAcohQnL/drhNO3aDT6WAIsqagQ5988rM2Zfcw034ySzX9oxvbRORFNYKtj+Ng6
         vkwUtVuwPHWyn2OlEaUSOlejm/euhT752EEeIw1E3LnqmL7SdZZc3f/ywtQLmy6CRm1O
         cZ3VbdGA3wuWwFsUwecRkWxocux21PUuDIb70hPtdN2CCpt78PyK6OylFDK/X5sJpZ5X
         GLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jmdFxDxOGl5OOq4iSpyv1uhFqa+FVdAyjqjS7tBqXAE=;
        fh=gbcfBKWZqbW0o4ez5FtWVO4GUBO8tMm9f+h+Y06iQW8=;
        b=ByF9z1nsKWjY5f+/aKkiffff2AhNLSQQmhLluZa6C54KbYHwZYkzU5j4lN7MfiIycM
         ny8TpSxP2a9M0aM39+Tjpr3ywxYB1TvGkYnezwXb8x//niZ47jzQJxa57FWHHruU6Vro
         ngVt6o+mbZuMFVKsXKnnb46B5MBg4FpXf6arygk151LziNx1ESeeDiBHvyZPSSHNbP+C
         D2PbR26r8C6sSDRLIzOPBfkQux9lU9k/fBDgZ7JB6rpYxknQu2m97wy6CpSicckZNwCP
         8IsTIvYZqckiD5fvq+HyndcdjCKv66h0kMCVJbD2Ik6nznb7NLSBqmSzvCzxWkSlvuP3
         UJzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775426649; x=1776031449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmdFxDxOGl5OOq4iSpyv1uhFqa+FVdAyjqjS7tBqXAE=;
        b=al4Jb8A7WM0ZFCxfoSdkDeIOtWM3aRb2pw8aNWgYyfUExA+HDLTiPddFVHghzME02a
         XLPiyzVpMz8CvILj7VkhINpfPNhc9kMt2/s4Dl2x8mGOODFoctJVwh8GdySXGYpvSfL5
         lyRzfjAQwIia3Bc2YQJn5cM5ybUtEmwuej2o7ki2nrlSU20trC4XpLzv1632QTWP79ug
         qYWHcBK7XyPPn8elQ0GhkAmTtcDEuXGTixXRJYkOtojGUeyvFOTY3wc4j8INzllrWTMz
         D2Dm5AN4YNVX6OkJmaBHn3jO8w6zkBfmaMdI3lVR6I/dT6CdQ777CUxuqXpfNLlNAT1O
         p5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775426649; x=1776031449;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmdFxDxOGl5OOq4iSpyv1uhFqa+FVdAyjqjS7tBqXAE=;
        b=ihLVv4RKSRrRIJh6zMy+RDThFW1+48yTgb97uOXx2nj2QD9Z+BDcWGPpnZ4bp3E9bf
         M2G4A/27M7tDryJb6V01l0PXHJTAnH0MRqTVzUmGWGbB7LOj8vJ0z2w3U8rm2qjd54L2
         jtBNZy6bRnrR2MfR/HFS8eBkGr3aXPO+Q8iRH4uLue2syEszppug85tYdwRX9/IBdSUZ
         oFVSYw76uUI5em9j/ocBzfuth3Cv4mQP+BY1mj8glq8/zaRqG53nc+6B+k4mIdcFyRYJ
         gz0PoyeNUeCk5XVyCelPGPRchyxH6a84VvsKGpkMWMx2QueWvK2aOr8Yq8OGLwtckay7
         V6SA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6Yykmpo3tJvxAxZjPC6mmrj7fdzTB9Jj1wibzJohTCqkjroZs48ZS88cxChsgZLnSX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrVFJjZwHu5FwPW8kbt6cEr8xjEMa2lcseGGFPYbbRk4oLhXk
	/jHhHhcWxvh/tBMAOGyYw0JENsmFCFU6XTE/rjHBx4BYg99hNS+D+xVDyK+YO2Fgob169l/n8sp
	aREH+PTCQ6PIxh3IGe051WdL/bSLnzcSPKQ==
X-Gm-Gg: AeBDietsv5sezij5ykS9TQe+9X2Oj9kZ7Et95mMT1KX/hiDx68zmsAzSo+2a0pWUdPT
	QqYoMDXQS9jVVhoDacty1aNwQ1lFOUc15ieaUaLMSRFFCbOGMejR1mF2Yq6C1mksIItmjS6DhNL
	AMm7jAOlR64HRHcrbwLkHUUkfNZmWF3pgHMZj5TzYhaAzeonlDARKdEjgUSZHqGxwmLbjCZsdq8
	N8P4b9gCB5erQ82Rt0GJqTA4iRUzWSwlaGfWxfwVbZFE0lVCx7/Qotkt0QIeGm9JsMbnzSPEqd7
	EGE45ncGcjZQvmHD7JAbLL78xR0vJctktMU3483j
X-Received: by 2002:a05:6102:605b:b0:605:1994:a8a8 with SMTP id
 ada2fe7eead31-605a4d770f1mr2778614137.9.1775426648802; Sun, 05 Apr 2026
 15:04:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 Apr 2026 15:04:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 Apr 2026 15:04:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260405011135.125912-1-zakariyahali100@gmail.com>
References: <20260327234019.95591-1-zakariyahali100@gmail.com> <20260405011135.125912-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 5 Apr 2026 15:04:07 -0700
X-Gm-Features: AQROBzDqlaJF1czLnf8ZXfW2XLOER25-044qIbA4e7nLPbDPFXyXKaUBo8ySiNY
Message-ID: <CAOLa=ZTuk-33xz4RQJDv-nyK-MqFzLWHM7zdmBBGnXjYiJBsSQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] t2000: modernize overall structure and path checks
To: Zakariyah Ali <zakariyahali100@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000ba2119064ebdba57"

--000000000000ba2119064ebdba57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zakariyah Ali <zakariyahali100@gmail.com> writes:

> This test script that dates back to 2005 certainly shows its age and
> both its style and the way the tests are laid out do not match the
> modern standard. Modernize it to match the current testing standards:
>
>   * Executables that prepare the data used to test the command should
>     be inside the test_expect_success block in modern tests.
>
>   * In modern tests, running a command that is being tested, making
>     sure it succeeds, and inspecting other side effects that are
>     expected, are all done in a single test_expect_success block.
>
>   * A test_expect_success block in modern tests are laid out as
>
>          test_expect_success 'title of the test' '
>                  body of the test &&
>                  ...
>                  body of the test
>          '
>
>     not as
>
>          test_expect_success \
>                  'title of the test' \
>                  'body of the test &&
>                  ...
>                  body of the test'
>
>     which is in a prehistoric style.
>
>   * In modern tests, each &&-chained statement in the body of the
>     test_expect_success block are indented with a horizontal tab,
>     unlike prehistoric style that used 4-space indent.
>
>   * Replace bare 'test -f/-d' and 'test ! -h' assertions with dedicated
>     test_path_is_* helpers (specifically test_path_is_file_not_symlink an=
d
>     test_path_is_dir_not_symlink). While less commonly used in the test
>     suite than test_path_is_file/dir, they act as direct replacements
>     for the specific checks being performed and provide clearer
>     diagnostics on failure.
>

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
> ---
> Hi Yuchen,
>
> Thanks for the review. Regarding test_path_is_file_not_symlink and test_p=
ath_is_dir_not_symlink, I used them as direct replacements for the existing=
 pattern: `test ! -h <path> && test -f/-d <path>`. As you noted, they are s=
imple and straightforward. Following your suggestion, I've added a note abo=
ut them to the commit message in this v4 patch.
>
> I have also added the 'Helped-by' trailer as suggested, since the commit =
message structure was provided by Junio C Hamano.
>
> Also, a quick question please: since the GSoC proposal period for 2026 ha=
s closed, could you guide me on the next steps for applying to subsequent r=
elated internships (like Outreachy, if applicable)? I would love to know ho=
w I can best continue contributing to Git in the meantime.
>
> Regards,
> Zakariyah Ali.
>
>  t/t2000-conflict-when-checking-files-out.sh | 99 +++++++++++----------
>  1 file changed, 54 insertions(+), 45 deletions(-)
>
> diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-confli=
ct-when-checking-files-out.sh
> index f18616ad2b..a8a49df93e 100755
> --- a/t/t2000-conflict-when-checking-files-out.sh
> +++ b/t/t2000-conflict-when-checking-files-out.sh
> @@ -48,17 +48,16 @@ mkdir path0
>  date >path0/file0
>  date >path1
>
> -test_expect_success \
> -    'git checkout-index without -f should fail on conflicting work tree.=
' \
> -    'test_must_fail git checkout-index -a'
> -
> -test_expect_success \
> -    'git checkout-index with -f should succeed.' \
> -    'git checkout-index -f -a'
> +test_expect_success 'git checkout-index without -f should fail on confli=
cting work tree.' '
> +	test_must_fail git checkout-index -a
> +'
>

Not on you, but generally the data setup happens in the same block as
the test, in this case we're relying on previously setup data. But this
is already better than before.

> -test_expect_success \
> -    'git checkout-index conflicting paths.' \
> -    'test -f path0 && test -d path1 && test -f path1/file1'
> +test_expect_success 'git checkout-index with -f should succeed.' '
> +	git checkout-index -f -a &&
> +	test_path_is_file path0 &&
> +	test_path_is_dir path1 &&
> +	test_path_is_file path1/file1
> +'
>

Okay we combine the two tests which were doing the execution and
validation independently.

>  test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>  	mkdir -p tar/get &&
> @@ -83,53 +82,63 @@ test_expect_success SYMLINKS 'checkout-index -f twice=
 with --prefix' '
>  # path path3 is occupied by a non-directory.  With "-f" it should remove
>  # the symlink path3 and create directory path3 and file path3/file1.
>
> -mkdir path2
> -date >path2/file0
> -test_expect_success \
> -    'git update-index --add path2/file0' \
> -    'git update-index --add path2/file0'
> -test_expect_success \
> -    'writing tree out with git write-tree' \
> -    'tree1=3D$(git write-tree)'
> +test_expect_success 'prepare path2/file0 and index' '
> +	mkdir path2 &&
> +	date >path2/file0 &&
> +	git update-index --add path2/file0
> +'
> +
> +test_expect_success 'write tree with path2/file0' '
> +	tree1=3D$(git write-tree)
> +'
> +
>  test_debug 'show_files $tree1'
>
> -mkdir path3
> -date >path3/file1
> -test_expect_success \
> -    'git update-index --add path3/file1' \
> -    'git update-index --add path3/file1'
> -test_expect_success \
> -    'writing tree out with git write-tree' \
> -    'tree2=3D$(git write-tree)'
> +test_expect_success 'prepare path3/file1 and index' '
> +	mkdir path3 &&
> +	date >path3/file1 &&
> +	git update-index --add path3/file1
> +'
> +
> +test_expect_success 'write tree with path3/file1' '
> +	tree2=3D$(git write-tree)
> +'
> +
>  test_debug 'show_files $tree2'
>
> -rm -fr path3
> -test_expect_success \
> -    'read previously written tree and checkout.' \
> -    'git read-tree -m $tree1 && git checkout-index -f -a'
> +test_expect_success 'read previously written tree and checkout.' '
> +	rm -fr path3 &&
> +	git read-tree -m $tree1 &&
> +	git checkout-index -f -a
> +'
> +
>  test_debug 'show_files $tree1'
>
> -test_expect_success \
> -    'add a symlink' \
> -    'test_ln_s_add path2 path3'
> -test_expect_success \
> -    'writing tree out with git write-tree' \
> -    'tree3=3D$(git write-tree)'
> +test_expect_success 'add a symlink' '
> +	test_ln_s_add path2 path3
> +'
> +
> +test_expect_success 'write tree with symlink path3' '
> +	tree3=3D$(git write-tree)
> +'
> +
>  test_debug 'show_files $tree3'
>
>  # Morten says "Got that?" here.
>  # Test begins.
>
> -test_expect_success \
> -    'read previously written tree and checkout.' \
> -    'git read-tree $tree2 && git checkout-index -f -a'
> +test_expect_success 'read previously written tree and checkout.' '
> +	git read-tree $tree2 &&
> +	git checkout-index -f -a
> +'
> +
>  test_debug 'show_files $tree2'
>
> -test_expect_success \
> -    'checking out conflicting path with -f' \
> -    'test ! -h path2 && test -d path2 &&
> -     test ! -h path3 && test -d path3 &&
> -     test ! -h path2/file0 && test -f path2/file0 &&
> -     test ! -h path3/file1 && test -f path3/file1'
> +test_expect_success 'checking out conflicting path with -f' '
> +	test_path_is_dir_not_symlink path2 &&
> +	test_path_is_dir_not_symlink path3 &&
> +	test_path_is_file_not_symlink path2/file0 &&
> +	test_path_is_file_not_symlink path3/file1
> +'
>

Shouldn't all the tests above (since 'mkdir path2') be a single test
block? First we setup the data, validate the data, the previous test
runs 'git-checkout-index' and finally here we're verifying the endstate
here. I think this should all fit into one test block.

Thanks,
Karthik

>  test_done
> --
> 2.43.0

--000000000000ba2119064ebdba57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48289c3936bd7113_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uUzNGVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejNEREFDTU5xV3lqam43bEdwT01MY3BKV1VmUzZtUwowUEJDazNXaTJm
RjJxd2IraXZBMjcyMTFGdm91aW9SYk1ScU9RZjlrdm02a1l4U09CSUZWT0JoTHhuQkM3VDNsCjVP
eisvUDBMRGw2SXZZL3U4L0JnTXg2cmgxQ2Z2OEwwaEhKSW1ORG9QU1NtMkxONmx6cnVQbHVvM0NQ
ejJIeFkKUnZjelQ4YkJKOURGOGNyT3BlQkNiclJ6OE9mY1h2ckRFMEJNL2g1QUt0UzhYR2pNdUR4
c2F5elYvWlZHMldHcQpFWWdjVitFc3JMYWNRZFRIYzFsYXdESWY0L2kzdGNVcDVsQnZqb3NRSEp4
NFJvNFpjeHJ1c0Q1OFF6Q3hxNk9DCjJ5SDBGTGtTSDllWUp4V3JQeW1wcFkzOGZMaGVYM0lnWDI1
N2JwL1gxbnhtSE1jKzdUT0JscER0dG1MeUZOdloKUFAyc0RCWXJXREZMbExNVkZZWm11VkpWd1Iw
d0tLTVJhU2tWYVF2RWxIa2R1UWhPd2hSWmMwc001dzREbjN2NQpBQ211cmNydGRzeVpGRFV3dito
dnlWdHM0dmdOaW9wYTc1bVFpUVVxU29hZ1J3Y2hlK0d0TGRHZW9CUjhXY1doCk10b2FhbkxqWUc1
SWwzaS9LYVJGek1sYWd4WUpNZ0ZLR1VoNkVLVT0KPWhNeisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ba2119064ebdba57--
