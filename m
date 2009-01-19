From: "Johnny Lee" <johnnylee194@gmail.com>
Subject: [HELP] A local branch has disappeared
Date: Mon, 19 Jan 2009 11:54:04 +0800
Message-ID: <488807870901181954p558756f5v94c8a6681125e8bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 04:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOlEc-0002gl-7I
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757891AbZASDyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758703AbZASDyH
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:54:07 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:17776 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758684AbZASDyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:54:05 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2993954wfd.4
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 19:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=aT9PdsTnpsP83ZE8WDa5jzcpPDwcG0OEacOSDxE+EbI=;
        b=VodQx/cD7+v5JOZE1sfoisB8+tcXMvWJaDqMk9uJsbLAQeXdYUogEFrgdHE18cNo0+
         66kTI9zplI3hjxAQeh5B97l/VlG1sSZZLnuJjpFylgGeQMFWaVclCi37UPFSytd0NY2C
         aKs1l8w7+WHGg/YIKIEKCrV8nVaA9wFTORyVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xKk+cIyXjjWjNWoPazUEoATJvoPeWAGszWPoaE5hWD/Xlwv33++eaDqst1kgP4fRvr
         N2MNZxyfcl2WbGeMVHohff9CkrnZg+bFUgXTOt/2M06TpPOtvHYaeaiAtPfRN3zV9d3/
         e6JGbDs1WYqrb3FCk/WtvP1j+ANk9zMRi3nOk=
Received: by 10.142.237.20 with SMTP id k20mr2175915wfh.93.1232337244483;
        Sun, 18 Jan 2009 19:54:04 -0800 (PST)
Received: by 10.143.37.4 with HTTP; Sun, 18 Jan 2009 19:54:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106317>

Hi all,

Today I found my current branch (named cupcake) has disappeared.
git@tomato:~/golf$ git branch -a
  htc_cupcake
  tmo_cupcake
  origin/HEAD
  origin/cupcake
  origin/device

As you can see, there is no "*" to mark the current branch.

But when I check the HEAD, it still pointed to the cupcake branch
git@tomato:~/golf$ cat .git/HEAD
ref: refs/heads/cupcake

But when I check the ref/heads, the cupcake is missing
git@tomato:~/golf$ ls .git/refs/heads/
htc_cupcake  tmo_cupcake

And the cupcake in still in the config:
git@tomato:~/golf$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        sharedRepository = 1
[remote "origin"]
        url = /home/rick/golfresort/device/.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "cupcake"]
        remote = origin
        merge = refs/heads/cupcake

I'm confused:
1. I didn't do any aggressive operations. Why the branch has
disappeared? Normally I have done these operation for this repo:
   i. pull from parent repo
   ii. cloned by children repo
   iii. pulled by children repo
   iv. pushed from children repo
2. Is there any way to resume the cupcake branch? Can I manually add
the cupcake to ref/heads?

Thanks very much for your considerations,
Johnny
-- 
we all have our crosses to bear
