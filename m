From: "David J. Neu" <davidjneu@gmail.com>
Subject: git-checkout question
Date: Sun, 13 Jan 2008 09:21:40 -0500
Message-ID: <20080113142140.GB10426@bach.davidneu.local>
Reply-To: djneu@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 15:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE3j5-0006sk-Fv
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 15:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYAMOVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 09:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYAMOVp
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 09:21:45 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:8316 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343AbYAMOVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 09:21:44 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1576987hsz.5
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent;
        bh=byruARlJUfFi0vCGQHn+NfFszkhQVe+lETalvrxL5Vg=;
        b=PQbUViN8NTJ/SHXGG+X4X+XKbInNnBUddz+zRW9RY02Qf548WrjuDYWngxyoCy4Zgbra53/RsRXhMkeoJmIkFLrwzVzaN/BqkfhxV5T68OADbsA+QkmOdM5geQdH7q83n44BFZU2Q37AzLE8crfgUq3YaRk320Y5ymev/N3fhO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent;
        b=BrY8SseyqJ+QC+aIX+AclLuENkbTArZYhCPsYCb5LqWxiqKGlrACgwvffaGnw79gJVASHsSydMBVOXjGfbZsrvIQosxx9jlIv6gO9sab/L21s7Aci4FYat8FuauT90lAJ3qzS+i8S/I1geDi6FFGls+DvN+VEn4SPayMKyBCJj4=
Received: by 10.150.140.6 with SMTP id n6mr1968762ybd.33.1200234102301;
        Sun, 13 Jan 2008 06:21:42 -0800 (PST)
Received: from localhost ( [75.69.180.181])
        by mx.google.com with ESMTPS id q30sm9257148wrq.4.2008.01.13.06.21.40
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 06:21:41 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70383>

Hi, 

I was wondering if someone could explain the following behavior.

1. create and switch to branch off master
2. edit a file in the branch
3. checkout master without committing changes in the branch
4. the changes in the branch are automatically applied in working tree 
   in master

I wasn't expecting the changes in the branch to be automatically
moved to master.  Had I committed while in the branch this doesn't
happen.  I'm using git version 1.5.3, the details are below.

Many thanks!

Cheers,
David

[/tmp] mkdir git-test
[/tmp] cd git-test
[/tmp/git-test] git-init 
Initialized empty Git repository in .git/
[/tmp/git-test] # create hello.py
[/tmp/git-test] git-add hello.py 
[/tmp/git-test] git-commit   
Created initial commit 58282ee: Initial commit of git-test.
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 hello.py
[/tmp/git-test] cat hello.py 
print "hello from master."
[/tmp/git-test] git-checkout -b test-branch
Switched to a new branch "test-branch"
[/tmp/git-test] # modify hello.py
[/tmp/git-test] cat hello.py 
print "hello from test-branch."
[/tmp/git-test] git-checkout master
M       hello.py
Switched to branch "master"
[/tmp/git-test] cat hello.py 
print "hello from test-branch."
[/tmp/git-test] # hmmm?
