Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6E620248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCMKQg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:16:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36794 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMKQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:16:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so995827edi.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9zGapRAnamy+C9pyPdGt9QUEjrCuM7OYFRpWVW48J9E=;
        b=rpYXH7AYYuMw8F4k5DNoitA2V1IaCkId7znZUvvP6/ZdMOIJ42862QxtHRvmLTkInn
         YEpRjLFqxF60jUnw10Ly3U5DKfeGeKch/nlkczepW3o0y2G5/JvWEFGeNeXzLuf84Jxa
         A9rXO98l4T/T6xH39Ki9qEC+lYszadXg85LM4X0I0Q5oVykACxM7Mw/U+1I/4qr20O6R
         GpNLJv9mRO8LSYAVueGCtM0/ZpaL0SVnkzJcAAzG5EmWMsSrnzlGIRSNtlrtfmNMhq/4
         iiS0chRaMt99OdTB6CpnliP/Zjn3kGMVpo7AjGUsCYENnsBwzFzb4CB6GTKO2BoCs3yA
         u1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9zGapRAnamy+C9pyPdGt9QUEjrCuM7OYFRpWVW48J9E=;
        b=ayRg0ARLIhTB9DYZj9kN2R3ScZ+evG575jvbCwyz25/CVZVM5PNP0f13Q016yZVQYc
         7MAjW4sly3ZPY7fRFf9Y+9xClbedMyDR40XZ+0yH84eqZxPb2iisCUFPTzUsLNrTZdDt
         iliRWC4idqh4MMMUm0vEKj4uZyg/JT6xTTPnDhKtFDxWGiOVCQPaei/Eh8rkQXdqPs7K
         bY5i42S2KFXCCADIg3dkdksdN1462IqOS9z6MOhHbCpxCW/xnWtGm4VLd7MXLRNSQAmF
         HAfBCbobWeqAN+0RBmo61erBx6mTc7MbJpSWx7MVrWsdQEHbWEKhjPp6qDed6ESVfBw6
         Nh5w==
X-Gm-Message-State: APjAAAUDmzs34rGJfC0QND7rRixne7H57NLjc4z+HGe2n+bS7TwVnweJ
        gfzG6hEISwAX2zCGsWld5Wikkz/a
X-Google-Smtp-Source: APXvYqxmmp7YA9RepAeeQn7PFaSLB4Bhw/tg12Y6vOayLUrt6X+P6Zt5pxFR1zUVyioisDNZWuB9dQ==
X-Received: by 2002:a50:b308:: with SMTP id q8mr6895928edd.213.1552472193009;
        Wed, 13 Mar 2019 03:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm353476ejk.8.2019.03.13.03.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:16:32 -0700 (PDT)
Date:   Wed, 13 Mar 2019 03:16:32 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 10:16:27 GMT
Message-Id: <d8c4a3dde5bed492bcdb6399fd8a73ebf4798320.1552472189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] sequencer: improve error message when an OID could not be
 parsed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The interactive rebase simply complains about an "invalid line" when the
object hash of, say, a `pick` line could not be parsed.

Let's tell the user what happened in a little more detail.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 95dda23eee..f91062718d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2137,7 +2137,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	item->arg_len = (int)(eol - item->arg);
 
 	if (status < 0)
-		return -1;
+		return error(_("could not parse '%.*s'"),
+			     (int)(end_of_object_name - bol), bol);
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
 	return !item->commit;
-- 
gitgitgadget

