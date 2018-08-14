Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F991F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeHOCJq (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:09:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40066 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOCJp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:09:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so18570606wrs.7
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ERsJv4KfQQfIlBpKTEoFoCzYM1D09r6J2N0pPbqst8M=;
        b=d+IfB3YpBDFi+ax5dLnfje/S+nmzgn5V7WlI+v5KutESlRimkVBIU0erxsGj9qS+uf
         pFJ5/5oGCg7CXLq/GvrGQ/nOgztYEaIN3p9Ihp3WjGNwxI70pz5TRiHPy8L5S4Ih32tc
         Zr77RuNPuNv9NzzHsSoaveoHJuTORIJitS2pph8hMj9fUYLYk2vTmyokHX2fhdVI5wD3
         n1G+zGaNmtOZ48Ng4cfM9rtBNZsp4FNoT1H8xGc8QlD3xJ27JrBmcoXyQCn/UgLWVcPA
         8PbyPNsgkpEqFSmsq4YH3QbYO/BvAieWY1NHBILnp7KHRBZ0ZIwem1zI/GRP6DmdWNjz
         JKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ERsJv4KfQQfIlBpKTEoFoCzYM1D09r6J2N0pPbqst8M=;
        b=h4+pXty1bMxEBRnsLz8wLzmTil37+XqRbihlLoI/DHAcG0D1Sq04XYSce/m+Z/wzVG
         pkSMpLtMhr+prCF/hAWVkImmqF7QgoUhLM380Z4hfzSHe5bEjXg+HOcralr1Q2lXRzLE
         5JJNuUKkFIckT5sG3JsjGP0ntaexyO7kGN5RAZzFitii//dA8QMy2c8CsqeoUb+EH3SO
         736HvHPn+3LnPs4YzQj7Cgf+DejWJp2C0Ne0Vv0IFGUzGYc4UUhZfNuLt0Fjzm3c1UbE
         WtccVQBf5HL6Cz7oh8aKQyLA2wkX1/i08+uuVQifVLqnBF4wJ9QyrmvGXjyZXWENYHf7
         AN4A==
X-Gm-Message-State: AOUpUlFC9B7xYwsiUclB18+nvVFKbWLQRn1gUjM6v0fYpilZe+DK+vq8
        BXPhzTVHnV8t7aysyoAtkv4=
X-Google-Smtp-Source: AA+uWPwTj2t8MN6HXktENW68fmKn4WEYV2iX8soXk1NvRVRiHquMrW76Rxx8uEWsSxOya3pwa/I/sQ==
X-Received: by 2002:adf:a557:: with SMTP id j23-v6mr14407554wrb.220.1534288816694;
        Tue, 14 Aug 2018 16:20:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s10-v6sm906035wmd.22.2018.08.14.16.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 16:20:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     joakim.tjernlund@infinera.com, git@vger.kernel.org,
        bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 1/2] store submodule in common dir
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
        <20180814223820.123723-1-sbeller@google.com>
        <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 14 Aug 2018 16:20:15 -0700
In-Reply-To: <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 14 Aug 2018 16:04:36 -0700")
Message-ID: <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> My understanding of what Joakim wants to do is to have a top-level
> project that has three subdirectories, e.g. kernel/v2.2, kernel/v2.4
> and kernel/v2.6, each of which is a submodule that houses these
> versions of Linux kernel source, but only clone Linus's repository
> (as the up-to-late tree has all the necessary history to check out
> these past development tracks).  And that should be doable with
> just the main checkout, without any additional worktree (it's just
> the matter of having .git/modules/kernel%2fv2.6/ directory pointed
> by two symlinks from .git/modules/kernel%2fv2.[24], or something
> like that).

Actually I take the last part of that back.  When thought naively
about, it may appear that it should be doable, but because each of
the modules/* directory in the top-level project has to serve as the
$GIT_DIR for each submodule checkout, and the desire is to have
these three directories to have checkout of three different
branches, a single directory under modules/. that is shared among
three submodules would *not* work---they must have separate index,
HEAD, etc.

Theoretically we should be able to make modules/kernel%2fv2.[24]
additional "worktree"s of modules/kernel%2fv2.6, but given that
these are all "bare" repositories without an attached working tree,
I am not sure how that would supposed to work.  Thinking about
having multiple worktrees on a single bare repository makes me head
spin and ache X-<;-)
