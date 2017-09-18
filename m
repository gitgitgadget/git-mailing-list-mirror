Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BE32047F
	for <e@80x24.org>; Mon, 18 Sep 2017 22:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbdIRWZp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 18:25:45 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:45112 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdIRWZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 18:25:44 -0400
Received: by mail-pg0-f42.google.com with SMTP id 188so934649pgb.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LdFXkIcei+u4Jat0oh0hKoMVlQj46dowgNMJPPP10gQ=;
        b=jadnE9+Ym97VCmP2Etro0g1PNPVoOOXUj2sAxOg0KAg8Bdn1iRXSL+URArBfwnzGl+
         QpZpC+3wMrCQWOiTaf/mg/Zv2UDHH6R2W2Jd0kv3+flTPpWUc85WLhm/9MgE4ftoZc4l
         YPAAWX2TLM8Og9XJ6VyrHqy0ulm4QJekmPM1a7rWxr5yLuRub+UTJetBKPEcwJVDHRSR
         Y5u/ce4egwvadmXAwFFdDK2Jd/EgAKHNOjm9lmG7kBwDlDugIaLcKBkmWZ6Pi4JNmIwU
         8nt8+AolyeTQC7ywrq6vrNRR0zDFUAxy5WT+0MM0s5KXqzeOb1IaTAxUqHh/+CMeUC8Y
         RsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LdFXkIcei+u4Jat0oh0hKoMVlQj46dowgNMJPPP10gQ=;
        b=ifK+41aOAHtENsOyrTu2MhQAerOKOlG1L3EX5vxsy7Mx2cQxWAAnMJ6IWdB+fuqJHx
         e3Zh/fXccDBGWqKqkhAtOrEs2KyI3n3pJ5P0IohklZyEWHsJZlaeLboDqoFWNEsMgim8
         XDvw+TqUdVcfENoKjJc49f5jwk0X7l64TeB0nrTtfzKImrNsCKaC6tSeK3cdCsguC5zL
         bXteryfFbL0xxp+fbnq+LWIo3eSpoIlKPz4eFVii68LAyxgD/WhE/MgQn1EFK5ciLggW
         KXqn1NJLN6nORWnhXijquqZSeLzUbMOwBtehzX5VuqcPx5uXa9dWxm/xL+jgfZXHLhuZ
         t3jw==
X-Gm-Message-State: AHPjjUj3WO6E1crST7LLxHFagU9F8mNIjirpp3fbsHkR6Dd+8pHfVKLe
        pg76cbQH3cujHg==
X-Google-Smtp-Source: AOwi7QAmzYe19u4lDgTU7heroHeULaZyWPimKII2D8fxV1iT/Hk6J8e2RoBzU+oYUZ/TFQKaCYwoLg==
X-Received: by 10.84.132.78 with SMTP id 72mr74366ple.185.1505773543790;
        Mon, 18 Sep 2017 15:25:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id v25sm478654pfg.52.2017.09.18.15.25.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 15:25:43 -0700 (PDT)
Date:   Mon, 18 Sep 2017 15:25:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Gilles Van Assche <gilles.vanassche@st.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170918222540.GX27425@aiede.mtv.corp.google.com>
References: <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <59BFB95D.1030903@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59BFB95D.1030903@st.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Gilles Van Assche wrote:
> Hi Johannes,

>> SHA-256 got much more cryptanalysis than SHA3-256 […].
>
> I do not think this is true. Keccak/SHA-3 actually got (and is still
> getting) a lot of cryptanalysis, with papers published at renowned
> crypto conferences [1].
>
> Keccak/SHA-3 is recognized to have a significant safety margin. E.g.,
> one can cut the number of rounds in half (as in Keyak or KangarooTwelve)
> and still get a very strong function. I don't think we could say the
> same for SHA-256 or SHA-512…

I just wanted to thank you for paying attention to this conversation
and weighing in.

Most of the regulars in the git project are not crypto experts.  This
kind of extra information (and e.g. [2]) is very useful to us.

Thanks,
Jonathan

> Kind regards,
> Gilles, for the Keccak team
>
> [1] https://keccak.team/third_party.html
[2] https://public-inbox.org/git/91a34c5b-7844-3db2-cf29-411df5bcf886@noekeon.org/
