Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B676820954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbdKVX2T (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:28:19 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:42005 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdKVX2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:28:17 -0500
Received: by mail-it0-f66.google.com with SMTP id n134so8188312itg.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 15:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7mo6cTKhwPwv+Aq/sn7DdgAXBcxhDSuVVr7lktFoto4=;
        b=crSVby5VEhWPPWxB1uQvNzAyIMwUJA3mucnS9+eDe3Q8gQ7B+pngNardcCdIi956vj
         hSrhBl8xFejCkLpHuKR1tZrayNxsRrVgPfciPgY6/o9Z3oX1Jar06bEQXXUOTD9sAbnc
         9LwJwqZdPysOCxgsnCut3TNYISJBPo+uNvQk/SseZIcQu81HTa7oPkciME15kJPWlVBs
         9uwd2rKWp32AUxIqIALdvACURzZZjQ2Rp//ZaBYXys2RfUwTp8+n7kfa4QVV2c3kZe/u
         T6SP/wi3phTQSmjbtUhS5An4o0U5N+X5/RNhFb1cFcctQazP8slBRtOMlZBni9kpaFMf
         V7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mo6cTKhwPwv+Aq/sn7DdgAXBcxhDSuVVr7lktFoto4=;
        b=Lhv0TYXUJWOqyZqqYKM2vznd6jgga467cUbwruxxio6XkC2CsjEvwENAdLvT3ngba7
         WCLvcCqtyodU4na1mejwqVrUhmNfh5kiGwtUUyelLRT//I/tOMn0LAn6U8tY2ayeEhA4
         Rgyh4/W8SB2hZBMqw/aFDmlt8O0ECbrgZvH2ii3s8eHQm+e3pLuNyuk1tDb5ad7Kj4cB
         F2MSSfTjPDPb5xRQ4p9EUKTw6f2S4NS8hObDkKlez65SG0iex8/WRFfL+GeOzMcH8ZWX
         Rpwk3u0YfOJZb8oll1xYGM+jQoBdcG2BD1RcPUkT9vKP2a2OWsBguiVJX3P7TjpNZru2
         SZEA==
X-Gm-Message-State: AJaThX4b7Fg92D8zvjh/yZ9kxQIt2LPRLWfFit7Qka2e/jRFeSMg2yFW
        k2SvkjqzMMcned4stDR7dNELXJUx
X-Google-Smtp-Source: AGs4zMbu2uP9TTxRDDrihCuGDkHTTmfr5u6QhBwylehHqpNC/SnCcObwIMBjdl9NVMUrLCy24qQHag==
X-Received: by 10.36.47.204 with SMTP id j195mr8470315itj.98.1511393296651;
        Wed, 22 Nov 2017 15:28:16 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e12sm7375093iod.4.2017.11.22.15.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 15:28:16 -0800 (PST)
Date:   Wed, 22 Nov 2017 15:28:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171122232814.GH11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122232457.GA8577@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Wed, Nov 22, 2017 at 02:38:24PM -0800, Stefan Beller wrote:

>> On reviewing [1] I wondered why there are so many asserts and wondered
>> if these asserts could have been prevented by a better functionality around
>> bug reporting in our code.
>>
>> Introduce a BUG_ON macro, which is superior to assert() by
>>  * being always there, even when compiled with NDEBUG and
>>  * providind an additional human readable error message, like BUG()
>
> I'm not sure I agree with the aim of the series.
>
> If people want to compile with NDEBUG, that's their business, I guess.
> I don't see much _point_ in it for Git, since most of our assertions do
> not respect NDEBUG, and I don't think we tend to assert in expensive
> ways anyway.
>
> I do like human readable messages. But sometimes such a message just
> makes the code harder to read (and to write). E.g., is there any real
> value in:
>
>   BUG_ON(!foo, "called bar() with a foo!");
>
> over:
>
>   assert(foo);

I think you're hinting at wanting

	BUG_ON(!foo);

which is something that the Linux kernel has (and which is not done in
this series).

[...]
> I also find (as your third patch switches):
>
>   if (!foo)
> 	BUG("foo has not been setup");
>
> more readable than the BUG_ON() version, if only because it uses
> traditional control flow.

Yes, I think you're right.

Thanks,
Jonathan
