Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFAD20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 14:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdFAODL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 10:03:11 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32968 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAODK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 10:03:10 -0400
Received: by mail-lf0-f41.google.com with SMTP id a136so12831452lfa.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ixz5IOX0h7ZYwE6YMAVZ9TgYS/piIQtXN0V/M2w6LOg=;
        b=lYxwAW5ZnnltVQpSp+4C1FI1t7xxjMrlCy2s93nL0MSg/R6brYenCxfCEIcXUK1bQ8
         f0f0fWsiWRqdj9DOet9Sx1AwHGzovFGhsVrOJN2ISV/zgJi9Qf8eyNxhUvhcIHv+dcgi
         0KnwRE2S3yvDj/Bc7fo8x/YtVYI3RW2bWT/6Vpqh9WHu9u/hfIMCDeDOvLmHJb+V6VLE
         W8oAvPCJ+XXAi6NZfPmq4XWpQJymzSUnZq/VGYkv16un+EigaykBQ+nHKfu3RsAKIBJ5
         moxt11w+YaNcxwofCBZtLEC+rtCaOm36gkjM6l2oeiqPlUhg4Zj7Oizi/IrE8btrZiQe
         1ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ixz5IOX0h7ZYwE6YMAVZ9TgYS/piIQtXN0V/M2w6LOg=;
        b=bOKkKtufRR3v2ZsOnRVOCDQ+mJQFIIh97QEt+zmr5Fs+CQUlq9QzDcoHaQTB/jHHmO
         jECacXYEBOm6lqkq8eyXQACJfl2sjkNYGs/6sNPNRej2ma4aWoZEWEei3aL25s52HZqo
         mAVEk1RRQb5jMcfLy7fE/9AOEt11WcbELvpYgM7E5M+enXX+4yiM+C5I/Fwm2Gm1+dA+
         sKDF6ClKTNh1RYiZHWvDA60o6ID7tpCvH0oh7Nsg0PDoFbLa8+z7vX1wvSZdExd/Zb3E
         Z00QlGJTKC0C7Y3BSBnxbGYj00xWmNarH+aJyUg2z0BYAVOuGzyEKRf7F//sFjlLvhKQ
         1U8Q==
X-Gm-Message-State: AODbwcAwr/saqejaUifE0UBk/Mt3lcFmSO90I49/wjV0fxtRWsQoxoVm
        uveTmpWgBSfXgCtGpuKtm0NKC/0zXg==
X-Received: by 10.46.70.10 with SMTP id t10mr640947lja.45.1496325788907; Thu,
 01 Jun 2017 07:03:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.217.20 with HTTP; Thu, 1 Jun 2017 07:03:08 -0700 (PDT)
In-Reply-To: <20170515220939.vkgofpkdtpz7u26v@sigill.intra.peff.net>
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
 <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl> <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
 <20170515220939.vkgofpkdtpz7u26v@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 1 Jun 2017 16:03:08 +0200
Message-ID: <CANgJU+XQ4uk_OZ+bHxJ51qxAxM6Lq9yu-GNSqZ4BNiBU-8Zpqg@mail.gmail.com>
Subject: Re: Git 2.13.0 segfaults on Solaris SPARC due to DC_SHA1=YesPlease
 being on by default
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 May 2017 at 00:09, Jeff King <peff@peff.net> wrote:
> On Mon, May 15, 2017 at 04:13:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> On Mon, May 15, 2017 at 3:58 PM, Marc Stevens <marc@marc-stevens.nl> wro=
te:
>> > Hi Aevar,
>> >
>> > Thank you for notifying us of this issue.
>> > Big endianness is a tricky issue, also since I don't have access or ac=
curate knowledge about all big endian systems.
>> > Our github repo does check correct functioning, including an endiannes=
s mistake, with 'make test'.
>> > But I guess this is not included for SHA1DC in Git.
>> >
>> > Anyway, we can easily add the _BIG_ENDIAN macrotest to the git repo an=
d will do so soon.
>> >
>> > I don't think the segfault is caused by buffer overflow, inproper acce=
ss, or the endianness issue.
>> > But I did notice an unexpected issue: the message block pointer m=3D0x=
398ad5 is odd.
>> > Can you confirm whether loading an uint32_t from an odd address trigge=
rs a hardware interrupt on your platform?
>> > This is not problem for x86, but maybe for your platform it is?
>> > If it is then we should always copy buffer contents to the sha1context=
 to avoid this issue.
>>
>> I don't have access to the box in question, Michael was testing this
>> code for me. But unaligned access is probably the cause, although
>> according to some info I found online that should give a SIGBUS not a
>> SIGSEGV, but that may have changed:
>
> Yeah, I would have expected SIGBUS there. If we have alignment issues,
> though, I'd expect that ARM systems will experience problems.
>
> Block-sha1 uses a macro which allows unaligned loads on platforms that
> support it, and otherwise does the endian conversion on the fly as we
> load the bytes into a local variable (which presumably happens all
> in-register). That may be faster than doing a mass copy of the buffer.

I agree. It is fairly normal to use that kind of macro and not do a
memcpy with hash functions.

In fact many hash functions ONLY use that kind of macro, as decent
compilers will automagically convert the macro into an unaligned load
on platforms that support fast unaligned loads.

The only reason to expose the direct unaligned load is to make sure
that the hashing code is fast on such platforms even when compiled
under -g.

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
