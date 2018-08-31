Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34A81F404
	for <e@80x24.org>; Fri, 31 Aug 2018 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHaV15 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 17:27:57 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35599 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaV15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 17:27:57 -0400
Received: by mail-qt0-f172.google.com with SMTP id j7-v6so15372024qtp.2
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s88k/2GKvHfogM+XtBQ06SV3QZPZcZ9i/EdpuJCE8vM=;
        b=dPqHJCrNWnLvL/PgDuna4RxNoRRba1Mfmn9Yde8F3zkuhviGo+SQInC1HV8Uyis1lB
         3oH8wOM1h0KK/TTEq4CoTOhX/0BFWHFBAvXqD8sjQaQ10lvCB78ztMiCHu6XDGA82GJ3
         37WQdVWnECRQoB+FqnnJJQWOkqmlIvr9IfktdrfTUVTQL5yLUzP2dvYnSky08C7iusdL
         hVvDYhVERKa1R4AMrPwrWKbxe4wOpk4HwA9c7e614oNcimx4hzSsNSmBshOA4Fb2iCT3
         5y/6xAGDBjgsLuubWt1FrdlmKrLSJvI8TQTjCicZ6bke+d80DHZ/wVLPy/8nnTE0OeEN
         J4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s88k/2GKvHfogM+XtBQ06SV3QZPZcZ9i/EdpuJCE8vM=;
        b=Lwt+G8ahAiKKGywh5yDmUhYLWURFgHwj8VeOLXaypZTO/DGW6UdyXMWys0Q8WT2FWz
         ihwMBlLZZNfh722lnl34lvUZwRvBOjcycL1Y6e+3GeUS5BPhkucARHjqVbWMXFgLtCRa
         dpv1IUt+qDjepnGzRzDWj+bGaWgl3rdaw22V7ozUgtC7Oyx0LVnozMmSoyvmyEInGqzT
         +Le6SNfrDMulcVvswbs2Ztd2z/GXPLW1W+/lBrrh0wBrJgzyHL12JAGO/jq6qXhgsE/C
         hvvF8QkRzQtZpGGJlu4vHY/JFLWNnIB373yyUtPSuDlH1qc50k0Qbs1xiuPudi5SzMyE
         S3bg==
X-Gm-Message-State: APzg51APB5zBzER+RPGBDF2OYnrbfaWdoAT86rfqnvyyDt+hST5mnDYe
        5qveL8DiJ0q44w5lEkBJd4A=
X-Google-Smtp-Source: ANB0VdbOU/MDLB0ykz96dtfrbolt6h48cSTgF+C2VF8UEq36TFIHOogrgZQkhxN2Am6pJv/zrhjLXQ==
X-Received: by 2002:a0c:882d:: with SMTP id 42-v6mr16114369qvl.38.1535735968227;
        Fri, 31 Aug 2018 10:19:28 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u72-v6sm6600653qki.89.2018.08.31.10.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:19:27 -0700 (PDT)
Subject: Re: [PATCH 0/8] WIP: trace2: a new trace facility
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
Date:   Fri, 31 Aug 2018 13:19:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/31/2018 12:49 PM, Jeff Hostetler via GitGitGadget wrote:
> This patch series contains a new trace2 facility that hopefully addresses
> the recent trace- and structured-logging-related discussions. The intent is
> to eventually replace the existing trace_ routines (or to route them to the
> new trace2_ routines) as time permits.

I haven't been part of the recent discussions on these logging efforts, 
but I wanted to mention that I'm excited about the potential here. I 
want to use this new tracing model to trace how many commits are walked 
by graph algorithms like paint_down_to_common().

I'm playing with some efforts here, and found one issue when the API is 
used incorrectly (I'll respond to the patch with the issue).

Thanks,

-Stolee

