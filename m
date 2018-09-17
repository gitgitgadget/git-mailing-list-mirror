Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D0F1F42B
	for <e@80x24.org>; Mon, 17 Sep 2018 16:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIQWWN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:22:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43284 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:22:12 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so12041027ioa.10
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QiX+/3bFiMvbpipNL72pwtLuemA80vt5ciTq35GJXt4=;
        b=uaQ584sY+oxGxkMr+9yooX42wke6WBhRzUlLAy0/V/FtQ9i2bBq13zsxWRLS4eCHBs
         sQeoaIXbmcSYrsyV92p1EBQO2fUnXVvIYkMjY7NX9+N/qkMM/4wgMgMmZ902zKKkvnHc
         XQZU5LVipflh0/uCusLlHelyA6tt4GwKgrWFCYoZnxg+sLDR6nVOWgY66sC0hfvxwAlP
         ouz0zXChAWuac2GlRYsDfOh21XxsD/dvVy5vkt+TzTAhu7gj39aBmpN84UWa3WgRDkWk
         wN1mhFwUJCD25sHUlP+tc86pCsLbEWfwicTaifu6qb0JLhTje3jb5WpQ08i59EoQOFW+
         6oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QiX+/3bFiMvbpipNL72pwtLuemA80vt5ciTq35GJXt4=;
        b=LUVNXWg2VaWoDPHXqAsyAe6KnxSZ4VfEn4f53AtmqSLgnTEoGBe5RGrUXHLyxBXAYC
         ql3EC9KYMdVMEIzYKqrWPUw6NrAtSUEGwWDqYJ27/SBPdQgSgJBF3Are7UdrUDv/dLWn
         TcAPuEiGqDzrUBalVFAsVnlRUwwAOw1enf07xYX17Tght9EvGFS204U+L/nd4yxPPWfP
         +zLqZUi57V7i48jUaGlzkn7ZxcuZUZ1NBnL2kP23zrFvMxfocynzTUf0p9ya2F7CBn7z
         IIdfCK3T1JR24UJQS2SbNnKNCIoA7NrthFCNdQLZhXN/CgIqhVFuz5CKGtAyO9nK5B4W
         HxAw==
X-Gm-Message-State: APzg51CJ8zco02H9zc+kFB5icU16i2X4o/c6wOlN6H5rINvjBXAooVXD
        KDyLwhp/b+XhhPYGx2dCwiae9sq1G2CENgaknjU=
X-Google-Smtp-Source: ANB0VdZ8FnPuO5iSWV+4G2j1vPh3Tih2oxXZXmzCL6KIDyttspkWyedcMIZbpSfKO2MN4OqrCPm2RlOJ+X9rLdrQYik=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr20094174iok.236.1537203240919;
 Mon, 17 Sep 2018 09:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180909085418.31531-1-pclouds@gmail.com> <20180915161759.8272-1-pclouds@gmail.com>
 <20180915161759.8272-3-pclouds@gmail.com> <xmqqo9cw851q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9cw851q.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 18:53:34 +0200
Message-ID: <CACsJy8A6ox7gRp6pNJWy-Yb_+gQDPZJYfAmKd+of8MAdajic4A@mail.gmail.com>
Subject: Re: [PATCH v4 02/23] read-cache.c: remove 'const' from index_has_changes()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > This function calls do_diff_cache() which eventually needs to set this
> > "istate" to unpack_options->src_index (*). This is an unfortunate fact
> > that unpack_trees() _will_ destroy src_index so we can't really pass a
>
> Wasn't the whole point of introducing src_index and dst_index to
> unpack-trees API so that we can keep the src_index read-only by
> writing the result of merge to a separate in-core dst_index?
>
> What does the above exactly mean by "will destroy src_index"?  Is it
> now fundamental that src_index needs to lack constness, or is it
> something easy to fix?

"destroy" is probably a strong word, but we do modify the src_index, e.g.

 mark_all_ce_unused(o->src_index);
 mark_new_skip_worktree(.., o->src_index...
 move_index_extensions(&o->result, o->src_index);
 invalidate_ce_path();

all these update the source index. It is possible to fix, but I don't
think it's exactly easy and may even incur some performance cost (e.g.
if we stop modify ce_flags in the src_index, then we need to do one
extra lookup to wherever we store these flags).
--=20
Duy
