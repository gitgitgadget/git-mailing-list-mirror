From: "Zakirov, Salikh" <salikh.zakirov@intel.com>
Subject: RE: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Date: Sun, 28 May 2006 00:57:35 +0400
Message-ID: <E124AAE027DA384D8B919F93E4D8C70801EFFB52@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Sat May 27 22:57:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk5r3-0006OY-18
	for gcvg-git@gmane.org; Sat, 27 May 2006 22:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWE0U5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 16:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWE0U5q
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 16:57:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:33934 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964948AbWE0U5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 16:57:45 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101-1.fm.intel.com with ESMTP; 27 May 2006 13:57:45 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2006 13:57:44 -0700
X-IronPort-AV: i="4.05,180,1146466800"; 
   d="scan'208"; a="43409284:sNHT2480010435"
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 27 May 2006 13:57:44 -0700
Received: from mssmsx402.ccr.corp.intel.com ([10.125.2.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 27 May 2006 13:57:44 -0700
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Thread-Index: AcaBuv72VO07IZhmRWmLw8EVWE5pqgAE6trw
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 27 May 2006 20:57:44.0321 (UTC) FILETIME=[33764F10:01C681D0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20871>


Junio C Hamano <junkio@cox.net> writes:
> So even in this modern day, preserving CRLF is not
> something that happens by default -- you would need to make sure
> that everybody on your mailpath to the recipient is set up the
> right way.

> So now I am less in favor of the change than when I wrote that
> response.

I understand this reasoning, and I am not sure if the fix is correct
from the "GIT world" point of view.

However, I believe that the command sequence git-format-patch, git-am
without any e-mail transfer in between and in the same repository
should work perfectly regardless of the contents of the files, 
no matter if they are binary, text, or "CRLF text" or even 
"broken LF and CRLF text". This is a requirement from a nasty "real
world".

Junio, could you point at a right place to fix to get git-format-patch, 
git-am sequence work flawlessly on Cygwin?

By the way, the change affects only non-Unix users, as fopen(..., "rt")
is equivalent to fopen(..., "rb") on all Unixes anyway.
