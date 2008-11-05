From: Yang Zhang <yanghatespam@gmail.com>
Subject: How to rebase for git svn?
Date: Wed, 05 Nov 2008 14:09:00 -0500
Message-ID: <4911EF4C.8030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 20:10:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxnle-0005oZ-3x
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 20:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYKETI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYKETI7
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 14:08:59 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:62032 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbYKETI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 14:08:58 -0500
Received: by yx-out-2324.google.com with SMTP id 8so91374yxm.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=JQneQSxEQD1IkoEPa+RiTzk82JOyZAaoOcMoemNGa7o=;
        b=ZwLbYWA/zH3v9XPODdzQDfRWm1I1SIOmDnerpiedaiMj4MAf44iqjcqqyCiMpR20oJ
         Wt/l/5FHiVPtCSPbE5Ao4mjepNrqPyfIBZHp2lHAo6oZqkBwvdjPWrrdcWeuv7s4qdrD
         TxByWeFP9FBEkEUtzj7tiIu11qOSpMywXV8a0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=L16tPyNPj5GRxr5aqxQkzfoBHpFO7vB1/0lAxq89qhW4pAjN6laB0gz9O1bEl6iBrm
         ZRQtAoYGF3h3qRGhlZTq6FA+eTD22WysahB35CqhNAFg5L2dDGd96pItwochOCwVTB3e
         Go7VsQLCTh4gLv5EIFFKnhrq6DVO+7PyBSyQs=
Received: by 10.231.37.129 with SMTP id x1mr468547ibd.39.1225912136379;
        Wed, 05 Nov 2008 11:08:56 -0800 (PST)
Received: from harvard.csail.mit.edu ( [18.26.1.77])
        by mx.google.com with ESMTPS id 4sm284390yxq.9.2008.11.05.11.08.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 11:08:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100174>

Hi, I made a git svn repository from an svn repository.  Then I cloned 
the git repository, committed some changes to the clone, and pulled back 
to the original repository.  However, now the original repository gives 
me conflicts whenever I run git svn rebase.  I believe this is because 
git pull treats the other repository's commits as a branch and merges 
them back instead of rebasing them and maintaining the type of linear 
history that is good for playing with svn.  Any hints as to how to fix 
this?  I think the solution is to undo the merge that resulted from the 
pull, but I don't know how to do this.

I wrote a simple script reproducing exactly what's going on (along with 
a transcript of its output).  I tried to make it as simple as possible, 
but it can probably be simplified even more to reproduce the problem:

http://assorted.svn.sourceforge.net/viewvc/assorted/sandbox/trunk/src/git/gitsvn.bash?revision=1057&view=markup

Thanks in advance for any help!
-- 
Yang Zhang
http://www.mit.edu/~y_z/
