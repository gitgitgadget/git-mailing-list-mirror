Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A28202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 04:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbdJUEub (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 00:50:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:54247 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdJUEua (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 00:50:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id s2so8083360pge.10
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=BsFCM8AxImtM65fkweSxgPAKJO/DcSwuybI7/unDqyw=;
        b=By7VjLEiZNJv1jeBadBh0MOAFoFL2eeASPWjelyKyoVToL+DNTLfHf3yhOdXRet9he
         dNPUhURwi00rflJXavSG3uWl9LZ9b9IU6aX88j1YoojYQwJaJ2+aZfeRodWVsGHJLYZD
         9m/drfUnvsvNxdsYhva+0CoaXxXc8UZBQlXVHXARwQaZ+grHLNVvYddpm5eKw+TJe86w
         PCaKfkDH1eT+1lDjf08lN7ZWltUTVrzA2iP/e0/XBOhI2j+kJhSlFi3IF/2+By7NIOTS
         HkbZ1FUzEB4Zve5vG+QRw3nrU3HaQJLWL0c/nEh/Ib2fADawpKjO1F6omIGAHjCsMA3L
         Bf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=BsFCM8AxImtM65fkweSxgPAKJO/DcSwuybI7/unDqyw=;
        b=pqr8+l+J8kQiBSdT0RcPpH4yC2Zoj1rcQxTvCxqBs+k9SKa4K61sj6EQJXvj2oXOUb
         yEEmbYjfsOT92gPCIGIW4Bu01nIBSWjiR3MhmA3jR+LCoKeQOc2KTvOOhvh8ASN5jGwQ
         PYOlGYwCZ4qWtUfDS0DulUiEva3uQC0aS6XV45+xUabEZBqjpYiV+QwCYIYoCXN1HpLb
         6usN9QrVp3aL04NW8E4YmjuvKxwSAknev5J6LeOcRaCB8+1qPD9kmUSjgnLHkODgT8uY
         pt6yxSAgzHYXjDT+B3jyrFcfAOSq6Qn145DARi98xSNbopFbTlVn5yNAoHudbmpg56Xj
         7Nog==
X-Gm-Message-State: AMCzsaVHEKkkSIr7OOFRqv2JV5Iu2WUgU0yTv7C+cyw+x92eXaLeA6dl
        lPeqEFBlWe8Uwao9tP9/gYs=
X-Google-Smtp-Source: ABhQp+RMIVsMPACdovibwHMWoRFc7o/IXCMbi67zWkptO3rVRQOYUXArswasaBu5s3yxPYtQlMalVw==
X-Received: by 10.98.166.205 with SMTP id r74mr6895411pfl.285.1508561429702;
        Fri, 20 Oct 2017 21:50:29 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id d76sm3844647pfk.69.2017.10.20.21.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 21:50:28 -0700 (PDT)
Message-ID: <1508561424.2516.19.camel@gmail.com>
Subject: Re: [PATCH 3/3] branch: forbid refs/heads/HEAD
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
References: <20171013051132.3973-1-gitster@pobox.com>
         <20171013051132.3973-4-gitster@pobox.com>
         <20171013131501.3qarwhanktfvgjqd@sigill.intra.peff.net>
         <xmqqefq6v5qj.fsf@gitster.mtv.corp.google.com>
         <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 21 Oct 2017 10:20:24 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> 
> > Perhaps.  Also we may want to make sure that "git branch -D HEAD"
> > still works as a way to recover from historical mistakes.
> 
> The only difference is improved tests where we use show-ref to make
> sure refs/heads/HEAD does not exist when it shouldn't, exercise
> update-ref to create and delete refs/heads/HEAD, and also make sure
> it can be deleted with "git branch -d".
> 

In which case you might also like to ensure that it's possible to
"rename" the branch with a name "HEAD" to recover from historical
mistakes.

> diff --git a/sha1_name.c b/sha1_name.c
> index c7c5ab376c..1b8c503095 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1332,7 +1332,7 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
>  int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
>  {
>  	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> -	if (name[0] == '-')
> +	if (*name == '-' || !strcmp(name, "HEAD"))
>  		return -1;

I guess this makes the check for "HEAD" in builtin/branch::cmd_branch()
 (line 796) redundant. May be it could be removed?

>  	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
>  	return check_refname_format(sb->buf, 0);
> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index e88349c8a0..4556aa66b8 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -331,4 +331,27 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
>  	grep "fatal: invalid ref format: ~a" err
>  '
>  
> +test_expect_success 'branch rejects HEAD as a branch name' '
> +	test_must_fail git branch HEAD HEAD^ &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'checkout -b rejects HEAD as a branch name' '
> +	test_must_fail git checkout -B HEAD HEAD^ &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'update-ref can operate on refs/heads/HEAD' '
> +	git update-ref refs/heads/HEAD HEAD^ &&
> +	git show-ref refs/heads/HEAD &&
> +	git update-ref -d refs/heads/HEAD &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'branch -d can remove refs/heads/HEAD' '
> +	git update-ref refs/heads/HEAD HEAD^ &&
> +	git branch -d HEAD &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
>  test_done

So, may be the following test could also be added (untested yet),

test_expect_success 'branch -m can rename refs/heads/HEAD' '
	git update-ref refs/heads/HEAD HEAD^ &&
	git branch -m HEAD head &&
	test_must_fail git show-ref refs/heads/HEAD
'

-- 
Kaartic
