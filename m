Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B451F404
	for <e@80x24.org>; Thu,  8 Mar 2018 18:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755675AbeCHSvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 13:51:19 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34854 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755617AbeCHSvS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 13:51:18 -0500
Received: by mail-qk0-f194.google.com with SMTP id s188so851707qkb.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 10:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=F+RokBx4sQDg1+LrZOwPUA5doNAB/8UNs71OGYxq6Qo=;
        b=bZl6sjMaAWNLaSKrmekw+m21ac/O0JkrSnt4srkh2M9k1pXf99v9xM5A5q9B6fhIpW
         Ou84RFP7SIn8AkLnMHrvsP2Jsx9lhQNDWE7vB6x40+0vCgCYvusBC69/ATZf57+SNpzU
         iAhUO21+Hyh15eCbGGmYKZMidcEZGNWW124YocHDFB0MMeVJhf8kGc+ybzWtrI7m0R2G
         aApqrrshCZWeMhT+Re1opurQbj8vMSjwx8BNZtC3IsiWh9ytOE7uItDslV5xdD4/dzld
         qpsWvLC0z70X7QV4OxcczOKcR7ANccBt/116Ry+6W+l2GMJmlADtngS+D3VXOd07ggvL
         tywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=F+RokBx4sQDg1+LrZOwPUA5doNAB/8UNs71OGYxq6Qo=;
        b=WOp1WHyGxetmjkDx01S36H0s0A8V0ZdKxxemS6i+POuIDzO56f35VVwqP3STT4TuZ6
         Jd6fq2AMFJT0z82osL2dWLjSCLdLsnPF+Sap40VZmbZkBBa406vn34tT5hb5ciSFh6JN
         nEYPU1ETl4T3aC2WU1V11WkjM7DVuqiBneedyhmmg4JgFW5q3XMAyMxM6bzFwBgBxFLB
         NFmDgTD86AKjLiB/m8+FDBZUCDAHRyAbfCj67MgPl7bwzoucLmX26EITDAGFDkBRuQ86
         UzDyYJkO8aAESl+cJMbDuJUjdj5G3Xh5lbLi+yGdjoBm9i5gfZ/96sSGHZDJIw9B6jMp
         dqwQ==
X-Gm-Message-State: AElRT7FI0D9xGzIQZkJmY6oSCWdsfS5Og0Pqqc66egHrCloSXnwiSUx3
        ajW4XJSA6H6ZTk646AAKlqGVTgRVFd/NhMW6mtQvoA==
X-Google-Smtp-Source: AG47ELtUfpYzYDiwfIrvO1yk5twSXU2swKtpCn27+TnHEW179KCsX2aP7Pzr2dHztPY13TvjDRw9LjkC+rNh6P+AjrE=
X-Received: by 10.55.203.67 with SMTP id d64mr38982993qkj.210.1520535077700;
 Thu, 08 Mar 2018 10:51:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 8 Mar 2018 10:51:17 -0800 (PST)
In-Reply-To: <20180308123844.15163-2-szeder.dev@gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com> <20180308123844.15163-2-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Mar 2018 13:51:17 -0500
X-Google-Sender-Auth: nLM5EgWOMLVoLcrBQNJtkiFbGX0
Message-ID: <CAPig+cTtV2unsixsMCWytdJMiYYytgdvbavfENhBrwvXq_79Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9400-git-cvsserver-server: don't rely on the output
 of 'test_cmp'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 7:38 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> The test 'cvs update (-p)' redirects and checks 'test_cmp's stdout and
> even its stderr.  The commit introducing this test in 6e8937a084
> (cvsserver: Add test for update -p, 2008-03-27) doesn't discuss why,
> in fact its log message only consists of that subject line.  Anyway,
> weird as it is, it kind of made sense due to the way that test was
> structured:

[excellent explanation snipped]

> Unroll that for loop, so we can check the files' contents the usual
> way and rely on 'test_cmp's exit code failing the && chain.  Extract
> updating a file via CVS and verifying its contents using 'test_cmp'
> into a helper function requiring the file's name as parameter to avoid
> much of the repetition resulting from unrolling the loop.

An alternative approach used elsewhere in the test suite[1] would be
simply to 'exit' if test_cmp fails:

    for i in merge no-lf empty really-empty; do
        GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out
        test_cmp $i.out ../$i || exit 1
    done &&

(And, like the existing patch, this removes the need for capturing
test_cmp's output into a "failures" file.)

[1]: For example, the "setup" test of t2204-add-ignored.sh.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-serv=
er.sh
> @@ -447,12 +452,10 @@ test_expect_success 'cvs update (-p)' '
>      git push gitcvs.git >/dev/null &&
>      cd cvswork &&
>      GIT_CONFIG=3D"$git_config" cvs update &&
> -    rm -f failures &&
> -    for i in merge no-lf empty really-empty; do
> -        GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out
> -       test_cmp $i.out ../$i >>failures 2>&1
> -    done &&
> -    test -z "$(cat failures)"
> +    check_cvs_update_p merge &&
> +    check_cvs_update_p no-lf &&
> +    check_cvs_update_p empty &&
> +    check_cvs_update_p really-empty
>  '
