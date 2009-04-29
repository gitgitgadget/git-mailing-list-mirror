From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Equals method should not assume anything about the type of its argument
Date: Wed, 29 Apr 2009 23:47:29 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A287800302A82C@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:48:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHdb-0000Ji-8j
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZD2VsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZD2VsL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:48:11 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:53706 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbZD2VsK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 17:48:10 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n3TLm56i006541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Apr 2009 23:48:05 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-puzzleid: {9F120F2C-CB13-4AAA-80F8-06E1B9101F51}
x-cr-hashedpuzzle: BenB CC8B DMTa FGBY FO2a F6cv Mewp P1Gt RG2X Vszr YcQt bbwb cYx5 e2VW fPhb h5HR;3;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA7AHIAbwBiAGkAbgAuAHIAbwBzAGUAbgBiAGUAcgBnAEAAZABlAHcAaQByAGUALgBjAG8AbQA7AHMAcABlAGEAcgBjAGUAQABzAHAAZQBhAHIAYwBlAC4AbwByAGcA;Sosha1_v1;7;{9F120F2C-CB13-4AAA-80F8-06E1B9101F51};bQBhAHQAdABoAGkAYQBzAC4AcwBvAGgAbgBAAHMAYQBwAC4AYwBvAG0A;Wed, 29 Apr 2009 21:47:30 GMT;WwBQAEEAVABDAEgAIABKAEcASQBUAF0AIABFAHEAdQBhAGwAcwAgAG0AZQB0AGgAbwBkACAAcwBoAG8AdQBsAGQAIABuAG8AdAAgAGEAcwBzAHUAbQBlACAAYQBuAHkAdABoAGkAbgBnACAAYQBiAG8AdQB0ACAAdABoAGUAIAB0AHkAcABlACAAbwBmACAAaQB0AHMAIABhAHIAZwB1AG0AZQBuAHQA
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Equals method should not assume anything about the type of its argument
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlABTQvvQAA5wL+A=
X-OriginalArrivalTime: 29 Apr 2009 21:48:04.0450 (UTC) FILETIME=[2CC66C20:01C9C914]
X-Scanner: Virus Scanner virwal05
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117955>

From: Matthias Sohn <matthias.sohn@sap.com>
The equals(Object o) method shouldn't make any assumptions about the
type of o. It should simply return false if o is not the same type as
this.

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
Shawn Pearce <spearce@spearce.org> wrote:
> FWIW, your From header in the emails comes out "Sohn, Matthias"
> while your Signed-off-By is as above.  This means that when I slam
> your patch through git-am I get an author name of "Sohn, Matthias",
> which looks damn funny.  I have to remember to edit the patch after
> the fact to make it come out correct.
>
> Any change you can get your MUA to behave better?  Or is this
> Exchange enforcing a nice uniform standard... *sigh*

Didn't find a way to get around our Exchange server mangling the from header, 
hence trying to give From: in mail body. If this doesn't help I will issue a 
ticket for our Exchange administration to get this solved.

.../src/org/spearce/jgit/lib/AnyObjectId.java      |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index 2e3a43e..acb3cb5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -253,7 +253,10 @@ public boolean equals(final AnyObjectId other) {
 	}
 
 	public boolean equals(final Object o) {
-		return equals((AnyObjectId) o);
+		if (o instanceof AnyObjectId)
+			return equals((AnyObjectId) o);
+		else
+			return false;
 	}
 
 	/**
-- 
1.6.2.2.1669.g7eaf8
