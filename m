From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 10:15:29 +0200
Message-ID: <81b0412b0905130115v78b5065bjdeb3f349072eed4c@mail.gmail.com>
References: <4A0A6BD1.7050907@gmail.com>
	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
	 <4A0A777E.7080506@gmail.com>
	 <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>
	 <4A0A7BA1.4030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:15:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49cq-0002bD-EC
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbZEMIPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZEMIPb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:15:31 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:62016 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbZEMIP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:15:29 -0400
Received: by bwz22 with SMTP id 22so475971bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cL1bdsoIV0mBacXy7w8tT0JQlzsvCA/Sj66GnFRT83c=;
        b=NGpU1L1CSvc0GwdTbTNs3LanVi0iDrdKA05v5RO95cdw2HQhtbShTz2gyXyvUw6nod
         7B5Zf/R/+xrZnk5yMKOxG2NQpabf67+IcGolhg0PCTKGPG4ywVtxqCPtM7ePujQtVPfs
         MDXD68HFslVKVFzfdftYHCPt8mH1mzcnrk4xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KLODL0m1pn1T4xqqF7a8qkZIN652ysjFW53fl1cP4jLr/pW8hdLt5tN/vkYf1bi95l
         OxH47owFRC/ycRxFGVAoDZ8Tp44mbPUQggMH2BJCRnks0W0lpJRQ2n94Ot9kqgdxhrB/
         nnHy3Jc3VVfnXwo94jvT4TOmB4SMrZGCTfV2o=
Received: by 10.204.123.136 with SMTP id p8mr680164bkr.21.1242202529104; Wed, 
	13 May 2009 01:15:29 -0700 (PDT)
In-Reply-To: <4A0A7BA1.4030500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119000>

2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>
> tried git rebase, this is what i get:
> git rebase -i upstream master
> fatal: Needed a single revision
> Invalid base

$ git checkout my-old-master-based-on-old-upstream
$ git rebase -i old-upstream

>> Ok, that simplifies everything. Just cherry-pick (see "git cherry-pick")
>> your commits on new upstream. You might find it easiest if you cherry-pick
>> them on commits in new upstream which correspond the old-upstream
>> exactly.
>
> can you explain a bit more how to work with git cherry-pick? if i understand
> correctly, i need to write down my commits, switch to the new upstream tip
> ('git checkout upstream master'?) and then call git cherry-pick for each of
> my commits.

$ gitk old-upstream-with-my-changes-on-top &
$ git checkout -b my-new-master-on-top-of-new-upstream  new-upstream
...select a commit in gitk...
$ git cherry-pick <paste-the-selected-commit-here> # hit Enter

repeat until you run out of commits you want to have on top of the new upstream.
