Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D731FD09
	for <e@80x24.org>; Wed, 31 May 2017 14:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdEaOYM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 10:24:12 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34787 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdEaOYL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 10:24:11 -0400
Received: by mail-io0-f178.google.com with SMTP id k91so16923305ioi.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oam6Fp8GDVe6i6plmE00dGytvjwlksnbFytMjjnhMxA=;
        b=T+921vNEhuBOKvDd2R52f623aNA5+z5IoGg3THrFjuazIJCxDjbjQ8a3oJ5ue9VKS3
         Bgyhue/5g22OpQRWJqX0+uJ8sZZElvixeKnM086520dBBkOyZ6abUu3XnoFgvO2gC86P
         jxWBtqURQpYXmwKFcf65Fvqu3w5hGdHQc7TsBMpRZrbL+w5XgRLL64gglkNStnHpsjD/
         AFRq6XUetErUWFHy58x2qwg9gnvd2/jFKv3rLhmBFT235B7Q15Ovk0Q1bv4llGwuurG2
         dSS0/WQ+bpY4ShPh0j9gqg0CZiPKUIPNWrmbmF/9pH0F/ZnUUhhsVIR+c6fCW4h/DwSk
         UYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oam6Fp8GDVe6i6plmE00dGytvjwlksnbFytMjjnhMxA=;
        b=cppENntEps4jiujIzMfv7aZ636B/xzBwrcDH1qqv5N5fSjEhLYHls5MR7WYtZNRiXB
         eLPt1skp+4HkQqMkLWoU2Wa+E0CUe/jcXyJPH7YMCP8a7eQ3YMLAL4HC0y3w5OelWCOT
         e7wFvL15gStX8nCrkyf135OW/JVOMaqND7AUL7yD48/aUn/L4T7b6t2ebex/owCW9QTX
         LWi0r7er2xnZcpKHsXokb7GWfFQMAhZT3uk55Nkjrjd3Aq+Ch+UtZelaE1p9rmpqHwP9
         45f1VdJeMYmr4RxNrFUrY0SX2V31c7iZc7kKaoAAVA1bfQpIyaDgtlVxiaHqG8FNy2WN
         ZO2w==
X-Gm-Message-State: AODbwcCHvQYizmozi1E8iV+9LDKwZgmQGjrqLIe40oplkDRNRWrt3SPg
        gTCBOQ995GmncuH3rpRwDWZVy1nMVw==
X-Received: by 10.107.138.21 with SMTP id m21mr22305472iod.80.1496240650439;
 Wed, 31 May 2017 07:24:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 07:23:49 -0700 (PDT)
In-Reply-To: <20170531045051.ctoo7sv3f66xurdf@sigill.intra.peff.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net> <1495230934.19473.10.camel@booking.com>
 <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net> <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
 <20170531045051.ctoo7sv3f66xurdf@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 16:23:49 +0200
Message-ID: <CACBZZX6LQRW=78R-rkeUKmDCRUmN52SjkShSjDC5AgV5o7T6iQ@mail.gmail.com>
Subject: Re: persistent-https, url insteadof, and `git submodule`
To:     Jeff King <peff@peff.net>
Cc:     Elliott Cable <me@ell.io>,
        Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 6:50 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 26, 2017 at 11:22:37AM -0500, Elliott Cable wrote:
>
>> Hi! Thanks for the responses (I hope reply-all isn't bad mailing-list
>> etiquette? Feel free to yell at with a direct reply!). For whatever it's
>> worth, as a random user, here's my thoughts:
>
> No, reply-all is the preferred method on this list.
>
>> > The other approach is to declare that a url rewrite resets the
>> > protocol-from-user flag to 1. IOW, since the "persistent-https" protoc=
ol
>> > comes from our local config, it's not dangerous and we should behave a=
s
>> > if the user themselves gave it to us. That makes Elliott's case work o=
ut
>> > of the box.
>>
>> Well, now that I'm aware of security concerns, `GIT_PROTOCOL_FROM_USER`
>> and `GIT_ALLOW_PROTOCOL`, and so on, I wouldn't *at all* expect
>> `insteadOf` to disable that behaviour. Instead, one of two things seems
>> like a more ideal solution:
>>
>> 1. Most simply, better documentation: mention `GIT_PROTOCOL_FROM_USER`
>>    explicitly in the documentation of/near `insteadOf`, most
>>    particularly in the README for `contrib/persistent-https`.
>>
>> 2. Possibly, special-case =E2=80=9Chigher-security=E2=80=9D porcelain (l=
ike
>>    `git-submodule`, as described in 33cfccbbf3) to ignore `insteadOf`
>>    rewrite-rules without additional, special configuration. This way,
>>    `git-submodule` works for ignorant users (like me) out of the box,
>>    just as it previously did, and there's no possible security
>>    compramise.
>
> After my other email, I was all set to write a patch to set
> "from_user=3D1" when we rewrite a URL. But I think it actually is a bit
> risky, because we don't know which parts of the URL are
> security-sensitive versus which parts were rewritten. A modification of
> a tainted string doesn't necessarily untaint it (but sometimes it does,
> as in your case).
>
> We could actually have a flag as part of the rewrite config, like:
>
>   [url "persistent-https"]
>   insteadOf =3D "https"
>   untaint =3D true
>
> but I don't think that really buys anything. If you know about the
> problem, you could just as easily do:
>
>   [url "persistent-https"]
>   insteadOf =3D "https"
>   [protocol "persistent-https"]
>   allow =3D always
>
> It really is an issue of the user knowing about the problem (and how to
> solve it), and I don't think we can get around that securely. So better
> documentation probably is the right solution.
>
> I'll see if I can cook something up.

I was going to say: A way to have our cake & eat it too here would be
to just support *.insteadOfRegex, i.e.
"url.persistent-https://.insteadOfRegex=3D"^https://".

But in this case, even if we can just do un-anchored string
replacement, isn't a way around this just to do
"url.persistent-https://.insteadOf=3Dhttps://" & untaint & document that
you should do that?

Although that would potentially leave people who have existing
protocol rewrites without :// open to rewrites they didn't intend for
submodules...
