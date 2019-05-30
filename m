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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A8951F462
	for <e@80x24.org>; Thu, 30 May 2019 18:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfE3Sqq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 14:46:46 -0400
Received: from avasout04.plus.net ([212.159.14.19]:37283 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3Sqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 14:46:45 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 14:46:45 EDT
Received: from mailserver ([209.93.137.235])
        by smtp with ESMTP
        id WPxJhbVuYticRWPxKhfdjD; Thu, 30 May 2019 19:39:14 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Gs88BX9C c=1 sm=1 tr=0
 a=OVOw0JOETibW2qhth7KVPA==:117 a=OVOw0JOETibW2qhth7KVPA==:17
 a=x7bEGLp0ZPQA:10 a=YbTMELGUhT8A:10 a=pGLkceISAAAA:8 a=H9Wy_3nOsWJAWYE_l6AA:9
 a=y5w_7QHp1lY0aFnu:21 a=hLrfXUZu5lQcYeqn:21
From:   Chris Mayo <aklhfex@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org
Subject: [PATCH v2] send-email: update documentation of required Perl modules
Date:   Thu, 30 May 2019 19:39:10 +0100
Message-Id: <20190530183910.25518-1-aklhfex@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG8SUI0IDyoTwOWscoBSxmaF1lP+BYtk7i8HDexD1ukxueqa+8OTSeQmRb9yohnANFd5wFVBCQPGaHszr5stwjzpbbgIIdPFTOTHyprUdY7a+mnvsCL1
 WP/l0RK2BRVYz/VHmcH+9FrpxYLywbiZzrD6mEZu64iwNZQlJnEtPxFr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve and complete the list of required email related Perl modules,
clarifying which are core Perl modules and remove Net::SMTP::SSL.

git-send-email uses the TLS support in the Net::SMTP core module from
recent versions of Perl. Documenting the minimum version is complex
because of separate numbering for Perl (5.21.5~169), Net:SMTP (2.34)
and libnet (3.01). Version numbers from commit:
bfbfc9a953 ("send-email: Net::SMTP::starttls was introduced in v2.34",
2017-05-31).

Users of older Perl versions without Net::SMTP::SSL installed will get a
clear error message.

Signed-off-by: Chris Mayo <aklhfex@gmail.com>
---

This is v2 of the patch titled:
"send-email: remove documented requirement for Net::SMTP::SSL"

Changes:
- add the core Net::Domain and Net::SMTP modules with an expanded note as
  suggested, also the core module MIME::QuotedPrint (MIME::Base64 is already
  listed).
- add the CPAN module Mail::Address (Authen::SASL is already listed)

 Documentation/git-send-email.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 1afe9fc858..504ae7fe76 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -500,8 +500,12 @@ app-specific or your regular password as appropriate.  If you have credential
 helper configured (see linkgit:git-credential[1]), the password will be saved in
 the credential store so you won't have to type it the next time.
 
-Note: the following perl modules are required
-      Net::SMTP::SSL, MIME::Base64 and Authen::SASL
+Note: the following core Perl modules that may be installed with your
+distribution of Perl are required:
+MIME::Base64, MIME::QuotedPrint, Net::Domain and Net::SMTP.
+These additional Perl modules are also required:
+Authen::SASL and Mail::Address.
+
 
 SEE ALSO
 --------
-- 
2.21.0

