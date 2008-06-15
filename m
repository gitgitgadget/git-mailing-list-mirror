From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 01/20] Fix typo in PackIndexV2
Date: Sun, 15 Jun 2008 23:45:30 +0200
Message-ID: <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K803w-0001YY-Gi
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbYFOVp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYFOVp7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:45:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYFOVp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:45:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3137938fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=peg0emu9RZIc+tOggTyapQS647V38WKQh2XKCxEqxM0=;
        b=NAgkNYp39Rl5h9kGV4BfaoKHj5nHSCfH4lm8GRrCmgwJNm85aktCJbXSGZbeJI45Hz
         PL7MhJloC+xj6OktJDo6rqYWgXeL9plDGrc3LLKww0I9zwMpsopAJWhkr0iFhHuXEH27
         UXArDQFgw5nfzBcH75MzKfu189qk8GpBJiopU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RcagWJHiScyi4MgWSMxjlz04BqWVAdtrwOQI7eSft+ssVmPp9U16qMtXHHp0sgA6IP
         YSlzKppH2pcQs17jkMI3ml3wAr+PP8ehrUQEaWeWwjS0ATi3PlWgSZcALsKPYFnj/hlq
         H15Mi14tJKW3dpeDcm8I0d72nY/wrG6gRtKwI=
Received: by 10.86.100.19 with SMTP id x19mr7226071fgb.61.1213566357017;
        Sun, 15 Jun 2008 14:45:57 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d6sm8595856fga.2.2008.06.15.14.45.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:45:55 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85125>

levelTWo -> levelTwo

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index 9a695ef..ae70f11 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -184,13 +184,13 @@ class PackIndexV2 extends PackIndex {
 	private class EntriesIteratorV2 extends EntriesIterator {
 		private int levelOne;
 
-		private int levelTWo;
+		private int levelTwo;
 
 		public MutableEntry next() {
 			for (; levelOne < names.length; levelOne++) {
-				if (levelTWo < names[levelOne].length) {
-					objectId.fromRaw(names[levelOne], levelTWo);
-					int arrayIdx = levelTWo / (Constants.OBJECT_ID_LENGTH / 4)
+				if (levelTwo < names[levelOne].length) {
+					objectId.fromRaw(names[levelOne], levelTwo);
+					int arrayIdx = levelTwo / (Constants.OBJECT_ID_LENGTH / 4)
 							* 4;
 					long offset = NB.decodeUInt32(offset32[levelOne], arrayIdx);
 					if ((offset & IS_O64) != 0) {
@@ -199,11 +199,11 @@ class PackIndexV2 extends PackIndex {
 					}
 					objectId.setOffset(offset);
 
-					levelTWo += Constants.OBJECT_ID_LENGTH / 4;
+					levelTwo += Constants.OBJECT_ID_LENGTH / 4;
 					returnedNumber++;
 					return objectId;
 				} else {
-					levelTWo = 0;
+					levelTwo = 0;
 				}
 			}
 			throw new NoSuchElementException();
-- 
1.5.5.1
