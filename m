Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3C01F462
	for <e@80x24.org>; Sun, 26 May 2019 17:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfEZRWp (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 May 2019 13:22:45 -0400
Received: from avasout03.plus.net ([84.93.230.244]:33572 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfEZRWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 May 2019 13:22:45 -0400
Received: from mailserver ([209.93.137.209])
        by smtp with ESMTP
        id Uwr5h6nsh5hISUwr6hidEI; Sun, 26 May 2019 18:22:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=esShMbhX c=1 sm=1 tr=0
 a=u68OYVRc/Z2sxEGkPHj3Dw==:117 a=u68OYVRc/Z2sxEGkPHj3Dw==:17
 a=x7bEGLp0ZPQA:10 a=YbTMELGUhT8A:10 a=pGLkceISAAAA:8 a=H9Wy_3nOsWJAWYE_l6AA:9
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   Chris Mayo <aklhfex@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] send-email: remove documented requirement for Net::SMTP::SSL
Date:   Sun, 26 May 2019 18:22:42 +0100
Message-Id: <20190526172242.13000-1-aklhfex@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJ6WOjKMgaefAlvenbyf+36kqvTkV+PHDRR+o6WHzdW4DwaxRtB4TMLYCYexDfOanfNWxgsDlbcmEZ8H8nkf4SelFpF+YaXZhaqYfGzRbw9peV0g3aTx
 TNaxGN/2edfMZAkctUIXU24nRyUj2QJwToLG651C2eXXyV4QQJoKgQE6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-send-email uses the TLS support in the Net::SMTP core module from
recent versions of Perl. Documenting the minimum version is complex
because of separate numbering for Perl (5.21.5~169), Net:SMTP (2.34)
and libnet (3.01). Version numbers from commit:
bfbfc9a953 ("send-email: Net::SMTP::starttls was introduced in v2.34",
2017-05-31)

Users of older Perl versions without Net::SMTP::SSL installed will get a
clear error message.

Signed-off-by: Chris Mayo <aklhfex@gmail.com>
---
 Documentation/git-send-email.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 1afe9fc858..a2acdaffa3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -500,8 +500,8 @@ app-specific or your regular password as appropriate.  If you have credential
 helper configured (see linkgit:git-credential[1]), the password will be saved in
 the credential store so you won't have to type it the next time.
 
-Note: the following perl modules are required
-      Net::SMTP::SSL, MIME::Base64 and Authen::SASL
+Note: the following Perl modules are required
+      MIME::Base64 and Authen::SASL
 
 SEE ALSO
 --------
-- 
2.21.0

