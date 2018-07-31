Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFBD1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 08:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGaK0H (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 06:26:07 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40078 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGaK0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 06:26:07 -0400
Received: by mail-ed1-f48.google.com with SMTP id e19-v6so5084753edq.7
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjy3Vw7mj0Ap5J/09cMNk3WKKbkKBv0CREtHLePlP1Q=;
        b=u7kwEF0ZAFTPw3VB9yZ6B3WNMxvcw7Lb7ETeOWgkBRP0xkTQtaI4YPDk4zM7FYjyWn
         NU3SgLEHWgE8qwGfvzN91Vb83O1Gmh6r0bWHv4PzSDXZrCnei4kJympB7eiXRKemAJUR
         v7mLwQbTZPXTXey7Z1A8Yi0rkXXt+LJypxv+qEAM3Qm5pTxeKTI21qnJ+muervDvIGp5
         gdQmhq0aiL91Q955ZGb2iKft5zz1XhFENKElBxyFrTazL7sjmZuehZCDi1PruJnuDma3
         oo5Xup5RZw9MNXQ08hnJ7V2GBoZhExQZWAkAch4aCO3nonoxM16079acH63QeNWcOaCz
         5tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjy3Vw7mj0Ap5J/09cMNk3WKKbkKBv0CREtHLePlP1Q=;
        b=fl0gVvD1Wr3idQAud9KzfMnL3ZG35ZeiTZHierewGRzezkntv08Mcvaaz2fCdmzUvg
         zo/JnEvOAAU6mGn6VczGBPBZYevarFuCcFwsX4jxFxZBfrixsAG/5X4sFkdCVSFbxEbW
         nmi7pAkRxWWoOlrsDshinj23n64kYLytGxaglA8rzvQkU6E9iKDYgRlL6Wr/+smq53Ws
         YPdQ334u1XZG6TwFBhpXL+fONPE2+XMnLvZRnSbgjAyzlGhe9J857hxP9JhG2d1zGv0u
         QzsfNmqT3Nqb3c7XmrEkx2yFo5mhfx8D76lgqCYY/pin2sjy/z5lr+qUCbP35sDmKfqT
         U0iQ==
X-Gm-Message-State: AOUpUlFjspx/aRNytE3yLHN2ok4IX3MoK/xze1i+oeZ4QfmuBaQ0EdMi
        RNYE+ZBlohWl08X0LrC9+TI=
X-Google-Smtp-Source: AAOMgpcMIIxZrnanDwEL3f+4R+Kz5VYGzGOldoUhJzCjxihvV4mAjiAt8Nd3u8Tfdl0W05QmSPVH4w==
X-Received: by 2002:a50:ad0f:: with SMTP id y15-v6mr11485285edc.78.1533026810220;
        Tue, 31 Jul 2018 01:46:50 -0700 (PDT)
Received: from buzz.localdomain (x590cfeaf.dyn.telefonica.de. [89.12.254.175])
        by smtp.gmail.com with ESMTPSA id p10-v6sm2640634edh.9.2018.07.31.01.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 01:46:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Chen Bin <chenbin.sh@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
Date:   Tue, 31 Jul 2018 10:46:38 +0200
Message-Id: <20180731084638.18793-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180727112222.19061-1-chenbin.sh@gmail.com>
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com> <20180727112222.19061-1-chenbin.sh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 4849edc4e..2b7baa95d 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -261,6 +261,35 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>  	)
>  '
>  
> +# Test following scenarios:
> +#   - Without ".git/hooks/p4-pre-submit" , submit should continue
> +#   - With the hook returning 0, submit should continue
> +#   - With the hook returning 1, submit should abort
> +test_expect_success 'run hook p4-pre-submit before submit' '
> +	test_when_finished cleanup_git &&
> +	git p4 clone --dest="$git" //depot &&
> +	(
> +		cd "$git" &&
> +		echo "hello world" >hello.txt &&
> +		git add hello.txt &&
> +		git commit -m "add hello.txt" &&
> +		git config git-p4.skipSubmitEdit true &&
> +		git-p4 submit --dry-run >out &&

This must be 'git p4 ...', i.e. without dash.

The dashed form causes the test to fail:

  <...>
  +git config git-p4.skipSubmitEdit true
  +git-p4 submit --dry-run
  t9800-git-p4-basic.sh: 12: eval: git-p4: not found
  error: last command exited with $?=127
  not ok 19 - run hook p4-pre-submit before submit


> +		grep "Would apply" out &&
> +		mkdir -p .git/hooks &&
> +		write_script .git/hooks/p4-pre-submit <<-\EOF &&
> +		exit 0
> +		EOF
> +		git-p4 submit --dry-run >out &&

Likewise.

> +		grep "Would apply" out &&
> +		write_script .git/hooks/p4-pre-submit <<-\EOF &&
> +		exit 1
> +		EOF
> +		test_must_fail git-p4 submit --dry-run >errs 2>&1 &&

Likewise.

> +		! grep "Would apply" err
> +	)
> +'
> +
>  test_expect_success 'submit from detached head' '
>  	test_when_finished cleanup_git &&
>  	git p4 clone --dest="$git" //depot &&
> -- 
> 2.18.0
> 
> 
