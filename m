Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67509C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 04:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BE761880
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 04:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhI3E1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 00:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhI3E12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 00:27:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F37C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 21:25:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ba1so16941285edb.4
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 21:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5kfgHUUnb0z7sS/d102NHetFSb2ZPjA9pDxNbW6mRLA=;
        b=PRROIZfkgPD91IemYwVIEhYMGHW/vCpvR8Yn8KrdkKRBMdZ7WSI9wdbiAxpBWqOqwn
         8+d17Fzo/P9xQ/BkfdVEFfUFGLSKUKVqqlD/7SJXQzylIKm93DR+dq5Or4M8V7Zl+UJ7
         Lt2Xqqdc0JSLo7lUzSFBgaW+Aczu3SHnNtBlVRx8DMFfAUF1D0E/QsuSvNX3yAZPEXGr
         vrWjPfR6vhNwyE3x6WgKu57WiQHlRJ6fH12yWGjy3kDr/T6nuMGB1X71EYx/g+VDA42R
         ZB8QdB52mikngSJ9JZWISsB46V5NBoIHKB2u9hYfntwi2xa8uaKVzthuv8m/dOzEENmM
         1tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5kfgHUUnb0z7sS/d102NHetFSb2ZPjA9pDxNbW6mRLA=;
        b=NVUnISuafdLmSR9/ILHJvkiaR62ov0mvHIB1qUdRyXD8iQHViIk2p4bHmxlSNzsq2m
         X/AToQzWTxy/58mxkZ/Dj5PLhops2t/wFj7d75Nrla7HgF6zP3f4lXnosJZCRJKpeOTi
         L6Da2AFd0rtE6GQUUX1HzkPtytn8XRBQPRLB78q++/MWbG4BUP2e2DeEYAB9RdF5lioM
         bVXMsaWIfNyFc/RzL7uul/xjrdXw9t9MADj5UDDpxMF9NSlPDmvxOUOsQdm/isDboUNh
         XEW1jNvESAvrWpmOPCt9YuQb6CuYXVXlgKfSPdsQbgcl1eWCv/4IXIOVrvTogg0rnPa5
         unKQ==
X-Gm-Message-State: AOAM532k2wNumXcLN70HLwdQ17jkUHP/OFqPBtKNPuXVYQEMjxrZPB9T
        3wKPGcgtmP8MTT0AKOjfZ9ijnyO4GQjLaqaz2e5rU7Ra2dg=
X-Google-Smtp-Source: ABdhPJwH99M3aLzCatNlIzbtefdOqqKPSk5bYJ+qaYu/aFhafxIlvXOzjkmf+Ox6ET1FWcqM7uXL2wYRT09MX4seeeU=
X-Received: by 2002:a17:906:38c8:: with SMTP id r8mr4227727ejd.172.1632975933482;
 Wed, 29 Sep 2021 21:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com> <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com>
In-Reply-To: <87ee97utaq.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Sep 2021 21:25:20 -0700
Message-ID: <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to unpack_trees_options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 29, 2021 at 11:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Sep 29 2021, Elijah Newren wrote:
>
> > On Wed, Sep 29, 2021 at 2:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
...
> >>
> >> I think getting rid of the boilerplate makes sense, but it doesn't sou=
nd
> >> from the commit message like you've considered just making that "struc=
t
> >> dir*" member a "struct dir" instead.
> >>
> >> That simplifies things a lot, i.e. we can just DIR_INIT it, and don't
> >> need every caller to malloc/free it.
> >
> > See the next patch in the series.  :-)
>
> Ah!
>
> >> Sometimes a pointer makes sense, but in this case the "struct
> >> unpack_trees_options" can just own it.
> >
> > I did make it internal to unpack_trees_options in the next patch, but
> > kept it as a pointer just because that let me know whether it was used
> > or not.  I guess I could have added a boolean as well.  But I don't
> > actually allocate anything, because it's either a NULL pointer, or a
> > pointer to something on the stack.  So, I do get to just use DIR_INIT.
>
> I think I'm probably missing something. I just made it allocated on the
> stack by the caller using "struct unpack_trees_options", but then you
> end up having a dir* in the struct, but that's only filled in as a
> pointer to the stack variable? Maybe there's some subtlety I'm missing
> here...

As per the next patch:

int unpack_trees(..., struct unpack_trees_options *o)
{
    struct dir_struct dir =3D DIR_INIT;
    ...
    if (!o->preserve_ignored) {
        /* Setup 'dir', make o->dir point to it */
        ....
        o->dir =3D &dir;
    }
    ...
    if (o->dir)
        /* cleanup */
    ....
}

The caller doesn't touch o->dir (other than initializing it to zeros);
unpack_trees() is wholly responsible for it.  I'd kind of like to
entirely remove dir from unpack_trees_options(), but I need a way of
passing it down through all the other functions in unpack-trees.c, and
leaving it in unpack_trees_options seems the easiest way to do so.  So
I just marked it as "for internal use only".
