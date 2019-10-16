Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5301F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437450AbfJPVKO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 17:10:14 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:15433 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbfJPVKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 17:10:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46tlLV3DKFz5tlG;
        Wed, 16 Oct 2019 23:10:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E861220A1;
        Wed, 16 Oct 2019 23:10:09 +0200 (CEST)
Subject: Re: [PATCH v2] userdiff: Fix some corner cases in dts regex
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20191016203239.212174-1-sboyd@kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4f8e8a13-c41f-558f-18c3-b2bda178a06b@kdbg.org>
Date:   Wed, 16 Oct 2019 23:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016203239.212174-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Removed bouncing addresses of Matthieu Moy and William Duclot from Cc]

Am 16.10.19 um 22:32 schrieb Stephen Boyd:
> diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multiline-prop
> new file mode 100644
> index 000000000000..db4b4bdda686
> --- /dev/null
> +++ b/t/t4018/dts-nodes-multiline-prop
> @@ -0,0 +1,14 @@
> +/ {
> +	label_1: node1@ff00 {
> +		RIGHT@deadf00,4000 {
> +			multilineprop = <3>,
> +
> +
> +					<4>;

I was actually thinking about something like

			multilineprop = <3>,
					<0xabcd>,
					"text",
					name,
					<4>;

or something like that -- whatever occurs in the real world.

> +
> +
> +
> +			ChangeMe = <0xffeedd00>;
> +		};
> +	};
> +};

Apart from that, the patch looks good.

-- Hannes
