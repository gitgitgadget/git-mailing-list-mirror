From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: Cherry-picking to remote branches
Date: Fri, 6 Jul 2007 09:09:26 -0500
Message-ID: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 16:09:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6oV1-0003oZ-9O
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbXGFOJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbXGFOJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:09:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:5287 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXGFOJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:09:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so278694wah
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 07:09:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UJcN2yYXci3Q1rfO748PdqL5LOuSQOQahvnAGKW9yIo3VnSsyNMJsI1mlAL0J0QpmDm/a9n4KEJH1l+NTtllSeonpXfD6RlEf9GqfGwQPXkY909mVdzbBL8N560ZQXBOX32JuNEO318bP/uIghKN3oVnxcCHrhmr2i/oZCBsTSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XW9xe7/TGrWRnGk8M3bSHYFG8imjlMoIqBWKH/BKYvcP5jgN/GNOh2B9nP/m8MFfGbhgD4HIOPe5dyRRdSvfwQqhRwZq4yMXjGn0Kb9s/KPHsE3KjMcXyErk8FTQNG2Zk/6FSszQf11IFM9waNuQFVw/3Kn6lig+0v9E7aszXgo=
Received: by 10.114.153.18 with SMTP id a18mr658789wae.1183730966969;
        Fri, 06 Jul 2007 07:09:26 -0700 (PDT)
Received: by 10.114.203.4 with HTTP; Fri, 6 Jul 2007 07:09:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51751>

I have been having trouble with the following workflow.  I am trying
to push changes to a remote from a branch that is tracking it.

git clone git://mysite.com/data/git/linux-devel.git linux-devel

cd linux-devel

git remote add -m master -f linux-stable
git://mysite.com/data/git/linux-stable.git

git branch -r

  linux-stable/HEAD
  linux-stable/master
  origin/HEAD
  origin/master

git checkout -b stable linux-stable/master

git cherry-pick  b3b1eea69a   (a commit from linux-devel)

git push linux-stable

error: remote 'refs/heads/master' is not a strict subset of local ref
'refs/heads/master'. maybe you are not up-to-date and need to pull
first?
error: failed to push to 'git://mysite.com/data/git/linux-stable.git'

Thanks for your help,

Sean
