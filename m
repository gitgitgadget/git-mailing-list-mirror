From: Drew Northup <drew.northup@maine.edu>
Subject: [RFC] Print diffs of UTF-16 to console / patches to email as
	UTF-8...?
Date: Fri, 22 Oct 2010 12:06:48 -0400
Message-ID: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 18:15:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9KGc-0007j5-Ie
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 18:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353Ab0JVQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 12:14:48 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:53306 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab0JVQOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 12:14:48 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MG6r3R014407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 12:06:53 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MG6r3R014407
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288368422.42607@z3iorH087dAPkJH2lXcmJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159708>

I am currently thinking about what the best way to preset readable (and
safely email-able) patches to the user may be when the content is
UTF-16. This is part of my ongoing work to treat UTF-16 as text (in
other words, the crlf options will work and .gitattributes hacks won't
be required to display diffs, etc).
I was also concerned that the result be re-importable to valid UTF-16 in
the end. This has led me to consider printing diffs as UTF-8 (no data
loss, at least 16->8) when the source text is UTF-16. This should also
be git-gui / gitk friendly (in theory). I would favorably consider this
as a configurable option (export_unicode_diff_as_utf8 ?) leaving plain
UTF-16 output as the standard output from "git diff" (once I convince it
that UTF-16 is indeed text).
Also, there is the issue of being able to recognize UTF-16 as UTF-16 in
diffs/patches. Is there a precedent/standard I should be aware of with
respect to BOMs and patches? I would think that adhering to the UTF-16
standard with respect to whole text files would make sense here (no BOM
== Big Endian, BOM used to match LE/BE otherwise).

Comments welcome!

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
