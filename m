Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7322D2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdBWSir (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:38:47 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35438 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBWSiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:38:46 -0500
Received: by mail-pg0-f46.google.com with SMTP id b129so18043700pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 10:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9Wv/uLywtX9nCfXMAyE+Y0TvmFlm/rpPvhzK+Zw0z+M=;
        b=JgbMic3tuONEyYbiAwizrThg4AhXzksT8DCe65Ea6m255LsZKsC/9Xd6KZcET+yx/O
         VIdNZgAwhgB9Y4TPSHzWuEGl8+23gMsSou7zBPmPZNWxbaSgjWSRYcuj2Od6Zf28TrgF
         gG2cUTdlm4hnxCNo0LZ2ivdJ/Cw6IgUaKOAdpg9teCpcOncqeC68p8+WRkLpUa+QE7AF
         k9SMrDOltnyLWNVJKLItlefD1SMLoJ/ZYO6Muxwenk0ttODRRariARNIOEtsqJPUMK0/
         JhR6h6wQqpAjpyhQFdWbfseSHVQwKCwfxrxMa2SxIpkCgc0C9aFAVYD6d/EtSeH3hHu5
         ireg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9Wv/uLywtX9nCfXMAyE+Y0TvmFlm/rpPvhzK+Zw0z+M=;
        b=KEdotSJjTav0OTwRG9GRhYFZ5whUYXMNsmTzXpXakciWAlt38xs6CS38PD9Uro94LX
         cHlyWYecJgZqQ/nqAgRHn8EbKlTFnonlp7CgaVu3DEHMvUiKA1MuvRxllaZkZWbUPkt4
         rIyMSpmXTglAXrJZJgZ7VgXxZA1lOQFlTSDDNqS3YfILJtUQz5gK6PDBSJLiJkLal+tl
         NSO6Vyv2orfkeL/RIalqG1qu0tXyI7dUFczpKPAcN9ramLuI8g/mxlMcWSb0aKD57+1l
         MAIAfOidngByBOhm3HVqiV6c+LlLIXbsfjglayE7yb8wJJCean3zbV/taZbj2hDLjISd
         87hw==
X-Gm-Message-State: AMke39mBX2h3LUIH/JGlEaNIHEtYvymmlAgBks/7FwkwX54xyNtSNzlaGPW2iCq0s9avhw==
X-Received: by 10.99.160.81 with SMTP id u17mr50360909pgn.92.1487875125880;
        Thu, 23 Feb 2017 10:38:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id o18sm11163465pgn.36.2017.02.23.10.38.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 10:38:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joey Hess <id@joeyh.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
        <20170223181018.ns4vyosgzmuoyiva@kitenet.net>
Date:   Thu, 23 Feb 2017 10:38:44 -0800
In-Reply-To: <20170223181018.ns4vyosgzmuoyiva@kitenet.net> (Joey Hess's
        message of "Thu, 23 Feb 2017 14:10:18 -0400")
Message-ID: <xmqqk28g92h7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> For example, git fsck does warn about a commit message with opaque
> data hidden after a NUL. But, git show/merge/pull give no indication
> that something funky is going on when working with such commits.

Would

    $ git config transfer.fsckobjects true

help?
