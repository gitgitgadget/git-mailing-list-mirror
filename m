From: Don Zickus <dzickus@gmail.com>
Subject: git merge questions
Date: Fri, 16 Dec 2005 15:05:11 -0500
Message-ID: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 21:06:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnLpO-0007r7-7L
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 21:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVLPUFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVLPUFN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 15:05:13 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:43446 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751331AbVLPUFM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 15:05:12 -0500
Received: by wproxy.gmail.com with SMTP id i3so977085wra
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 12:05:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m4fCOWtSrspF/c72hit17ALe3B0aw1uDQW8PBZiIteKdCEPC3MaSL8zf5F08I3DLqQEDlaCZcfvK85wF1j5NA7qpSvu4EHAozs5hv5gbKiZ4P+EqR/PJykzyrDonzFFZT5y8uSvSoulqhJqnM8R73Iq18VLKB4jaumxMabCXEiI=
Received: by 10.65.249.15 with SMTP id b15mr155366qbs;
        Fri, 16 Dec 2005 12:05:11 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Fri, 16 Dec 2005 12:05:11 -0800 (PST)
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13746>

I now have a git merge question.  I decided to try merging branches
and was left with a situation in which the file was moved on the
master branch and updated on my branch.  Not sure how to properly
integrate the changes from my branch.

For example:
%git checkout -b test v2.6.14
%<manually apply all the 2.6.14.z stable patches>
%<commit those patches>
%git checkout -b test2 v2.6.15-rc4
%git pull . test

Now over the course of 2.6.15 the arch/ppc64 was renamed to
arch/powerpc.  Fine. The merge algorithms handled all the unchanged
files properly.  However arch/ppc64/Kconfig was modified and the
merging was left unresolved.  In fact there is no file no merge
against (because it moved).  So 'git-ls-files -u' only shows stage 1+3
(no stage 2, of course).

How do I merge those changes?  I don't know enough about all the git
commands to figure this out, especially how to take advantage of the
stage 1, 2, and 3 files.

Thanks for any help,
Don
