From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v6 4/7] submodule: fix submodule--helper clone usage
Date: Mon, 29 Feb 2016 14:58:32 -0800
Message-ID: <1456786715-24256-5-git-send-email-jacob.e.keller@intel.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 23:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWmA-0005RY-8o
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbcB2W6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:58:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:52381 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcB2W6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:58:40 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; 
   d="scan'208";a="661447399"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287927>

From: Jacob Keller <jacob.keller@gmail.com>

git submodule--helper clone usage stated that paths were added after the
[--] argument. The actual implementation required use of --path argument
and only supports one path at a time. Update the usage string to match
the current implementation.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1e18075ed90f..3c4d3ff7f4af 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -187,7 +187,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--url <url>]"
-		   "[--depth <depth>] [--] [<path>...]"),
+		   "[--depth <depth>] [--path <path>]"),
 		NULL
 	};
 
-- 
2.7.1.429.g45cd78e
