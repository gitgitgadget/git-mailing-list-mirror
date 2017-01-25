Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B7B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbdAYWiZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:38:25 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36244 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbdAYWiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:38:24 -0500
Received: by mail-io0-f169.google.com with SMTP id j13so25628884iod.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rH/Hr52HAe79De/+Q+/tQ4z2N2qiCZrR6tAaSI7Fk5c=;
        b=YXM9b4b80qKmxXtjUUxmt60jvC4oUtP8Le3A9GwT5RQDA28KlMBkXX17nc57CVd42z
         zGz4a8BlDrt60zC2mJP9CaI1EwH/021oSrV5SJtO9BWmPUXV/BmyA+0b+s0Yu5YwmiSO
         rfwnvMAaseDl17xuv4aFfzaXZrE5YAZVfpGl8bSn4aCtGCgHsfEMTMIry15CVnUBNu3B
         wLV4/uVkoEkbirVcCPcI9XooiwqnQC23BjoAZz4FSdpo2/ADok9tur5XOD3JIijjvrut
         XrzMivkyvIu9yc5D5dBfppFaLZ6y5cbZhArOLYm+9jckq8ZB+gi9dzlP4k7AOAfAd+4n
         sRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rH/Hr52HAe79De/+Q+/tQ4z2N2qiCZrR6tAaSI7Fk5c=;
        b=iiHagfpuKr3s5s1F23UX0gC/vw8Z8Qv7Nl+IsIEdzI1Ob3etzGxuVMVCrD8s1G681p
         b/bXNK/SZfqSq9C302C5ohOEllkrRDbpz/2iBrwm4L6wjzAq8X2hJ4KzRuyErlBXbG4x
         KEN5qpgsyQlT8p/5w94wKVa7hvoGGiPNVO36rxIvQH+U/G7v0dT2DSZjWe9bM5Aj9j39
         KlFmvfOq6oAZXHmnHqVWepe87PrKTn5jMe2mVJa1o7PeYiJWpg8DrhzhX21moeZU3fUd
         xi7kSu8vwrz3To6Ajd5P24ixOVVMHMQD4cqnxsYzVlBcNypGAhuF3m/FyBS1NiTeOfH6
         6eKQ==
X-Gm-Message-State: AIkVDXIBbPrYtEqO3xIa92jkc8RiJ/Ijw066Rqp+jq4F47c8GhVieL2rUzZVWxgLGTLFHoJz2nXDzrJbHMl7vUFa
X-Received: by 10.107.3.160 with SMTP id e32mr231336ioi.52.1485383903890; Wed,
 25 Jan 2017 14:38:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 14:38:23 -0800 (PST)
In-Reply-To: <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com> <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 14:38:23 -0800
Message-ID: <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>,
        Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 10:54 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> -Do not PGP sign your patch, at least for now.  Most likely, your
>> -maintainer or other people on the list would not have your PGP
>> -key and would not bother obtaining it anyway.  Your patch is not
>> -judged by who you are; a good patch from an unknown origin has a
>> -far better chance of being accepted than a patch from a known,
>> -respected origin that is done poorly or does incorrect things.
>> +Do not PGP sign your patch. Most likely, your maintainer or other
>> +people on the list would not have your PGP key and would not bother
>> +obtaining it anyway. Your patch is not judged by who you are; a good
>> +patch from an unknown origin has a far better chance of being accepted
>> +than a patch from a known, respected origin that is done poorly or
>> +does incorrect things.
>
>
> Wouldn't this also benefit from a forward reference to the section 5 on the
> DOC signining? This would avoid Cornelius's case where he felt that section
> 5 no longer applied.

Yeah I agree. My patch was not the best shot by far.
