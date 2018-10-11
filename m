Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3B31F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 02:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJKJkk (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:40:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36864 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:40:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so7788351wrd.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=3bkCxwcYXC99dY2RUNJyhKCVtHET1NsKLp8JUUbra08=;
        b=pcg77ZsFT5SKi6dl080/a622eA8KVGmHFIdq+WaAiNDe0BYhM3a3m46PavNCMVBFe8
         9k7vbXsh++yS5OHeOYaHIjz8fXi9SKIpjpCayyW+VV35EbSemPjngOCqekn2Zn7GY2vh
         nGHiF8OPGZX4b6g7zGRhp6wq/4X5KXTPsY6KdwyYD0Cl5O/GKekJ++CtZx62SvyRpDew
         c2fTRu1igYnHC5p1E+QE9lwBWt9VMP4cKGOwF+jI38BnXaQKO9ILs6i/26LHUOVP4+VP
         r/FbusQu+B8l+E6/wt4LqFDCkZTiBEWAHEs7+DZQIwnnmxFsu0LVrZ+CqVrZKGfd5Ize
         B9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=3bkCxwcYXC99dY2RUNJyhKCVtHET1NsKLp8JUUbra08=;
        b=YcmKlDW325NX7wzL6fZJmX6KVusdFzyyej9N5G2ce9qSNSjHFSGBZ1RKCpqVWkP2xm
         OmwGadCzRz5/SOkjKLrb47YMM9MoZdSvz+tzJUOflIPUNIbaJBHFMhjO9b2rOFN9jQhm
         Zo/7SkCSPOPZoUAN41yb3vhiyNjmM+tWZx6JiXAVzNazSKn/DsvCagkKLCQwsLzlncBc
         yCwdH/M9PiHlrbUBaaHzOqzrQjs71HF1/c/Gp4RWTeNF7G93NR4dgkJCQCDqRTWC3bjn
         B0FXsx78jik08AzDeLawItOVBv/s4M4IyErjL6wnYzrYAOgiTZdBuGOppgGaMl09xiKt
         cJxg==
X-Gm-Message-State: ABuFfogkB+8IFVA0Iw/60OWYDLzh4/XFur7D78pQk0fBagD0UvPXqLsa
        ELZp8jkhslEh1kgFpuuw1NNhDuL61Bs=
X-Google-Smtp-Source: ACcGV62Ah4S9Rp0MizjLhM9vk8xgsM17om8KpYq4KclCm4trPyEtf5bKLF65QQeRTvFd6V7IaPpIPA==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr26769049wrh.72.1539224138412;
        Wed, 10 Oct 2018 19:15:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 201-v6sm19540313wmf.30.2018.10.10.19.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 19:15:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] fixup! builtin rebase: support `--gpg-sign` option
Date:   Thu, 11 Oct 2018 11:15:36 +0900
Message-ID: <xmqqzhvlgref.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 27 Sep 2018 14:48:17 +0200

The `--gpg-sign` option takes an *optional* argument, not a mandatory
one.

This was discovered as part of the investigation of
https://github.com/git-for-windows/git/issues/1836.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

 * I am sending this out as I want to mimize the number of
   non-trivial changes that come into my tree without hitting the
   list archive.

 builtin/rebase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a28bfbd62f..43bc6f7915 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1030,8 +1030,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
-		OPT_STRING('S', "gpg-sign", &gpg_sign,
-			   N_("gpg-sign?"), N_("GPG-sign commits")),
+		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
+			N_("GPG-sign commits"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_STRING_LIST(0, "whitespace", &whitespace,
 				N_("whitespace"), N_("passed to 'git apply'")),
 		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
-- 
2.19.1-328-g5a0cc8aca7

