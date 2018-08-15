Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E672A1F42B
	for <e@80x24.org>; Wed, 15 Aug 2018 21:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeHPAvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:51:19 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:40454 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeHPAvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:51:19 -0400
Received: by mail-io0-f181.google.com with SMTP id l14-v6so2242966iob.7
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXrRi+0EpfbHgH5sE2SNN2RUByX9yWQ4/UVkuhHtS1c=;
        b=Qf4l+QmSzpXYv2yghqzFGXOOoexdPYWpdLeGyVTz4i96+jP0xeVRlSv/15GX9uyMgt
         ivAKwtjpRWsoeDe/doiuNJIL4VoP0lvd6WadWd9CmeT5yU40nyS9Ls9R14ugnNGnhs3t
         /+7Jby4lm2f8yNLqU6lNGQUu//RGk+H0tquqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXrRi+0EpfbHgH5sE2SNN2RUByX9yWQ4/UVkuhHtS1c=;
        b=fRuo0MD8jBfs5i9U9q0Yo2b6RahxC1oQt4JdvS9T9NV6/f46e5eJTWYvWxonmc0mfU
         JjCYo31L+wMkxzfVJOzMqwOoYMRLOBY2jlFfOjR3NTkZu57rt6y/Aa+GGK72NwU7do0P
         ReBk5C/23+cJIR22w2SqlIXM6q6cssUr4bIhZehCulkDh3zSn1WfgV8WCExuvOxWjM7Q
         QSC+0Xv3OQi/MJbsEAWMpf3pf8h/jlkCksAN/3eIfA10wrhtYNSUSlu1OP/F4GlYigTF
         ZhZLJwsI7gwfJ2jcJMNRa0d9fwncQ7jg5a7tJNVE+v0i4YxKezSwnrV76WYAwfnMzEa4
         e8mA==
X-Gm-Message-State: AOUpUlGcPBHopAN/V2eE5SPRpGUyMjwuv8vSC5cjY3sIoh+roCZtrTjZ
        T5PmYqi+TN/csvzGfq0qLD0+eBXnBoN7OnyLJbY=
X-Google-Smtp-Source: AA+uWPxxEfkz3pNoj1nsOyzoqMZv6aSjKHqytPRpF+GYvT6x4yb7asWHm4qbghXzLMC/FnIhxgAS5FJc0JdudT+cGOo=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr19434556iom.238.1534370237208;
 Wed, 15 Aug 2018 14:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
 <87k1orqpxj.fsf@evledraar.gmail.com>
In-Reply-To: <87k1orqpxj.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 14:57:05 -0700
Message-ID: <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
Subject: Re: "less -F" is broken
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bug-less@gnu.org
Content-Type: multipart/mixed; boundary="000000000000f17daf0573806844"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000f17daf0573806844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2018 at 2:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Downloading & trying versions of it locally reveals that it's as of
> version 520, not 530. The last version before 520 is 487. Presumably
> it's covered by this item in the changelog:
>
>     Don't output terminal init sequence if using -F and file fits on one
>     screen[1]

Side note: that's sad, because we already use X in the default exactly
for that reason.

So apparently "less" was broken for us to fix something that we
already had long solved. The code basically tried to do "automatic X
when F is set".

And all that line_count stuff (which is what breaks) is pointless when
-X is already given.

That does give a possible fix: just stop doing the line_count thing if
no_init is set.

So "-F" would continue to be broken, but "-FX" would work.

Something like the attached patch, perhaps?

            Linus

--000000000000f17daf0573806844
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jkvodr7m0>
X-Attachment-Id: f_jkvodr7m0

IG1haW4uYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbWFpbi5jIGIvbWFpbi5jCmluZGV4IDE3OWJkNzguLjk2MWE5
ZGIgMTAwNjQ0Ci0tLSBhL21haW4uYworKysgYi9tYWluLmMKQEAgLTU5LDYgKzU5LDcgQEAgZXh0
ZXJuIGludAltaXNzaW5nX2NhcDsKIGV4dGVybiBpbnQJa25vd19kdW1iOwogZXh0ZXJuIGludAlw
cl90eXBlOwogZXh0ZXJuIGludAlxdWl0X2lmX29uZV9zY3JlZW47CitleHRlcm4gaW50CW5vX2lu
aXQ7CiAKIAogLyoKQEAgLTI3NCw3ICsyNzUsNyBAQCBtYWluKGFyZ2MsIGFyZ3YpCiAJewogCQlp
ZiAoZWRpdF9zdGRpbigpKSAgLyogRWRpdCBzdGFuZGFyZCBpbnB1dCAqLwogCQkJcXVpdChRVUlU
X0VSUk9SKTsKLQkJaWYgKHF1aXRfaWZfb25lX3NjcmVlbikKKwkJaWYgKHF1aXRfaWZfb25lX3Nj
cmVlbiAmJiAhbm9faW5pdCkKIAkJCWxpbmVfY291bnQgPSBnZXRfbGluZV9jb3VudCgpOwogCX0g
ZWxzZSAKIAl7Cg==
--000000000000f17daf0573806844--
