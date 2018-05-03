Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0019D200B9
	for <e@80x24.org>; Thu,  3 May 2018 12:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeECMlH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 08:41:07 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35191 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbeECMlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 08:41:06 -0400
Received: by mail-wm0-f54.google.com with SMTP id o78so30200954wmg.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JH5bYTRmmctl2ppdAmkhfQsMJ3xlPqU0SoWnnm+5JSQ=;
        b=YvAOMnWHc++CiJm/EoLLKMbq9UkzATAhk6dWd6lcsJkSoGT7xzskTdFHG6xoRiNSD2
         lZSpXsRaX+apkHFPnCvZMIS7Df7V7xUVPR+1tA6ULuHQWoJiXTcR1Y2fuc+cBoD3HNFm
         Fh0RxE84rh5JRNivwlQw0ihAerr/QtzOJIC6PwMe8lmNG3izex/gVasVYtlsMr5mX31A
         tRCZPWQhI+POnmtUTGgRrxQZ8aOU1oqJbwVYSpsrLgYfT9lV1OSYgsJkE1AsOXlPR9fN
         N7xX5B7qESLHPHsSppdRXDFI6peAqEil0Pz8kEy3+nkIJJ1LR+8gLozn4ipqt/4Cat+v
         quNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=JH5bYTRmmctl2ppdAmkhfQsMJ3xlPqU0SoWnnm+5JSQ=;
        b=Fo9ztmTt7llH/5rKovVEbVf/6xJR3puKdCz3TJ2FRzC3lcoDRARTofkjjjbpLFbySP
         ZKmmLTX1v5UcQIEtDgqgR3G5RcznBcOE3zrNWv6q6G+5ragIFELsMeJInYLgiBesqTMX
         Nq4bxhpYvotP54Q4EmN282hxUQmG7JUZKBAqWlctQ3wRaR2xjhtNS65UqaxHy4RvJssy
         ZJRGYOjwk7dviJUIMcFEHHtUk2dXUx6f2g8WsvFqg0H9wdUQedV9O1jZaQdT97Px6nN4
         DyFzyT5sNwCZm40699KsJU9M8O6gDNOcsfCz/fkvurFxH4E6RgrMJpqEoiedQ6767WBf
         FozQ==
X-Gm-Message-State: ALQs6tD7NV9Tf+FplaqeE6F75JhSKoyp9U5fynU4mq1UdpTgrmXYWbJG
        8f9N0oWtmc/XKvAUPJWOX4JTiedL
X-Google-Smtp-Source: AB8JxZqUXeMF8IuSzqVXn753/RaSgOm5jSYgevBDBunv5PkE/YMP3BIT3uv96RSwM/p1WtMt4o8nZA==
X-Received: by 10.28.173.198 with SMTP id w189mr13837445wme.15.1525351264660;
        Thu, 03 May 2018 05:41:04 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egn45.neoplus.adsl.tpnet.pl. [83.21.77.45])
        by smtp.gmail.com with ESMTPSA id o15-v6sm1648255wrj.13.2018.05.03.05.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 05:41:03 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shin Kojima <shin@kojima.org>, git@vger.kernel.org
Subject: Re: [PATCH] gitweb: Measure offsets against UTF-8 flagged string
References: <20180501064015.59977-1-shin@kojima.org>
        <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 03 May 2018 14:40:59 +0200
In-Reply-To: <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 May 2018 17:01:53 +0900")
Message-ID: <86k1skzzc4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Shin Kojima <shin@kojima.org> writes:
>
>> Offset positions should not be counted by byte length, but by actual
>> character length.
>> ...
>>  # escape tabs (convert tabs to spaces)
>>  sub untabify {
>> -	my $line =3D shift;
>> +	my $line =3D to_utf8(shift);
>>=20=20
>>  	while ((my $pos =3D index($line, "\t")) !=3D -1) {
>>  		if (my $count =3D (8 - ($pos % 8))) {
>
> Some codepaths in the resulting codeflow look even hackier than they
> already are.  For example, format_rem_add_lines_pair() calls
> untabify() and then feeds its result to esc_html().  The first thing
> done in esc_html() is to call to_utf8().  I know that to_utf8()
> cheats and leaves the incoming string as-is if it is already UTF-8,
> so this may be a safe conversion, but ideally we should be able to
> say "function X takes non-UTF8 and works on it", "function Y takes
> UTF8 and works on it", and "function Z takes non-UTF8 and gives UTF8
> data back" for each functions clearly, not "function W can take
> either UTF8 or any other garbage and tries to return UTF8".

The problem with handling encoding in sane way, that is encode it on
input (to UTF-8), and decode on output (to plain text or HTML) is the
$fallback_encoding.

Gitweb assumes that everything uses UTF-8 encoding.  If the source is
not in UTF-8, but for example uses latin-1 encoding, then there we could
stumble upon byte sequences which are not valid UTF-8.  If that happens,
then gitweb tries to convert it to UTF-8 using $fallback_encoding.  If
$fallback_encoding is single-byte encoding, like latin-1, where any byte
sequence is valid, then that's all.  If there is an error during
conversion to UTF-8, then Unicode REPLACEMENT CHARACTER, code point
U+FFFD, is used.

But there are places where gitweb outputs plain text; the intention is
to use source data as is - to have it as one would have in the console.
Some input paths are common for plain text and HTML output; because of
that problem the data is not converted to UTF-8 on input.


The to_utf8() function tries to be clever, and do not convert alredy
converted data.

> Also, does it even "fix" the problem to use to_utf8() here in the
> first place?  Untabify is about aligning the character after a HT to
> multiple of 8 display position, so we'd want measure display width,
> which is not the same as either byte count or char count.

I think the problem is not with aligning, otherwise we would simply get
bad aling, and not visible corruption.  The ACTUAL PROBLEM is most
probably because of concatenating strings marked as UTF-8 and strings
not marked as UTF-8.  Strange things happen then in Perl, unfortunetaly.


One solution would be to force conversion to UTF-8 on input via "open"
pragma (e.g. "use open ':encoding(UTF-8)';").  But there is no
UTF-8-with_fallback encoding available - we would have to write one, and
install it as module (or fake it via Perl trickery).  This mechanism is
almost the same to what we currently use in gitwbe.

Another would be to use the trick that Perl 6 uses when encountering
byte sequence that is invalid UTF-8 - encode it using private plane in
Unicode using UTF-8, thus achieving lossless conversion / decoding.  But
this also as far as I know is not available from CPAN, so we would have
to implement it ourself.

Best,
--=20
Jakub Nar=C4=99bski
