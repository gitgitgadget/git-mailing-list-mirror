Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC934139D0A
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754232791; cv=none; b=e4hJw3SY2trI5Eu2QgvOo0TuIS/VEPN8EoCMvMvHLVzTByVT9rN5BRgSNkNhVLepeAbC4tKpG+cRTSovC2QbHyXYHhSatwZm01eQ5TFlMKgtIrWqb3aHFiftc0oAsiH84OwFr1UhVjqQLcs1F5TX5gaQLsxLxbzw2UtbwtCJgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754232791; c=relaxed/simple;
	bh=1Sl9rlHkTFw3ZAZAr7tQZfGKfE6QGrqyU23dFKDzJQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW/CD7/0UQkeMe8i8wQtvdZS6JqQsEA2hYtaMql+QWL12ojCeLNsw2dYOnlZeX6Lsa5gkX4Jh09Obnucc+X3QF30oUoHmbwu5162nIiAO4BMXqSd5BqF1RwwHhaTLj8OlZuaCL9MxM3DdxYGPNTDxHD1BkVaEKBnZquKubthJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGn19ikY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGn19ikY"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so4835333a12.2
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754232788; x=1754837588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShKGV/ZD9wS0DnEKEQf/Xly9nSUXvZCUHkO+bX+EPF8=;
        b=RGn19ikYVWQUGIRbyCkTsWiITkBjsJpNVLn6tNZgxL+Yyryro0+9TKZsllPZ0fW6vt
         BME4OEvwrnQ7rgfKVRUbzy39zWfGZbELKs3X4G6lSPKK3FfvIs+uiBjY2YezxHi1gkJR
         h8o9YAniwJdk+IfaEQFPo1THMzrL089Ukc6P3bnIpK1dVr2QBX4vaoBRgF75/eZ37h9o
         f0TAmL+mV2PnTUUFbmimVevgP9WJcytYi4nPtbS5A1GKSM8KKtUs/NEoCmX5BcZbFczM
         CWb/fyMnBCfqJbAl9VbfS9shsW0if324ZkwRlzZNwK513EgZzlamel+opA0OUGj9WC2f
         nzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754232788; x=1754837588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShKGV/ZD9wS0DnEKEQf/Xly9nSUXvZCUHkO+bX+EPF8=;
        b=ceuK5zy68OB1tcQErpJicYHFpfJ7X1nMSy01q9AoNH0VJNvgSSv+QEAxEcEaBMVPjY
         dda0WLWN53g8b4gC7IQ+PO5Ym1Uu5H1tHTAVvrcTffys5d9AdvFo19X1nrS+qbfLBmL3
         C4x3PSne6BE+ucIv8KcKj3LKi8ToJ+2rr9zTTNIx1Oo5Gxvl1Jxgx6te6jvlIK/n5L6X
         49pOm5T7p1l4mepblVr6893GFYbyBMqOqGFCt0ULbVb2oWpOCCsFNeKrSyIDdTkhx1Yn
         sOdR6QfgD2ENBmJKVXJgbFfA979KmW1NdNdtJL+dZcBRZsAfPUyhbiCfF7czG+yE6tI0
         2oZw==
X-Gm-Message-State: AOJu0Yya8EbEiORstGAq6DmV94YGALx6iP8DS87ieooXKxq79prIuW2h
	8xX5GzjY5Wg2+y1WRV1CXlNctobSVO3n3RkpIJXTqT2ntULS6RnlcbV5GfA3Sr1URQLmmUCokrN
	byoGjX9VLNOp+9sAD8eN7Ra1wd0ZbHSgFoR9sc04=
X-Gm-Gg: ASbGncuiaC/L/Zk5e0ge1lx0u8q63VBjSlO/g+Xh915bPBEfcvoK0qWO0F0+iZTY5/Y
	7MpTcdjV9jLzkZ36ZUccdWBLQQEWgNqqULOcD+Uinp5C7LxV04PbhdrgJdvHgNutRUqzKlopRRT
	6ikPpcYYtRxoqB2NmV1AOrkCiWl/vZW1u3J6WR3BHfJV5+G0xUakni+1VeL61Brm3M4hvsVMVOR
	Q2ChhZzioBID1fpKtKVxYKT0UlvArguDXG7JuXE7vAOM46cUgI=
X-Google-Smtp-Source: AGHT+IH8cqmawpE5QNezFEDR7KkKT8po7KwZh2c+pMHlMx0OgInud6jeTeIohuLanamT2fDwZfQZEI9dSYP8tGwODKA=
X-Received: by 2002:a17:907:7245:b0:ad8:9a3b:b26e with SMTP id
 a640c23a62f3a-af94024886bmr673454166b.56.1754232787869; Sun, 03 Aug 2025
 07:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250803020744.1037392-1-usmanakinyemi202@gmail.com> <20250803020744.1037392-2-usmanakinyemi202@gmail.com>
In-Reply-To: <20250803020744.1037392-2-usmanakinyemi202@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 3 Aug 2025 10:52:56 -0400
X-Gm-Features: Ac12FXxPE6xUHm-uCAD8P8lezk0wFW2Q1byMHAm9Eni2LFMmJOmjOFBX8uKTxsU
Message-ID: <CALnO6CBCynikVcZq17SxOTfwuRMM86cv+BWQb0zZoOdMYX-72g@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	gitster@pobox.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 10:07=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Replace manual `-h` tests with a loop over all subcommands using
> `git --list-cmds=3Dmain`. This ensures consistent coverage of `-h`
> behavior outside a repo and future-proofs the test by covering
> new commands automatically.
>
> Known exceptions are skipped or marked as expected failures.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t1517-outside-repo.sh | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 8f59b867f2..4a827b96f0 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -109,8 +109,6 @@ test_expect_success LIBCURL 'remote-http outside repo=
sitory' '
>
>  test_expect_success 'update-server-info does not crash with -h' '
>         test_expect_code 129 git update-server-info -h >usage &&
> -       test_grep "[Uu]sage: git update-server-info " usage &&
> -       test_expect_code 129 nongit git update-server-info -h >usage &&
>         test_grep "[Uu]sage: git update-server-info " usage
>  '
>
> @@ -120,5 +118,26 @@ test_expect_success 'prune does not crash with -h' '
>         test_expect_code 129 nongit git prune -h >usage &&
>         test_grep "[Uu]sage: git prune " usage
>  '
> +for cmd in $(git --list-cmds=3Dmain)
> +do

This part of the patch does not apply cleanly to v2.50.0 (the original
base of the series), but I was able to apply to latest master
(866e6a391f (The sixteenth batch, 2025-08-01)). It seems like the
conflict was due to 7cd03a555a (builtin/prune: stop depending on
'the_repository', 2025-07-04).

All fine, just leaving a note for myself ;) I didn't see any mention
of the changed base in the cover letter, so I was confused. (Rebasing
onto latest master makes sense to me, but I'm not sure what the list
convention is).

PS I think we want a newline after the closing quote of the prune test
and before the start of the loop.

> +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> +       case "$cmd" in
> +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
> +       difftool--helper | filter-branch | fsck-objects | get-tar-commit-=
id | \
> +       http-backend | http-fetch | http-push | init-db | \
> +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> +       mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
> +       remote-http | remote-https | replay | send-email | \
> +       sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> +       upload-archive--writer | upload-pack | web--browse | whatchanged)
> +               expect_outcome=3Dexpect_failure ;;
> +       *)
> +               expect_outcome=3Dexpect_success ;;
> +       esac
> +       test_$expect_outcome "'git $cmd -h' outside a repository" '
> +               test_expect_code 129 nongit git $cmd -h >usage &&
> +               test_grep "[Uu]sage: git $cmd " usage
> +       '
> +done
>
>  test_done
> --
> 2.50.1
>

I have had to deal with yet more instaweb issues [1], which I think
are because the Windows CI runs without Perl. I'm trying to come up
with a fix there, but any advice welcome. (I think we just need to
mark that test with the Perl pre-req, but it's interesting that this
is the only command I've seen have that problem.)

Looks like Makefile:2664 is the responsible code, which I couldn't
find from just looking at the instaweb script (instead had to grep the
error message -> grep for use of the "unimplemented" script).

[1]: https://github.com/benknoble/git/actions/runs/16699688470/job/47268852=
351

--
D. Ben Knoble
