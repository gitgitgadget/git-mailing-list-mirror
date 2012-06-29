From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Does "git config --local core.excludefiles" exclude files in a
 single repository?
Date: Fri, 29 Jun 2012 18:11:06 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF02C738@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	"git-users(mailer list)" <git-users@cisco.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 20:20:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkfoB-0002iy-3r
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 20:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab2F2SUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 14:20:39 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:60236 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab2F2SUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jun 2012 14:20:38 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2012 14:20:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=731; q=dns/txt;
  s=iport; t=1340994038; x=1342203638;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=EU46qaSiVA0daYL5RkUhuDEwbFMPe3IfD0jJm9R/zPY=;
  b=d6S61QLmxixpLJ/lkVyBh2nePy+qTVckK7b0c765gFXhYBsjiMdUo/7W
   9geH7h6OQpOXvLVH5Dd5bYpAMBTbEblumg25qmx95EjtKRHMvT0Yudri3
   YAr8IbGYq4mJMBvE/7BYA6j9QnI5idCJnPEkfUVx6LFbyk23aQe/RWXyA
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAGjv7U+tJV2b/2dsb2JhbABFtlaBB4IaAQQSASdRASoUQiYBBAEaGodoAZthoD6QYWADo1CBZoJf
X-IronPort-AV: E=Sophos;i="4.77,498,1336348800"; 
   d="scan'208";a="97330066"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-2.cisco.com with ESMTP; 29 Jun 2012 18:11:07 +0000
Received: from xhc-aln-x10.cisco.com (xhc-aln-x10.cisco.com [173.36.12.84])
	by rcdn-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id q5TIB7oZ028750
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 29 Jun 2012 18:11:07 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.185]) by
 xhc-aln-x10.cisco.com ([173.36.12.84]) with mapi id 14.02.0298.004; Fri, 29
 Jun 2012 13:11:07 -0500
Thread-Topic: Does "git config --local core.excludefiles" exclude files in a
 single repository?
Thread-Index: Ac1WIo0tIuG0O/jAQuOj6NlKwHx2Eg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
x-tm-as-product-ver: SMEX-10.2.0.1135-7.000.1014-19004.005
x-tm-as-result: No--23.417800-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200822>

Will git ignore files in an exclusion file that is specified in a local ($GIT_DIR/config) "core.excludefiles" configuration option?

I mistakenly ran "git config core.excludefiles=<file>", and I was curious whether this command actually has any effect.

I know that "$GIT_DIR/info/exclude" is normally used for listing files that a single user wants exclude from a single repository.  And I know that "git config --global core.excludefiles=<file>" is normally used for listing files that a single user wants to exclude from all repositories.  But I didn't see any explicit documentation for whether "git config core.excludefiles=<file>" would exclude files for a single user in a single repository.
