From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/6] Add some string_list-related functions
Date: Wed, 12 Sep 2012 16:04:41 +0200
Message-ID: <1347458687-31092-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 16:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnZ8-0004W5-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758894Ab2ILOFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:05:09 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:46564 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab2ILOFG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:05:06 -0400
X-AuditID: 12074413-b7f786d0000008bb-e7-505096912039
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C1.92.02235.19690505; Wed, 12 Sep 2012 10:05:05 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CE51QS021888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 10:05:04 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsUixO6iqDtxWkCAwapduhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujAdTprEV
	rOKpOPxyPXsDYxNnFyMnh4SAicSkix2MELaYxIV769m6GLk4hAQuM0rMXdHMDuGcYZJYM/se
	G0gVm4CuxKKeZiYQW0RATWJi2yEWEJtZIEWi43k32CRhATuJlqff2UFsFgFViSM/m8BqeAVc
	JO7c2MgOsU1R4sf3NcwTGLkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSnd
	xAgJCOEdjLtOyh1iFOBgVOLhZUjwDxBiTSwrrsw9xCjJwaQkyvt5ckCAEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRHeDbpAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eS
	BO/bKUCNgkWp6akVaZk5JQhpJg5OEMEFsoEHaEM5SCFvcUFibnFmOkTRKUZFKXHeM5OAEgIg
	iYzSPLgBsNh9xSgO9I8wr+BUoCoeYNzDdb8CGswENHjCWn+QwSWJCCmpBsYOwZ+yS5Msu3ae
	OrLhi9aXkLYX3RFnGaOZHgWv7/h9+f6JhQobT3R/jC7NPPCB43d57pF103fN8kudt+fWeq+C
	U7pHtp0pKz7VnZoZr7LIe3L+2vgPNum3HntOtnNZdu6L5YnVv9jtGtxslSQ2BLlMCcxQlOc9
	Uyo5YXPjbcl14qLrV5T77LunxFKckWioxVxUnAgA0xdYJLgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205290>

Version 3 of a patch series that adds some functions to the
string_list API.  This patch series applies to current master.  Thanks
for Junio for lots of great feedback.

The patch series "Clean up how fetch_pack() handles the heads list"
v3, which requires some of the new string_list functionality, works
unmodified on top of this version of the patch series.

Changes since v2:

* Use "if (!...) die(...)" instead of assert() to check function
  preconditions.

* Remove unneeded cast.

* Fix formatting of api documentation.

Michael Haggerty (6):
  string_list: add function string_list_append_nodup()
  string_list: add two new functions for splitting strings
  string_list: add a new function, filter_string_list()
  string_list: add a new function, string_list_remove_duplicates()
  string_list: add a function string_list_longest_prefix()
  api-string-list.txt: initialize the string_list the easy way

 .gitignore                                  |   1 +
 Documentation/technical/api-string-list.txt |  68 +++++++++++++--
 Makefile                                    |   1 +
 string-list.c                               | 127 ++++++++++++++++++++++++++--
 string-list.h                               |  71 ++++++++++++++++
 t/t0063-string-list.sh                      | 121 ++++++++++++++++++++++++++
 test-string-list.c                          | 123 +++++++++++++++++++++++++++
 7 files changed, 502 insertions(+), 10 deletions(-)
 create mode 100755 t/t0063-string-list.sh
 create mode 100644 test-string-list.c

-- 
1.7.11.3
