Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E210E201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbdF3Udd (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:33:33 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36428 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdF3Udc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:33:32 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so68505575pgb.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylnMVaOYEUlue3Bo+hGh+tMvFRPngcnpDZK2CYWN4HI=;
        b=KO1gE23iVUIioimC5xJnlMYI0mDjtodAoNWllBF+ym3BA1pCTCvsyajFgCXarrOc3A
         Pl0cx3v8TDpDCuB00zgwMtnha6clP/xqfwBaYkdmpDS8LGK4JUPOkrfGHvl8notE+vmI
         ZjiIUHKOKNpN7h9LBH6vuhEAwGlJ6qFYcRWlLknnsyhEgLydRxgGtSYx9cxXIgeUSFDv
         7dxlJFOgch4gciw9f0ItUptYzO8ACmrAr/QlIpRNULS3T73sO7lLJurloK3U2kezFwbK
         fHZV54Mbo0rX1oBpdRL+s98qwQqQ9AfkQ3fx+rwe3myufCH3i5wOZYqmER8Q/9NAjo0j
         fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylnMVaOYEUlue3Bo+hGh+tMvFRPngcnpDZK2CYWN4HI=;
        b=tWhHPruzzSfUAgNIlUvqJ4QvK+fXiwuVw95L+uiDtkG4gyg/A6ZX2f8mUrOIxe/tAw
         KPpElgFgP9O02X/hLi0DFFW/3NiFOTBMkvXc8IaHEIB28JfjjDq06cJ8N9qN1SMjtSJa
         hVAg8Rpilk3t1qqA2lDT3NmXStDlCiDM16Wt3VPOC1En19bI1o2tvKcO0qIzd+zjSktu
         8u0KqYT6Gm2vQaF2/JVXDSwRc5KLNtt4jPcA9ja0lOuhoj91cf/Y0wtq2ArF/my55sJZ
         TGGvEj17ZWp1TCv+yYnP8Jj2MLVCGhK2vgHLT2/DmolwxIzxz2Njp3c1vUfd79VUuMkM
         E9EQ==
X-Gm-Message-State: AKS2vOzIgC/jwdrzP8kLigtmFrRWe6oPAyJQ+FhfqLzEkAR4SrlRCjIr
        63yaYEBqBg+/NkyWWdog4ceQegQWfYnr
X-Received: by 10.98.69.76 with SMTP id s73mr23842246pfa.94.1498854811918;
 Fri, 30 Jun 2017 13:33:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 13:33:31 -0700 (PDT)
In-Reply-To: <20170630203117.ktobhqnvgxgjujzi@ruderich.org>
References: <20170630000710.10601-1-sbeller@google.com> <20170630000710.10601-26-sbeller@google.com>
 <20170630072611.q733inuxdvjmhjgw@ruderich.org> <CAGZ79kYONNMrB7L65WjwZjSuKOf3rAOWPwjb1bH26MU0owTJ4w@mail.gmail.com>
 <20170630203117.ktobhqnvgxgjujzi@ruderich.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 13:33:31 -0700
Message-ID: <CAGZ79kYejnJoSPMhaTwXy01dM2YC2FW0+_+tedTqvZ5Tqk+BGA@mail.gmail.com>
Subject: Re: [PATCH 25/25] diff: document the new --color-moved setting
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 1:31 PM, Simon Ruderich <simon@ruderich.org> wrote:
> On Fri, Jun 30, 2017 at 09:04:50AM -0700, Stefan Beller wrote:
>> [snip]
>>
>> However
>>
>>     context
>>   + moved line, block A or B
>>   + moved line, block A or B
>>     context
>>
>> is omitted, because the number of lines
>> here is fewer than 3 ignoring the block
>> type.
>>
>> Maybe
>>
>>   If there are fewer than 3 adjacent lines of
>>   moved code, they are skipped.
>
> My issue with "skipped" is that it's not clear what exactly is
> skipped. Move detection? Inclusion in the diff? Something else?
> That's why I tried to add the "excluded from move detection" to
> make it clear that the change is still shown to the user, just
> not handled by move detection and using the usual diff colors.
>
> In your example above, what exactly is "omitted"? The complete
> hunk from the output or the special coloring? That's what
> confuses me and what might confuse a future reader of the
> documentation.

Oh. I see. That was not the point of confusion that I thought.

skipped/omitted both refer to the move detection and the lines
will be included in the diff, but just as regular added/removed lines.

Will fix.

Thanks for bearing with me,
Stefan
