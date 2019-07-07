Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2266D1F461
	for <e@80x24.org>; Sun,  7 Jul 2019 03:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGGDPN (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jul 2019 23:15:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45967 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfGGDPM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jul 2019 23:15:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so5937929pgp.12
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 20:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CiC4NdRsxndLY7yPypBM+JRymmu4f7D8LCAx6GQBXHk=;
        b=TGijbmYkiEU+9wJvz3cgkXux9mxhZb1EH29MR2Bt0F4OBiKRkSpp8+iuXxoy8hdWZQ
         tftZUoDyULS18S7DbShFaMswtTZ5HwUJxQtKG8Ghk1GORRXVaJyU48sfQOsf+CXSLD4F
         TOftUfzpUy4eVR9c9cIk3mBEgZnQT+9/OamjEQobt55xAXcfbtsSbIHaGJcdQNA91s4O
         CSXBqYwCXOXylwgCoO5CcuyJo8FAvMF2GbRbbLQnDecp0eeUNnSNZSERFR61Y7iaSl2a
         WCISozSvAdRkzHIN4US+0vCSbsj5iSAJjuwum7h3jpvhpsP68J6boYK3060GRggyBYNC
         YX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CiC4NdRsxndLY7yPypBM+JRymmu4f7D8LCAx6GQBXHk=;
        b=Q1dmKT2KstpxsvVSa6FzNHvgQHlqUkZecZP6M0HOf2PJOTY8HOwyBBAJlOSJp5TdIP
         YFJsC7P8s6FKQkGgIXxY+gwz1mjt2xz+FMyWlXv0SGmlWFUws72zpBuGvPMd6fmfrsWV
         IsV/O5JvDFlbd5Ly6XVyXnTIKOPxyfeHLb07iO5EkKbi18f4uLHOzopFKkkcUhj4WSKY
         9ZlZsazXawNdZcPDgs7NLAfVkyDxoH759wtexcPrFtPJzfxDBWTyJLzlL9ELsZi8eygG
         VwxhW7J/zjWL1lg4h4+hnOg3eNJSimNm03oYx9GwxpEj/qSg6rgFsEJbP7Eb7WAkVPSM
         HJ9g==
X-Gm-Message-State: APjAAAW4brjnsYknFiUqGAWGa0dzojfnLQVwA+kHAZOkBhE3/SIiy2q5
        E9rqDyWRRBf3fCdduOULZPH3a1vTf41wkqKKBy+YNw==
X-Google-Smtp-Source: APXvYqxp24ddBR76OCLvn9zxVfDd9gPxPOkjf7i5BqEE83jtShMEUf29F4CiPs+fCkUT2XY6EeBDaoj+pQmnpUuuf4M=
X-Received: by 2002:a63:2252:: with SMTP id t18mr8015793pgm.5.1562469312036;
 Sat, 06 Jul 2019 20:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190707000052.26057-1-eantoranz@gmail.com>
In-Reply-To: <20190707000052.26057-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 6 Jul 2019 21:15:01 -0600
Message-ID: <CAOc6etYGA_rHhrDgMbf4x_GxdWwgWy7W2Kqvv6PsMMHFP0U_vA@mail.gmail.com>
Subject: Re: [PATCH v1] builtin/merge.c - cleanup of code in for-cycle that
 tests strategies
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 6, 2019 at 6:00 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> @@ -1645,6 +1631,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>          * auto resolved the merge cleanly.
>          */
>         if (automerge_was_ok) {
> +               write_tree_trivial(&result_tree);
>                 ret = finish_automerge(head_commit, head_subsumed,
>                                        common, remoteheads,
>                                        &result_tree, wt_strategy);

I realized later that the call to write_tree_trivial could be included
in finish_automerge. Will include this change on v2 of the patch (if
there's a v2, depending on feedback).
