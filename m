Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C64E1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbcLTWHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 17:07:41 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33025 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbcLTWHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 17:07:39 -0500
Received: by mail-qt0-f181.google.com with SMTP id p16so187628152qta.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vmUjJvAlz75psSL6nSyYu7lXyr8X2TyF/RT39nBIvug=;
        b=WKS/p5keNBH4obAfCRRcbeH5goPv6mQZ6mRZmNXmuooPf3XfnYMZ/gx7q43Dgb/5AE
         HKDpGjzscVlGujSn4BiJc1DtdTXx0U23IQjhprv3rBKGxNXZkRpSw2VNzpFwc3t16Bci
         NcfKjBSdK/0IHcUzyIZGbeApVl17VUfYaWqu7iAEt822b0VsHNMgGHoXM4MrCV0ydBLP
         xNu2Lgv44vsx4u8W4CNmy/7r566r+iAHtVFKxLAJh4pF94UGBwekO0Cfr9ux9DjnZL2M
         OWH0/VOGWo2tpFQ8GeXjzcKhXabuEGuuvHaiazEqcbacwtL3eICdU68NcugD5mZad2uG
         ZYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vmUjJvAlz75psSL6nSyYu7lXyr8X2TyF/RT39nBIvug=;
        b=AQXal5C0mHblW1svlHH35P3/Wj32YOWPZHYaM8VASQGqEWFwSV6yZvyEDwKddWs4zU
         KOOpI863vZigV/FuzMTZZgLSVVU+WAMyDcn/1WYyvJXS76E+G8LFCMRYSdH0NAplcxmg
         ZlU+F4UAjeSO6H/n3yqPjpIyrXfXVh0i98MK1MsAoeCrhRFa5yoAhTV59scQPcLpyhHZ
         KdbBEKIG3Kx5zaa8zglJL/tYi2c8ABcaFE3iyYSZReC7cEbyHyXlnMESjalTBo49aDh7
         G1w03W8tSiO+xs7+NvNkkoCQREi37TyJDbxsRIk4odAzb4lYMS/+j2+c+XbwuDGuVrB/
         E3hg==
X-Gm-Message-State: AIkVDXIj4qXWSVrgx5G10Giig3/eg/1TKPcht1lBGI640yj+erXsggGF2mewCO7n5/Hp3cG4QQuJkMmlXnY65bt0
X-Received: by 10.200.42.232 with SMTP id c37mr1745893qta.145.1482271643558;
 Tue, 20 Dec 2016 14:07:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 20 Dec 2016 14:07:23 -0800 (PST)
In-Reply-To: <48970168-ba4b-e125-6624-e4c37b8a7180@kdbg.org>
References: <20161219232828.5075-1-sbeller@google.com> <20161219232828.5075-4-sbeller@google.com>
 <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org> <CAGZ79kYNKWfnEXWJfyRUutFyaQiRD9qW--LkK4Nbwdf7FtdPQA@mail.gmail.com>
 <f14ee492-8297-c8ec-f80f-f8f24caf91e1@kdbg.org> <CAGZ79kYG-veuWNFh6G1g5MiQHBGk2i1qbH_NBtnMS6jFcoWocg@mail.gmail.com>
 <48970168-ba4b-e125-6624-e4c37b8a7180@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Dec 2016 14:07:23 -0800
Message-ID: <CAGZ79kYgK4e75G9QWUUGKdTUNm+F1GagJ83uXfWY+1ptQQm2dw@mail.gmail.com>
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 1:47 PM, Johannes Sixt <j6t@kdbg.org> wrote:

> This does not explain why the *complete and detailed* invocation must be
> reported.

eh. I tried to say that a report that looks like a *complete and
detailed* invocation
should be such, and not be misleading (and e.g. miss one out of 5
arguments printed).

 I haven't followed this topic at all, so I may be missing some
> cruical detail. (If you say "it must happen" one more time, then I will
> believe you, because for me that's simpler than to plough through a flock of
> submodule topics. ;-)

It doesn't have to happen; I am trying to come up with a better message.

>
> -- Hannes
>
