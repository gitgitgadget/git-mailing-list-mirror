Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE98B1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 09:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfGCJM3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 05:12:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGCJM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 05:12:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id u18so1900687wru.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lnk+HiKJ5RrZc+83gYPCELWDF1t+NicAWEQ+bwNNKug=;
        b=kGuhf/epluZHwaaA7nuBu2LPNAsOAkFkEyiYFsWQYTo6gnhoyFrPmylKh9OI61ghmP
         eOMfcV757nfeOyLn6cMEuHUTh7WIoKWHXfeFadYril2AUQo3jVa15OiWoel/j3/QwWou
         l7lFn3eAr74+p+0YgXsEvjVFg4JeTqdWsf5H6QVsU5KY3U7tdBdvzjdB57mAuDDAyxY9
         P7f8XFIP38Vyt2inQbnrImDrhZedUDLf9UCcxl6J47w++GphFarcIr8z8BFaf/A7vgPF
         YZBBdz/SH+6Gv3HugL6gEBDHWB79bM5C2IuloHxjA1+tStY4G2eUSA02pph2TszlE+kp
         /iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnk+HiKJ5RrZc+83gYPCELWDF1t+NicAWEQ+bwNNKug=;
        b=i0tw1apWkYcxEPDTdlyCi6RnmBKsBp/mrQB1QYro+X0iqZamftzheAvvmcEWQU65w/
         zWdbzIbSJYp6QXkrB5z1rmPjHCCyvnpcujEcZ3q+o5z+Yogq8DcTpQZqVJuRD7yzCt8X
         wbWqmXhdw6G22KCCLDREXJuTI2NTagQNRw8qkQmgCEX9iR7Jga52laHITIFjkGJGAH6N
         VcyCveAA3eV7Wbgz9lCCJksBy9UQNscgN5R8Rof+QOkNo+A+rRejwyCBXCgJu1untmFD
         BqrifTQoZ0LJKuZlecBaNX7FaT8gQ9Wi6FSzNTufJwEcZxPdoKqIq/PMO519jIv5JVfB
         Q1fw==
X-Gm-Message-State: APjAAAXeo/4mGtI3UlybNPGew+rAqjvKSjK6uy6xJ9TekcR5jXJiI/UF
        I/iRw9UT87uSXqguHVCTvk4=
X-Google-Smtp-Source: APXvYqylM68Dbi2SUZReOmvEP0RPvq56jexyv4ZI6z9oRBk9ezlXERHYLNDe84gazNve7HXkvzmz9A==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr20700091wrm.87.1562145147582;
        Wed, 03 Jul 2019 02:12:27 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id q12sm622629wrp.83.2019.07.03.02.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:12:26 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:12:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] check_everything_connected: assume alternate ref
 tips are valid
Message-ID: <20190703091225.GQ21574@szeder.dev>
References: <20190701131713.GA25349@sigill.intra.peff.net>
 <20190701131815.GB2584@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701131815.GB2584@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 09:18:15AM -0400, Jeff King wrote:
> diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> new file mode 100755
> index 0000000000..3353216f09
> --- /dev/null
> +++ b/t/t5618-alternate-refs.sh
> @@ -0,0 +1,60 @@

> +test_expect_success 'log --source shows .alternate marker' '
> +	git log --oneline --source --remotes=origin >expect.orig &&
> +	sed "s/origin.* /.alternate /" <expect.orig >expect &&

Unnecessary redirection, 'sed' can open that file on its own as well.

> +	git log --oneline --source --alternate-refs >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> -- 
> 2.22.0.776.g16867c022c
