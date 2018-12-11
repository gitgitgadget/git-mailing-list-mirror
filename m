Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D33A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 03:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeLKDNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 22:13:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeLKDNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 22:13:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so654380wmh.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 19:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UtXrGHl48Ic3jpMeliro1IUOB916PdNsBP4301bbZiM=;
        b=T51DUq+xvP2eisgBXdVTpzXUK5p2TKpgYNxZU/VlnTljQspwc1uIUDg1byduS5FEBA
         s5BZ9q0tXGiO27sDzy74ozFOpX7/Sgzea/az8T4fzwZ7105+OYcvFt8USloX5AwGfSgV
         geCN13TJT0X+W6kJ9RR9/qiUuvr1mVnykQnVBn++jLw9F4Sfp00TyQMTBiQBiIUkn6hZ
         NclHN3bHCuRDtsFQDkuku1JbyAciemFkMHADclB7rY/6YrTiDvH0CyZXHZidfrNnRlp6
         romo/tP1EiYgHr3J4lRmkruWyKbUgQcuU9S+8W+gkTau6YdriulMdS9y5zpIGBCqxQS1
         zRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UtXrGHl48Ic3jpMeliro1IUOB916PdNsBP4301bbZiM=;
        b=BVSo87otVuZJpPuPycL44kC7sBLMN73HIvwVCQxfnh3R6jC3Iixjtm3yry3oaKSQ0k
         Zjo3+T1FMJ9ZtU5SASvzqR9aETpcXrzcZ7YRZyJrQY26furg15idknF7PQsXyrGrDl/a
         0yBvDS+O1PGmohfDDXLVPjYAOieAlCMZX1yUAggdL15zjbz/+lohbPWeGzdbddrPl3fh
         Da2Kys9r8LDWftfA07Db9UCd/DeJKbtjWOPDhQkpsSLiIUWuIPzhBW1tMZJJNLbYUa+g
         mOQ3fKyD7jrA0k76v8pXKmnCFSBy7hGRUU1px7y3HPPYU/Y+BgHlpQ4Ul2HdqRRNywb5
         u3Ew==
X-Gm-Message-State: AA+aEWYujU0vB3nlVjcXi8NREK1UGAwxJQvxJR9nAj2glV0KbMTYr7ru
        AUzIpx8T31jemNsRvuhlzoM=
X-Google-Smtp-Source: AFSGD/V/lMvEHqrr2D4s15WWo6dgUo1fwNnycZAyWD+4xuDIjtLgHm7+b8RBonCnSBDoppSvmR2mQQ==
X-Received: by 2002:a1c:dfc1:: with SMTP id w184mr686639wmg.2.1544497982126;
        Mon, 10 Dec 2018 19:13:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c10sm13004139wrw.49.2018.12.10.19.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 19:13:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
Date:   Tue, 11 Dec 2018 12:13:01 +0900
In-Reply-To: <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 10 Dec 2018 17:49:41 +0100")
Message-ID: <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Elijah wanted another mode (and I agree) that modifies worktree but
> leaves the index alone. This is most useful (or least confusing) when
> used with <tree-ish> and would be default in restore-files. I'm not
> saying you have to implement it, but how do the new command line
> options are designed to make sense?

I'd model it after "git apply", i.e.

	git restore-files [--tree=<treeish>] <pathspec>

would work only on the working tree files,

	git restore-files --tree=<treeish> --cached <pathspec>

would match the entries in the index that match pathspec to the
given treeish without touching the working tree, and

	git restore-files --tree=<treeish> --index <pathspec>

would be both.

I have never been happy with the phraso, the (arbitrary) distinction
between --cached/--index we use, so in the very longer term (like,
introducing synonym at 3.0 boundary and deprecating older ones at
4.0 boundary), it may not be a bad idea to rename "--index" to
"--index-and-working-tree" and "--cached" to "--index-only".  

But until that happens, it would be better to use these two
consistently.
