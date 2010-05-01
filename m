From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: How to manage parameter files and code separately using git?
Date: Sat, 01 May 2010 14:57:31 +0200
Message-ID: <op.vb0195s1a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 14:58:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8CHK-0006Bt-Mv
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 14:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0EAM5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 08:57:34 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:64345 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab0EAM5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 08:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1272718651; l=1497;
	s=domk; d=tilo-schwarz.de;
	h=From:Content-Transfer-Encoding:MIME-Version:Date:Subject:To:
	Content-Type:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=gLNwqzT2ztcJnzAkRhgbLRga/wY=;
	b=Mn8UMJfWXeAR5Sa+gx2nDdIfBj7SJlTeoLRfPythyq8Qk9CmURo0uKzwA/qvq125i8L
	XP/rh/ZUbUZAYpEn+9JUxNdw/55QY+1hBbUyCu5UDaZh0TkAn4omcHfkBd8O6+Ng40EvF
	4SVGCCOrtb2ucVo3keixb/XKIvq0MXm9ffE=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlc5y1cxMLDk=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CB694.dip.t-dialin.net [84.156.182.148])
	by post.strato.de (fruni mo57) (RZmta 23.0)
	with ESMTP id w01861m41BYsxn for <git@vger.kernel.org>;
	Sat, 1 May 2010 14:57:31 +0200 (MEST)
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146084>

Hi all,

maybe someone has an idea how to do what I'd like to do using git:

I use git for "normal" c coding, i.e. having branches like master, test,  
foo, etc. Built are executables (Linux), which need parameter text files  
to work. What I did up to now was to check in the parameter files in the  
same way I check in the code: when I change a parameter file, I do a  
commit on it, this way I always have a history of my parameter files.

This has one drawback: If I check out an older version, I also get the old  
parameter file, which is not what I want, because the parameters are  
determined by hardware settings. I.e., I would like to checkout an old  
commit, but still have the last version of the parameter file.

I tried to solve the problem by

1. creating a branch 'parameters', which contains only the parameter files
2. ignore the parameters files with extension *.m in .gitignore in the  
code branches (master etc.)

This seemed to work at first, but when I switch back from the parameters  
branch to master, all *.m files are removed, although .gitignore of master  
contains '*.m'.

So apparently git removes during branch switch first the tracked files and  
than populates the working dir with the new files of master.

Now my questions are

1. Is there a way to work around it?
2. Is there a maybe totally different way to solve my initial problem  
(separate code history from parameter file history) without using two git  
repos?


Thanks a lot!

     Tilo
