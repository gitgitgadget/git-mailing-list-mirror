From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] git-merge: Honor pre-merge hook
Date: Wed, 05 Sep 2012 17:30:06 +0200
Message-ID: <50476FFE.5070602@alum.mit.edu>
References: <cover.1346851863.git.git@drmicha.warpmail.net> <dc8ebcd7f7b80ff930c04b5a407361ba8f2f077f.1346851863.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:30:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9HYZ-000203-4M
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 17:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab2IEPaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 11:30:11 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:47683 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753187Ab2IEPaJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 11:30:09 -0400
X-AuditID: 1207440d-b7f236d000000943-fc-50477000418e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F2.54.02371.00077405; Wed,  5 Sep 2012 11:30:08 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q85FU6N0005847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Sep 2012 11:30:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <dc8ebcd7f7b80ff930c04b5a407361ba8f2f077f.1346851863.git.git@drmicha.warpmail.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqMtQ4B5g8Py0jsWaF6eZLbqudDM5
	MHm0Tp7E7PF5k1wAUxS3TVJiSVlwZnqevl0Cd8aWm8cYC7bzVzTNecvawLiXp4uRk0NCwERi
	/80VjBC2mMSFe+vZuhi5OIQELjNKbN6+kBnCOcYk8X33IzaQKl4BbYnD2/eB2SwCqhKTHt9m
	B7HZBHQlFvU0M4HYogIhEmu+TWGEqBeUODnzCQuILSKgL3Ht3BPWLkYODmYBcYn+f2BhYQEL
	ibdn1jNB7OpjlJjy6QxYglMgXmLOtqdgu5gFdCTe9T1ghrDlJba/ncM8gVFgFpIVs5CUzUJS
	toCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSKjy7mD8v07mEKMAB6MS
	D+8LU7cAIdbEsuLK3EOMkhxMSqK8jHnuAUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeLNTgHK8
	KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneinygRsGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQrMYXA6MVJMUDtLcH5Cbe4oLEXKAoROspRl2Oz09P3mUU
	YsnLz0uVEuetzQUqEgApyijNg1sBS0yvGMWBPhbmbQe5hAeY1OAmvQJawgS0xPW9C8iSkkSE
	lFQDo8wxrfLD+5XSNzy78/mzV9OGmfMnP85evq/vcs/xBr+6apnpszaf3RkqfkXef9L3fT+e
	FpaxVvXOzJnw8JXAivDmk91i6tW99+s+2vQ99pvLtf+3qYTmuROR0/4csd47O3ji 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204832>

On 09/05/2012 03:39 PM, Michael J Gruber wrote:
> git-merge does not honor the pre-commit hook when doing automatic merge
> commits, and for compatibility reasons this is going to stay.
> 
> Introduce a pre-merge hook which is called for an automatic merge commit
> just like pre-commit is called for a non-automatic merge commit (or any
> other commit).

What exactly is an "automatic merge commit"?  Is it any merge that
doesn't have a conflict?  A merge that doesn't invoke the editor?  A
merge done as part of another operation (e.g., pull)?  I don't see the
term mentioned in the git-merge or githooks man pages.

I think it would be good if you would define this term in the
documentation files that your patch touched, and perhaps in the githooks
section about "pre-commit" as well.

Secondly, though it is impossible (for backwards compatibility reasons)
for the pre-commit hook to be invoked for automatic merges, no such
considerations prohibit the pre-merge commit from being invoked for
non-automatic merges.  In other words, both hooks, pre-commit *and*
pre-merge, could be invoked for non-automatic merges.  Would this be
preferable?

It depends on what pre-merge scripts are likely to be used for.  If they
will tend to be used for merge-specific actions, then it might be more
convenient for *all* merges to be vetted by them.  On the other hand, if
they tend to do the same actions as pre-commit hooks, then having
non-automatic merge commits go through both hooks would tend to be more
annoying than helpful.  Specifically, one of the scripts would probably
have to check whether the merge is a non-automatic merge, and if so do
nothing (i.e., letting the other script take care of it).  This would
also require an easy way for a script to determine whether a commit is a
non-automatic merge commit.

Have you considered this?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
