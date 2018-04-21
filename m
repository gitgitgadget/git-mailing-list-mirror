Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BF51F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDUJtP (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:49:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:43827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeDUJtO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:49:14 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lw2dd-1eMIzj21fR-017k3e; Sat, 21
 Apr 2018 11:49:10 +0200
Date:   Sat, 21 Apr 2018 11:48:54 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 06/11] Add a test for `git replace --convert-graft-file`
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <1b703f9b9d5c182d3ade6ef776a04c977638690b.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z8wIdVf2ROl4WMOj7c15nLno/5Gghi/CWnneObOlyNMfmyO6pEV
 mW3R2Cu1KdPjzx8TV5czggCEaHWEC++Og3pNcBIoBOsjryF7aj+ozzbKYHqOwYNWOKQsAG2
 C1lJNZBLyRHN8iJG3V51w5heSyHcD5AZmf5//d8pE9QDaJC9Owqb4JAi6QgUhbsl+A4ESly
 4Dr/fsm6BCgEMP00N1vEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:37Lv9OlqzCk=:31yH0MHcw5lPAnRC//Hhsm
 Zzuwucg53Jrhx+OxjR+r4Vwug6Fwhl1S3GfN8YZX3YXgn+6C/7GhRzppwvOvIb+Uhh09M9AEm
 0Esji9u6w8LhzehuDMhCTsels7jXEZ9qhcDG6CQHTSPM+awqkatOyDK0MhXf7v1XjqjBxkB8u
 ODboHJ1blpr5RqW6euM+Xuk9kmb0egk+dk7zFsUJ/Nl0M1S5PbpA5L6MCA2v1qg7eyDvMnKVL
 Y6zK6HRvhw3QQMM3F25mK+lBr+H9Y1jn1hM3Q1+ceLlt1guaB5Kj1O6gjovwP2TRpx3h9TBcw
 5GtMc+wrn7eqqVi+K6QchYFzW1YmN+TtYIues6M/2mnKy5QYLLmw774RUZSWF+97P/A3WriIw
 b/1veMEjyeVOMlV8QD8aKn06iHB3smjQSwK7kxZq52/ooxrixbkCYiT8z4ip7XBazvpX4FeR+
 P1oAw4evVrRJOaHPhz5MliGOhFoDsZ959NwfUlifvW4MZVy/QglmnnBeGX3ECM0VR1iRhJ+nH
 N3w81zlHxQEKzw/8R2MBVEhXY/U9HFA+y84nQpjdKQCpQabfxtv+mwaEAFv+fIDIXBgj7Goz7
 u/1JG3xOj/Mkb4g38CPlK8fFCwW+X4sMzTn6qxO5ptznWTY/MZPab8ey+jYinQUWbWgze4I9H
 xsm6F3vc2AGHdCGr7ET8+zNss04br51yqUEJ6Hi/W9+A1J/oZ8TJRg+HkQAFl8q2pBgdYtt38
 CGXsouvgBxrxeFM9XB2MdOexX8LUrAk5iTwSgGckn4nbzMtNTB4/G5uLTLNVll4P8a+b3r9qD
 DWJ+eJGf1OCxjcELJKlj48ROCzXOK2p8PqTyOixBnlt5I6ZR8Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proof, as the saying goes, lies in the pudding. So here is a
regression test that not only demonstrates what the option is supposed to
accomplish, but also demonstrates that it does accomplish it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6050-replace.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657e..bed86a0af3d 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
 	git replace -d $HASH10
 '
 
+test_expect_success '--convert-graft-file' '
+	: add and convert graft file &&
+	printf "%s\n%s %s\n\n# comment\n%s\n" \
+		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
+		>.git/info/grafts &&
+	git replace --convert-graft-file &&
+	test_path_is_missing .git/info/grafts &&
+
+	: verify that the history is now "grafted" &&
+	git rev-list HEAD >out &&
+	test_line_count = 4 out &&
+
+	: create invalid graft file and verify that it is not deleted &&
+	test_when_finished "rm -f .git/info/grafts" &&
+	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
+	test_must_fail git replace --convert-graft-file 2>err &&
+	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" err &&
+	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
+'
+
 test_done
-- 
2.17.0.windows.1.15.gaa56ade3205


