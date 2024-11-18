Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C941C71
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918901; cv=none; b=uMJ+ZQ4feFPtS8tfmvadtacwsmr5x3ZlXXfe8dCNW041xdFdT6QheLdAwAFtWwZ73Dhwe47aTqsvFK7in1n3WW1EUHZ4oar6NLW2WfwcRkT7vIUuL9HMK/4XmMo1G1n6dtP1Ko9lGbynTcBBQW8o8NZrJ/AoWb0MN/05jN2Dqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918901; c=relaxed/simple;
	bh=xy9ObnxPDAgmGHigS8FoFfvaqr4mdBzrKWLmChlLfLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROq2I39E36mluuVAt9wjcugThLJ0nH6f8rFD2JcKCVp6Gy8NeGoidyBkMSFEFn61X3fE4V6L9YJiozbjnb9jyIBr5DFmPhJYdCk6Sst5FfEPXXTY7p7raqvrrGmAk5NkjjofWp6TY/78YD+CiwP1zjCDLrWFmz1Geasbo8q08EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e95DWzCv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e95DWzCv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ee79e82361so9364977b3.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731918899; x=1732523699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5zmvggY/C7OVD0JBW9ltF9wgEN8lUe60k83QeNvx5/Y=;
        b=e95DWzCvZs33RPRZ/EuMqGjCAw58i8XlXbMlOSdhyNVgdWsSp2YEODxlofokzBc5Tf
         eDBgf2ImgwYGYEUjNoB8gNwPuGWwCL7JZYKVQT1Bm4aS6D+wUfWyXGamhMApE38SbdVf
         oKvYXAGXslIGZCvfkMEjmUp0+JjoHdHojXz4HnQ1KyMJzaIWJMVdt2O/C0lUzZ9KQMgr
         IbYVWTStXDEDKWV1fTe+EfUqgK2A26XEVxPCEyQxfokQPnWbQBzo9bWpDlyyyLazBhae
         IB1ydQVfXPU+C1is88VRLkOIUaqWEG49SOEjYpD19p4h1XhqDA1w8xrIIXgOnXxYoqyU
         MvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918899; x=1732523699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zmvggY/C7OVD0JBW9ltF9wgEN8lUe60k83QeNvx5/Y=;
        b=lwUAz39xTC8nWSOHvu0NuVjdZNPENz5QYP94/+37u1wVqeio0/WVML5gD9TLsu5HtT
         wDWkiFP3pa2dz3GTI0KOUgmBntYI5EdKPe2WE4zjHQy7XJOWt4yVWrv0g0mxN4+lsHJQ
         pl+bqoQjtixbLOdbH1W7zrj9lLIKJhe+Dcx0/iE800InJ6DP1gvLgd4hGj9/ml3Sjzqu
         tmN69nqUte7S8rCjo9qOLnj3jqAv/PJrCY+SIPkvz71kROtMh+zdkGHp6kdyhSqZYaW/
         x5chumlyclZz56cYJ28X5Nq2P5hzkRAuUXgMpGbe93nBPvKkeZCAcLE58omQE32+CTrm
         eBnQ==
X-Gm-Message-State: AOJu0Yye94a7XN/RcdHzv5YjOgR4m9bTO6cukBS5pX1XpPKLg1hrFJuP
	X3eByFryKA5Rc+il9j/My1cu67UaPW6XXsGGmUfWVyjnlkwOiGm4M1O+eB1Nh7Tk11ZGq4L67eE
	s4JdDsq4Q/oNPVsJm6d6iNgRr4TJWHwABhFfBMA==
X-Google-Smtp-Source: AGHT+IGdaMLHGc/cDyRAXNo+npEyZQGejzz0NnXks+yCz6vvbS/F8l5ziU0vN65uMbXxibal6qsgPWlg3GCR9FBj6n8=
X-Received: by 2002:a05:690c:4b93:b0:6ee:676b:4c65 with SMTP id
 00721157ae682-6ee676b5033mr77327977b3.19.1731918898931; Mon, 18 Nov 2024
 00:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031094554.68916-1-kuforiji98@gmail.com> <20241102102801.26432-1-kuforiji98@gmail.com>
In-Reply-To: <20241102102801.26432-1-kuforiji98@gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 18 Nov 2024 09:34:45 +0100
Message-ID: <CAGedMtdQ6qcDAPf2oiFgqUrsOD3xk-7LFN=TsG7gqGw0QotQKw@mail.gmail.com>
Subject: Re: [PATCH v2] t9101: Refactor test_expect_success format
To: git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk, kristofferhaugsbakk@fastmail.com, 
	me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Nov 2024 at 11:28, Seyi Kuforiji <kuforiji98@gmail.com> wrote:
>
> The current script uses an outdated formatting style for
> test_expect_success blocks, where each argument is separated by a
> backslash and newline. This style can lead to readability issues and
> makes it harder to maintain the script.The modern style consolidates the
> multi-line command arguments into a single quoted block, which improves
> readability, maintainability, and aligns the code with current coding
> standards.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/t9101-git-svn-props.sh | 48 ++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
> index b2ee626b9a..792f7896e4 100755
> --- a/t/t9101-git-svn-props.sh
> +++ b/t/t9101-git-svn-props.sh
> @@ -73,12 +73,13 @@ test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
>  test_expect_success 'fetch revisions from svn' 'git svn fetch'
>
>  name='test svn:keywords ignoring'
> -test_expect_success "$name" \
> -       'git checkout -b mybranch remotes/git-svn &&
> +test_expect_success "$name" '
> +       git checkout -b mybranch remotes/git-svn &&
>         echo Hi again >>kw.c &&
>         git commit -a -m "test keywords ignoring" &&
>         git svn set-tree remotes/git-svn..mybranch &&
> -       git pull . remotes/git-svn'
> +       git pull . remotes/git-svn
> +'
>
>  expect='/* $Id$ */'
>  got="$(sed -ne 2p kw.c)"
> @@ -94,10 +95,11 @@ test_expect_success "propset CR on crlf files" '
>          )
>  '
>
> -test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
> -       'git svn fetch &&
> -        git pull . remotes/git-svn &&
> -        svn_cmd co "$svnrepo" new_wc'
> +test_expect_success 'fetch and pull latest from svn and checkout a new wc' '
> +       git svn fetch &&
> +       git pull . remotes/git-svn &&
> +       svn_cmd co "$svnrepo" new_wc
> +'
>
>  for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
>  do
> @@ -110,15 +112,17 @@ cd test_wc
>         printf '$Id$\rHello\rWorld' >ne_cr
>         a_cr=$(printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin)
>         a_ne_cr=$(printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin)
> -       test_expect_success 'Set CRLF on cr files' \
> -       'svn_cmd propset svn:eol-style CRLF cr &&
> -        svn_cmd propset svn:eol-style CRLF ne_cr &&
> -        svn_cmd propset svn:keywords Id cr &&
> -        svn_cmd propset svn:keywords Id ne_cr &&
> -        svn_cmd commit -m "propset CRLF on cr files"'
> +       test_expect_success 'Set CRLF on cr files' '
> +               svn_cmd propset svn:eol-style CRLF cr &&
> +               svn_cmd propset svn:eol-style CRLF ne_cr &&
> +               svn_cmd propset svn:keywords Id cr &&
> +               svn_cmd propset svn:keywords Id ne_cr &&
> +               svn_cmd commit -m "propset CRLF on cr files"
> +       '
>  cd ..
> -test_expect_success 'fetch and pull latest from svn' \
> -       'git svn fetch && git pull . remotes/git-svn'
> +test_expect_success 'fetch and pull latest from svn' '
> +       git svn fetch && git pull . remotes/git-svn
> +'
>
>  b_cr="$(git hash-object cr)"
>  b_ne_cr="$(git hash-object ne_cr)"
> @@ -141,7 +145,7 @@ cat >show-ignore.expect <<\EOF
>  /deeply/nested/directory/no-such-file*
>  EOF
>
> -test_expect_success 'test show-ignore' "
> +test_expect_success 'test show-ignore' '
>         (
>                 cd test_wc &&
>                 mkdir -p deeply/nested/directory &&
> @@ -155,7 +159,7 @@ no-such-file*
>         ) &&
>         git svn show-ignore >show-ignore.got &&
>         cmp show-ignore.expect show-ignore.got
> -"
> +'
>
>  cat >create-ignore.expect <<\EOF
>  /no-such-file*
> @@ -170,7 +174,7 @@ cat >create-ignore-index.expect <<EOF
>  100644 $expectoid 0    deeply/nested/directory/.gitignore
>  EOF
>
> -test_expect_success 'test create-ignore' "
> +test_expect_success 'test create-ignore' '
>         git svn fetch && git pull . remotes/git-svn &&
>         git svn create-ignore &&
>         cmp ./.gitignore create-ignore.expect &&
> @@ -179,7 +183,7 @@ test_expect_success 'test create-ignore' "
>         cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
>         git ls-files -s >ls_files_result &&
>         grep gitignore ls_files_result | cmp - create-ignore-index.expect
> -       "
> +'
>
>  cat >prop.expect <<\EOF
>
> @@ -207,7 +211,7 @@ test_expect_success 'test propget' '
>         test_propget svn:ignore nested/ ../prop.expect &&
>         test_propget svn:ignore ./nested ../prop.expect &&
>         test_propget svn:ignore .././deeply/nested ../prop.expect
> -       '
> +'
>
>  cat >prop.expect <<\EOF
>  Properties on '.':
> @@ -225,12 +229,12 @@ Properties on 'nested/directory/.keep':
>    svn:entry:uuid
>  EOF
>
> -test_expect_success 'test proplist' "
> +test_expect_success 'test proplist' '
>         git svn proplist . >actual &&
>         cmp prop.expect actual &&
>
>         git svn proplist nested/directory/.keep >actual &&
>         cmp prop2.expect actual
> -       "
> +'
>
>  test_done
> --
> 2.47.0.86.g15030f9556
>

Hi Taylor,

I trust you're well.

I didn't get any status update on the patch I updated the commit
message, found here:
https://public-inbox.org/git/20241102102801.26432-1-kuforiji98@gmail.com/

Is it good to go?

Thanks
Seyi
