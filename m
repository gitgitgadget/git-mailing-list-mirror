From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: git bisect and the merge from hell
Date: Fri, 3 Feb 2006 15:16:58 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F059F4AF6@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:17:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5AAz-0002uS-2T
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 00:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945983AbWBCXRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 18:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946037AbWBCXRJ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 18:17:09 -0500
Received: from fmr21.intel.com ([143.183.121.13]:13496 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1945983AbWBCXRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 18:17:08 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k13NGxmR027512;
	Fri, 3 Feb 2006 23:16:59 GMT
Received: from scsmsxvs041.sc.intel.com (scsmsxvs041.sc.intel.com [10.3.90.10])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k13GS8so029801;
	Fri, 3 Feb 2006 16:28:21 GMT
Received: from scsmsx331.amr.corp.intel.com ([10.3.90.4])
 by scsmsxvs041.sc.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006020315165807996
 ; Fri, 03 Feb 2006 15:16:58 -0800
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by scsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 3 Feb 2006 15:16:59 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git bisect and the merge from hell
Thread-Index: AcYpBPDyTfIGqIMSSgmMq0wXQXEg6AAEoAQA
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 03 Feb 2006 23:16:59.0028 (UTC) FILETIME=[EE93AD40:01C62917]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15557>

> "git bisect visualize" really makes it very obvious what to try next, I 
> think. Which exact commit you try next probably depends on what the 
> compile error was. I'd try
>
>	git reset --hard 3d5271f9883cba7b54762bc4fe027d4172f06db7
>
> (which is after the "pull release into acpica branch" commit).

Yup, that got the bisection moving again.  I finished up at:

$ git bisect bad
96db255c8f014ae3497507104e8df809785a619f is first bad commit
diff-tree 96db255c8f014ae3497507104e8df809785a619f (from 0897831bb54eb36fd9e2a22da7f0f64be1b20d09)
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Nov 2 00:00:00 2005 -0500

    [ACPI] ACPICA 20051102

So Len's mega-octopus merge wasn't a problem at all, but this is still
all his fault :-)  I'll go beat on him.

Thanks for the tip.

-Tony
