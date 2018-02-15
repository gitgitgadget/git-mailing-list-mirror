Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E43E1FAE2
	for <e@80x24.org>; Thu, 15 Feb 2018 20:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033884AbeBOUDP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:03:15 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33806 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033881AbeBOUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:03:12 -0500
Received: by mail-wr0-f194.google.com with SMTP id m5so896139wrg.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u7hG36OCG3JQ62oms4pRJhMlU/y7l7yrbHt27igSY2o=;
        b=s9L1Yizp0H1L/38ZoromHG9KUuc6QezdVUl1dT44r1TYYFP+8Mrr4ckd1DaMjZuIpX
         mhPR36CzeFaGSKMpCbIKrpRDxnepOZVY1AeF+IR1pRmSNfXR8a6solMtcK0jdk0G4ATa
         h9z5eTln4vuJAsNuo26WLBDcCeLuSZ38MwXSPKqNXTkS7XYFutQblEejcjL3Je8Ym5Ws
         oq6iErOpN4eu9Xc0O6vTcgSKWj2G+8oUY8vMoQ4zpJ/K2S80ndLXE2kIIt4T/7+AHtv9
         pqjbt0xpUESZgP0B6A7ZbTvpIFbfQbNwtX6PUukqN/PIf1Ne3ZbIbuH/aPsWhZ1G3COi
         nmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u7hG36OCG3JQ62oms4pRJhMlU/y7l7yrbHt27igSY2o=;
        b=Ldb7C//u8PPwBnhTXHBZeyjNgwl8If4DVpR6ZgHegeY3mh6t0oGV5YL8S3QktiR/zQ
         1sOcZYk2RVE6MOWt8m5ysPBg0Wq+HmDv7/bbyxx/Mz1IUdJJHsNXuFV4R6hE/5IIsuJE
         V495FqUqdZEdDplJWu91Fq5drKv62JB5KNopq/ZP22SxBAgzEBQ237iC5mhZlWXEHVY9
         1bUJFJaA9RuRJB9Gix0OUE561xdpYa5Nu4rHPAzXHRpQHygkpWRRwaCBvrFFVWAAYdIv
         6pOZ1LH3nvGk/qDjmJutZzYztplgzWQqj/43ZrsqWJ+sU3IoWw+UTSV+dUEEOiLiHRGs
         6KGA==
X-Gm-Message-State: APf1xPCBnuYLHRjzkzhoMerlkJZlsU5Uw+o4bab2zCFAWvGlq12ggASd
        2qnDGTOr82RdAnsnOAEza88=
X-Google-Smtp-Source: AH8x226gz5X7wZ8SxJBO9eQyRrHaTKfMslC85Pb1qg3UOWmltWNfLb/ZtSouVlzeo+zxjrdRGJ4vMw==
X-Received: by 10.223.198.200 with SMTP id c8mr3756995wrh.79.1518724990166;
        Thu, 15 Feb 2018 12:03:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u3sm4994245wre.39.2018.02.15.12.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:03:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <20180215152711.158-1-lars.schneider@autodesk.com>
Date:   Thu, 15 Feb 2018 12:03:06 -0800
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com> (lars
        schneider's message of "Thu, 15 Feb 2018 16:27:04 +0100")
Message-ID: <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> -- Git clients that do not support the `working-tree-encoding` attribute
> -  will checkout the respective files UTF-8 encoded and not in the
> -  expected encoding. Consequently, these files will appear different
> -  which typically causes trouble. This is in particular the case for
> -  older Git versions and alternative Git implementations such as JGit
> -  or libgit2 (as of February 2018).
> +- Third party Git implementations that do not support the
> +  `working-tree-encoding` attribute will checkout the respective files
> +  UTF-8 encoded and not in the expected encoding. Consequently, these
> +  files will appear different which typically causes trouble. This is
> +  in particular the case for older Git versions and alternative Git
> +  implementations such as JGit or libgit2 (as of February 2018).

I know somebody found "clients" misleading in the original, but the
ones that do not understand w-t-e do not have to be third party
reimplementations and imitations.  All existing Git implementations,
including ours, don't.

One thing I find more problematic is that the above places *too*
much stress on the UTF-8 centric worldview.  It is perfectly valid
to store your text contents encoded in ShiftJIS and check them out
as-is, with or without this patch.  It is grossly misleading to say
that older versions of Git will check them out in UTF-8.  "will
checkout these files as-is without encoding conversion" is a better
way to say it, probably.

Also notice that even in the world with w-t-e, such a project won't
benefit from w-t-e at all.  After all, they have been happy using
ShiftJIS in repository and using the same encoding on the working
tree, and because w-t-e assumes that everybody should be using UTF-8
internally, such a project cannot take advantage of the new
mechanism.

And from that point of view, perhaps w-t-e attribute is somewhat
misdesigned.

In general, an attribute is about the project's contents in the
manner independent of platform or environment.  You define "this
file is a C source" or "this file has JPEG image" there.  What exact
program you use to present diffs between the two versions of such a
file (external diff command) or what exact program you use to
extract the textual representations (textconv filter) is environment
and platform dependent and is left to the configuration mechanism
for each repository.

To be in line with the above design principle, I think the attribute
ought to be "the in-tree contents of this path is encoded in ..."
whose values could be things like UTF-8, ShiftJIS, etc.  What
external encoding the paths should be checked out is not a
project-wide matter, especially when talking about cross platform
projects.  Perhaps a project in Japanese language wants to check
out its contents in EUC-jp on Unices and in ShiftJIS on DOS derived
systems.  The participants all need to know what in-repository
encoding is used, which is a sensible use of attributes.  They also
need to know what the recommended external encoding to be used in
the working tree is for their platforms, but that is more like what
Makefile variable to set for their platforms, etc., and is not a
good match to the attributes system.

