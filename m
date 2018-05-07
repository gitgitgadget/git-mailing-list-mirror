Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43993200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeEGPYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:24:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46640 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeEGPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:24:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id y15-v6so25483385oia.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/d+WAlWWeznRcch+zK6URvrpojyCr+/JIDNOlon/+0Q=;
        b=E9ERd23HrWr1TmDI/fNG1OYpqolkB1Yw0xOaU8VNUGmfhPGQKrz4DIkXgsI35gpaQa
         EnKHS5t2+0cxmNrivJTkgi2H96PAQoSrvTQwAz8sQKUc939+XZuQ3t8BliqoMOxo9ZW2
         cWhEOsS114A/T4ttGB8H3XV1FXshCxNbpsj7MuTdoPqWFTbbUidSYPXca8qel+1dvlE5
         akE2J4uhd+aQ2vhmNt4evqN+IuxNvXV5lnskQaVpLaRBXdVOtsAwqJ3bRlwdHzC3UdpX
         NR3cIZwEKn4aBodXHcq2tXxEaCvC+Oz1ORYcsusrQv/6Mnois+qD0cvTY0r3wD0kmutd
         CZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/d+WAlWWeznRcch+zK6URvrpojyCr+/JIDNOlon/+0Q=;
        b=U6+gDB+QtQontBB8lWCo0KeOGSoMTOeKrnpE6NltKxkyueQSWbhNN/klZKw0yhOYCf
         pDCivhTrNCWDtQ8c5UGJ55XDy558AGJiKFJy78M4RovQYsXum1r60MUG4Iiabu84kCj9
         YgIlPmpObTKSrKWveEBEA51J7eMcISgRDqPGafI2mi5BMR6DqEZ80aJr8RemKMH4PbdX
         gV84jwD6EdVc8XQRyKAlLaJji4OBQbcKBAOkQ2/IZnPxiBcz8ji6B824yUYpJeNIl1yA
         /+GeLH6IzAYelEbXU5Jq7xDobua7tDgSpFgSGQjq5oYp2g8KuDRW1g4Lds3NCJ7gt2sV
         U2CQ==
X-Gm-Message-State: ALQs6tBxF4gZRDGLhR9dUqMF3ovUyGei84qUg2qSP27Py5YZXd02S5Om
        Pt+Gz0UeewW/m1AEGVyC5yi7QVs0CECEOdXKAyk=
X-Google-Smtp-Source: AB8JxZr5buA/FmpDu0J3joZeDacBZvn/VjakuNbCFhet0Un2034QHwJBd6Jo8TNemMbjaueIiXSORopTu5TCIOrB9Fc=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr11837224oir.56.1525706676393;
 Mon, 07 May 2018 08:24:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 7 May 2018 08:24:05 -0700 (PDT)
In-Reply-To: <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
References: <20180506141031.30204-5-martin.agren@gmail.com>
 <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
 <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com> <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 May 2018 17:24:05 +0200
Message-ID: <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 9:32 PM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> On 6 May 2018 at 19:42, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, May 6, 2018 at 7:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sun, May 6, 2018 at 4:10 PM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>>> These `struct lock_file`s are local to their respective functions and =
we
>>>> can drop their staticness.
>
>>>> -       static struct lock_file lock;
>>>> +       struct lock_file lock =3D LOCK_INIT;
>>>
>>> Is it really safe to do this? I vaguely remember something about
>>> (global) linked list and signal handling which could trigger any time
>>> and probably at atexit() time too (i.e. die()). You don't want to
>>> depend on stack-based variables in that case.
>>
>> So I dug in a bit more about this. The original implementation does
>> not allow stack-based lock files at all in 415e96c8b7 ([PATCH]
>> Implement git-checkout-cache -u to update stat information in the
>> cache. - 2005-05-15). The situation has changed since 422a21c6a0
>> (tempfile: remove deactivated list entries - 2017-09-05). At the end
>> of that second commit, Jeff mentioned "We can clean them up
>> individually" which I guess is what these patches do. Though I do not
>> know if we need to make sure to call "release" function or something/
>> Either way you need more explanation and assurance than just "we can
>> drop their staticness" in the commit mesage.
>
> Thank you Duy for your comments. How about I write the commit message
> like so:

+Jeff. Since he made it possible to remove lock file from the global
linked list, he probably knows well what to check when switching from
a static lock file to a stack-local one.

>
>   After 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05)=
,
>   we can have lockfiles on the stack. These `struct lock_file`s are local
>   to their respective functions and we can drop their staticness.
>
>   Each of these users either commits or rolls back the lock in every
>   codepath, with these possible exceptions:
>
>     * We bail using a call to `die()` or `exit()`. The lock will be
>       cleaned up automatically.
>
>     * We return early from a function `cmd_foo()` in builtin/, i.e., we
>       are just about to exit. The lock will be cleaned up automatically.

There are also signals which can be caught and run on its own stack (I
think) so whatever variable on the current stack should be safe, I
guess.

>   If I have missed some codepath where we do not exit, yet leave a locked
>   lock around, that was so also before this patch. If we would later
>   re-enter the same function, then before this patch, we would be retakin=
g
>   a lock for the very same `struct lock_file`, which feels awkward, but t=
o
>   the best of my reading has well-defined behavior. Whereas after this
>   patch, we would attempt to take the lock with a completely fresh `struc=
t
>   lock_file`. In both cases, the result would simply be that the lock can
>   not be taken, which is a situation we already handle.

There is a difference here, if the lock is not released properly,
previously the lockfile is still untouched. If it's on stack, it may
be overwritten which can corrupt the linked list to get to the next
lock file.  (and this is about calling the function in question just
_once_ not the second time).
--=20
Duy
