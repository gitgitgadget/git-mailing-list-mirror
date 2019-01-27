Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1873A1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfA0AHm (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:07:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35163 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfA0AHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:07:42 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so10663399ion.2
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1imBWED3KQcLIqAT3AUgeh7RF0hrl70NFQR7vSKE08=;
        b=KVGuVhYTCs9cn4tqBdOOf8g0GclhDANeV2N0qHzTm3HY/eXFVzoXIZGC5XfqXV4ZAd
         N3brxoxPA+K3xhuqXq0gArDzFjYUDsM2o7KxoWbGon7uTrmTCewYeH/o0qNvTfba2bAb
         5hC0iLt2TSZnS24LzBSgf0m477xwcMDhMRO+K1jMAlpqsbx+vW4bvZd+sgAxhS/SBlT3
         TElZGeTOe9wuUnEfywSAABIcU4fhwPKM47Wac+nXAPHlghraMrY6h2KyNtvHLUSfJx03
         EmrSYF/d9tU82dOtw/B/gVE4sO5QSifT1Fxbv8s8ibtJWHqZIUFlsnhkPXQU2VgbPopu
         mVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1imBWED3KQcLIqAT3AUgeh7RF0hrl70NFQR7vSKE08=;
        b=VqOKji86zfTt8hvREBQ/Gtd/1fWtBJ+EwB6HtjraTT7n/YBroOyjvgbS5WCXzrCWH3
         /Oz1DHRZFaMO4mhpxqGcatZ4F83kKL/VNy/Wkl7SHzdA8W0RdVf61bjDNBk4KcZk4Abe
         v6/DAmoqLQZLzksGRq++180M6mHT2JsExbofn54MfvxU00vJfkn8RbOUwfSyyzCkQPIF
         vQlIBmsNalttg6NnDR4opWbN4YBBa+CApAcVwRQvnBnu5vBBQSBjITPVUU76IxW0g5yM
         WLEn5zcaprJ8aYmh5rD2uAKM6jXeXFXCi+vpyk//1tIVt3tYWkjBmimwwbcEoIVtIDoN
         FBsQ==
X-Gm-Message-State: AHQUAuZzqqzLalrgeoMFTvUTAXyIm6B+Py/6GYVkTceTCalHILymttHe
        9T5eq6RRf8E3KtssSp3/4w/HLmT7zzNlRCqz7rI=
X-Google-Smtp-Source: AHgI3IZW5gw6vPOsIQhaN3ttLHcvpE/605hKjYthA0YH9fZU7asGei49sQMtNznp0VeAl3BqNcu+Ja8D9nf1GyNGNQM=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr8192530ior.282.1548547661256;
 Sat, 26 Jan 2019 16:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20190126204951.42455-1-koraktor@gmail.com>
In-Reply-To: <20190126204951.42455-1-koraktor@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 27 Jan 2019 07:07:14 +0700
Message-ID: <CACsJy8A6hF+Sxitpt3J9EmDEXjGb2e+AeMtJDaE7Y32fg4NEKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Add tests for describe with --work-tree
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wrote:
>
> The dirty ones are already passing, but just because describe is comparing
> with the wrong working tree.
>
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  t/t6120-describe.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index d639d94696..9a6bd1541f 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -28,6 +28,24 @@ check_describe () {
>         '
>  }
>
> +check_describe_worktree () {
> +  cd "$TEST_DIRECTORY"

Strange alignment. We normally do it in a subshell...

> +       expect="$1"
> +       shift
> +       R=$(git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe "$@" 2>err.actual)

These commands should be executed inside test_expect_success, not
outside. And you need to chain commands with && to make sure if
something breaks, then the whole test will fai.

If it's too ugly to generate test_expect_success with a shell
function, then just write a shell function that "describe" and compare
(i.e. the test body). Then you can write something like this later

test_expect_sucesss 'describe with --worktree foo' '
        check_describe_worktree foo
'

and check_describe_worktree can now do

( cd "$TEST_DIRECTORY" && .... )



> +       S=$?
> +       cat err.actual >&3
> +       test_expect_success "describe with --work-tree $*" '
> +       test $S = 0 &&
> +       case "$R" in
> +       $expect)        echo happy ;;
> +       *)      echo "Oops - $R is not $expect";
> +               false ;;
> +       esac
> +       '
> +  cd "$TRASH_DIRECTORY"
> +}
> +
>  test_expect_success setup '
>
>         test_tick &&
> @@ -145,14 +163,20 @@ check_describe A-* HEAD
>
>  check_describe "A-*[0-9a-f]" --dirty
>
> +check_describe_worktree "A-*[0-9a-f]" --dirty
> +
>  test_expect_success 'set-up dirty work tree' '
>         echo >>file
>  '
>
>  check_describe "A-*[0-9a-f]-dirty" --dirty
>
> +check_describe_worktree "A-*[0-9a-f]-dirty" --dirty
> +
>  check_describe "A-*[0-9a-f].mod" --dirty=.mod
>
> +check_describe_worktree "A-*[0-9a-f].mod" --dirty=.mod
> +
>  test_expect_success 'describe --dirty HEAD' '
>         test_must_fail git describe --dirty HEAD
>  '
> --
> 2.20.1
>


-- 
Duy
