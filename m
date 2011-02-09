From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] fast-import: clarify documentation of "feature" command
Date: Wed, 9 Feb 2011 16:43:02 -0600
Message-ID: <20110209224302.GA17128@elie>
References: <20110202045826.GC15285@elie>
 <20110202050735.GE15285@elie>
 <201102022047.55152.trast@student.ethz.ch>
 <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
 <20110209214638.GA16716@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 23:43:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnIkp-0004yl-QJ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 23:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1BIWnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 17:43:15 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36745 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab1BIWnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 17:43:14 -0500
Received: by qyk12 with SMTP id 12so583039qyk.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pCixOoAn1Lf8A9NMH/9dy2RdRLKOSljbqKC3O5DUHYw=;
        b=Odj3nkSc6y427BLdcQjwo2v81XB/5Ep6BHrWfLH+eDa49d0u4LwH1Z/Kg/hqWpBovK
         wWm++HePgR2qTx1yEuj+WogCD2NM37ostoyFFa7OS5GxCI3kqH4XbIJw2AdhigJqCgYY
         PTkfrSAyRiwAPuUnEtplvG0BVla+kN8sZ3Dpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B7RcMiJ6pzwU2j+9aBtzOReTGuZLSntW6usQq/dSUGckEkFeTxTEyHaeOW2SPFQxGz
         PnB5Fj8Sz+jNSeDBa7ZhvzB9AVgYKf3xV4QbLCRG8ps8GqmgsP56fwERndQ5Xcve/On8
         SQP2pJp+oEnmxb5BCLMJGSz3VRAtiKE/jdHOc=
Received: by 10.229.97.139 with SMTP id l11mr5592202qcn.250.1297291393486;
        Wed, 09 Feb 2011 14:43:13 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id s10sm520035qco.23.2011.02.09.14.43.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 14:43:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110209214638.GA16716@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166451>

Date: Sun, 28 Nov 2010 13:43:57 -0600

The "feature" command allows streams to specify options for the import
that must not be ignored.  Logically, they are part of the stream,
even though technically most supported features are synonyms to
command-line options.

Make this more obvious by being more explicit about how the analogy
between most "feature" commands and command-line options works.  Treat
the feature (import-marks) that does not fit this analogy separately.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Just a cherry-pick.

 Documentation/git-fast-import.txt |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 19082b0..3bf04e3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -878,28 +878,25 @@ Require that fast-import supports the specified feature, or abort if
 it does not.
 
 ....
-	'feature' SP <feature> LF
+	'feature' SP <feature> ('=' <argument>)? LF
 ....
 
-The <feature> part of the command may be any string matching
-^[a-zA-Z][a-zA-Z-]*$ and should be understood by fast-import.
+The <feature> part of the command may be any one of the following:
 
-Feature work identical as their option counterparts with the
-exception of the import-marks feature, see below.
+date-format::
+export-marks::
+relative-marks::
+no-relative-marks::
+force::
+	Act as though the corresponding command-line option with
+	a leading '--' was passed on the command line
+	(see OPTIONS, above).
 
-The following features are currently supported:
-
-* date-format
-* import-marks
-* export-marks
-* relative-marks
-* no-relative-marks
-* force
-
-The import-marks behaves differently from when it is specified as
-commandline option in that only one "feature import-marks" is allowed
-per stream. Also, any --import-marks= specified on the commandline
-will override those from the stream (if any).
+import-marks::
+	Like --import-marks except in two respects: first, only one
+	"feature import-marks" command is allowed per stream;
+	second, an --import-marks= command-line option overrides
+	any "feature import-marks" command in the stream.
 
 `option`
 ~~~~~~~~
-- 
1.7.4
