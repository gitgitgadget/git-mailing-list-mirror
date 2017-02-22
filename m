Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4046D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934577AbdBVXmr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:42:47 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33464 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934640AbdBVXmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:42:44 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so2315310pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 15:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y8MONDdoeDysEhOt+87Buvho/xhmz3mELtmV/B4XqJM=;
        b=WEU+KndDI+5ykuctU+ds75mxHmAXeTAHX5XydaEKHTrfS8cxzKmNzJX25I1G9YoRUK
         SaolWXWSsJ+cZZNv+OAfjkwj5RzgYS5Bq18fwu24X5pZX01PNFZ3aEH+6sHu+/s6jasj
         Nx6Yk/0WmqQJCw518gUE9mBv9B1mt1BdzQoHeJpnG/oePZ18skxRMFUJY6fUVVB9R+4i
         9ozgNrWS4wbdc2q/3lqBsAg4UV40A4qWi967w5Xk2tqtSC3qpiLW6/6e3JJz0dAzQtb+
         gCBmb1QPl7GJMLmeeGROhpFbQ5eQ6iJ7IIVAc6hZvsP48YDSzV1GuoHxp5Pmqa6AzPjn
         dt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y8MONDdoeDysEhOt+87Buvho/xhmz3mELtmV/B4XqJM=;
        b=n0AW+riigBOwxDHJQTxJ8VyS+YsovjaN1gOZks4i0w3fS6nW1G4Hri6VBeRuAfw633
         W8oa61Zs2Uqb2h4bCRyzSJjpRvpFO5UdLA9zfw6roNzfJwcZNOOyOyDNhqt+UVe9pMIw
         DtnZ169bWx+jKUggCMGAuDzuZ1mwbR6Fx6RQO7yic4RlqV8XQTeBV53MC83aTe3/9Id1
         MDjodU5x1hjBHHfoKWHa8SbbFBOaGy8mPcA/OBRSrI+Nay2M8ewNff66hIoFxXgCWRTF
         61Sjkz7iaHLYTRA3S0sT5qiZGMLfKMqK9JBQAUP0QFJHS1VXYpej37mFHHEpXg81GoDs
         W8vA==
X-Gm-Message-State: AMke39lPX88/pESZ9t4ZNtCfu9c85Mf9iE1lz5kMSjg5tuH1qJeRqRiVkOPF8qbXuynysw==
X-Received: by 10.99.160.81 with SMTP id u17mr45039076pgn.92.1487806953303;
        Wed, 22 Feb 2017 15:42:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id y67sm5575614pfa.96.2017.02.22.15.42.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 15:42:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t: add multi-parent test of diff-tree --stdin
References: <20170222232215.u2agozagwsyy2ooe@genre.crustytoothpaste.net>
        <20170222233838.925157-1-sandals@crustytoothpaste.net>
Date:   Wed, 22 Feb 2017 15:42:25 -0800
In-Reply-To: <20170222233838.925157-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 22 Feb 2017 23:38:38 +0000")
Message-ID: <xmqqfuj5aj32.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We were lacking a test that covered the multi-parent case for commits.
> Add a basic test to ensure we do not regress this behavior in the
> future.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t4013-diff-various.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> It's a little bit ugly to me that this test hard-codes so many values,
> and I'm concerned that it may be unnecessarily brittle.  However, I
> don't have a good idea of how to perform the kind of comprehensive test
> we need otherwise.

Hmph, perhaps the expectation can be created out of the output from
'git diff-tree master^ master' or something?

>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index d09acfe48e..e6c2a7a369 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -349,4 +349,23 @@ test_expect_success 'diff-tree --stdin with log formatting' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff-tree --stdin with two parent commits' '
> +	cat >expect <<-\EOF &&
> +	c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
> +	:040000 040000 da7a33fa77d8066d6698643940ce5860fe2d7fb3 f977ed46ae6873c1c30ab878e15a4accedc3618b M	dir
> +	:100644 100644 01e79c32a8c99c557f0757da7cb6d65b3414466d f4615da674c09df322d6ba8d6b21ecfb1b1ba510 M	file0
> +	:000000 100644 0000000000000000000000000000000000000000 7289e35bff32727c08dda207511bec138fdb9ea5 A	file3
> +	9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
> +	:040000 040000 847b63d013de168b2de618c5ff9720d5ab27e775 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 M	dir
> +	:000000 100644 0000000000000000000000000000000000000000 b1e67221afe8461efd244b487afca22d46b95eb8 A	file1
> +	1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
> +	:040000 040000 da7a33fa77d8066d6698643940ce5860fe2d7fb3 847b63d013de168b2de618c5ff9720d5ab27e775 M	dir
> +	:100644 100644 01e79c32a8c99c557f0757da7cb6d65b3414466d b414108e81e5091fe0974a1858b4d0d22b107f70 M	file0
> +	:100644 000000 01e79c32a8c99c557f0757da7cb6d65b3414466d 0000000000000000000000000000000000000000 D	file2
> +	EOF
> +	git rev-list --parents master | git diff-tree --stdin >actual &&
> +	test_cmp expect actual
> +'
> +
> +
>  test_done
