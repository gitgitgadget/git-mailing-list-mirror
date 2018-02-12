Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA231F404
	for <e@80x24.org>; Mon, 12 Feb 2018 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932736AbeBLXmt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 18:42:49 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36677 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbeBLXms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 18:42:48 -0500
Received: by mail-wr0-f196.google.com with SMTP id y3so16905791wrh.3;
        Mon, 12 Feb 2018 15:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YBLDfwExa24CSoWdz7nkEuyPvDqsTtlzaPeGyWSfNAM=;
        b=o53SKV+mL8OSmLf8uU8enNTL51lgbZcPMIfapexV4/WolX3EraTAjyxGvT8ufQzsUu
         uF9Kybr5d4fgt3iAwPRA5yrdOoJhRdjHYhhbpTG2AkcWRO7Nj7XsmSyw/2ug26ucDB05
         7No1naAXTTAFckR7WrJcTkE/Q/bTFkVUl1OeoDUvCt9Oj0Dsao90GJ6+2Wus1uzawH6L
         +C+swht9opy3/x1zM3XZc5/0plLQUIdiTwJBb2N9LLVle2Cj+pyfxgdbbiR/YOu59cd/
         SKdjlQHszWhxI6Q4QtFz05v/rUMLHcZ9T77DfTEIxE/xFoienLOvk8ZB9TqI27BwlzOY
         go3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YBLDfwExa24CSoWdz7nkEuyPvDqsTtlzaPeGyWSfNAM=;
        b=dfpmvW5Pz+bF1It+vUHI9aGMEn/RHVlfCpnJWqWYQCaKQw5k0+sfF1oj7kbqFjZqdv
         yYjrGvjH6yQ1uXlnpOk88GnCcqgymHivzCmmYE6JFAa9Gkb9HWzfiu6lLpWZphMvzXEx
         OwgkDcbZTvvfYBVaJqHqilRBLDFFdTc7I5riYn8v88BJcxiNl+abGwdOao5ZxRH7+a22
         I9Qt7pMOJCGKCCIn5o9hNKUlVQkby8qQ0q9x93TlA6s26qAeXlrmHGVR4uNvN7362l3C
         f2DqegVlCux6nWV3zd+VitWwFHkddRJGxHFcz9dZFJ/8cNj5HUiOCt9cerVNa4pf5aKG
         rlXA==
X-Gm-Message-State: APf1xPA3AYJwLNuv+UCHUraJNVQiu6XMVpmtaOaOqk0SmUYp+mjuMRbb
        KnleacBtaOdQZjcxNMNOiB8=
X-Google-Smtp-Source: AH8x227x9M5kEVfO13czJtnwm7UegEaP8q7maDIw86yU1RluwLVbvapg9chk4IQPebbxjM48rtokaw==
X-Received: by 10.223.151.106 with SMTP id r97mr4881114wrb.203.1518478966120;
        Mon, 12 Feb 2018 15:42:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm8279766wml.24.2018.02.12.15.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 15:42:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
Date:   Mon, 12 Feb 2018 15:42:44 -0800
In-Reply-To: <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 12 Feb 2018 13:59:27 -0800")
Message-ID: <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And some maintainers end up using multiple repositories as branches
> (the old _original_ git model). Again, you can just use "git fetch +
> git reset", of course, but that's a bit unsafe. In contrast, doing
> "git pull --ff-only" is a safe convenient operation that does both the
> fetch and the update to whatever state.
>
> But you do need that "--ff-only" to avoid the merge.

OK.  I guess it is legit (and semi-sensible) for downstream
contributors to "git pull --ff-only $upstream $release_tag_X" to
bring their long-running topic currently based on release X-1 up to
date with respect to release X.  It probably makes more sense than
rebasing on top of release X, even though it makes a lot less sense
than merging their topics into release X.

As you said, pull of a tag that forbids fast-forward by default is
rather old development (I am kind of surprised that it was so old,
in v1.7.9), so it may be a bit difficult to transition.

There is 

	[pull]
                ff = only

but pull.ff is quite global, and not good for intermediate level
maintainers who pull to integrate work of their downstream (for
which they do want the current "do not ff, record the tag in a merge
commit" behaviour) and also pull to catch up from their upstream
(which they want "ff-when-able").  They need to control between
ff=only and ff=when-able, depending on whom they are pulling from.

We may want per-remote equivalent for it, i.e. e.g.

	[pull]
		ff=false ;# good default for collecting contributions

	[remote "torvalds"] 
		pullFF = only ;# good default for catching up

or something like that, perhaps?
