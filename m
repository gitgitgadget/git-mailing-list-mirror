From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 0/3] merge-recursive: Avoid diagnostic on empty work tree
Date: Fri, 24 Jan 2014 15:10:46 -0500
Message-ID: <cover.1390592626.git.brad.king@kitware.com>
References: <cover.1390574980.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 21:10:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6n5A-0007A7-52
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbaAXUKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:10:24 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:59749 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752288AbaAXUKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:10:21 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id DD2019FBA3; Fri, 24 Jan 2014 15:10:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390574980.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241030>

Hi Folks,

Here is the second revision of this series.  The previous
revision can be found at $gmane/241009.

Updates since the previous revision of the series:

* Patch 1 test indentation and commit message updated thanks to
  comments from Jonathan.

* Patch 2 now adds a different new argument to make_cache_entry.
  This one is to request certain refresh behavior instead of just
  to get an error value back.

* Patch 3 uses the new make_cache_entry feature in patch 2
  to fix the test case.  This approach is based on suggestions
  from Elijah and Junio.

Thanks,
-Brad

Brad King (3):
  t3030-merge-recursive: Test known breakage with empty work tree
  read-cache.c: Optionally tolerate missing files in make_cache_entry
  merge-recursive.c: Tolerate missing files while refreshing index

 builtin/apply.c            |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/reset.c            |  2 +-
 cache.h                    |  2 +-
 merge-recursive.c          |  3 ++-
 read-cache.c               | 21 ++++++++++++++++-----
 resolve-undo.c             |  2 +-
 t/t3030-merge-recursive.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 70 insertions(+), 11 deletions(-)

-- 
1.8.5.2
