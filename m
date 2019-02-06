Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15831F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBFKms (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:42:48 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34917 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBFKms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:42:48 -0500
Received: by mail-wr1-f44.google.com with SMTP id z18so6210970wrh.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 02:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+uVSwlLyaymP70oOrmMFgB8I8s7vndh7l10FKfSARI=;
        b=aAV4Anx/BZtH8nTBovfSIz5M/mZ9QCSGzgA5rU8Yiv4cDivvyGbf0sBLGdGIq0UECo
         ZKW6J5ikutYjVMjEr5ZtzmDTle0ha4d9YQ2qAV8javCCw8RcWRlxYgwhAbsbX8yqPvVK
         /+t0cFAdaxtyAAscPe23BJLCGFkDJkYwNebYSM6nJc4byYYfrt37FlcH75xFGWrHpge9
         k7CHqUceN3NbNtzzwY7zU3DEGhBolTcA3/aJN6yntolyoJjI1NlnPPRaAZk3t9CfOQ8a
         zFbU2IT/BjKluvVVUPeTAKRAB8Vhk6QbdYJluU9xTu6nG3rtU1HJ9GtR2jIZrespwvaQ
         LBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+uVSwlLyaymP70oOrmMFgB8I8s7vndh7l10FKfSARI=;
        b=hXPVMaBoUUtxyiJ4UjEpO5Y72D0/Kpnedeha0USxXK8C07YjPgaSeU3kCCzAYl1nKC
         1KZfRTeIFtRc8qgheivh8Hlyv+mSsjL605V0wlLhM+ml2E7r0wPc03ps4IHA6y3/JZy4
         QNazThojvx24JSzy92lPwOaYdaRVjdrfvU+HCjvjHsHXCUeQRSKqi83KRleLtlxyi1L5
         bdE1tevU8Bjpd3p7UAkj9U+lWK8o20QWDfrK4B9dK8d+BvOTdz/r21as5ZKI4A01bYng
         AxZ4TF5E6b93D9pF7w4P8pskBTH/wCsFMDCw6zQ1gHKF75L2RifZJDIXbZQS/pI+DtXd
         ccPQ==
X-Gm-Message-State: AHQUAuYHQfikFz9oZ1ZABskEg4Sdo9hkyO3m5wE5MyYqDLhBYx8LumtZ
        gdhnSymIEUk8zG199Vj7fl3xxopk
X-Google-Smtp-Source: AHgI3IaeQKzjRPMUdsBuCJH0Yi+hHt+Z1rQ8OyFbIW8uVFDuyPwgVafEotc9VaRMBJUiDHxc87EE6w==
X-Received: by 2002:adf:f009:: with SMTP id j9mr7284539wro.170.1549449766235;
        Wed, 06 Feb 2019 02:42:46 -0800 (PST)
Received: from szeder.dev (x4dbda645.dyn.telefonica.de. [77.189.166.69])
        by smtp.gmail.com with ESMTPSA id j24sm26090825wrd.86.2019.02.06.02.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 02:42:45 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:42:43 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: t0025 flakey?
Message-ID: <20190206104243.GJ10587@szeder.dev>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 11:25:38AM +0100, Johannes Schindelin wrote:
> Hi Torsten,
> 
> at first I thought that those intermittent test failures were limited to
> Windows, but they are not: I can see it now in a build on 32-bit Linux.
> Full logs here:
> 
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1032&_a=summary&view=ms.vss-test-web.build-test-results-tab
> 
> Excerpt from the failing test case:
> 
> -- snip --
> not ok 2 - renormalize CRLF in repo
>  expecting success: 
> 	echo "*.txt text=auto" >.gitattributes &&
> 	git add --renormalize "*.txt" &&
> 	cat >expect <<-\EOF &&
> 	i/lf w/crlf attr/text=auto CRLF.txt
> 	i/lf w/lf attr/text=auto LF.txt
> 	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> 	EOF
> 	git ls-files --eol |
> 	sed -e "s/	/ /g" -e "s/  */ /g" |
> 	sort >actual &&
> 	test_cmp expect actual
> 
> + echo *.txt text=auto
> + git add --renormalize *.txt
> + cat
> + sort
> + sed -e s/	/ /g -e s/  */ /g
> + git ls-files --eol
> + test_cmp expect actual
> + diff -u expect actual
> --- expect	2019-02-06 09:39:42.080733629 +0000
> +++ actual	2019-02-06 09:39:42.088733629 +0000
> @@ -1,3 +1,3 @@
> -i/lf w/crlf attr/text=auto CRLF.txt
> +i/crlf w/crlf attr/text=auto CRLF.txt
>  i/lf w/lf attr/text=auto LF.txt
> -i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> +i/mixed w/mixed attr/text=auto CRLF_mix_LF.txt
> error: last command exited with $?=1
> -- snap --
> 
> Any ideas?

I reported this and Peff looked into it on the way to Git Merge, but
not working solution yet.

https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.net/T/#u

