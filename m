From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 11:57:49 -0400
Message-ID: <1311263869.9745.72.camel@drew-northup.unet.maine.edu>
References: <20110721125544.26006.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, anthonyvdgent@gmail.com, git@vger.kernel.org,
	nico@fluxnic.net, torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 17:58:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjveA-0000OK-Ih
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 17:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab1GUP6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 11:58:42 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:45356 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1GUP6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 11:58:41 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6LFvs4K019083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Jul 2011 11:57:59 -0400
In-Reply-To: <20110721125544.26006.qmail@science.horizon.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6LFvs4K019083
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311868683.55737@bS3J8qdWAS3OmivVUnZ1ZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 2011-07-21 at 08:55 -0400, George Spelvin wrote:
> > I have not read yet one discussion about how generation numbers [baked
> > into a commit] deal with rebasing, for instance. Do we assign one more
> > than the revision prior to the base of the rebase operation or do we
> > start with the revision one after the highest of those original commits
> > included in the rebase? Depending on how that is done
> > _drastically_different_ numbers can come out of different repository
> > instances for the same _final_ DAG. This is one major reason why, as I
> > see it, local storage is good for generation numbers and putting them in
> > the commit is bad. 
> 
> Er, no.  Whenever a new commit object is generated (as the result
> of a rebase or not), its commit number is computed based on its
> parent commits.  It is NEVER copied.

I don't see the word "copy" in my original. 

B-O1-O2-O3-O4-O5-O6
 \
  R1----R2-------R3

What's the correct generation number for R3? I would say gen(B)+3. My
reading of the posts made by some others was that they thought gen(O6)
was the correct answer. Still others seemed to indicate gen(O6)+1 was
the correct answer. I don't think everybody MEANT to be saying such
different things--that's just how they appeared on this end.

Now, did you mean something different by "commit number?"

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
