Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1108D211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 18:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbeLBS6o (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 13:58:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46970 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbeLBS6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 13:58:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so9922663wrt.13
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R4fZE6YEIsIL2ITm9SKAE5gUOz0FcVpSlwW0G/6E5eM=;
        b=G7HwF7z+9UDkFYzv1k5MtFHIIFCWMJJUXEnAm1nEu1XwF12HuouXqb+0SxnwU89PUx
         9LW6nKQ1CLXxw/oylgX/kSirz1/AkMlBljYadiPEcXo3QjmQS0ff+eInMtx/ZIkyGr76
         jwbTCzqPfXIDbDIRKbvZyeFCG6D8LhKs21WwN+HoAgtKiEwGQOnwC/M1MK8rztx+SCcT
         eh5PARkZLvg9LXhPpVxoGQYY6BPelzQT7jFpXuVSzPdOpC5gWHhD43d5Fkj2EtgdLr2X
         uaeFmY83aLdyWVvUv+Zi5htYO3pwlxqld/4kwayNGKdG0cjFM1LM9ElhOanwpdtrzwO0
         T1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4fZE6YEIsIL2ITm9SKAE5gUOz0FcVpSlwW0G/6E5eM=;
        b=MtuqeHmMUVCXFdTQNNfA0s4g0yycdd1OXyf+HiyLeYHuSjSlkQSjDxKGrVuG9P7Ab7
         zsTPhnM+QUN2GWKVEkEN9blM25yPvFGFAFbLzxh8YdSWJwlOVWQqDGfWiSSGWGzQHGJ3
         1uF2puX1hXkIHdwKLE9vwInG0vrkTmAhKERDxH27aFKBI8ISV98OpEHVwvTokSVUYrri
         /CSEoWvzs4zt/77G3KFd/WkkHwUEvBjGp9nxl9De1D4OPVtRfZF1wAgK7OgiJIhLh3bC
         RLz4L+nxVUhtuV4kwBDBjenDQs4U515I+FDB7fJphpi5RSpcAllgbLnzS7L0TPe3huro
         o3Rw==
X-Gm-Message-State: AA+aEWY6bohcu1kZ//2d9FBqn5EcJCKOAlV2U7qUIqeYIfzrcv4J03TO
        CxV8BXfFevd3ObBhdkUVfpFE2Bn6
X-Google-Smtp-Source: AFSGD/X/1HuAFrLta3yMmH/Ix+8x7Yr8pd3SDXzXH3YULvLTA3XdIzxvuumdUaTBAGVXVi4N4lm5tA==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr11019144wrn.307.1543777120781;
        Sun, 02 Dec 2018 10:58:40 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id s1sm14896566wro.9.2018.12.02.10.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 10:58:39 -0800 (PST)
Date:   Sun, 2 Dec 2018 18:58:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        avarab@gmail.com, git@vger.kernel.org, sbeller@google.com,
        sxenos@google.com
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and
 restore-files
Message-ID: <20181202185838.GN4883@hank.intra.tgummerer.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
 <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Junio C Hamano wrote:
> 
> I am unsure about the wisdom of calling it "--index", though.
> 
> The "--index" option is "the command can work only on the index, or
> only on the working tree files, or on both the index and the working
> tree files, and this option tells it to work in the 'both the index
> and the working tree files' mode", but when "restore-files" touches
> paths, it always modifies both the index and the working tree, so
> the "--index" option does not capture the differences well in this
> context [*1*].  As I saw this was described as "not using the usual
> 'overlay' semantics [*2*]", perhaps --overlay/--no-overlay option
> that defaults to --no-overlay is easier to explain.

Agreed, I think --{no-,}overlay is a much better name for the option,
I'll use that for my patch series (I hope to send that soon after 2.20
is released).

I must admit that I was not aware that the mode is called overlay
mode, before you explained it to me, so I wouldn't expect most users
to know either.  But as it's easy to explain that probably doesn't
matter much.

>     side note 1.  I think the original mention of "--index" came in
>     the context of contrasting "git reset" with "git checkout".
>     "git reset (--hard|--mixed) -- <pathspec>" (that does not move
>     HEAD), which does not but perhaps should exist, is very much
>     like "git checkout -- <pathspec>", and if "reset" were written
>     after the "--index/--cached" convention was established, "reset
>     --hard" would have called "reset --index" while "reset --mixed"
>     would have been "reset --cached" (i.e. only work on the index
>     and not on the working tree).  And "reset --index <directory>"
>     would have worked by removing paths in <directory> that are not
>     in the HEAD and updating paths in <directory> that are in the
>     HEAD, i.e. identical to the non overlay behaviour proposed for
>     the "git checkout" command.  So calling the non overlay mode
>     "--index" makes sense in the context of discussing "git reset",
>     and not in the context of "git checkout".
> 
>     side note 2.  "git checkout <tree-ish> <pathspec>" grabs entries
>     from the <tree-ish> that patch <pathspec> and adds them to the
>     index and checks them out to the working tree.  If the original
>     index has entries that match <pathspec> but do not appear in
>     <tree-ish>, they are left in the result.  That is "overlaying
>     what was taken from the <tree-ish> on top of what is in the
>     index".
> 
> Having said all that, I will not be looking at the series until 2.20
> final.  And I hope more people do the same to concentrate on helping
> us prevent the last minute glitch slipping in the final release.
> 
> Thanks.
