Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DC81FC44
	for <e@80x24.org>; Mon,  8 May 2017 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbdEHQzA (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 12:55:00 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36429 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbdEHQy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 12:54:58 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so6673409pfg.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Kq4l/OocOS6uUnBgd95Nsja4sxgfEOGfR6/uFp7A3w=;
        b=ed1hq3OKTXsBgj7JA/NH4jJraZNrvSVyd5+5gLdyUdvriE4mSeDF3Hq9i13UZLp8nZ
         O7EHJD4PO05TW2jPgbgHkwiEXl7us56xZXuxOUgHQHG7QUk1mS9u6gjFcKAFnROOrQoS
         J+kQy2cknnjL55DuWX7ooThIcg1Vi7S6L0lL/YRUhf8nrZp13jleqx/cGDnjCRn0kYQu
         LCnLfcEPuong989UDGnlZTywSxgqhFIVM5Y63z7L9GDIIFUaoRRWpPCpf0r34NlvxpiQ
         oQHfzjj6OE0hhbUUd4lu3pu0a8BOJLaYPAomrEV2r61xB535a6jzM2TeCiOuPxBeuDqS
         Y7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Kq4l/OocOS6uUnBgd95Nsja4sxgfEOGfR6/uFp7A3w=;
        b=UJrl6hnwt0Q0HdlOXzdAdPEPExf+VVNxm6eZlWVhu5psVC/Nw5BnLt9ASGSUIywQaM
         c6RVfemlWMa1FifzJkhlPtt/I8rZD9U8PkpxelgfY4OTICMCqUElzlkaNASb//KT0AIh
         uL8LsQDAVUcLIYHCAe5/0cBXYlEGJOMEUSYR++ztUJ12uqA6WNut8eNHMfvbhQ82qocA
         243Q5dmP05qCMw96cIqzDwuGpmtg0OxmSdi/V3F75S8YYRs4q8vjLlPY+MUJphCp5pHh
         c2QLzkl6KnAcIXuByLm5gHtzeuvhZrmS3Rg9c2OuQnG2A4kJECYEgeqlMqWLn0SdJ5i1
         qSUA==
X-Gm-Message-State: AN3rC/4yKJG9JEE6nimlv4yqWl0A6/ldQ62BjDkX5VzVSKZV66yWA/Pr
        eAziH6/GZZ/ZLaVlOXVJ1FqzmMmF5S6BIdc=
X-Received: by 10.98.213.194 with SMTP id d185mr32200202pfg.35.1494262496069;
 Mon, 08 May 2017 09:54:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 09:54:55 -0700 (PDT)
In-Reply-To: <002201d2c81a$9ff76060$dfe62120$@nexbridge.com>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
 <001b01d2c809$62ac8520$28058f60$@nexbridge.com> <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
 <002201d2c81a$9ff76060$dfe62120$@nexbridge.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 09:54:55 -0700
Message-ID: <CAGZ79kbxdXhhG3+4v9qH_oDi5o_zseGsQf8KCyTN3+axZB9sUA@mail.gmail.com>
Subject: Re: Add an option to automatically submodule update on checkout
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Ciro Santilli <ciro.santilli@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 9:46 AM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On May 8, 2017 12:25 PM, Stefan Beller wrote:
>>On Mon, May 8, 2017 at 7:42 AM, Randall S. Becker <rsbecker@nexbridge.com=
> wrote:
>>> On May 6, 2017 4:38 AM Ciro Santilli wrote:
>>>> This is a must if you are working with submodules, otherwise every
>>>> git checkout requires a git submodule update, and you forget it, and
>>>> things break, and you understand, and you go to stack overflow
>>>> questions
>>>> http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout-a
>>>> utomatically-do-git-submodule-update-recursive
>>>> http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-git
>>>> -pull-automatically-update-submodules
>>>> and you give up and create aliases :-)
>
>> The upcoming release (2.13) will have "git checkout --recurse-submodules=
", which will checkout the submodules
>> at the commit as recorded in the superproject.
>> I plan to add an option "submodule.recurse" (name is subject to bikeshed=
ding), which would make the --recurse-submodules
>> flag given by default for all commands that support the flag. (Currently=
 cooking we have reset --recurse-submodules, already
>> existing there is push/pull).
>
> Brilliant! =F0=9F=98=8A
>
>>> I rather like the concept of supporting --recurse-submodules. The compl=
exity is that the branches in all submodules all have to have compatible >>=
semantics when doing the checkout, which is by no means guaranteed. In the =
scenario where you are including a submodule from a third-party (very >>com=
mon - see gnulib), the branches likely won't be there, so you have a high p=
robability of having the command fail or produce the same results as >>curr=
ently exists if you allow the checkout even with problems (another option?)=
. If you have control of everything, then this makes sense.
>
>>I am trying to give the use case of having control over everything (or ra=
ther mixed) more thought as well, e.g. "checkout --recurse-submodules -b ><=
name>" may want to create the branches in a subset of submodules as well.
>
> I have to admit that I just assumed it would have to work that way this w=
ould not be particularly useful. However, in thinking about it, we might wa=
nt to limit the depth of how far -b <name> takes effect. If the super modul=
e brings in submodules entirely within control of the development group, ha=
ving -b <name> apply down to leaf submodules makes sense (in some policies)=
. However, if some submodules span out to, say, gnulib, that might not make=
 particular sense. Some downward limit might be appropriate. Perhaps, in th=
e submodule ref, you might want to qualify it as <commit>:<ref> (but the im=
pact of that is probably and admittedly pretty horrid). I hesitate to sugge=
st a numeric limit, as that assumes that submodules are organized in a bala=
nced tree - which is axiomatically unreasonable. Maybe something in .git/co=
nfig, like
>
> [branch "topic*"]
>         submodules=3Da,b,c
>
> But I suspect that would make things even more confusing.

I thought about having yet-another-flag in the .gitmodules file, which
states if the submodule is extern or internal.

[submodule "gnulib"]
    path=3D./gnulib
    external =3D true # implies no branch for checkout -b --recurse-submodu=
les

I think there are a couple more situations where such "external" submodules
are treated differently, so maybe we'd want to think carefully about
the actual name
as different workflows would want to have different features for an
internal/external
submodule.

Thanks,
Stefan
