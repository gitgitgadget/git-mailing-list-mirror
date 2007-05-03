From: "Brown, Len" <len.brown@intel.com>
Subject: git-send-email vs address syntax
Date: Thu, 3 May 2007 02:13:18 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6030BDEAF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 03 08:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjUZG-00049I-5t
	for gcvg-git@gmane.org; Thu, 03 May 2007 08:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbXECGNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 02:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbXECGNY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 02:13:24 -0400
Received: from mga03.intel.com ([143.182.124.21]:24583 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbXECGNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 02:13:23 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 02 May 2007 23:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.14,482,1170662400"; 
   d="scan'208";a="223528548"
Received: from fmsmsx334.amr.corp.intel.com ([132.233.42.1])
  by azsmga001.ch.intel.com with ESMTP; 02 May 2007 23:13:21 -0700
Received: from hdsmsx411.amr.corp.intel.com ([10.127.2.70]) by fmsmsx334.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 May 2007 23:13:21 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-send-email vs address syntax
Thread-Index: AceNSiSIU80EfcKxQMuV+ED5Vr2Nrg==
X-OriginalArrivalTime: 03 May 2007 06:13:21.0673 (UTC) FILETIME=[26858790:01C78D4A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46069>

I recently used git-format-patch and git-send-email
to patch bomb 105 patches to linux-acpi@vger.kernel.org

But It appears that messages 37-45 and 96-104.
got dropped by the mail server because they
had a '.' in a destination address:

To:	linux-acpi@vger.kernel.org
Cc:	malattia@linux.it <malattia@linux.it>, Len Brown
<len.brown@intel.com>
Illegal-Object:	Syntax error in Cc: address found on vger.kernel.org:
	Cc:	malattia@linux.it<malattia@linux.it>
					 ^-missing end of address


Dave Miller says that this address would have been legal
if it were enclosed in quotes.

I don't know if the fix should be in the git-am script
which set the From: field, or in the git-format-patch
script which takes that field and makes it into
an e-mail message.

-Len
