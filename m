From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v3] api-parse-options.txt: document OPT_CMDMODE()
Date: Fri, 25 Mar 2016 20:14:41 +0000
Message-ID: <01020153af6a22a0-88286f19-ad5c-4a4e-9571-8905ea7dd731-000000@eu-west-1.amazonses.com>
References: <01020153af24cfbc-a145ad2b-0cc2-4378-bce9-6b1f68251ce8-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 21:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajYOF-0003MF-EA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 21:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbcCYUbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 16:31:22 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:53786
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580AbcCYUbW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 16:31:22 -0400
X-Greylist: delayed 997 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Mar 2016 16:31:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458936881;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=x09/izlXrBN6ru51KivwSLaOFPTTuQG/hVirvPnrQXQ=;
	b=bI2uVtEMpw29qGKKAaWRuTZ3SrIy0xJHd7vCycXMWIFMw6iFJ87V1m6eN932TClB
	DK4FKoDLkp9be6si+pIQlI1RB4c0jIch4Z92K3AZ0YTQlO8t9Z4W1o8UF/OQvbDe4AH
	XrqDoF8Qy8sngpiX7MOy6xbt3u14W5aDoY5perWs=
In-Reply-To: <01020153af24cfbc-a145ad2b-0cc2-4378-bce9-6b1f68251ce8-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.25-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289950>

OPT_CMDMODE mechanism was introduced in the release of 1.8.5 to actively
notice when multiple "operation mode" options that specify mutually
incompatible operation modes are given.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5f0757d..695bd4b 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -231,6 +231,13 @@ There are some macros to easily define options:
 	pass the command-line option, which can be specified multiple times,
 	to another command.
 
+`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
+	Define an "operation mode" option, only one of which in the same
+	group of "operating mode" options that share the same `int_var`
+	can be given by the user. `enum_val` is set to `int_var` when the
+	option is used, but an error is reported if other "operating mode"
+	option has already set its value to the same `int_var`.
+
 
 The last element of the array must be `OPT_END()`.
 

--
https://github.com/git/git/pull/219
