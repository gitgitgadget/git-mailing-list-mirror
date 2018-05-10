Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB861F406
	for <e@80x24.org>; Thu, 10 May 2018 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757401AbeEJSbO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:31:14 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:43279 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757311AbeEJSbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:31:13 -0400
Received: by mail-io0-f177.google.com with SMTP id t23-v6so4116522ioc.10
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hnDt0AlTc10O7vucZ1uzDEFBD0KTpAlNopyldAKM0/w=;
        b=HYAGvjiITo85MHQYCi/RluqNFKUIVV1FrrQOrEHCqe2BEnnvTBdDy0aPRuYD0wu+yj
         qtf0oZVUxMdcQpAdenlB8yEoy23HuPjZEFPPI+aGFRrP5B0wwbvI5h7VMhiyzp1XNvVm
         xF8XNUdh7JCj9cL/J68H0t16XRY+VaZwOW4JCCGu97M6xuExMCOFHwooayDlmJsQqI/y
         CcK7VSC+aLkKbFaIatWSslVF7gT+3OJtTflULXpEA5z5vV8sdJNNNqIQ/+L4jEudMaih
         mwVyoTXdZBUbAWWSfVm9jzxtEFx27ll37wLwmoW/6HglR4dYsvqt9L9j60NLm6qBskXs
         Pkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hnDt0AlTc10O7vucZ1uzDEFBD0KTpAlNopyldAKM0/w=;
        b=Gv9Qx6jS92kEDAZyH3hvcJezvFAPLspImcQsdp3C8ki0SX8CzozEK50l8u4mBVe8a/
         8FBZaNlZJiOJLCm3avdbCOxnyu727J241eaZRkaAQmjKKrcogpxPS4xrG21VM1VjT6PA
         Vm9fwi2tHXZ7wyBSu2tclBH1IWVX/aYRMb+m1BcpYUbY5piHYy7xIOQvFjO6OjsB1QJG
         oPPuTdGpT2nLQ25crpf7qgG8XKlRqwE6sYKmxr+cxyYYeboaxrPFSFDooyDWuiruejw7
         qCo5VB33EhWOod0wlqk8gkmi4TGXNW/LYRFgLFfuWXr3otup99ew9ZxLRX9y0q+QX6U5
         4POQ==
X-Gm-Message-State: ALKqPweyIsGnsBqZMtHNxCk2HLOquF5EZP59UZYQV/CFR9FwuCtZ05T5
        z/ikwhi4evJBlPpyWdfc5iUJ/P7I6MCuAp69spq6OVQH
X-Google-Smtp-Source: AB8JxZpLVoKkpHt7GDnQjV4XbrhUZhzRSgFY2kg44pJ4eW6DIjn4zHsfjP5hQ08XiF5nA74OTSxEDu13iJPlu42gEgU=
X-Received: by 2002:a6b:9dc1:: with SMTP id g184-v6mr2516487ioe.41.1525977073058;
 Thu, 10 May 2018 11:31:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.114.23 with HTTP; Thu, 10 May 2018 11:30:52 -0700 (PDT)
In-Reply-To: <418E3D80-FE0F-436B-B9D1-475E49C4D75D@gmail.com>
References: <418E3D80-FE0F-436B-B9D1-475E49C4D75D@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 10 May 2018 20:30:52 +0200
Message-ID: <CACBZZX7Mgsd8cSzZc0YTPgziB6FiFhPiHZ_mG5C_PCshrp4=vg@mail.gmail.com>
Subject: Re: bug: SHA1 calculation on PPC machines when built with gcc older
 than 4.6
To:     Ken Cunningham <ken.cunningham.webuse@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 8:11 PM, Ken Cunningham
<ken.cunningham.webuse@gmail.com> wrote:
> Some vintage Apple PPC machines build a non-funtional version of git as o=
f git 13.1 when using the stock gcc compilers that are installed with the O=
S; the SHA1 calculations are faulty. This can be repaired with a simple pat=
ch (attached).
>
>
> Stock vintage Apple PPC machines come with gcc-4.0 or gcc-4.2. On MacOS 1=
0.4 and earlier, or when not using Apple Common Crypto on 10.5, git uses th=
e SHA1 calculation code from here <https://github.com/cr-marcstevens/sha1co=
llisiondetection>. The code in <https://github.com/cr-marcstevens/sha1colli=
siondetection/blob/master/lib/sha1.c> tries to detect all systems that are =
BIG_ENDIAN, but the above noted systems fall through because they fail the =
tests.
>
> It appears that the primary test:
>
> #if defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__)
>
> only works as of gcc-4.6 and newer, so the code is built as LITTLE_ENDIAN=
 on PPC with older gcc versions.
>
>
> Issue report:
>
> <https://github.com/cr-marcstevens/sha1collisiondetection/issues/40>
>
>
> MacPorts bug report:
>
> <https://trac.macports.org/ticket/54602>
>
>
> The included patch to git fixes the issue on our testing.
>
> Thanks for git!
>
> Ken Cunningham
>
>
>
>
> =3D=3D=3D=3D=3D
>
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 25eded1..5faf5a5 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -92,6 +92,10 @@
>   */
>  #define SHA1DC_BIGENDIAN
>
> +#elif (defined(__APPLE__) && defined(__BIG_ENDIAN__) && !defined(SHA1DC_=
BIGENDIAN))
> +/* older gcc compilers which are the default  on Apple PPC do not define=
 __BYTE_ORDER__ */
> +#define SHA1DC_BIGENDIAN
> +
>  /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelis=
t> */
>  #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
>  /*

Thanks. As noted in
https://public-inbox.org/git/87603xxc3k.fsf@evledraar.gmail.com/
patches like this should be sent to the upstream, it appears you just
opened an issue there, but sent the patch here. Could you open a PR
with upstream with this patch?
