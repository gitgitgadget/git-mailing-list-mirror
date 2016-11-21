Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E8C1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 16:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbcKUQ5G (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 11:57:06 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:32872 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbcKUQ5F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 11:57:05 -0500
Received: by mail-yw0-f176.google.com with SMTP id r204so217060695ywb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mVV4SQ6jNbvooDFOsWAiZvxvWtL0GBBQrxM+wovRotc=;
        b=hAvKC8Q5bgJdD5U8wN7jKxXR6RTL6Ch3ZauzJ3us0PUtPR5z89VAq89iECI1cJcx5x
         wzrKNyYJVo8fUrO7uk+AtcB8xdOAU/K4T1nkyd6pbUtDP5gjslZoZxKMdnZrOAwOpjpP
         UWIp/qDBZWPbYNkqnpgmJDKJt45MOhz1A3LBv+o9Ds0KyRUtn58LaqZ8yYrFCK0lO81f
         3RjH+VWJd1sg6+1mYicpWvbr7m0re6YA04p6b+3DJCRq+eIu6lGf2liiY6rxB/go7UTn
         hxw/kchBx18Drlcar14WxJRrK1pizJzBHN2BPLoSGYrdyRVN7xFIHSJNC6gLu6HFzocS
         p0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mVV4SQ6jNbvooDFOsWAiZvxvWtL0GBBQrxM+wovRotc=;
        b=dLDz8aqXWwA6Vub1Fz4mbOD/93ZMkSMYCjjDrIuZYXuM9UZwO0EkxMukIiulEJdAUi
         3/yJI6clFTMO9/XBlt6BpAsgMEnbO44300tgwxgrDGO6wwUsnxaoutQKYBObydRaUENx
         GvrT1DYSKcFD339AVC8s/vz7miWlF+5MeJvf5c2tMGCLaB6X+739KXdzL7k3Wg93zDUV
         bTocK+R1pH5L14CaFInZ4obdqkfJF5ib/+HTtAhglBQA/BB9tBZCLg/82TK/PnILuEkk
         sgSWZzjqdIOkdzYBAlShgzXS2xbE6orC+BrhWz2bWgeX3ImFry0mYkJTB6xtLMUUPq+a
         Iknw==
X-Gm-Message-State: AKaTC03EF7II3YVD0A38J9Rng2n3wrgKeh4PhSgubyYsuNGOtEpEJUzuvA41EojnkY5zVe7mpfv7Ip6bQwB9ew==
X-Received: by 10.13.221.12 with SMTP id g12mr16379835ywe.257.1479747424831;
 Mon, 21 Nov 2016 08:57:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 21 Nov 2016 08:56:44 -0800 (PST)
In-Reply-To: <14657461479715884@web21h.yandex.ru>
References: <14657461479715884@web21h.yandex.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 21 Nov 2016 08:56:44 -0800
Message-ID: <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 12:11 AM, KES <kes-kes@yandex.ru> wrote:
> Hi.
>

Hi,

> I have some question about how diff works then give proposal:
>
> it will be very useful for each "symbol" store additional meta info as source line length. So in this case when git counter two equal sequence of commands it will do further comparison: Adds 23 chars deletes none VS adds 75 chars deletes 46
>
> Actually I got this:
>
> @@ -129,8 +132,9 @@ sub _preprocess_message {
>  sub _process_message {
>      my ($self, $message) = @_;
>
> -    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
> +    my $time =  [ gettimeofday ];
>
> +    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>      return $self->send_error(ERROR_REQUEST_INVALID)
>          unless defined($method);
>
> Instead of expected:
> @@ -129,6 +132,8 @@ sub _preprocess_message {
>  sub _process_message {
>      my ($self, $message) = @_;
>
> +    my $time =  [ gettimeofday ];
> +
>      my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
> -
>      return $self->send_error(ERROR_REQUEST_INVALID)
>

Have you tried the various options for git to search for smaller
diffs? Or using the other diff algorithms such as histogram instead of
patience?

Thanks,
Jake
