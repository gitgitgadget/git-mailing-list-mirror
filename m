From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] Add a bunch of docstrings and make a few minor cleanups
Date: Fri, 21 Feb 2014 17:32:01 +0100
Message-ID: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:32:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt1p-00016A-0G
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbaBUQck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:32:40 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49650 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932264AbaBUQck (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:32:40 -0500
X-AuditID: 1207440f-f79326d000003c9f-e4-53077fa79820
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E1.3D.15519.7AF77035; Fri, 21 Feb 2014 11:32:39 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAgs026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:36 -0500
X-Mailer: git-send-email 1.8.5.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqLu8nj3YoO2VkEXXlW4mi4beK8wW
	t1fMZ7aY9+IFm8WPlh5mB1aPv+8/MHk8O9HO5vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGcc37WJrWABd0X/n3XMDYzvOboY2TkkBEwkHkt0MXICWWISF+6tZ+ti5OIQErjMKNF+
	6hcrhHOcSWLzqhZ2kCo2AV2JRT3NTCC2iECOxJarBxlBbGYBB4nNnxvBbGEBH4mZzTdZuhg5
	OFgEVCXO784BMXkFXCS29uhB7FKQaFm2i30CI/cCRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
	RbomermZJXqpKaWbGCHBwb+DsWu9zCFGAQ5GJR5eh1T2YCHWxLLiytxDjJIcTEqivN9rgUJ8
	SfkplRmJxRnxRaU5qcWHGCU4mJVEeJujgXK8KYmVValF+TApaQ4WJXFe9SXqfkIC6Yklqdmp
	qQWpRTBZGQ4OJQne8jqgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQiMcXA4Mc
	JMUDtLcSpJ23uCAxFygK0XqKUVFKnDcJJCEAksgozYMbC4v5V4ziQF8K84aDVPEA0wVc9yug
	wUxAg0s2soIMLklESEk1MCYc41VafEpcPtJ3UvHv5JiKC1mpn2883hRxRrhvMueGtX5frlvz
	qxefevA3LmQyTxAzx/yI3ekpd3dH/ct4aZe0s29NxeOstkcPQ6cfF686pDnB9uBmpetMzGmn
	le2j7l7+2npMWUP96TdlhZtVE9gmOTd8PCyRd0MsJpvHbZvPLF7WGNsPwkosxRmJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242469>

I was reading around in the neighborhood of fsck, objects, and packs
and I had the familiar and discouraging experience of having to read
code all the way up and down the callstack to understand *anything*.
Please let's all make more of an effort to document functions,
especially things that are not obvious from the name and signature,
like who owns the memory that is being referred to.

This is my attempt to document a number of the functions that I was
looking at based on what I inferred from my reading.  It is also a
selfish trick to get other people to double-check my understanding.

I also fixed up a couple of small things that I noticed along the way:
"refactoring for understanding".

Michael Haggerty (6):
  Add docstrings for lookup_replace_object() and
    do_lookup_replace_object()
  replace_object: use struct members instead of an array
  find_pack_entry(): document last_found_pack
  sha1_file_name(): declare to return a const string
  Document a bunch of functions defined in sha1_file.c
  Document some functions defined in object.c

 cache.h          | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 http.c           |  2 +-
 object.c         | 23 +++++++++++++++-
 object.h         |  7 +++++
 replace_object.c | 17 ++++++++----
 sha1_file.c      | 66 ++++++++++++++++++++++++--------------------
 6 files changed, 157 insertions(+), 42 deletions(-)

-- 
1.8.5.3
