Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A23202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 20:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdJ2UHY (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 16:07:24 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:49413 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdJ2UHX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 16:07:23 -0400
Received: by mail-qt0-f172.google.com with SMTP id k31so14041799qta.6
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=z2p7qUoj9W7+rvv7Erm0gtrujqz4AVooy5LZ1NeaBX8=;
        b=Xz608pnPkfv0juCqt0/vHGO12cDgYJV67mIwD5pgoc9REGTHlhQkirKPDRPsq5KDgc
         XrhZrXfNh8HqMpNzOrrBYbjSVhq88ZXMu+vSJQbeMMl0AaCwCe9VhAGZgyuy6doHpwLH
         mYWbZreZzhauMMBW6kBMk/r/tM9yGbYEZSPW+TbpjMXNka1yckP4tg+NpbwenDnW/4pw
         EEST2iqe22wkHQTlUJkV0l1y7AKtCZQLU0gk4MjU6xVe8ogchKzBc1THsauExM8VwTqc
         0RoMVhzLYs+/p34xlkPob9NXzM/3Z9Et9pn+89pRBciIMmQq+QNbYTYNQSY6O4LWiKMl
         GemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=z2p7qUoj9W7+rvv7Erm0gtrujqz4AVooy5LZ1NeaBX8=;
        b=ny/Yz659AUuzr5vzdvRFreRZ226Nh/UPl64Qe6ZnLI7GOUteJyJ3CCRuPgxSUlOY5l
         Qh/C93D4LgWFYVVdqF1XRvpHNhHZDSOxv5GcYhXgvn9iO1wdNXFqVzH45iHzV8l2tCbg
         2izReD89CVlTpDRaowZ6lB738xiYfrZymkP+7xER8FuEBcnyKoTpYL+7y4n1sWm8nJhR
         +R+NhnPPUKHfwWBD7lU+ke4PERBg39vMKcoNpUzoDz3gtYhsRfeo+n0e4UQfsxD4sxNa
         09Hh1FiY1JTTKjZ78DM3eVbTi7WKIHtvJXSnQk38HujfkKGLCRmnWKKljkVDNZ+Wv8jm
         ll2w==
X-Gm-Message-State: AMCzsaX8wm0DtoW4h6wQWKDwCTdXawUeeGpRJklO2qNambzNKTKcVvBt
        fG0H3q/iKVWd778XqSHAhAXyKxJhYmJqEkiPhtdsLQ==
X-Google-Smtp-Source: ABhQp+TI2IIrDt2LRN8rZIyTaaEWfo1EdeHyHfKYu5Lp5peQja4gVswuep7DhT5sa41YSi362+/fKK0s9IrLFA4trR8=
X-Received: by 10.200.53.12 with SMTP id y12mr11561434qtb.84.1509307642220;
 Sun, 29 Oct 2017 13:07:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 13:07:21 -0700 (PDT)
In-Reply-To: <87a809959p.fsf@curie.anarc.at>
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-2-anarcat@debian.org>
 <CAPig+cSmfJ2Uv21Q4DgJNoy6Ywj7GWPJa6qq0YL9Kar6Q74a_Q@mail.gmail.com> <87a809959p.fsf@curie.anarc.at>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 16:07:21 -0400
X-Google-Sender-Auth: UbrHL8pcmTpEW8YEAUvFvn0XMMg
Message-ID: <CAPig+cTySXEWGxSUTxQXmHz7rR_nTbf+ALciZahJ2Ks6EmSqzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] remote-mediawiki: add namespace support
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>, Kevin <kevin@ki-ai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 2:29 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org> =
wrote:
> On 2017-10-29 13:24:03, Eric Sunshine wrote:
>> On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupr=C3=A9 <anarcat@debian.o=
rg> wrote:
>> So, the idea is that if the input has form "something:number", then
>> you want to look up "something" as a namespace name. Anything else
>> (such as "something:foobar") is not considered a valid page reference.
>> Right?
>
> frankly, i have no idea what's going on here.
>
>> The multiple 'return's are a bit messy. Perhaps collapse the entire
>> function to something like this:
>>
>>     sub get_mw_namespace_id_for_page {
>>         my $arg =3D shift;
>>         if ($arg =3D~ /^([^:]+):\d+$/) {
>>             return get_mw_namespace_id($1);
>>         }
>>         return undef;
>>     }
>>
>> In fact, it may be that the intent of the original code *was* meant to
>> do exactly the same as shown in my example above, but that the person
>> who wrote it accidentally typed:
>>
>>     return get_mw_namespace_id($namespace);
>>
>> instead of the intended:
>>
>>     return get_mw_namespace_id($1);
>>
>> So, a minimal fix would be simply to change $namespace to $1.
>> Tightening the regex as I did in my example would be a bonus (though
>> probably ought to be a separate patch).
>
> so while i'm happy to just copy-paste your code in there, that's kind of
> a sensitive area of the code, as it was originally used only in the
> upload procedure, which I haven't tested at all. so i'm hesitant in just
> merging that in as is.

I don't think there's a need to copy/paste my example code. If you
instead make the minimal suggested fix, then the resulting code will
be effectively equivalent to my example (minus the tighter regex).

> i don't understand why or how this even works, to be honest: page names
> don't necessarily look like numbers, in fact, they generally don't. i
> don't understand why the patch submitted here even touches that function
> at all, considering that the function is only used on uploads. I just
> cargo-culted it from the original issue...

I, myself, am not familiar with or a user of Mediawiki or with the Git
bridging, and I don't know what page names look like, but I'm pretty
well convinced from reading both the existing code and this patch that
the changes to get_mw_namespace_id_for_page() are really just a bug
fix to that function. My interpretation is that the function really
was intended to strip the ":id" portion of "name:id" before calling
get_mw_namespace_id(); the fact that the original code neglects to do
so seems just an oversight. The fact that the regex uses capturing
parentheses implies strongly that it was indeed the intention to use
$1 in the call to get_mw_namespace_id(). Unlike the "fix" in the patch
you posted from Kevin, which is perhaps unnecessarily complicated, the
fix I suggested above is about a minimal as possible. That is,
changing:

     return get_mw_namespace_id($namespace);

to:

     return get_mw_namespace_id($1);

should achieve the same result. (It could be made more robust by
tightening the regex as in my example, but that's a separate topic,
not needed just to get the function to work as intended.)
