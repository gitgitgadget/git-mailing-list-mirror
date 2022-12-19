Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0ACC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 03:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiLSDHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 22:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSDHn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 22:07:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3062F4
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 19:07:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 17so7804756pll.0
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 19:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CzixZn0Ah8VhdQ6SiV3IZirDfrcLHRfsjZ3gtTt0q7g=;
        b=Uz1m41FVOCNvB8gt/sbxnxlEKHS2Xz/vc02ZKuyE+VcgNTKXXEKbQhTLA7QE9a2Q7V
         BgqzN6dgT6MNQk5ZR0jyOMZq1KN8sSTjI13MlGno8VkKSUU/dpD78tLVBYygXTVcP+fO
         8oCpTBgwhyEmtsNIRn3IHLdmrQnMCfkIBFF6Dng+NHVekYarK/wiVbMnejbUUX0c67Gv
         ME1ENiPDJQdp+AU9VcTBzs8I7LgdLUNy91Ae+W3B6B4TNfbSmmJW0Pti1xXXXs8bw6U6
         QPPXnA5uv3UgLgKlS8OcNC8xYInMvzoseSWtI0Oba14OxGRlOAM+W95srOy/NgeGZ0Rl
         UYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzixZn0Ah8VhdQ6SiV3IZirDfrcLHRfsjZ3gtTt0q7g=;
        b=MrD2ZZjuZPx24Ya84yqbBNjnnOQHxZApwE00KbFSBHGcoB7MkYxpygU26pib8h1Cvc
         HMChtKByXE01Ji72ZbFClFIXwLyVRffCidTojkmJB2K/Oak9tC4EFLqdzlXWuAWio8mj
         /msVtyKhTW6kFMRpK9KldmvhwYrqr7mmBDPQmx6b++P1jWPbgYvZWPkkwdnjUfPiEeN5
         15PP6KIz0kYT21cJEM+1L5iycFBOfUqlC7aDARK7zv1P0VGfpd9dkNTpxSIk9arQCTRk
         ZNQBp/qLYW/sqm5SAra+pXhYAI5YsyHTCyayy0jmY0HlSeg3SxRt8zpahA2nnXhnFZQ1
         35Kw==
X-Gm-Message-State: AFqh2kphMabUlxWL5OyrbJboRvhU9CbDr5ro8kJgVcnQbTxPDhmi5qvL
        g2RFDkNQQC+3o2n2QyYLpt3fxV2Y2bjowA==
X-Google-Smtp-Source: AMrXdXs5d745AboBTN3nxoTOyMD64iaUhL+nV4fXNUkLYxl2agfAPeha0bb09sq4BKSU6A4UdPOgJw==
X-Received: by 2002:a17:902:7613:b0:18f:9b13:5fb9 with SMTP id k19-20020a170902761300b0018f9b135fb9mr6682218pll.60.1671419261898;
        Sun, 18 Dec 2022 19:07:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x13-20020a65538d000000b004792ff8ab61sm1961052pgq.80.2022.12.18.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 19:07:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #06; Sun, 18)
References: <xmqqh6xtw4uw.fsf@gitster.g>
Date:   Mon, 19 Dec 2022 12:07:41 +0900
In-Reply-To: <xmqqh6xtw4uw.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        18 Dec 2022 16:25:27 +0900")
Message-ID: <xmqqh6xsum4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the ones marked as "Will merge to 'master'" in the most recent
issue of the "What's cooking" report, the following topics haven't
changed since they were cooking in 'next' before the tip of 'next'
was rewound:

    rj/branch-copy-and-rename
    rr/status-untracked-advice
    aw/complete-case-insensitive
    sx/pthread-error-check-fix
    rs/diff-parseopts
    jk/avoid-redef-system-functions
    jk/avoid-redef-system-functions-2.30
    rs/t3920-crlf-eating-grep-fix
    js/t3920-shell-and-or-fix
    jh/fsmonitor-darwin-modernize
    ab/t4023-avoid-losing-exit-status-of-diff
    ab/t7600-avoid-losing-exit-status-of-git
    ab/t5314-avoid-losing-exit-status
    jh/t7527-unflake-by-forcing-cookie
    rs/plug-pattern-list-leak-in-lof
    rs/t4205-do-not-exit-in-test-script

Hence, even though it has only been a few days since they were
merged back to 'next', I'll be merging them down to 'master'.

There may be other topics in the same state, which hopefully will
hit 'master' shortly.

Thanks.
