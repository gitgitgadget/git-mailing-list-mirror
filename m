From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 0/3] merge-recursive: Avoid diagnostic on empty work tree
Date: Mon, 27 Jan 2014 09:45:05 -0500
Message-ID: <cover.1390833624.git.brad.king@kitware.com>
References: <cover.1390592626.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 15:45:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7nR4-0008Dn-Cu
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 15:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbaA0Ool (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 09:44:41 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:35750 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753500AbaA0Ooj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 09:44:39 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 40B429FBA3; Mon, 27 Jan 2014 09:45:09 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390592626.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241139>

Hi Folks,

Here is the third revision of this series.  The previous
revisions can be found at $gmane/241009 and $gmane/241030.

Updates since the previous revision of the series:

* Handling of lstat ENOENT has been moved down into refresh_cache_ent
  and activated by a new CE_MATCH_IGNORE_MISSING option.

* Rather than adding a new argument to make_cache_entry, the existing
  'refresh' boolean argument has been generalized to a set of options.
  This required the addition of a new CE_MATCH_REFRESH option to
  enable refresh with no other options.

Thanks,
-Brad

Brad King (4):
  t3030-merge-recursive: Test known breakage with empty work tree
  read-cache.c: Refactor --ignore-missing implementation
  read-cache.c: Extend make_cache_entry refresh flag with options
  merge-recursive.c: Tolerate missing files while refreshing index

 cache.h                    |  6 +++++-
 merge-recursive.c          |  4 +++-
 read-cache.c               | 27 ++++++++++++++------------
 t/t3030-merge-recursive.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 14 deletions(-)

-- 
1.8.5.2
