Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D091F403
	for <e@80x24.org>; Sun,  3 Jun 2018 04:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750789AbeFCE6o (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 00:58:44 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36214 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeFCE6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 00:58:43 -0400
Received: by mail-ua0-f193.google.com with SMTP id c23-v6so13419163uan.3
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 21:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xIST2KSR302ARhY5QVF/9UkwGVXgDnfaThwP3UdzZRs=;
        b=WOzMIl3XpqIPovn3zYmK08sN9sKPUTPRpnWmXnaaP1X4ZKaHDN0qIXeLzxyF9qouTe
         d9xSBGyEF2KnYauX0eqVqhZ0k4Seo5TcXfrW7Wy8U2HX3tVwYERuU3H5wVi1Hr2iQZ3Z
         /5CISbEdp94+7Ojpqtw6HxrAgBDTMXn5hNhNyVR5lK/ulrNoNN6hwRdJO7xKZ593pOM6
         5mrHd607VQRPTGkC3l5d98e1+hHz1rmEfI/F7BKCTEscC6IKMCcfurqUe511x3jk4tDW
         jfUH6sO/U/PBTXRd8oDblf/MhGn2nkBpcT/xm4AWWTJ8doTPRIdd7wmbAPLNUI2dt0CI
         PmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xIST2KSR302ARhY5QVF/9UkwGVXgDnfaThwP3UdzZRs=;
        b=pJpGbR4+14iUru5363RSKh3vLo2F4hZmayjBQMk2XSRjZsLrYTp6kRsr0mhQwmKdMK
         +OHtBpm8DgNXg9B5s6Yukd4o3wi41OUgjkeAOwwJJ4F6fwkIDB/dRZ9MRnPCKzewmNRZ
         FlFcpblslt5fwH7x8NisCQR3V9gK7NvHR9geg0ex89MXumqbvwkZVgDrX1vPCOKsOaRq
         R8dDEP+h47oHkagCyIsnm9dc4DGhB6G8qPEi8lijiGg+SPIHkNOYDTb4aXRxnDUmall0
         D18A431W/Whu152E+irxmgnmL7khE2wB4XFnKYdKAWPwrtRoZeieN8eSYBQl7bxqoNP4
         zO4w==
X-Gm-Message-State: ALKqPwdndu5aQoHC98DXq4IeBIDU/FCP6SysknbSjJ3h/ndptzXnKtYl
        M8zoB6HZpJ2yrfi+J16oHOTs3XpaFMH4dt37ph8=
X-Google-Smtp-Source: ADUXVKLK9K5LYDO7xwbj/CL2wbKpvpn8Pq0WQzcd21TwSeI8oHij+x0hv+4TbOLwOIxvSlJKpIDz3oITIxditjIMgoQ=
X-Received: by 2002:ab0:1723:: with SMTP id j35-v6mr10865431uaf.154.1528001922177;
 Sat, 02 Jun 2018 21:58:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 2 Jun 2018 21:58:41 -0700 (PDT)
In-Reply-To: <CACsJy8Ai5befewi9OxKzUxTOOOON9wgWpqcNy3AuK1YBk7MbxQ@mail.gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com> <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
 <CACsJy8Ai5befewi9OxKzUxTOOOON9wgWpqcNy3AuK1YBk7MbxQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Jun 2018 21:58:41 -0700
Message-ID: <CABPp-BEMUUrYd_=a1sPYV941rMCdWh_x-4j5uUiCEUFA0Fwoww@mail.gmail.com>
Subject: Re: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 10:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jun 1, 2018 at 8:34 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Fri, Jun 1, 2018 at 9:11 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>>> This is more of a bug report than an actual fix because I'm not sure
>>> if "o->src_index" is always the correct answer instead of "the_index"
>>> here. But this is very similar to 7db118303a (unpack_trees: fix
>>> breakage when o->src_index !=3D o->dst_index - 2018-04-23) and could
>>> potentially break things again...

I'm pretty sure your patch is correct.  Adding Brandon Williams to the
cc for comment since his patches came up in the analysis below...

>> Actually, I don't think the patch will break anything in the current
>> code.  Currently, all callers of unpack_trees() (even merge recursive
>> which uses different src_index and dst_index now) set src_index =3D
>> &the_index.  So, these changes should continue to work as before (with
>> a minor possible exception of merge-recursive calling into other
>> functions from unpack-trees.c after unpack_trees() has finished..).
>> That's not to say that your patch is bug free, just that I think any
>> bugs shouldn't be triggerable from the current codebase.
>
> Ah.. I thought merge-recursive would do fancier things and used some
> temporary index. Good to know.

Well, it does does use a temporary index, but for dst_index rather
than src_index.  It then does some fancier things, but not until the
call to unpack_trees() is over.  In particular, at that point, it
swaps the_index and tmp_index, reversing their roles so that now
tmp_index is the original index and the_index becomes the result after
unpack_trees() is run.  That's done because I later want to use the
original index for calling verify_uptodate().  verify_uptodate() is
then used for was_tracked_and_matches() and was_tracked().

Anyway, the whole upshot of this is:
  * merge-recursive uses src_index =3D=3D &the_index for the unpack_trees()=
 call.
  * merge-recursive uses src_index =3D=3D o->orig_index for subsequent
calls to verify_uptodate(), but verify_uptodate() doesn't call into
any of the sites you have modified.

Further:
  * Every other existing caller of unpack-trees in the code sets
src_index =3D=3D &the_index, so this won't break any of them.
  * There are only two callers in the codebase that set dst_index to
something other than &the_index -- diff-lib.c (which sets it to NULL)
and merge-recursive (which does the stuff described above).

So, having done that analysis, I am now pretty convinced your patch
won't break anything.  That's one half...

>> Also, if any of the changes you made are wrong, what was there before
>> was also clearly wrong.  So I think we're at least no worse off.
>>
>> But, I agree, it's not easy to verify what the correct thing should be
>> in all cases.  I'll try to take a closer look in the next couple days.
>
> Thanks. I will also stare at this code some more in the next couple
> days trying to remember what these functions do.

Your patch has two divisible parts:

1) Your modifications to
  * clear_ce_flags_1()
  * clear_ce_flags_dir()
  * clear_ce_flags()
  * mark_new_skip_worktree()
The clear_ce_flags*() functions are only called by each other and by
mark_new_skip_worktree(), which in turn is only called from
unpack_trees().  Also, in all of these, your change ends up only
modifying what index_state is passed to is_excluded_from_list().

2) Your modifications to
  * verify_clean_subdirectory()
  * check_ok_to_remove()
In this case, the former is only called by the latter, and the latter
ends up only being called (via verify_absent_1()) from verify_absent()
and verify_absent_sparse().

I'll address each, in reverse order.

2) The stuff that affects verify_absent()

While verify_absent() is not called from merge-recursive right now, it
was something I wanted to use in the future for very similar reasons
that verify_uptodate() started being called directly from
merge-recursive.  In particular, if the rewrite of merge-recursive[A]
I want to do sets index_only when calling unpack_trees(), then does
the whole merge without touching the worktree, then at the end goes to
update the working tree, it will need to do extra checks.
verify_absent() will come in handy as one of those extra checks.  For
that case, using the_index (the new index just created with lots of
changes) would be wrong in all the same ways that using the_index
caused massive problems for was_tracked() in merge-recursive (e.g. the
blow up of when Junio merged the original directory rename detection
series into master and subsequently reverted it); we'd instead want
src_index (which was the index that existed when merge was called)
instead.  So, with this patch you've fixed some important bugs that I
would have hit later.

[A] sidenote: see
https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/
for more details

1) mark_new_skip_worktree() ... is_excluded_from_list().

Sadly, I'm not very familiar with the skip_worktree and sparse
checkout stuff.  However, the fact that mark_new_skip_worktree()
explicitly takes an index_state (and a different one is passed to it
the two different times it is called), and that it is the only caller
of the clear_ce_flags*() family of functions, and that those function
use the cache entries from the index passed to them in all cases other
than the calls to is_excluded_from_list() makes those two look like
oversights.  In fact, a little more digging turns up commit
   fba92be8f7 ("dir: convert is_excluded_from_list to take an index",
2017-05-05)
and before then, those functions didn't use the_index directly.  But
they did use it indirectly, because they called a function in dir.c
that had it hardcoded.  So it looks like Brandon fixed part of the bug
for us, but moved the incorrect hardcoding from dir.c to
unpack-trees.c.  Your patch is just fixing it up.  In fact, a little
more digging turns up:

2c1eb10454 ("dir: convert read_directory to take an index", 2017-05-05)
a0bba65b10 ("dir: convert is_excluded to take an index", 2017-05-05)

which appear to be the culprits behind the other two uses of the_index
called from verify_absent().  It looks like before these commits that
unpack_trees() was carefully using the appropriate index, except that
functions in dir.c had use of the_index hardcoded.  Brandon fix the
functions in dir.c for us, but ended up still hardcoding the_index in
unpack-trees.c.  Basically, he did most of the necessary lifting, and
your patch just finally changes them over to use the correct index.

Brandon: Does anything look off in my analysis above?
