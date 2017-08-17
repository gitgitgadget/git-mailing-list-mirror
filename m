Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20331208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 06:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdHQGzH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 02:55:07 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37475 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdHQGzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 02:55:06 -0400
Received: by mail-vk0-f68.google.com with SMTP id r199so2442770vke.4
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uciYFXryHj9Nf4/vouH+Y6NqXEyxzgarBNJXgCd2al4=;
        b=rC0AUHyw0CBPn74npXqPwBZZprsUZ9t0no8/pb19U1S1KRlw69d8ZJCL8+mjqU2+I9
         s29eomdgcFMWiV56HXTyZ96u9ROuwwPKVed9KErbVrka0Dt6j3snJvXTx8e457cRRZ52
         qpBisLSQJFC9uAIetiDXj7L8nc4ELqZE97koMnp3KeMTAUP8Qrp4qPPIARcRkgUzq2jp
         NI6byS2LjSO3em46wCJ9/PImTadmtKAJfUmRg/J8ux+v8FypsOKQBD8F8SubREVuhLxk
         IT29zgm5yHUsgI/Oy9l5TLUyFZ5YSDKVA46HSACGABybyeONkUS+TgxcBpq3wYzMyNR0
         w9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uciYFXryHj9Nf4/vouH+Y6NqXEyxzgarBNJXgCd2al4=;
        b=UI78prUFGASE3NgzZopNBd99+Kqz0RkgqL26oDxBQe37NsnE5QJVvuoKAEFAM3lADp
         T4fmEUXh1G2ihnz7OifRkXHokhokeGnpsZGLN/FkYYEKF9FO7z6u8rNmKrlmy5fvejNt
         VaebMEOOSKZ7DC5E5qqMmZxku0i5Vc0iIl2XnPzGOe6b3J7JZohzkTNkrnAxOi8nIyRE
         lXtpQSG7uYUXbckzjDymBMKZpWByU49kJi77YfwJ9+I7tceZUzXOGpLlpeo3TUBwNj+o
         1xgGCezr0L1MvUcBox1w/O3k+kilYJuAUPGqVejsMEY1z/eSA+Su0Grz6dQmIpScMHmG
         fcUQ==
X-Gm-Message-State: AHYfb5iL/+Rn8uY0s+go6QvKbnctvG2ZxIrhQXTF6djbMQTwCbB+gIYj
        5Rem3z1sIMhyO564Ok0Jip0ZwzSDTNpD
X-Received: by 10.31.62.204 with SMTP id l195mr2466142vka.183.1502952905370;
 Wed, 16 Aug 2017 23:55:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.114 with HTTP; Wed, 16 Aug 2017 23:54:44 -0700 (PDT)
From:   ryenus <ryenus@gmail.com>
Date:   Thu, 17 Aug 2017 14:54:44 +0800
Message-ID: <CAKkAvax4Coqa6=jT52dpy4SYycfwoN-6kGfoh3QPLJi2-69Orw@mail.gmail.com>
Subject: [PATCH v2] update revisions doc for quoting in ':/' notation
To:     Git mailing list <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make sure the `<text>` in `:/<text>` is seen as one search string,
one should quote/escape `<text>` properly.

Especially, the example given in the manual `:/fix nasty bug` does not
work because of missing quotes when used in shell. A note about
quoting/escaping is added along with a working example, however, the
original example is left-as-is to be consistent with other examples.

Signed-off-by: ryenus <ryenus@gmail.com>
---
 Documentation/revisions.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 61277469c..d2862d55d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -185,7 +185,9 @@ existing tag object.
   e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
   literal '!' character, followed by 'foo'. Any other sequence beginning with
-  ':/!' is reserved for now.
+  ':/!' is reserved for now. And make sure to quote/escape for the text to be
+  interpreted as the expected search string/pattern, e.g., for a commit whose
+  message matches a literal \'`$`', use `git show :/\\\$` or `git show ':/\$'`.

 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
-- 
2.14.1
