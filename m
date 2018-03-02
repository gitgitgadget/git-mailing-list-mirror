Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF97B1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427980AbeCBP4w (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 10:56:52 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40072 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426307AbeCBP4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 10:56:50 -0500
Received: by mail-wm0-f47.google.com with SMTP id t6so3909937wmt.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 07:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uluk7KiCrtQYge/4vr2lx6VQpgTgiYxFcj5zXAXrMZ8=;
        b=caiMV8dYNlW2iGNrfZ9FkARbUFz314XNll1/V1WxbrCkxQrwzQnAHJrITd2Rt1LRli
         4NZ7AjZFtmlm8q8IVGRLqRDc8yQ1aERQmao2KspBw4skVvQbH8xPvT/Vr1IvxyphGEg4
         H3grZA16HCALVa3Ahniow7lBqwSIyNtcc/0t1nU0Iz4hDr0iKGVq8XigMN2mTiyN8ZP4
         TkizfnN8oCcIQGmHj0RggzAWRmT9zDDfMjyjpQZimvXDxzJtEDnwRspEGpFwYlAo6v2u
         7smLARi7Wcq0miH79E1U3w9KDXbulRrFFw1wBsc0rVMbZaFck9zCY+9OWHdcwdnX1tbC
         21pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uluk7KiCrtQYge/4vr2lx6VQpgTgiYxFcj5zXAXrMZ8=;
        b=Y/zJOTlbn1ZgE7zbR3oVrdjqoXEoTkTurVlPUVriChN/Df3lTYc1dBXTyRKkaeXCPK
         xymjH6I5c3w+uK7uGkLMABIBe1Cw+HQC6b/E4MIMbFmynYIl90ds3aazgjwVSHtnv5ok
         M9CB2sJp86A9483BieTCjySFDGdAEn7+k571l+Mum88dR/7ElphRJ3dA2JThFZjdkeTM
         GM3Y9+FAWVyYVgEgQ9upBCMeWaDPGlTxUwQ9nMmXtK3WQUQK9IL74whZoG4gz7HOYJAs
         HXQu5Br+3fm2M8k8wICMRkIsTcnN3xC8pz5SmPlAkZHw+0rifmFSdeV8eMwYWq8kAkOj
         Mbpw==
X-Gm-Message-State: AElRT7HZNLoss7puKdb7LE+vVNT9Dv1Eqj2vxfRrapCRz3RvV68dE3kG
        uLDXGoZFU3G356Zi8+pWcXI=
X-Google-Smtp-Source: AG47ELsshHsxvj7WRuXMg/9KXL4GbNuu+j/2z+Nf8QPooOL71RwSshdbfMAN9iCdQ9a7t6975KrzQQ==
X-Received: by 10.28.64.193 with SMTP id n184mr1773780wma.4.1520006208812;
        Fri, 02 Mar 2018 07:56:48 -0800 (PST)
Received: from localhost.localdomain (x4db004d2.dyn.telefonica.de. [77.176.4.210])
        by smtp.gmail.com with ESMTPSA id x189sm1367408wmg.23.2018.03.02.07.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Mar 2018 07:56:47 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 4/9] t3701: don't hard code sha1 hash values
Date:   Fri,  2 Mar 2018 16:55:28 +0100
Message-Id: <20180302155528.12106-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.512.g74dde89aed
In-Reply-To: <20180301105103.24268-5-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net> <20180301105103.24268-1-phillip.wood@talktalk.net> <20180301105103.24268-5-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Use a filter when comparing diffs to fix the value of non-zero hashes
> in diff index lines so we're not hard coding sha1 hash values in the
> expected output. This makes it easier to change the expected output if
> a test is edited as we don't need to worry about the exact hash value
> and means the tests will work when the hash algorithm is transitioned
> away from sha1.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 836ce346ed..f95714230b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -10,6 +10,19 @@ then
>  	test_done
>  fi
>  
> +diff_cmp () {
> +	for x
> +	do
> +		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
> +		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
> +		     -e '/^index/s/ 00*\.\./ 0000000../' \
> +		     -e '/^index/s/\.\.00*$/..0000000/' \
> +		     -e '/^index/s/\.\.00* /..0000000 /' \
> +		     "$x" >"$x.filtered"
> +	done
> +	test_cmp "$1.filtered" "$2.filtered"
> +}

t3701 is not the only test script comparing diffs, many other
tests do so:

  $ git grep 'diff --git' t/ |wc -l
  835

It's totally inaccurate, but a good ballpark figure.

I think this function should be a widely available test helper
function in 'test-lib-functions.sh', perhaps renamed to
'test_cmp_diff', so those other tests could use it as well.

