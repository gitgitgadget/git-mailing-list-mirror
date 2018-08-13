Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7051F428
	for <e@80x24.org>; Mon, 13 Aug 2018 15:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeHMSkb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:40:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43388 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMSkb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:40:31 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so15241735ioa.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yvgZxHevHN9g/Zp9aZRAAS6QCtU//mdOYX0nCLb65Y8=;
        b=bQP946gvnvOVMcCdsj2FkAJKE5vvR/DRekMFQL1SyyJNUpodzAr76doeoFgC6hEnUZ
         6VC0eXAsslIeSFK7a+yUq3+nZYY6Idk34uqskLDMiKsYjP7poYn9Vc2Kx8q2zHiODjVR
         hFDn/Zr7n0qmOLd4ICP0VHcLsH2zcwvhKaaq6Ik6Z6gPSdEFZDrZ4PKPRKbCx38hEf67
         V38hTxIaMNdtkQR+Oj9u9ClSy5tHkvSw8likT7u9G2sLpXlYc//HrYb7VN/5wJTncUig
         2xJRMaTJTbot2TBYfNQ50hLsqNtNc2hL9nEGFxFSIeYXx8u0EYiK1RIKZ4GxB8t2sEPj
         S+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yvgZxHevHN9g/Zp9aZRAAS6QCtU//mdOYX0nCLb65Y8=;
        b=X6hS1QZ2orIrD+Iw0NKvq1NUnqy7BzU63fydvaZCMik5MLZEPYR89kCz0gPcXBFNxc
         1Gx7FlaBDQ5EBGB99sCkODEuGjMQunLywYF+fI9NqUAZOy4FUqcVfezPurP5whmsU2Qh
         VYahEjgUsoaFSdEjN+iQX/XmeNH5GXd2tZDLeU1TMFotVkyoCi3VzYlQkyQiL5aNsxFy
         RJiCJMuOHTFEl+TFug+VgLJrT3pIpM9o/ENXaUBpSNrHxTqJtMxo/7NUG02QLinCOVWL
         yOF66zIdnrixBuYuyMjCC2ThP4TLIDkj3Fco1Gii5jseNO0zhx8lk2MQOPUcDbvcDUHs
         fElg==
X-Gm-Message-State: AOUpUlG4JWB/BA/vUCRo3EMUHTRNM4p+7NA+ylkW8w3QGSmMTViM2+eJ
        qPwwzxexzNICoQvfP9TmZmxcXtIWUslu9w2MLDw=
X-Google-Smtp-Source: AA+uWPwxUYGU5i/VkWfx39hWz+c9kZkBfuiKNAws04BmubQbgV1TdnJlBAqaqUEsody2eApBDMIIyUl+KQlIaCSFrf4=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr2043957iok.236.1534175861728;
 Mon, 13 Aug 2018 08:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-6-pclouds@gmail.com> <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
In-Reply-To: <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 17:57:14 +0200
Message-ID: <CACsJy8D+VMBO7oNH3DJ4SspLj7OBq78rkaBHB35BTLwuVsLekQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] unpack-trees: reuse (still valid) cache-tree from src_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 5:48 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sun, Aug 12, 2018 at 1:16 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > We do n-way merge by walking the source index and n trees at the same
> > time and add merge results to a new temporary index called o->result.
> > The merge result for any given path could be either
> >
> > - keep_entry(): same old index entry in o->src_index is reused
> > - merged_entry(): either a new entry is added, or an existing one updat=
ed
> > - deleted_entry(): one entry from o->src_index is removed
> >
> > For some reason [1] we keep making sure that the source index's
> > cache-tree is still valid if used by o->result: for all those
> > merged/deleted entries, we invalidate the same path in o->src_index,
> > so only cache-trees covering the "keep_entry" parts remain good.
> >
> > Because of this, the cache-tree from o->src_index can be perfectly
> > reused in o->result. And in fact we already rely on this logic to
> > reuse untracked cache in edf3b90553 (unpack-trees: preserve index
> > extensions - 2017-05-08). Move the cache-tree to o->result before
> > doing cache_tree_update() to reduce hashing cost.
> >
> > Since cache_tree_update() has risen up as one of the most expensive
> > parts in unpack_trees() after the last few patches. This does help
> > reduce unpack_trees() time significantly (on webkit.git):
> >
> >     before       after
> >   --------------------------------------------------------------------
> >     0.080394752  0.051258167 s:  read cache .git/index
> >     0.216010838  0.212106298 s:  preload index
> >     0.008534301  0.280521764 s:  refresh index
> >     0.251992198  0.218160442 s:   traverse_trees
> >     0.377031383  0.374948191 s:   check_updates
> >     0.372768105  0.037040114 s:   cache_tree_update
> >     1.045887251  0.672031609 s:  unpack_trees
>
> Cool, nice drop in both cache_tree_update() and unpack_trees().  But
> why did refresh_index() go up so much?  That should have been
> unaffected by this patch to, so it seems like something odd is going
> on.  Any ideas?

Probably fs cache and stuff. This is a laptop with just 4GB RAM and a
very slow disk so if something triggers in the background and evicts
some webkit.git's stat info, refresh_index will get hot fast (and with
275k files, webkit.git needs quite a bit of ram to make sure stat()
calls don't hit the disk).
--=20
Duy
