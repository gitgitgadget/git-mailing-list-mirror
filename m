Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2E41F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHVUYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 16:24:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38466 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeHVUYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 16:24:52 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so2184486ite.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z+DIarZbIoFW1U7DJQrlaRtFj3H5fg55989vDdLQVY=;
        b=PFpGu2Ssv3c3Tb7ADxnnpK866pf9yxeQQLpWPW0XbRQqdTSSOsd+I1xn3K+CTisiiL
         BeITzASB6WarjEA2kRfG+1Le2rWm5HBryiNIORKpD9Oz6+V1Mkm9WtTZsX01YFVCycJb
         iMD77b93tJRPe+HoGwODpQN+4nSKemHTEaXMlEp/Cqy3hAr00s77pKnT4lg8YQnhFvDd
         zGEUW8LCUBCsBPU4QDqq6tUATii+BPKQDrPmXbHiKDKnxqNB1TQxnCm4uZphinG4c5TP
         VEeo/7WEv5Ap0EHuxj2KAaqlQzk1Cse1YHzRCmrLZqNabp5JbT0CNWa8Ex90eof0bvqS
         BEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z+DIarZbIoFW1U7DJQrlaRtFj3H5fg55989vDdLQVY=;
        b=lqxn+ar1+SfLOdDyEc62gL8pcuSBsIRPj7eHHmOmwl60uC/tE/Z/sGA/HoG19xO4r9
         VZk+4AhcKVyxtTAq6E0jm7XKfmd10a+xppIm394d/GXHp+BOOnN2TLRWD9uvEJBzx6Wm
         Sq6j0AOrG6of01MkqoQf/mHFg8Q66d4J0vlBLYh682tWRRQDACXGRCVxga2c/5mSVim6
         f8IyVaMRUHyxyCmFXthKrR+NDn4C/LdnkdcaF2cCjE/7zAXk/0a3DpUhS2NchxKT2GXw
         +zlh8R4hFqG5+soqnO6Fxx5Qx3UkAe8pwlejehYmhJEl2yK8OUEx70kkhiDBuTbDlSqK
         h9hg==
X-Gm-Message-State: APzg51BMys/SiLmHyz2PqbM4M/VZPgl7Rx8OiqEyWJYsLJkuYCEwuFdk
        jNM7CuZlUs2T0OLKPxAM6mezTVx2UHLoQwKCrYA=
X-Google-Smtp-Source: ANB0VdZPL/shyyWToT3MdTYPJVCwXRCBJJaCReL08aicCm9olpN8zvBe1vkYjds8cSJ/HnvMPAy9rV9ATwEAGyR+fLc=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr3729397itk.62.1534957151236;
 Wed, 22 Aug 2018 09:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180821212923.GB24431@sigill.intra.peff.net> <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net> <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net> <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com> <20180822151703.GB32630@sigill.intra.peff.net>
 <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
 <CACsJy8DifmYtDE4D58yVM7rYhfJFe8p-t9bXgMmMsw=txxmzHA@mail.gmail.com>
 <20180822162609.GA11904@sigill.intra.peff.net> <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
In-Reply-To: <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 22 Aug 2018 18:58:44 +0200
Message-ID: <CACsJy8By49nz6-q78GuMYP8ssrjhWYyhYrJcL8eWpi4-mZzzxA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 6:49 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/22/2018 12:26 PM, Jeff King wrote:
> > On Wed, Aug 22, 2018 at 06:14:24PM +0200, Duy Nguyen wrote:
> >
> >> On Wed, Aug 22, 2018 at 6:08 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >>> On Wed, Aug 22, 2018 at 6:03 PM Jeff King <peff@peff.net> wrote:
> >>>> On Wed, Aug 22, 2018 at 07:14:42AM -0400, Derrick Stolee wrote:
> >>>>
> >>>>> The other thing I was going to recommend (and I'll try to test this out
> >>>>> myself later) is to see if 'the_hash_algo->rawsz' is being treated as a
> >>>>> volatile variable, since it is being referenced through a pointer. Perhaps
> >>>>> storing the value locally and then casing on it would help?
> >>>> I tried various sprinkling of "const" around the declarations to make it
> >>>> clear that the values wouldn't change once we saw them. But I couldn't
> >>>> detect any difference. At most I think that would let us hoist the "if"
> >>>> out of the loop, but gcc still seems unwilling to expand the memcmp when
> >>>> there are other branches.
> >>>>
> >>>> I think if that's the thing we want to have happen, we really do need to
> >>>> just write it out on that branch rather than saying "memcmp".
> >>> This reminds me of an old discussion about memcpy() vs doing explicit
> >>> compare loop with lots of performance measurements..
> >> Ah found it. Not sure if it is still relevant in light of multiple hash support
> >>
> >> https://public-inbox.org/git/20110427225114.GA16765@elte.hu/
> > Yes, that was what I meant. We actually did switch to that hand-rolled
> > loop, but later we went back to memcmp in 0b006014c8 (hashcmp: use
> > memcmp instead of open-coded loop, 2017-08-09).
>
> Looking at that commit, I'm surprised the old logic was just a for loop, instead of a word-based approach, such as the following:

Might work on x86 but it breaks on cpu architectures with stricter
alignment. I don't think we have a guarantee that object_id is always
8 byte aligned.

>
> diff --git a/cache.h b/cache.h
> index b1fd3d58ab..5e5819ad49 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1021,9 +1021,41 @@ extern int find_unique_abbrev_r(char *hex, const
> struct object_id *oid, int len)
>   extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
>   extern const struct object_id null_oid;
>
> +static inline int word_cmp_32(uint32_t a, uint32_t b)
> +{
> +       return memcmp(&a, &b, sizeof(uint32_t));
> +}
> +
> +static inline int word_cmp_64(uint64_t a, uint64_t b)
> +{
> +       return memcmp(&a, &b, sizeof(uint64_t));
> +}
> +
> +struct object_id_20 {
> +       uint64_t data0;
> +       uint64_t data1;
> +       uint32_t data2;
> +};
> +
>   static inline int hashcmp(const unsigned char *sha1, const unsigned
> char *sha2)
>   {
> -       return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +       if (the_hash_algo->rawsz == 20) {
> +               struct object_id_20 *obj1 = (struct object_id_20 *)sha1;
> +               struct object_id_20 *obj2 = (struct object_id_20 *)sha2;
> +
> +               if (obj1->data0 == obj2->data0) {
> +                       if (obj1->data1 == obj2->data1) {
> +                               if (obj1->data2 == obj2->data2) {
> +                                       return 0;
> +                               }
> +                               return word_cmp_32(obj1->data2,
> obj2->data2);
> +                       }
> +                       return word_cmp_64(obj1->data1, obj2->data1);
> +               }
> +               return word_cmp_64(obj1->data0, obj2->data0);
> +       }
> +
> +       assert(0);
>   }
>
>   static inline int oidcmp(const struct object_id *oid1, const struct
> object_id *oid2)
>
>


-- 
Duy
