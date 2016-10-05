Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9611F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbcJERWY (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:22:24 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:44525 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754738AbcJERWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:22:23 -0400
Received: (qmail 22357 invoked from network); 5 Oct 2016 17:22:22 -0000
Received: (qmail 13381 invoked from network); 5 Oct 2016 17:22:21 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 Oct 2016 17:22:16 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/14] i18n: add--interactive: mark status words for translation
Date:   Wed,  5 Oct 2016 17:21:06 +0000
Message-Id: <20161005172110.30801-11-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.366.g8a57a7a
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark words 'nothing', 'unchanged' and 'binary' used to display what has
been staged or not, in "git add -i" status command.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e81939f..0b4a27c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -295,7 +295,7 @@ sub list_modified {
 			my ($change, $bin);
 			$file = unquote_path($file);
 			if ($add eq '-' && $del eq '-') {
-				$change = 'binary';
+				$change = __('binary');
 				$bin = 1;
 			}
 			else {
@@ -304,7 +304,7 @@ sub list_modified {
 			$data{$file} = {
 				INDEX => $change,
 				BINARY => $bin,
-				FILE => 'nothing',
+				FILE => __('nothing'),
 			}
 		}
 		elsif (($adddel, $file) =
@@ -320,7 +320,7 @@ sub list_modified {
 			$file = unquote_path($file);
 			my ($change, $bin);
 			if ($add eq '-' && $del eq '-') {
-				$change = 'binary';
+				$change = __('binary');
 				$bin = 1;
 			}
 			else {
@@ -340,7 +340,7 @@ sub list_modified {
 			$file = unquote_path($2);
 			if (!exists $data{$file}) {
 				$data{$file} = +{
-					INDEX => 'unchanged',
+					INDEX => __('unchanged'),
 					BINARY => 0,
 				};
 			}
@@ -355,10 +355,10 @@ sub list_modified {
 
 		if ($only) {
 			if ($only eq 'index-only') {
-				next if ($it->{INDEX} eq 'unchanged');
+				next if ($it->{INDEX} eq __('unchanged'));
 			}
 			if ($only eq 'file-only') {
-				next if ($it->{FILE} eq 'nothing');
+				next if ($it->{FILE} eq __('nothing'));
 			}
 		}
 		push @return, +{
-- 
2.7.4

