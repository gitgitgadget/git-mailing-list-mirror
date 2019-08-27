Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4671F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 21:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfH0Vu6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 17:50:58 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47370 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0Vu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 17:50:58 -0400
Received: by mail-vk1-f202.google.com with SMTP id n185so301400vkf.14
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1qBmzKXxyVUsz97O0oE96plQeLSJaKm3VKuWyPib+Yk=;
        b=JdpgOH4bCkyqIvgZNkiEttxWmahw+F2YTEfgWHsKpjm45zyFJHAgrijLfdWoMuq+HY
         L0QiUV7T3mXBC1Irlyo8tLhLtu1n6rnNeeXdbZD6IFCeVqfZQiTIf3DIA7RPngoQUF6O
         GISRlMXZ12PDTJ4oqZh2x2+/pZeLHCCSjaW1KsdnsLc5CpFWM4ghQ/lfQNFQxArRf+bV
         Om0vDz3QMT0Ag2SScc6iz04a+rcx48fc2f7/jhk6Tv58tzxFBSJRIV4NbrD+fjVDpONV
         nqyKXF0d+T2Vbz+DOhzjJ+gWmZQ1HK/n9abSvlw409OUBIp6+dwiXHLxwye1QFL5Z45f
         ANlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1qBmzKXxyVUsz97O0oE96plQeLSJaKm3VKuWyPib+Yk=;
        b=Gbza45+Ad6OeMjBce53Oil9MvRFrXKt9Jyb4yYjF1Szo8yoPLK2cKCuh17qhmq++qy
         ljfBaktpw9QnhNuDzk7pU/v4qiDuWF2m4EDXMNi+ZCmQzPfbw79d9OLqtvbm3anXrALO
         eI9XSWkNIunzq3qcfOg/UMguP25PtTJwGtH4rTl1wy/SAE6q8qmA+amVdzs7E8gBCcWk
         rsNwmKkV7SNW68H7Og8VZA8V+gKxMJZBHFEw2ylswnfbFxDSQWMXvWsYy7lZR+TBdp+P
         Xqc5oK0OuuRgyc0u8dHU/HA18recLcZJOdi8iW4I+qvVEXU88A5HgK/YA0ghKn7a/k4J
         JpxQ==
X-Gm-Message-State: APjAAAXa0d+QMaDTwwa3MIeU24VllpNu0Ai1+KNhH8Rw7P4yrmlFzCVd
        4LxfFEhqWNI3DPEmcloU+WjPJRZhexHdezV2iveX
X-Google-Smtp-Source: APXvYqy2vbq+SY71VtQw9GbET+TsJkzhCTDFBSxzcKM45Vs6Nm7iQr6t6XFH9Ub3kmkhl8azvOYAYzWUUdT4du6WkVDL
X-Received: by 2002:ac5:ccda:: with SMTP id j26mr593356vkn.43.1566942657222;
 Tue, 27 Aug 2019 14:50:57 -0700 (PDT)
Date:   Tue, 27 Aug 2019 14:50:54 -0700
In-Reply-To: <xmqqmufu2w25.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190827215054.109496-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqmufu2w25.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > As written in the NEEDSWORK comment, repack does not preserve the
> > contents of .promisor files, but I thought I'd send this out anyway as
> > this change is already useful for users who don't run repack much.
> 
> What do you exactly mean by "much" here?

For diagnostic information to be preserved, the user must not have run
repack between the fetch and the discovery of a problem. Admittedly,
this is probablistic, but if the user never GCs (for example), this
would work.

> The comment sounds like it
> is saying "running this code once and you'd make the commits and
> objects that were depending on the existing promisor invalid", in
> which case it would be more like "it is already useful for users
> until they run their first repack that destroyes their repository",
> but certainly that is not what we want to do, so...

To be clear, repacks will not destroy their repository, whether before
or after this change. Before and after this change, a repack will just
collect all promisor objects from all promisor packs (that is, the ones
with .promisor) into one single pack, and then generate an empty
.promisor file to indicate that the new single pack is a promisor pack.
The difference is that before this change, Git does not write anything
into the .promisor file (at least for fetches), so nothing is lost. With
this change, we now write something for fetches, so something is lost
(since we delete all the old packs, including the .promisor files).

But the only thing lost is diagnostic information (for humans - to
diagnose, the user will need to open the .promisor file in a text
editor) - commits/objects are still valid, and the repository is not
destroyed.
