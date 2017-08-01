Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4402047F
	for <e@80x24.org>; Tue,  1 Aug 2017 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbdHANzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 09:55:18 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35762 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdHANzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 09:55:17 -0400
Received: by mail-qt0-f173.google.com with SMTP id p3so9325134qtg.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dMQziRcgkwD5WPcugTh9TUqpNcDmi211byXNz+NjM4Q=;
        b=Iv5ErkRCP+gEjeceETbFmNdphGvaP8i3jO8O5f5uhZ6zb3mnZYcVf1OPH1qNVNJGAw
         CE7E49DYoHs5cBmqFDsnLeUvZfwYpm7NvxQho5STMVTbuTEFgkc6AgLoerMy7tqUS6FF
         4wDE0iTD4wIQ9hpHg3Mb1OjiP7X2oZyNAnVi6qMe5jHwLG18zO9OF/oorB8q5i4ugM3t
         LrunEdWFnMeOAEL2kDu1FnGJYxKqJgkZmZz2R5hRnE8dukEkolNQckq7XfRVlr3wYQvc
         s2TVrbKlqfyLnMCd5kvDEJoEL69ob2XzZu+HAQtWv0Q7sz/K1LBxoShIIWxilY2ybjA8
         2ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dMQziRcgkwD5WPcugTh9TUqpNcDmi211byXNz+NjM4Q=;
        b=i1SXT2I5Sw/saD6htFsZQj3g0lo08qKajq2Zh8FvpdAw39zyolKt42qvA0zfjqiD5f
         oleM/k6VoilEo8v03Shqp4QUbnq+6KBVFRVjhmdwPi4cjH5BAZVCdodhJZlsJR/Hl7zi
         7C1PG0vaBf85sv9LmdkeWEeJkpfzuP+uX5pVRvAEcoYQJy14ryBtx3qh/PR4MLlN+iNA
         MPDgg48S7ZC2AhbG/UhmNWMp+4blJWF0YnBUX8o+A5nhoJtG1OGwPwgf15FIjmKB9Wub
         235O2kYqLCtRqMBfEp+Xe32tGN5CDOB383ln6mC1qt26XAIBXQ8BplSm0gE+gDEoyZx6
         ceNw==
X-Gm-Message-State: AIVw111woWsQruufy0Td/CdKLThFRULDiElAxZ2DQZ03Oh8A5rNXVGGk
        tTAu0z0UVJa3APK3ps2+Hmsyvg0Tj/7L
X-Received: by 10.237.49.103 with SMTP id 94mr25720351qtg.16.1501595716562;
 Tue, 01 Aug 2017 06:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.44.102 with HTTP; Tue, 1 Aug 2017 06:54:55 -0700 (PDT)
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
From:   Dave Borowitz <dborowitz@google.com>
Date:   Tue, 1 Aug 2017 09:54:55 -0400
Message-ID: <CAD0k6qTFV2AAbWiKvi4=OoodoXEgxswLEbraC3xP1LzvtRRaGg@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 11:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
> - Ref-like files (FETCH_HEAD, MERGE_HEAD) also use type 0x3.

> - Combine reflog storage with ref storage for small transactions.
> - Separate reflog storage for base refs and historical logs.

How is the stash implemented in reftable? In particular, "git stash
drop" needs to be able to remove an arbitrary single entry from a
reflog.

I don't think the current proposal supports writing tombstones for
reflog entries, so this maybe implies that "stash drop" would have to
be implemented by rewriting the whole reflog for the stash ref during
compaction. Can the current compaction algorithm support this?

I suppose there are more exotic alternatives:
* Go back to the normal ref(log) format for refs/stash. I figure you
probably don't want to do this, given that you already moved other
ref-like files into the reftable in a later revision of this proposal.
* Implement the whole stash storage/command in some other way that
doesn't depend on reflog.
