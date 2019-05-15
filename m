Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C75C1F4B6
	for <e@80x24.org>; Wed, 15 May 2019 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfEOJ3k (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 05:29:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40180 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOJ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 05:29:39 -0400
Received: by mail-it1-f194.google.com with SMTP id g71so3449203ita.5
        for <git@vger.kernel.org>; Wed, 15 May 2019 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9flydZ31z9XkNDGn07uFPvXtAkr0qhf+KN+nXAyCH/4=;
        b=vOWQ+rswIjFcOC8nVx22tXYR5KwYsTRiBcrd3/uYnLGMXv5Eiq0HyHvKBA0+3PdSQC
         HIuGnEQvMVxB2T+CZ9yiMVbcEndTzQ7KsqfRlIGmnOteh7yxcJGeyFcxRDkvfoEIWXG2
         /54iZzxSvHVPrfi3wzEm7bMKKfrJdjUF0TFQ/2JX8l+bX3iEMvbmkec2Zvg4yke2XAic
         c+egQhvHFsshB2cpjZGrjI7KkIJYlRgXWUsNzF3+ZvolkTG366m8M3ONkuJ0S+5fW6BC
         WXR5FqDBPZ/pZWzmX13+YUKYVEPeAExaCqp9dDPcWqWZtX4RWB0U/qWTfolKK7v9pLy6
         TJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9flydZ31z9XkNDGn07uFPvXtAkr0qhf+KN+nXAyCH/4=;
        b=cwzrCbw3AIs08OvCW+O7zTbSqJqC/qA8BQ0ZYUx/kgx3Eo8qrQNbCAveDKeFRprkKu
         M6jaVSMahyV7PFILXauPbhAs1zavqkSRTPevwHkEDfWNHNP4h4YYGuqB/u85K5VR2Lc0
         hmG0APzRJsFFIDQxBTTTjdBtmuCqPRprSm5jxjrAeAeIwcO410Bz1YVcu347lkGdae7L
         RzZdkkowpQ0gDvdcT52brhhp0SId6Jsp83REO6ML+Pp38+QNhRVCYSHFLn8cD2qR8CXU
         f54aosV2MsE1GekJ1xGMnfYHvwtGwkIs4uGqnZd5NTKLSAe5In6I4MXUgy86ZsQvf0bZ
         Z3Lg==
X-Gm-Message-State: APjAAAV0wSpY8ADkMJ5dL8C+6v5z1jAhmMbxY90ouGLqii78TIIf41OV
        pzCI4OsWteV32kPKvMApUwbhZGRUovR78hUQfao=
X-Google-Smtp-Source: APXvYqxp7ww2SV9rgRGjyiBPLXcANFRKRDUVPa8bo8DBHpN1bEDUrBUWfKoPDWzjz3TsAuJjbjXMwNUZ0Vp8eY0bG8E=
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr19374298jap.130.1557912579064;
 Wed, 15 May 2019 02:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190511205711.tdclwrdixaau75zv@dcvr> <20190511223120.GA25224@sigill.intra.peff.net>
 <20190511230204.GA18474@sigill.intra.peff.net> <20190514135455.GA17927@sigill.intra.peff.net>
 <CACsJy8AvsyOz2G1zjRjpKYVZ0DLKj02-v=hXJHS0BRHnxoeWAw@mail.gmail.com>
 <20190515014622.GB13255@sigill.intra.peff.net> <xmqqh89w70w8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh89w70w8.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 May 2019 16:29:12 +0700
Message-ID: <CACsJy8BS8NR6aZR29VLYUrRjBE_oyzH=L6X7CSpCO9G+sPjcbA@mail.gmail.com>
Subject: Re: [PATCH] get_oid: handle NULL repo->index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Antonio Ospite <ao2@ao2.it>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 12:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Also from my earlier message, if you missed it:
> >
> >   I also wondered if we should simply allocate an empty index whenever
> >   we have a non-toplevel "struct repository", which might be less
> >   surprising to other callers. I don't have a strong opinion either way.
> >   I did grep around for other callers which might have similar problems,
> >   but couldn't find any.
>
> That is an approach to make it harder to make mistakes by accepting
> possibly a small wasted resource; but at that point, I think calling
> repo_read_index() unconditionally from here and similar places would
> be a simpler fix in the same spirit.

For repo_read_index() case, maybe. But we have a lot of
"r(epo)->index->something". All or most of these references
traditionally are the_index.something, which is always safe to
dereference. Submodule repos with the optionally NULL repo->index
break this assumption.

So either we audit all the code and make sure "repo->index" cannot be
NULL because repo_read_index() has been called before (and may have to
repeat auditing), or we just stick to the old assumption and make sure
repo->index is not NULL from the beginning. This makes me think the
small extra resource is worth it. Much less time will be spent on
similar issues now and in the future.

PS. Sorry Jeff for the noise. I should have waited until I come home
and can read your mail more carefully.
-- 
Duy
