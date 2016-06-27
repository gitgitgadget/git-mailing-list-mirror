Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFAE2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbcF0Tdt (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:33:49 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35867 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0Tds convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 15:33:48 -0400
Received: by mail-it0-f45.google.com with SMTP id a5so74276701ita.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 12:33:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iqXQ5tFxjVHeAyIT7lGEQa448lAGooiQ9sGZ4jvZ4HI=;
        b=mxa9ps9oXGn6eVQ/RySREfWi6c8bEIB3OyvWvdtzjZbCQZIJP48er63vMZx+ESYrYI
         sgM8yzPMEsPCBMs/19Yltnk8L17V1gvFjOQ5JMOxV7BL/DZ02Uy31NvY3pgGFL3ujUW3
         TKmdCF4uD91LpXsUvj5aXbRzdFwoYnUucH7xP4I45NvgwvuAd+ay7TULy802RORPyJ6M
         ISSxOB2fwuVMe0bfcmdL2Mmw84lgqordkEaaSZgXgqoM+FzyszDz+MNR/dqaeKX+K2jM
         g8C1yJZKIUuFmn/Vf/K67UsZDXk8TsqRN2/gaV9ZrxpzR1xX6tpUDaCTZkMs85E9ezPs
         nClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iqXQ5tFxjVHeAyIT7lGEQa448lAGooiQ9sGZ4jvZ4HI=;
        b=IL/HipCG9Tszw/61P56kZc3TttBfsSQv+dqtdQ0/y/MmXKZQAhNVhhU2Q1/YvwzTU9
         oVr73+4rSyvpwwU4/m/DXnKcApmws7aBYbKPTZsTDG6oEZa4HE1wIXY20QX/fUOhbQQE
         vfEjiftcxq+3QOrJ7Du7aEg0SD4v4/1jLz3lzvnkKwIS6tQSX1NAU/feICDCIKSQ30F1
         YTiyWQylmex6cVzAs3SmnT7bwKHkLgK1sTaUg2pOmZrfIDCrz64WtM6Tb7srEKfzztc8
         FsjRkU/bGOFp7VRM4ahj9ZoApWIw161oE7yFDkjvdeuwUhO/9rixSFf3bK7/aM4K+oeB
         cpyg==
X-Gm-Message-State: ALyK8tIAvyHuOkIOrwX+J3AUOPlL9BQ8oH3g6fHHSFX9K3IcaTQPMOx5jxqpBE/pQ9tpeM4vmoEjJfeXZjnlLQ==
X-Received: by 10.36.84.79 with SMTP id t76mr10758953ita.63.1467056027772;
 Mon, 27 Jun 2016 12:33:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 12:33:18 -0700 (PDT)
In-Reply-To: <20160627192426.GA10877@sigill.intra.peff.net>
References: <20160626171616.27948-1-pclouds@gmail.com> <20160626171616.27948-4-pclouds@gmail.com>
 <20160627192426.GA10877@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 21:33:18 +0200
Message-ID: <CACsJy8BYsPCLiEM2syrGUa_VOCHnR3W+sSiG3sNFme1L0Hx7XA@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] diff.c: add --relative-names to be used with --name-only
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 9:24 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 26, 2016 at 07:16:16PM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> The difference with --relative option is, this option does not filter
>> paths outside cwd. You can add two more chars " ." on your command
>> line for that.
>
> Another difference seems to be that it applies only to --name-only, and
> not to other forms. I can see how "-p --relative-names" might be weird,
> because you'll get:
>
>   diff --git a/../foo/bar b/../foo/bar
>
> or something. But surely things like --name-status would want to support
> it?

That's my plan :) Anything that does not start with a/ or b/ should
respect this new option.
-- 
Duy
