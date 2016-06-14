From: Andreas Krey <a.krey@gmx.de>
Subject: 'untracked working tree files would be overwritten by merge' on ignored files?
Date: Tue, 14 Jun 2016 18:07:20 +0200
Message-ID: <20160614160720.GA22675@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 18:36:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCr3i-0004L8-AE
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 18:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcFNQTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 12:19:18 -0400
Received: from continuum.iocl.org ([217.140.74.2]:58460 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcFNQTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 12:19:17 -0400
X-Greylist: delayed 712 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2016 12:19:17 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u5EG7KS22860;
	Tue, 14 Jun 2016 18:07:20 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297303>

Hi all,

when I have an ignored file in my workspace, is git
then also assumed not to remove it in the course
of a merge?

Shouldn't it then say that the file is ignored,
as it does not show up in the untracked section
of git status?

Regards, Andreas

PS: Test script (will remove anything named 'tst'):
    rm -rf tst
    mkdir tst
    cd tst || exit 1
    git init
    echo '*.txt' >.gitignore
    git add .
    git commit -m initial
    git checkout -b side
    git checkout -
    date >a.txt
    git add -f a.txt
    git commit -m 'new file'
    git checkout side
    git commit -m 'nix' --allow-empty
    touch a.txt
    git status --ignored    # Shows a.txt as ignored
    git merge master        # Will complain
    git version

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
