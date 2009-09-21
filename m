From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: RE: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: Mon, 21 Sep 2009 10:02:51 -0400
Message-ID: <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
 <878wgcbb52.fsf@users.sourceforge.net> <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 16:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpjUX-0005eZ-VZ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 16:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbZIUODg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbZIUODf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 10:03:35 -0400
Received: from vamx02.bankofamerica.com ([171.159.192.79]:59009 "EHLO
	vadmzmailmx02.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752570AbZIUODf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 10:03:35 -0400
Received: from vadmzmailmx01.bankofamerica.com ([171.182.200.78])
	by vadmzmailmx02.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8LE30H4010287;
	Mon, 21 Sep 2009 14:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1253541781;
	bh=HjYY44AGb7b2Q5Yk2bK1fykN/tDu5HkwM8zMMXNcLfE=;
	h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
	 Content-type:Content-transfer-encoding:References;
	b=p7XY8It4Dlc28G96tI0vroI3kifR7rqTr7sfeAblzeePTn81jj2hIx8zkJCQzwYV0
	 nq0LMCoEvaLQnsF+DGu6/E44WeOLuxqORzhcNooY1sXtw9EjkgZ+YUe/jJ6j0l6r5b
	 kmlpWL1OSAFqOtf/AJjSoAH6KpgcN7YPB89INOBc=
Received: from memva2mta02.bankofamerica.com (memva2mta02.bankofamerica.com [171.186.140.77])
	by vadmzmailmx01.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8LE2Jd9005032;
	Mon, 21 Sep 2009 14:02:59 GMT
In-reply-to: <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Thread-index: Aco4w95C4ERW3empRZSLswTcNkGSBwB8dxLw
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 21 Sep 2009 14:02:52.0940 (UTC) FILETIME=[361DBCC0:01CA3AC4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-09-21_09:2009-09-17,2009-09-21,2009-09-21 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128886>

Johannes Sixt writes:

> I cannot reproduce the error. I have a repository with 100 commits in
a
> linear history and 5000 refs (50 refs per commit). They are named
> refs/heads/branch-XXXX. I don't see any problems with 'gitk --all'.

That still leave you with only 100 unique refs.
You need over 797 unique refs.

> The error must be in some other git invocation.

I put many debug pop-ups around the code and I believe that this the
call that is dying on.
This is the only part of the code that has the error text "fatal:
ambiguous argument".


Paul Mackerras writes:

> I knew about the 32k command-line limit under windows, but I don't see
> how that applies in this case unless it is $revs that is too long (and
> if that is the case then I don't see how your patch helps).  Is there
> also a 32k limit on the size of data returned by a command executed
> with [exec]?

In this case $revs is "--all"

I believe what I am experiencing is a 32K limit with [exec]

Additional info:
My repo has: 17,737 commits
