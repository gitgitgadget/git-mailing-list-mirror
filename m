Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197561F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbfFMPSQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:18:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40698 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbfFMPSF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 11:18:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so10536619wmj.5
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X/c+u/P38Q92HmFJuOjEFhqdVJeuiE6s5YNpNHypfnQ=;
        b=p1sa9TsU5hRmXL/jxcrmfXZb2t3eJmv9oDlcObcouXWxtIKH7trZr9Of0CYiB8uW5j
         VvHPHcCPp87hQUhD51Jar+1BmWnRp9mS50w+aHcReNB9lwOYDGFvaJ2uTDuosLPReUNL
         IsPE4X1IAmUlLedlpVqj/DSXkC6vt4xbL+2+S7N2VhIofaD/upFanEa2d/5rVQ1hx4ko
         vAL7ANaWTpIgXquqEUxRNv8/V+ZBlPmslNj/2nnlBDo6az/eCl69qN/Jqo0DrcPOuyGu
         cydazZUaYjooR1YDO8r6iMOHeXI8cHq21OItp/WOG3BV+lL/xX2xdKh5qJh9Idv5mKTZ
         llQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X/c+u/P38Q92HmFJuOjEFhqdVJeuiE6s5YNpNHypfnQ=;
        b=jFLXaEce/1SNCZzAqXwJxylY6e2qq0B14s0m9qp8XGv6+ZcoW52R/rqDy+1FfGrqiX
         IvkBR8Hvm7eEw2iQO112G7FFWy/46pn/BimUQFuznra598z+lTgfAaqt0qfp85rWxgXQ
         vez7VHUIln2Rn/RZDxQ6KolYKKLk8IHYp0XmAn1LJFgOOMTeGKGYX3CWQ1MJRgES6TJM
         Q8uqBH0Bicc1eIBtlACFaIfcCevzK5X8npdkyJgXm+JhKgPkGv4y/oUz79HDRRdIoRsQ
         AcfdWyXlXUh0yTuueHREJ42t60mREUU6hAWKkiBXgtPL4fGnHeqo6oWnMu3ZerZY5RL1
         TPXw==
X-Gm-Message-State: APjAAAUmiTpe0PFjlBkYa8wIrOoXnLY/D77hXjTWgzYuMlyvXD/B95lI
        bM9x8HyvvkU918/3KpJ61NE=
X-Google-Smtp-Source: APXvYqw2JagGWoKtEar+XkrSNOIif3PEUHvYkjXsHpAzmU7X7z9myZzVoZ4AF0s/mCBywhP7lZrTlg==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr4468229wmi.0.1560439082772;
        Thu, 13 Jun 2019 08:18:02 -0700 (PDT)
Received: from szeder.dev (x4dbd2f68.dyn.telefonica.de. [77.189.47.104])
        by smtp.gmail.com with ESMTPSA id v15sm4360605wrt.25.2019.06.13.08.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:18:01 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:17:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v8 7/9] blame: add a fingerprint heuristic to match
 ignored lines
Message-ID: <20190613151756.GA31952@szeder.dev>
References: <20190610153014.42055-1-brho@google.com>
 <20190610153014.42055-8-brho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190610153014.42055-8-brho@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 11:30:12AM -0400, Barret Rhoden wrote:
> diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> new file mode 100755
> index 000000000000..1d8fa1da74c9
> --- /dev/null
> +++ b/t/t8014-blame-ignore-fuzzy.sh

> +for i in $(test_seq 2 $last_test); do
> +	eval title="\$title$i"
> +	test_expect_success "$title" \
> +	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
> +done
> +
> +# This invoked a null pointer dereference when the chunk callback was called
> +# with a zero length parent chunk and there were no more suspects.
> +test_expect_success 'Diff chunks with no suspects' '
> +	test_write_lines xy1 A B C xy1 >file &&
> +	git add file &&
> +	test_tick &&
> +	GIT_AUTHOR_NAME=1 git commit -m 1 &&
> +
> +	test_write_lines xy2 A B xy2 C xy2 >file &&
> +	git add file &&
> +	test_tick &&
> +	GIT_AUTHOR_NAME=2 git commit -m 2 &&
> +	REV_2=$(git rev-parse HEAD) &&
> +
> +	test_write_lines xy3 A >file &&
> +	git add file &&
> +	test_tick &&
> +	GIT_AUTHOR_NAME=3 git commit -m 3 &&
> +	REV_3=$(git rev-parse HEAD) &&
> +
> +	test_write_lines 1 1 >expected &&
> +
> +	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&

Please use an intermediate file between 'git blame' and the downstream
'sed' command, here and in other tests as well.

This test script focuses specifically on 'git blame', but that pipe
hides its exit code.

