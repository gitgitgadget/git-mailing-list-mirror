Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0058E1F51C
	for <e@80x24.org>; Thu, 17 May 2018 17:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeEQRVZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 13:21:25 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:37144 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEQRVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 13:21:24 -0400
Received: by mail-yb0-f173.google.com with SMTP id i13-v6so1720888ybl.4
        for <git@vger.kernel.org>; Thu, 17 May 2018 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/GnbL2UHRTVxZCwU++tJdPchSba1Po14QI14Pn73FW8=;
        b=RiVKdeEemfg/ZHV0Wa3G2vIUmOlTjpvcGlOt7Xt1mLFM9ZyA59FrbiBcFwlVeQ6aBH
         jMVZbMTZRiyIUSMPGtCIy23qZyQEh1LHhU+ibw/kLXDAiDdphNT/gRqZRz09hbZAME0z
         uLY9OBHp4sVjMX6RdG0mYSpBV98P+WacN+xLfL0wp24aXd6vD3n2lNRBcvqvcMovSC+j
         C0tAxlDDa5Ilgovi4aqHgoBl+8He9JPKwIihPP3PH7F2Y0g0SJ58fFIHJ7AnE/bc3Bfd
         Sr36KSCGdx/aTkSjv4rCYP5jPhigxNSxWTqQ47X7QoAgDta/4qbtzcUDSvTo2YC1pkuH
         2FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/GnbL2UHRTVxZCwU++tJdPchSba1Po14QI14Pn73FW8=;
        b=WQBSnfpShJkjOaY4tDPmxo7zTiZ11YJNrTc67tFfgoEdkbTK2vZkUARDz+w4PY46HE
         d02qhde9QwADJHm6Qdz7V12XfigPnq+kyA8TEdyhK8nVLKb8GUXV8AtYqMI0Qs9jJLUr
         cvb8Dn02EdJITeZoElIS5k/4eBZEGKdUASGCUgolCOhZM6/XSoQ360YTnpV0TarMS2Hj
         9fDSI/hK/aJXCIZA86r7S/4a1P2tq+Do41pksjPKXfvFAW8N29Uxd7v9l87CI1Pii4yO
         wjCS3+DPC/3ZfUs4+IyU1ud6Kw5rF7iT4vLQ3Q29IvQX6OpcsuYHJGRQJqktUpq27bje
         rafg==
X-Gm-Message-State: ALKqPwchtIm0rAEfj2QK7WpCZJ+gdpTD5g141Rs+nNVD5lpPaOGY8OL7
        gv6J8Y8EADmSUWcglpDZxQ7xae4VQUvzbldkxoWLZQ==
X-Google-Smtp-Source: AB8JxZrKSpsjgIQvQ8V46xz9j4yQdZb+Meki2OnyufZisD+XZWCH7tBOm7GPckZfmoh4OGBCaJIk9Tk14gzfczoxbyY=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr3322406ybc.307.1526577683490;
 Thu, 17 May 2018 10:21:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 17 May 2018 10:21:23
 -0700 (PDT)
In-Reply-To: <xmqqbmdf6p1t.fsf@gitster-ct.c.googlers.com>
References: <20180515010425.149200-1-sbeller@google.com> <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
 <CAGZ79kYYy-r+Zs_6yg1ZVRNsBcTUdPWE=FeHrp_=0cV0Uf_GfQ@mail.gmail.com>
 <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com> <xmqqbmdf6p1t.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 May 2018 10:21:23 -0700
Message-ID: <CAGZ79kbvjoTq5079Ks+h2HNb+D99RELYPcJk2=pvZf9-Y8dToQ@mail.gmail.com>
Subject: Re: [PATCH] grep: handle corrupt index files early
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Antonio Ospite <ao2@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> With a majority of call sites dying like this though, I wonder if we
>> should just add repo_read_index_or_die() with die() inside. Then the
>> next person won't likely accidentally forget _()
>
> Yuck.
>
> That sounds like inviting a major code churn.  I tend to agree that
> it would be a good clean-up for longer term maintenance, but I am
> not sure if I can honestly say I'd look forward to such a clean-up
> at this point in the cycle when there are tons of large-ish topics
> in flight X-<.

ok, consider the series
https://public-inbox.org/git/20180516222118.233868-1-sbeller@google.com/
retracted for this cycle; I will keep it around and resend it at some future
date, hopefully.

Feel free to comment on it, though.

Stefan
