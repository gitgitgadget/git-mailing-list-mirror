Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23F61F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 14:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfAOOmj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 09:42:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44017 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730280AbfAOOmj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 09:42:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so3133028qtj.10
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1XfGDN3yr9vO9/Wp/T5a0M7jZZHbOCWiq6SCLgwJmHY=;
        b=o6s4VCabng0L6WI1n0tHxpva7etcIji18rDnoTLAqlpoRo1NtQWhV2r3B3RaQ5l+Ah
         aWYuVGe9m5VczHAj10kr/rF6Pp9FZTkS/Cwc/0+IZSx4/4x5Fmoil1x/4TpzDbGgNTfp
         kOjDbq6jbFBC4shNOaekbXC1jtmzYrPiXkH1LaINUQkaGpGObG8aNFt1Riy9x8ElSpoa
         DHXbKsPWBikt3FnFb2p/2F0EMrNblgAxtDMXah+hMUd/RKxBROgheUrB2DbcaVtNV/i0
         eLJzthzCU+ZudSCZsgk+RUTk8wjAXrEl0dULwIxEWd1NZcE1qo2KM5HbP1KhuRQ/Q7N+
         QS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1XfGDN3yr9vO9/Wp/T5a0M7jZZHbOCWiq6SCLgwJmHY=;
        b=F8ewopD6msOv6/afbPgcMQk/nIRn5tMH7kU76Oo2SKQD1W5x/KiZr+ORH1JuNynupq
         NIQDkpAQpy1emQhLCWscC+YqILf5u93zxM1ffDicUvcZFy+dKT/zS3rPgKeu8t6skNzu
         d7jyMCLlsHbLxiPg3S6ZConG9WBLtIp3gix8z/KfLhaV/yyBN0ZoN04rfHaV30la0CQ/
         cwAUoYisgBxdoLO2lWb6SlKVcNg/Fe9kP2DMRDtZA+Yah065XQX5RFqqlUaRmO1TY47U
         sxa3LWaLsNKN59WQ6lrxo6/wvan6z4VFGoH50np9yDv4n7hAZPaZbQAyfCG6fmVIwJnl
         YpNw==
X-Gm-Message-State: AJcUukdYmdme7abVqcY59iuZprBg0W3cG9MjciSTckxFQjeKHAjOZwnp
        /X2u776YfT9j5vgch962DkIT0f+Q
X-Google-Smtp-Source: ALg8bN67COYwi7f5Dkm2dL11a6u8c0UfG/7EYifAWe6aAhbdWT3m2Sc4hgTKCC0w3SriGX0jBVlL0Q==
X-Received: by 2002:ac8:548a:: with SMTP id h10mr3183927qtq.15.1547563358196;
        Tue, 15 Jan 2019 06:42:38 -0800 (PST)
Received: from [10.0.1.15] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id c49sm61283919qtc.94.2019.01.15.06.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 06:42:37 -0800 (PST)
Subject: Re: [PATCH] revision.c: fix sparse warnings (sparse algorithm)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <0f69cce6-a0a0-8972-93dd-5c1aa428f508@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a0ace9a0-65f9-ad2e-26f8-b46e3ef0153e@gmail.com>
Date:   Tue, 15 Jan 2019 09:42:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <0f69cce6-a0a0-8972-93dd-5c1aa428f508@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/2019 3:55 PM, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Derrick,
>
> If you need to re-roll your 'ds/push-sparse-tree-walk' branch, could
> you please squash this into the relevant patch [commit 9949aaeef4
> ("revision: implement sparse algorithm", 2018-12-14)].
>
> This commit caused both 'sparse' and my 'static-check.pl' script to
> complain about the visibility of the 'map_flags' variable (it is a
> file local variable), so one solution would be to mark it 'static'.
> However, it is simply not being used, so ...
>
> Thanks!
>
> ATB,
> Ramsay Jones

Thanks, Ramsay! I'm rerolling the series today, so I will make this change.

-Stolee

