From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] More object-related docstrings
Date: Fri, 28 Feb 2014 17:29:15 +0100
Message-ID: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 17:29:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQJy-0004Ph-TE
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbaB1Q3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:29:52 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52397 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752952AbaB1Q3u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 11:29:50 -0500
X-AuditID: 12074414-f79d96d000002d2b-37-5310b97eca9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BA.57.11563.E79B0135; Fri, 28 Feb 2014 11:29:50 -0500 (EST)
Received: from michael.fritz.box (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SGTLSd006566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 11:29:47 -0500
X-Mailer: git-send-email 1.8.5.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqFu3UyDY4OV/HovbM1uYLbqudDNZ
	NPReYbZYcXUOs8Xbm0sYLW6vmM9sMe/FCzYHdo+/7z8weTw70c7msXPWXXaPi5eUPT5vkgtg
	jeK2SUosKQvOTM/Tt0vgzpjdNpex4BhXxYdXkxkbGPdydDFyckgImEi0d19mgbDFJC7cW8/W
	xcjFISRwmVFiy87FTBDOcSaJaz0/2EGq2AR0JRb1NDOB2CICahIT2w6xgBQxC0xkkth85A1Y
	kbCAmcTnqSvZQGwWAVWJx/8gbF4BZ4mji2ewQaxTkGhZtot9AiP3AkaGVYxyiTmlubq5iZk5
	xanJusXJiXl5qUW6Fnq5mSV6qSmlmxghoSOyg/HISblDjAIcjEo8vJKLBIKFWBPLiitzDzFK
	cjApifJe3wEU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7aTFQjjclsbIqtSgfJiXNwaIkzvtt
	sbqfkEB6YklqdmpqQWoRTFaGg0NJgncvyFDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTS
	kox4ULDHFwPDHSTFA7T3Nkg7b3FBYi5QFKL1FKOilDhvAkhCACSRUZoHNxaWEF4xigN9Kcy7
	B6SKB5hM4LpfAQ1mAhrM6Qk2uCQRISXVwNil/8C/b6EH15GqmKBpB7dc934Q5v7jvH3yU5ZX
	Z17ndp46dd1ycl33vePFFwokDtwVeWLobnfOPmTzM3Gbu2fnSfXmNF9IWpB4I32D77kapq5V
	23dMXCunzH3jz5FbbhvmT/t3YLH610jV9B0/c5p+m3/2Eb3wyXNVl5/a3rNKjx9v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242982>

This patch series applies on top of mh/replace-refs-variable-rename,
simply because one of the comments refers to the global variable
check_replace_refs by its new name.

This is a re-roll of patches 1/6 and 6/6 of the series
"mh/object-code-cleanup" that I submitted earlier [1].  Patches 2-5 of
that series have already been queued.

The first patch emphasizes that do_lookup_replace_object() is only
meant for internal use, and moves the real docstring for that function
from the header file to the implementation file.

The second patch changes the docstring for hash_obj() to mention that
its return value is not consistent across architectures, and adds a
comment within the function explaining some points about the
implementation that were suggested in the discussion about v1.

Thanks to Junio, Christian, Nicolas, Jakub, and Jonathan for their
comments on v1.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/242469

Michael Haggerty (2):
  Add docstrings for lookup_replace_object() and
    do_lookup_replace_object()
  Document some functions defined in object.c

 cache.h          | 13 +++++++++++++
 object.c         | 29 ++++++++++++++++++++++++++++-
 object.h         |  7 +++++++
 replace_object.c |  7 +++++++
 4 files changed, 55 insertions(+), 1 deletion(-)

-- 
1.8.5.3
