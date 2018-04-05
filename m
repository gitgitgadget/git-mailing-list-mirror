Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F201F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeDECpY (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:45:24 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:44874 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDECpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:45:23 -0400
Received: by mail-pl0-f44.google.com with SMTP id b6-v6so15110894pla.11
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gJxq7pEliUvHnfw3iRpljND4evqg0uNggPBCiM7ogFs=;
        b=NzIGteGGbF9HQhYX6XJIwrnRAupcayZGwEk3cvUI8lgPQVxomGHng2rrY0ekqKiGtS
         yK5qMBK7/usC112SzTFyRMQsBhbxN0iOYSx0VBFbeg9Bc9mfeQvTwaWNsmCH86KYdlLP
         zcOMTr/Vpa0iawymWve/bzcdA4t+MSkVlLNazMldLBrBme7KTahyWDli/1sx1YzILrsH
         LGvebNnAo/+/BKg0ndlqM6SvQy2N0ji1ImvNqYWQgZhHaeBviPM7sB4SinGAgVaJlI1m
         cSBtnZSe2UWhmleR0JYWbZUsv4uAwokwjc/GuFXe2FCopcju1Hc/0B7ijCL3+bSxgPjA
         g3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gJxq7pEliUvHnfw3iRpljND4evqg0uNggPBCiM7ogFs=;
        b=XlEB4rTAfAggUzpEcXnM2Bc5QafGlP5gSasWASV1lmt9tEzRvTZEYJygUGQx7QETsy
         cvt+eOqc4pNEzxNqJoYaZAXU17maxFT7nvQR3QP+hYkbYoNsNxOs0PdNXw7p+A2dp24D
         L+0I7rVW9urw+SBB1P8bqBvkLhj9mONo/cMUq2TdMh67V0FI9mm8l1xv+cOOufV3VLsn
         o2aJWJoOzIMJG+DyMkhmsUep49UOJVGdzM1M2wipK17IpLFePHjNUIMQHhaqf+FP1hl7
         jiGN/ZWNqXjmFZOs0Y7dBx5XeI9VZFw/m9dS+Ck4V7LUyGmGq4jw6hW7UmRNSc+v7ZUE
         tHHw==
X-Gm-Message-State: ALQs6tCAk2iVIXgEiPsvlpun6PDxUWRr6/PRc4GttBG2sXQ5bmhh8Cky
        RC1IW/by1gEbauJgePPNAeSm1g==
X-Google-Smtp-Source: AIpwx4++FNm2M76AqmUeGcuXe7DVION4+43keNqyDjwk4Yt6weMFmgkaxsdZTKgJVn3ci/jVkaqoGg==
X-Received: by 10.98.212.67 with SMTP id u3mr1628918pfl.58.1522896322643;
        Wed, 04 Apr 2018 19:45:22 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id v18sm11337642pgb.23.2018.04.04.19.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:45:20 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:45:19 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] builtin/config: introduce `--default`
Message-ID: <20180405024519.GA31883@syl.local>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
 <20180329011634.68582-2-me@ttaylorr.com>
 <xmqqy3i930bl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3i930bl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 11:06:22AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > For some use cases, callers of the `git-config(1)` builtin would like to
> > fallback to default values when the slot asked for does not exist. In
> > addition, users would like to use existing type specifiers to ensure
> > that values are parsed correctly when they do exist in the
> > configuration.
> > ...
> > +--default value::
> > +  When using `--get`, and the requested slot is not found, behave as if value
> > +  were the value assigned to the that slot.
>
> For "diff.<slot>.color", the above is OK, but in general,
> configuration variables are not called "slot".  s/slot/variable/.

Thanks; I was unaware of this convention. I have changed "slot" to
"variable" as you suggested in the subsequent re-roll.

Thanks,
Taylor
