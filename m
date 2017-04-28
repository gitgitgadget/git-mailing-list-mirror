Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EAA9207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998210AbdD1Nu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:50:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:65077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033631AbdD1Nut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:50:49 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1d9LcM3VqP-005mR9; Fri, 28
 Apr 2017 15:50:43 +0200
Date:   Fri, 28 Apr 2017 15:50:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 08/25] status: close file descriptor after reading
 git-rebase-todo
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <d399458fd03d15445d5e537ca042789652386e2a.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EccGrlmay2feV+AUApmiZ8oQ2BCvSxAlESbOtTVhfWMXnasqeJk
 b0DSonoprtc3hLI9Zxq4ByJjmH2JN05Gqg/ud4IbTe4P/cso25LdY0pI3L30sWfJVMbZd7E
 mumgdMjZ+djXo9JYn298u9/y7mPMg3rcbup6R0Moh82KA9INO06Lcn399sCyJ7abDUOrHGu
 mc1qxB0GA9BLOloJ+fSOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sBEWn709bOU=:82dLV8vpUEZnzJV4IWKYKn
 ogUzwlXSF4X8tKfOCzG3VCT9jgnEyQSfzrlAL8J28zKaG1NyxO88p6UH6YQ7czb3XcaqS48f8
 d5lUPajnuJVYYzd4Y+KEZGW+vViCCBmvvOSjKT2ihZhFOl64KeAA16NEr3J3mOTbDglvzlHTH
 Isjmoblxx+tZb/v+9SDri2zjy7hAWdatdC64boIHfnT0ox1kmILkxbHkR2Sksh1/GsPzZAhSm
 sfeH6ibDC04NhOUBAhf0Bos+wT/narxkVlDvW3HiMJBxaW2jzSsbM3ALz6S9pmPjSZJmxfZDD
 mPLsXCfUj0DxQgBxMX321meRXLsj7XRQGIeKNUrtwaTsqXNxiXtrz8oJ0jLRxYVNYR7we9Vly
 m4CRlVBHO3yOgDh7E/IQUQ7Li7AInjU4fad6JurrmVSg5Hka+Gkq54w92c4GaJYVrS32oRV4v
 IVc6VC2WzsdG93qPrOecph4wtZ4Zfyriaw/hAMKKx7gqAbPrTLJglPO8Mlfoer/wpEM49kVPw
 DnJ1lKhNM8/nkbWNtd0fSZjPVCLWYSm1PRlJiat65nhboJ3IgvQQoDXgASIcD39PXOuUCg8eO
 rXk4t7iEHGHBWvAxAjgUAnAZxcsYL2yn+HkXBO0PyS5JCsB/pIOVRo9rGzyLACsegfx8uGvmy
 R4Ipa3WBkv5l1hE0HV8bn8J449mXlsIb76kPb8IIhB7uBBdaRMRO829Nc5DnewNtY4plnvH15
 9meGQ4QMT0VTRdYZacPuJwuEg+mPZcTcD6YUgWT+oBJt67aklqxy0+gm023xaT0bIxixd3G1E
 DpQ7Fz0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index 03754849626..0a6e16dbe0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1168,6 +1168,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	fclose(f);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


