Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341BA1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932832AbeGHSvW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:51:22 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36971 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932760AbeGHSvU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 14:51:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 67FF228C;
        Sun,  8 Jul 2018 14:42:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 08 Jul 2018 14:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FS1bDWdgUO5CgVb+r
        KLK0+exMLwEtUlf1ERF+bDG4os=; b=BuD+HAL8PoO9bPS9g94NNKvkItWrIdRcD
        yJ9DQ/sAvJSACVcfua0Q52dZO+dVQwqgRkVlCOF4HUtIs625oNZVQaIKIQBFuXEJ
        RDHHAJ6wRiK2EUO9xvBPNPLbiz2/zgX2iRDot+ivtu0l4N2TIhq9IkfG4OxdroSl
        3ces+MeFrcMjdIXOFjTNrd+9Ryh09+xWGhePyIInhQ+C6IJ0E/iCEyNsHJoS4moa
        k+y5y7eozZweq8WoKYzQweTQVp2rgHhuJrAJ0rtmaVp8BlUGeCz+t9HiXNk4yxee
        V8i55h5gHW4umtGJvKk2HggRER0eLmj+rtlhBvKor+hu5NUwofmsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FS1bDWdgUO5CgVb+rKLK0+exMLwEtUlf1ERF+bDG4os=; b=ViWIlSYu
        jfE2oP6LnYQUNoAyxOAWcmaBK4YyQMHLKCAeFEbtEdYAClyaFhZnUv0+P0c+xkdS
        em8mo0IF+AFj7+GFPGNgZa0U2y5QpTaJI0bH8K0OJn73HobdGJ2QTH9zCdhsqqg3
        Iz61Tx5kxtpWmv0AzMCBLr+Xef+LNqxqGjbFHQSI4rNFEnWAA/bqZXLPv7Lh1OuL
        i+ZdjpKZRzzSUQ1e9+fkFR8VcW+NUR8vHE+1763eFE8OvDvRB11bfL6s0BachJdH
        4Z/zVDcDy2LA4V5DlFaDFssdfqYM0CQj6NgJH7xskrYKJxQc1W3jnLr5jaSEwPPr
        fjx0BsFX297MNg==
X-ME-Proxy: <xmx:CltCW0HthwYabzqBAX2sbA9XB0FYVsRbtB7Oup1buoHVEN4lCmLHTQ>
    <xmx:CltCW2qXpy_Fpq6oQ8BgJgE1Yzmy4tf2HX-DMRcQwbAHhm289UUS7w>
    <xmx:CltCW87-mczJUYJtKCfXIKsXewgQPf01Je1khbA9_HDaDZgvXH6NOQ>
    <xmx:CltCWxHiQwCeyX1sbaPMVfEL0rICzB3ipJHo3tT2MU4q7mKSSm9u8A>
    <xmx:CltCW3mjCLuPTX4QBn4JFZOqTe7JIoXPKWS8RrT-YXF88iZm5kPOxQ>
    <xmx:C1tCW1KhDhauWLXRIUGodBUU78XvZYHd3R1kus6EV9VBpaL1wL9FRQ>
X-ME-Sender: <xms:CltCW-eZFGelxUuz6EVg7iN5guAMvtC7z5xdL2ALMzYpa0uo53tGNw>
Received: from localhost (unknown [46.185.196.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01544E405A;
        Sun,  8 Jul 2018 14:42:17 -0400 (EDT)
From:   Daniel Harding <dharding@living180.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Daniel Harding <dharding@living180.net>
Subject: [PATCH 1/2] sequencer: fix --rebase-merges with custom commentChar
Date:   Sun,  8 Jul 2018 21:41:10 +0300
Message-Id: <20180708184110.14792-2-dharding@living180.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708184110.14792-1-dharding@living180.net>
References: <20180708184110.14792-1-dharding@living180.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prefix the "Branch <name>" comments in the todo list with the configured
comment character instead of hard-coding '#'.

Signed-off-by: Daniel Harding <dharding@living180.net>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 4034c0461..caf91af29 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3991,7 +3991,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n# Branch %s\n", entry->string);
+			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
 			fprintf(out, "\n");
 
-- 
2.18.0

