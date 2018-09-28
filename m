Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8276B1F454
	for <e@80x24.org>; Fri, 28 Sep 2018 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeI1SHG (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 14:07:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43992 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbeI1SHG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 14:07:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so1398585qtq.10
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R3iiYaCR1OQSHMQGyGskp5KhrhraXTyrbUsSmC17c4Y=;
        b=jqnC9MP589R+8n1g0kCFGhl0KHvol36psFPHofP016xyQpGBMUdM3pLr/ooWJIqd25
         OUVxk2Kfb8eMKWdf5aifPBWgQ/c29RFW5BYjHS0a+c2jCnlCdCWVX4dePHtul8dLJhS4
         guwJepvdcrhwvwo2gnL54/ddeifl6b08nGcbWnvIQrB/oXFvnti7WXmjWv7Tu9dhsIKk
         vL+e127on+GE99q3yWHCd/PgjEcWmEKQqwM1S7SfncfCHFpydKF4b3KAKRrn1ZCyQbsx
         6gM1bHT+8qR4GBm/lxl3v1k71KRomGRbhZgX0jNogfkwZzJbUhQ2ecyizJ27npISOB6J
         OQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R3iiYaCR1OQSHMQGyGskp5KhrhraXTyrbUsSmC17c4Y=;
        b=WDhN/UYijzwUN7101IsIJvrujBiuSAJBb4cugaxjNg5xjnzKP9wt0ZQ9I3JTL+3FWu
         SPyyHoDS1zq+KtqhrsgVZPqupbPh3IY0/oK90cQ4vqjuyNgFv1B9aVxwidK1WjV2Mhgb
         rLoqEVdKTUKxqHS5fxVp3vvCOW42+FHRcFgusTnpqj6vW5WTLXAdTgIDt8ifexwOaDnj
         RIidnjDbJvlbQAmhJV+u5DBsDp6B0ym0GlyLw9itR5nLXL+nIYLiVqikOVhN0tjrZiFU
         5kACOvZeOV6kIgJDPJiYhkq2IaZMr6NKjufyU4rWw4GsfOsJ0BJecAGfl6TqM4eifYYi
         cOPw==
X-Gm-Message-State: ABuFfoiNpeOiXmwCGz58w3kb2/8VATIcxVMHuRDH5NBGEo8XtdUW5/Ej
        T8mjbuS2qd1OqKpB4BoJtjOnmuCkk1MCdvbcDtE=
X-Google-Smtp-Source: ACcGV61QIpvcfHQ8Brmk0djMz8bpxzvIg3xOCXQ4EJLby0mK9xBLuPMZBUs0PhwQWEgrqjlwkYAeqf+UNs/lxj6uldk=
X-Received: by 2002:aed:33e7:: with SMTP id v94-v6mr12453277qtd.52.1538135022564;
 Fri, 28 Sep 2018 04:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
 <20180925115341.19248-8-chriscool@tuxfamily.org> <20180928103548.GC23446@localhost>
In-Reply-To: <20180928103548.GC23446@localhost>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 28 Sep 2018 13:43:30 +0200
Message-ID: <CAP8UFD1HBUL+Kv7biBLwfkL9j9syw+UwBgrJ5rAykZ-M5h8jbg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] t0410: test fetching from many promisor remotes
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 12:35 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Tue, Sep 25, 2018 at 01:53:40PM +0200, Christian Couder wrote:

> > +     IDX=3D$(cat promisorlist | sed "s/promisor$/idx/") &&
>
> You could drop the unnecessary 'cat', 'sed' is capable to open a file
> on its own.
>
> > +     git verify-pack --verbose "$IDX" | grep "$HASH2"
>
> Don't run a git command, especially one with "verify" in its name,
> upstream of a pipe, because the pipe hides the git command's exit
> code.

Yeah, I copied both of the above lines from the test just above the
one I added. So I will probably add a patch to fix those kinds of
issues in t0410 at the beginning of the series, and then of course
copy the fixed tests in the tests I add.

Thanks,
Christian.
