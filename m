From: Lorenzo Campedelli <lorenzo.campedelli@tele2.it>
Subject: gitk diff fails on merges
Date: Sat, 12 Nov 2005 14:34:29 +0100
Message-ID: <dl4r17$7vl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060303030300050608010100"
X-From: git-owner@vger.kernel.org Sat Nov 12 14:42:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eavd5-0004pi-L1
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 14:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKLNlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 08:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVKLNlM
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 08:41:12 -0500
Received: from main.gmane.org ([80.91.229.2]:17584 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932352AbVKLNlM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 08:41:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EavcS-0004aT-M2
	for git@vger.kernel.org; Sat, 12 Nov 2005 14:40:36 +0100
Received: from d83-176-100-6.cust.tele2.it ([83.176.100.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 14:40:36 +0100
Received: from lorenzo.campedelli by d83-176-100-6.cust.tele2.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 14:40:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d83-176-100-6.cust.tele2.it
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11686>

This is a multi-part message in MIME format.
--------------060303030300050608010100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm using the following:

[campedel@betelgeuse ~]$ git --version
git version 0.99.9g
[campedel@betelgeuse ~]$ cg --version
cogito-0.16rc1

I think there's a bug in gitk diffing, both
	'Diff selected -> this'
and
	'Diff this -> selected'
fail when applied on the result of a merge.

To replicate the problem you can use the attached script
and then try diffing against branch_1 head.

Thanks for your attention (and for your wonderful work!)

Lorenzo

--------------060303030300050608010100
Content-Type: text/plain;
 name="script"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="script"

cg init
echo abc > a.file
cg add a.file
cg commit -m 'added a.file'
cg tag tag_1
echo def >> a.file
cg commit -m 'modified a.file'
git checkout -b branch_1 tag_1
echo ghi > b.file
cg add b.file
cg commit -m 'added b.file'
cg merge -c master
cg commit -m 'merged with master'
gitk --all

exit

--------------060303030300050608010100--
