From: Frans Pop <elendil@planet.nl>
Subject: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 05:13:58 +0200
Message-ID: <200907280513.59374.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 05:14:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVd8k-0000j8-BI
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 05:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbZG1DOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 23:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbZG1DOA
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 23:14:00 -0400
Received: from cpsmtpm-eml105.kpnxchange.com ([195.121.3.9]:51514 "EHLO
	CPSMTPM-EML105.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751146AbZG1DOA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 23:14:00 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML105.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 05:13:59 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 03:13:59.0707 (UTC) FILETIME=[736196B0:01CA0F31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124209>

The git-am manpage currently says:
  The body of the message (iow, after a blank line that terminates RFC2822
  headers) can begin with "Subject:" and "From:" lines that are different
  from those of the mail header, to override the values of these fields.

That's a very useful feature. However, on lkml there are frequently also 
mails with the following structure (example: [1]).

<example>
[Regular mail headers, including From: and Subject:]

[Comments, quotes from previous messages, or some introduction]

From: [email address]
Subject: [patch short description]
[patch long description]

[patch diff]
</example>

Here the overruling pseudo-headers are not at the beginning of the 
message, which results in all the leading comments getting included in 
the commit log and those have to be cleaned manually.

Would it be possible to add an option to git-am to "reset" the commit log 
when it encounters either a From: or Subject: pseudo header, so that only 
the intended patch short and long descriptions are used for the commit 
log?

Or is this already possible somehow?

Cheers,
FJP

[1] http://lkml.org/lkml/2009/7/10/49
