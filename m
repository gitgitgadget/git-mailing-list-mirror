Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC7C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 22:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhLGW0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLGW0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 17:26:07 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA45C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 14:22:36 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k37so1643325lfv.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVmDUdDSdTiHcTGBuHodPUoOSn4dM5oUTFemRBOEyZk=;
        b=kXNt/wjddcegG8B4O5uk2Drtje14Kt1A6Q1SYzpWXXbD7DlAtAxBYaRmj1RNvHIRHy
         i7u7DaP/1e5F3TyxQDPttBlwQrLRH5OBR4RToCz3X2cbMSA/YhWeJf6dLefOqz/g1o/5
         PftesGuwAnSviSYXAh3mJ51eHpKWPsbpucQt9SBtbv00JxEtjevdkN6x/vfn3SALdg7j
         3es0vjiV5PHy2gZmfUikCVW4mWYiK8dYrc6+Ajf6KYijTYW/PBtCwKTpCG778QMmrJju
         C3SoMBlX9cv9vK6LDLHHgfNrTGXaNIZHWrZY0YtiQTubQAPqPqX248UEP8B+sx2GwUl2
         k3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVmDUdDSdTiHcTGBuHodPUoOSn4dM5oUTFemRBOEyZk=;
        b=xPkJL1WrUxM+2igmhxCnIr8wG7EcvNteJz5Z5b9kogkzRPrGkmrpnvr2W/oSE7fgCW
         0qU4pzVcIRpQBZb6vY4E35Va8IHP/zPKOsyeg6Xy5Q0/k1TYgHCYYAn8jmjAZpgMek99
         WLKowK1DBJQrs/8Ll65ZwgJNArcvLSxnYO/JxXrg8P4v4tloxQHxZF1l+l0KDHJLbgyS
         F6LPQuCDwcTOJ0C3ZHs9VXDbbov8dFqicAzL9Q0IcZYRXV5DsOx6+sRgjf4qXJo3/LTz
         OTKs7M3+MqFgepg6C/+/ExNstX98jjV0EO0VJkYqNYcEQ3BIGshESXUeyptkdT1TwNLk
         tLLg==
X-Gm-Message-State: AOAM5326M/ROweZS/bvwepw2piY8jaWT/6JUzyDvLWHoqwcKs09ZaUDn
        BVBkKEz12aJDLs360AGEOMqoyRSt9BRrNo8oRJA=
X-Google-Smtp-Source: ABdhPJz2bWd3TFChuX0ujSZ6DJ6UaZpDzBAHvDh7T/Zn1RAdEV8BD3ThnloTrqMLGaMPdsFWEh1r17iXSjPScc68cIo=
X-Received: by 2002:a05:6512:3182:: with SMTP id i2mr41896668lfe.241.1638915754306;
 Tue, 07 Dec 2021 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
 <20211206222539.GA27821@neerajsi-x1.localdomain> <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Dec 2021 14:22:23 -0800
Message-ID: <CANQDOdfkRMMWpF2gaRpZW0NRzMuN-ADO++D1J4rS8WLxOPudRw@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 1:33 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Neeraj,
>
> On Mon, 6 Dec 2021, Neeraj Singh wrote:
>
> > I'm a little confused by this issue. Looks like an empty flex array
> > is supported here: https://godbolt.org/z/j3ndYTEfx.
>
> It is somewhat strange, but understandable, that the empty flex array at
> the end of a struct isn't triggering a compile error. But having a field
> _after_ that empty flex array _does_ trigger a compile error:
>
> struct MyStruct {
>     int x;
>     int flexA[];
>     char string[256];
> };
>
> Note the added `string` field.
>

Please see https://godbolt.org/z/4Tb9PobYM.  GCC throws a morally
equivalent error.  I don't think that's a valid usage of flex-array.

> See https://godbolt.org/z/TbcYhEW5d, it says:
>
>         <source>(5): error C2229: struct 'MyStruct' has an illegal zero-sized array
>         Compiler returned: 2
>
> > (Note that I'm passing /TC to force C compilation).
>
> Yes, `/TC` is one of the flags we pass to MSVC. For more details, see
> https://github.com/git-for-windows/git/runs/4389081542?check_suite_focus=true#step:9:125
>
> > Also, heap_fsentry doesn't appear to use a flex array in current sources.
>
> It does, but it is admittedly a bit convoluted and not very easy to see.
> The definition of `heap_fsentry` is
> [this](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat/win32/fscache.c#L77-L80):
>
>         struct heap_fsentry {
>                 struct fsentry ent;
>                 char dummy[MAX_LONG_PATH];
>         };
>
> No flex array here, right? But wait, there is a `struct fsentry`. Let's
> look at
> [that](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat/win32/fscache.c#L43-L74):
>
>         struct fsentry {
>                 struct hashmap_entry ent;
>                 [...]
>                 /*
>                  * Name of the entry. For directory listings: relative path of the
>                  * directory, without trailing '/' (empty for cwd()). For file
>                  * entries:
>                  * name of the file. Typically points to the end of the structure
>                  * if
>                  * the fsentry is allocated on the heap (see fsentry_alloc), or to
>                  * a
>                  * local variable if on the stack (see fsentry_init).
>                  */
>                 struct dirent dirent;
>         };
>
> Still no flex array, right? But wait, there is a `struct dirent`. Let's
> [see](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat/win32/dirent.h#L9-L12):
>
>         struct dirent {
>                 unsigned char d_type; /* file type to prevent lstat after readdir */
>                 char d_name[FLEX_ARRAY]; /* file name */
>         };
>
> Finally! We see the flex array.
>
> Now, you may ask why is this even correct? How can you have an empty-sized
> field in a struct that is inside another struct that is inside yet another
> struct _and then followed by another field_?
>
> The reason why this is correct and intended is that `struct dirent`
> intentionally leaves the length of the `d_name` undefined, to leave it to
> the implementation whether a fixed-size buffer is used or a
> specifically-allocated one of the exact correct size for a _specific_
> directory entry.
>
> In FSCache, we want to allocate a large-enough buffer to fit _any_ file
> name, and it should not only contain the metadata in `struct dirent`, but
> additionally some FSCache-specific metadata.
>
> Therefore, `struct fsentry` is kind of a subclass of `struct dirent`, and
> `struct heap_fsentry` is kind of a subclass of something that does not
> exist, a `struct dirent` that offers enough space to fit _any_ legal
> `d_name` (that is what that `dummy` field is for, it is not actually
> intended to be accessed except via `d_name`).
>
> > If it does start using it, there issue may actually be elsewhere besides
> > the struct definition (it could be just a badly targeted compiler error).
> > We have code like `struct heap_fsentry key[2];`.  That declaration can't
> > work with a flex array.
>
> I hope my explanation above made sense to you.
>
> Admittedly, it is slightly icky code, but honestly, I do not have any
> splendid idea how to make it less complicated to understand. Do you?

Thanks for explaining all of this.  It was hard for me to see what was
going on before.

So when trying the same thing with Clang, this construct is claimed to
be a GNU extension: https://godbolt.org/z/q3ndr57Pf

The fix I'd propose (uncomment the line defining FIXED_DEF in godbolt)
is to use a union where the char buf has the size of the fsentry
_plus_ the desired buffer.

Thanks,
Neeraj
