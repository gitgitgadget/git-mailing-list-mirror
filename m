From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2] api-parse-options.txt: document OPT_CMDMODE()
Date: Fri, 25 Mar 2016 18:58:58 +0000
Message-ID: <01020153af24cfbc-a145ad2b-0cc2-4378-bce9-6b1f68251ce8-000000@eu-west-1.amazonses.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:59:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWww-0006xP-3a
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbcCYS7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:59:02 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:34455
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753793AbcCYS7B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 14:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458932338;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=MEvxPToFbFlpRVED/YzL2HmDnhAhF8VfHWy2nCikqcI=;
	b=MzYVNud5PTDqZjvCiSFk2/+Mqdwyz4amqrfD+mHTX2oc6M2fxoogITdGrPPZXJYJ
	hCV9E2tBY1P5vbFQ1xdTScII34RWSPTI1ih4qQNiwLQ0EU0j+0L2zNXeGo0dmlPdD0X
	BOO3ZscJied8geRIhEPe7SDz7JIMkOejZ9FMNLRM=
In-Reply-To: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.25-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289944>

OPT_CMDMODE mechanism was introduced in the release of 1.8.5 to actively
notice when multiple "operation mode" options that specify mutually
incompatible operation modes are given.

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
