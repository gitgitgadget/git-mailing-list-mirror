Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F224E208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbdHJTjX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:39:23 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:38860 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbdHJTjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:39:22 -0400
Received: by mail-qk0-f173.google.com with SMTP id x191so9873601qka.5
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TghPVExgFElsZOBR207Tf4svLzG7+9zQLZFEEhH+Rsg=;
        b=IXg8I/FlHXUsxjWA+d/n2IS5URUVIlIeV4Xl1GJdQOoGjuSa6pQ1NPf9emXdoh8ino
         /kZ1A3U6DquZiPkTQcoqsguhkP2ylA6rf8af3kjpZJ1plxuspHHqrYI29Wxn8qr90njO
         GbW2WaWgoS72ZceI20Qizjf0mM6u0WKO7WIQGx7ylKKPt9ndqiN/smoOqcqqYF4Z6x++
         G82mXkdi8rN7Vkv0m2X3LXYA4DUOU3we8GaR1jeNwjlMgE1Cs5ZkKflgxd3hyjwYtRXm
         shymFwacPbLeAWyQWvikq3B87j2PmQu7XXxUXdxdcUts+ah7yASg+ekz+irmdE5dHB6M
         G7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TghPVExgFElsZOBR207Tf4svLzG7+9zQLZFEEhH+Rsg=;
        b=bu4RxXRXp9wfNnQRZdoMpRWyQ0VHuA2LS+j0lx2WTU4RLS/YvpfdB2+4FS6ZAPeFgd
         NWJzEU4Z0AFs4b8pYi1l+dvkx8AlHT3GkQjGMobJpdu6rz08HUsg3bhQ8Xj6HN0fbDYE
         sg6QHNGC6/qH7CeQtTClJvyDLnMJwmQF3YiMsSQJ61k9OEls/pW1kbRoDedKwckzOSm5
         LnC5dbfCBYy52zeAxwKfrUq4k398NnkNualLXK9l67LEHbA4FoMIkScK8yn9N9Vvn0cj
         wj8c4QtX4Y/8eLiPD/piALPbsntuCRu7jEtL4tQ4+gLAGpmikTfEEPliqc1vMWdwEKHd
         1E3Q==
X-Gm-Message-State: AHYfb5iGO92BQkeaoCfd2mgvOi/1AAMfvhTTmb0zHciaRZ0egzl5zMg5
        IclSP00bJmW5BT7Uj4MsYrMKoGsg3g==
X-Received: by 10.55.71.76 with SMTP id u73mr17907665qka.25.1502393961599;
 Thu, 10 Aug 2017 12:39:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 10 Aug 2017 12:39:21 -0700 (PDT)
In-Reply-To: <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net> <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 Aug 2017 21:39:21 +0200
Message-ID: <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 8:37 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 10, 2017 at 11:35:00AM -0700, Stefan Beller wrote:
>
>> On Thu, Aug 10, 2017 at 1:03 AM, Jeff King <peff@peff.net> wrote:
>> > The point of "--only-trailers" is to give a caller an output
>> > that's easy for them to parse. Getting rid of the
>> > non-trailer material helps, but we still may see more
>> > complicated syntax like whitespace continuation. Let's add
>> > an option to normalize the output into one "key: value" line
>> > per trailer.
>> >
>> > As a bonus, this could be used even without --only-trailers
>> > to clean up unusual formatting in the incoming data.
>>
>> This is useful for the parsing part, but for the writing part we'd
>> rather want to have the opposite thing, such as
>> '--line-break=rfc822'. But this doesn't have to be part of this
>> series. With this in mind, I do not quite understand the latter
>> use case how you would use normalized trailers without
>> --only-trailers?
>
> If you prefer the normalized form (and the input was line-broken in a
> way that you don't like), then this would convert to your preferred
> form. I agree that you could potentially want the opposite (folding long
> lines). Perhaps something like --wrap=72.

Related to this, I wonder if people might want to "normalize" in
different ways later. If that happens, we might regret having called
this option "--normalize" instead of "--one-per-line" for example.
