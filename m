Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D591F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeD1Wot (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:44:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:51367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752518AbeD1Wos (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:44:48 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M9vnQ-1f5ukd28Gu-00B6gs; Sun, 29 Apr 2018 00:44:43 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 07/12] Add a test for `git replace --convert-graft-file`
Date:   Sun, 29 Apr 2018 00:44:42 +0200
Message-Id: <fd4edf238230d0ac52d9e7cc3055506cb18d71af.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:SLVpllUW7EdruZef5BQLMUYcDhsahFdGbzbwSUr1MQtu8d+m7oq
 Ni/zSHCgjZNNr+9RldCH2/pFgDJ2Pvl6udbwDHH2h1+PoKMWr1zULz5cw3zO8L9Pfp6ws2w
 azsAQ8oZJzhvDO1wes2BBhZpgCV01Xvnlg1kqZYyirqZ95kFARyP/irhFyTKj/rUsW8PBwj
 dBLfI1rSB25Y6ElYGOfng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+x9ZEPXWxtw=:XKNVu2bHd3XE+33fm9iD62
 wKKrEnSntbru9lBFfb4YavlRPpGs2yUsCZucXG7C6K/nInrAoD5cduZsnXP2+K7a+tBTFJupW
 zKwKLCJIN88J4BtNnhW15e13DGl6mt6kcFAbEn8rVWUUNtUg7Vzou4MJ2KkETiusSZ1qdxXvZ
 DRByVaCNVf91uQ/Sqm2FfggRIPpX2SPI8Q3hiKpdv5oaer3oc7IJu7Mcwt79JCYnVU8wqksTc
 l1GXQelU9ia3xSGZFLX2NP+5/qaWRE9AR5UTWPYu4g+unRqAukbI9sPAA9jOdzTZTwtfbM29y
 /jgKzDm3HRLhQf4pxEqZNWUwEgZswcnC0z4UEk79/uVTox/RR6nxkVlARktMpL9u66r0sBnOw
 5RuG8YAXON8+PeEd3JcbzBQVBv4+HBD9RHz54POe2FwRcMIVe8g9tYGNMkLRocPIw7SjzpF/p
 vtXIRvZ50qhte+aGc/biX6oNQugiuokiH+MghkC78eRaCTv7HctxFNS4XCxj79EiknjHzp5k7
 5Lq9zwVCd9pjM7TvDSZ+oxL8vaT2MSnAsJogrj3Tq/3OQfVAY7+GlLskXaY/vxU09Nc7wQRNZ
 1h44nD9ixGo8kr5zz7jUJlViBpP8y4zqbwR2z+PBhuoP+4VWye6PU8OvY4yjxJDZoh+4KK2ik
 NguvkcobMtC2rMNhGG4mdLAcblHdZP8BPxSKa0HnZb8E3bbx+sY3iaI7wRfEnQ5d9FdN6RWz+
 gnf6JQi8mZG/yZ8Opfuef9pcn6kBM2G92XSXL00Rt8GK7IbYYnqtLVKL+G/Nmmde1RvBEU4eg
 rbM/98X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proof, as the saying goes, lies in the pudding. So here is a
regression test that not only demonstrates what the option is supposed to
accomplish, but also demonstrates that it does accomplish it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6050-replace.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657e..d174bfed309 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -444,4 +444,32 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
 	git replace -d $HASH10
 '
 
+test_expect_success '--convert-graft-file' '
+	git checkout -b with-graft-file &&
+	test_commit root2 &&
+	git reset --hard root2^ &&
+	test_commit root1 &&
+	test_commit after-root1 &&
+	test_tick &&
+	git merge -m merge-root2 root2 &&
+
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
2.17.0.windows.1.36.gdf4ca5fb72a


