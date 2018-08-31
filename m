Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B751F404
	for <e@80x24.org>; Fri, 31 Aug 2018 18:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeHaW6e (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 18:58:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54688 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaW6d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:58:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so6110555wmb.4
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f0hnQ7qHKRE5SiRXMfZPNfzgcK+WFMTPNAlB1IFftic=;
        b=mEZvspFg8XTTZHyPNFPOkOyv1kzIpeiOuAWBxfhW0jp/CdyytjThzWAAxIwUVOM7qE
         B7RW8wdu5ElFy1WzjxLzhnu4ULXbPltWM+tEXOlDZ5+lcUJOHF4vSG9esQiZ0gQy9PgL
         KLCIjIWXVTgI2qXgKQyi3Lehfixkj6IKts5LhxK76FY5IDXUrWc0Fyu28G4+aeR+iVL/
         L7DtKnjVmQCPtgLLpU7lC1fnEaTxIPpdIOTDEaJb03uNJNnlePZocNIxKW0WzPpy+oHp
         FruLo3Gl8Akn2dyg8F/DP9WWrsVP7zhD/bRk/VVjfQDgBeN+ol06ISJ+aRVD9N0bGKkM
         Y9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f0hnQ7qHKRE5SiRXMfZPNfzgcK+WFMTPNAlB1IFftic=;
        b=VCCnnlFAq03jdNGY6P6Q85IAggXRycAQhFU+hqbBF0Alq90dfOrgD8OWg00d25cRvO
         D/Kidja7srORrOVX770Dv6J+CberNndk0JAaq7w225JEXnRduyEd2il25DVSbBXda5WQ
         nZg5u0N30XVgkbE8SchIPaz4ncBVgWxFpHapXfUxccs9S0Q7NDgk91mz/xMaUvXIRMbN
         fb7k0fKwFGpOasJJdmuvDvxsz1M9olt3reWKlzuPBjarwbnoiMO/MpEQ0lJ/km1wEwfs
         YzrKfHXIfw7r3mwCgq01nG2XU+aoyp4kCn4Z/mx81WGUzKgRtN6JDtNubHkWI0+kBHFJ
         k4oQ==
X-Gm-Message-State: APzg51Arw95mNPI4Fs603AIhe5hSMsBvBx1fTiMMWDgaz66VB90dVeMB
        AXDtPIwbfzHX5/pDzEC64/M=
X-Google-Smtp-Source: ANB0VdYLk1DOJvuihL/G6u4becDbHVSu7CK+Quyre8hbSvAvG6Eyg45EdE9x9tmoxn7jAIKOOrHTWg==
X-Received: by 2002:a1c:9b95:: with SMTP id d143-v6mr5788714wme.95.1535741385425;
        Fri, 31 Aug 2018 11:49:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm9583560wrq.25.2018.08.31.11.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 11:49:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] doc-diff: add "clean" mode & fix portability problem
References: <20180830195546.GA22407@sigill.intra.peff.net>
        <20180831063318.33373-1-sunshine@sunshineco.com>
Date:   Fri, 31 Aug 2018 11:49:44 -0700
In-Reply-To: <20180831063318.33373-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Fri, 31 Aug 2018 02:33:15 -0400")
Message-ID: <xmqqva7q1id3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This series replaces Peff's solo patch[1] which updates "make clean" to
> remove doc-diff's temporary directory. Rather than imbuing the Makefile
> with knowledge specific to doc-diff's internals, this series adds a
> "clean" mode to doc-diff which removes its temporary worktree and
> generated files, and has "make clean" invoke that instead.

That sounds like a better approach.

> It also fixes
> a portability problem which prevented doc-diff from working on MacOS and
> FreeBSD.
>
> [1]: https://public-inbox.org/git/20180830195546.GA22407@sigill.intra.peff.net/
>
> Eric Sunshine (3):
>   doc-diff: fix non-portable 'man' invocation
>   doc-diff: add --clean mode to remove temporary working gunk
>   doc/Makefile: drop doc-diff worktree and temporary files on "make
>     clean"
>
>  Documentation/Makefile |  1 +
>  Documentation/doc-diff | 21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
