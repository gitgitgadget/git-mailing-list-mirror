From: Andy Parkins <andyparkins@gmail.com>
Subject: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 12:59:23 +0000
Message-ID: <200701231259.27719.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 23 13:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9LFV-0000nZ-3K
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 13:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbXAWM7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 07:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXAWM7i
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 07:59:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:34151 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964872AbXAWM7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 07:59:37 -0500
Received: by nf-out-0910.google.com with SMTP id o25so223243nfa
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 04:59:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZaFrDyEAoDPDHgNUvExyX304D62fugKE6aERTh5h1tgpx0jjTtLHlX/ldll1hANX2aaiXSFrcQ9cJLCZ8AI0dtXTvqCCqkl65/udMxJ8Geh5DF0dOXTb7gYERN4P/85xFySB2u7xfkmeDmqc5NNXtqYBStHeLeYvHpLpZyo2HPk=
Received: by 10.49.29.2 with SMTP id g2mr1024909nfj.1169557172405;
        Tue, 23 Jan 2007 04:59:32 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l21sm2445881nfc.2007.01.23.04.59.30;
        Tue, 23 Jan 2007 04:59:31 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37507>

Hello,

As per subject.

If anything, these are safer to delete than local branches because they will 
be restored automatically with the next fetch, so why do we require the extra 
switch for remote branches?

Would it be simpler for the user if the following worked?
$ git branch -a
* master
  origin/master
$ git branch -D origin/master

i.e. that the -r switch was unnecessary in unambiguous cases.

reflogs
-------

Why does the reflog directory .git/logs need to store the refs/ directory?  
Aren't /all/ the refs under "refs/" these days?

Is it right that the reflog for a branch is deleted when the branch is 
deleted?  Doesn't this kill one of the advantages of reflogs?  In particular, 
if I accidentally deleted a branch, I would have no way of getting it back 
because the reflog has been deleted too?  Personally I'd prefer that a reflog 
line was added saying
  XXXXXXXXXXXXXXX 00000000000000 Deleted
Or similar.  After all; it's only disk space.  If the ref was later created 
again, then the log can continue to be added to, but it will have a "Created 
from" in the middle instead of at the end.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
