Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454571F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeKMB4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:56:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33075 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbeKMB4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:56:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so14131793qko.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zf6f0vqVlJPJ4D6M/eU2vq+d1YMEi62GRJ6s8UcR8o8=;
        b=ayPjZR7SwVpPWKTHFccQBGMVN+eNb77ywg/URtwriP+4cMko5smE5NRJUVmKFEAqVr
         bC4wb6bHcGx/PHRTrTPgxksXth4rZF1NXVLQT3je5VB2StRwqCMtCDd4L+MDV7ufcJjN
         VUIA+YSO5WuPo7q7ym2R3W/jEv8gZLvcphqd+UnbG1yhhyipZpPOAdsQlKxbv+X8sF4E
         RyPTveRGtd5/3atqz94+M3fZG8UUaAPx768L9EXhQVNSCbmOaAuGRNbktMecLILB4cBt
         ZpZFcDdJ/0mP/bBrSntNpuFTUdbGcXtLuXbHHzhcco24WmDnell+SYAWRPP4OlerElxq
         Pkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zf6f0vqVlJPJ4D6M/eU2vq+d1YMEi62GRJ6s8UcR8o8=;
        b=n9F2Qjw90kQ4pW0LlcyRutxRdloZpK7whrqfv8hFwSGiBSXuMGuaOaCFrDS0RHxWXW
         03ph588OZdNI7Oo0Ly1YlYy2bVO5wOJIsAmn1jBeK6mbaQAqYvGGENVqFQIB0+4JEu0A
         pXYut2TrlT8X6Bc2cZwXjOsqOQ175LGWo1akDR0wnZPF/40Mcq5nPY6sSovInGZYpmal
         rIW+opqRre5yGomdWZFn8JnelHD+7fupHu684RKzPrHw3ttZaBv34KhV2VCJmyCvMSoj
         KkRqPTlyzaZ8uLE7DE4RFp7H5z9XYFEWhiqSN3+8AyQDcpfLquVPErtuwlJQtFrTU3ZN
         OuvA==
X-Gm-Message-State: AGRZ1gJILCsTHv1zDbDOb++Krvw75FSLUYfted+brQEvgSt/NserywdS
        auFZjkUC9bY4uhosKUP61Sg=
X-Google-Smtp-Source: AJdET5d4dLNIfYgwL2HvLtUuSUx+IWgNod0Uc8Jo57PAhHF0nfI7zi08uKbg1fiHx1MylfFBqOm9dA==
X-Received: by 2002:a37:23c5:: with SMTP id j188mr1411051qkj.68.1542038564635;
        Mon, 12 Nov 2018 08:02:44 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id b20sm6338001qkb.17.2018.11.12.08.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:02:44 -0800 (PST)
Subject: Re: [PATCH 0/9] caching loose objects
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <20181108120256.GA29432@sigill.intra.peff.net>
 <20181112144627.GA2478@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7f0dd0f6-ea74-9e8a-5bf9-936529d665cf@gmail.com>
Date:   Mon, 12 Nov 2018 11:02:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2018 9:46 AM, Jeff King wrote:
> Here's the series I mentioned earlier in the thread to cache loose
> objects when answering has_object_file(..., OBJECT_INFO_QUICK). For
> those just joining us, this makes operations that look up a lot of
> missing objects (like "index-pack" looking for collisions) faster. This
> is mostly targeted at systems where stat() is slow, like over NFS, but
> it seems to give a 2% speedup indexing a full git.git packfile into an
> empty repository (i.e., what you'd see on a clone).
>
> I'm adding René Scharfe and Takuto Ikuta to the cc for their previous
> work in loose-object caching.
>
> The interesting bit is patch 8. The rest of it is cleanup to let us
> treat alternates and the main object directory similarly.

This cleanup is actually really valuable, and affects much more than 
this application.

I really think it is a good idea, and hope it doesn't cause too much 
trouble as the topic is cooking.

Thanks,
-Stolee
