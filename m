From: Svenn Are Bjerkem <svenn.bjerkem@googlemail.com>
Subject: After git svn clone master is tied to a branch in svn, howto set 
	master to trunk
Date: Wed, 11 Mar 2009 08:17:04 -0700 (PDT)
Message-ID: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 16:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQCi-000299-BF
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbZCKPRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZCKPRI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:17:08 -0400
Received: from yx-out-2122.google.com ([74.125.44.25]:41489 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZCKPRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 11:17:06 -0400
Received: by yx-out-2122.google.com with SMTP id 33so18185yxl.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 08:17:04 -0700 (PDT)
Received: by 10.100.111.15 with SMTP id j15mr1294318anc.13.1236784624170; Wed, 
	11 Mar 2009 08:17:04 -0700 (PDT)
X-IP: 62.92.119.36
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) 
	Gecko/2008092814 Iceweasel/3.0.3 (Debian-3.0.3-3),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112937>

Hi,
after performing a
$> git svn clone https://svnserver/svn/a/b/c -T trunk/current -t tags -
b branches
I find that the git master has been tied to one of the branches. It
turns out that the highest svn revision number in the repository was
tied to that branch.

For historical reasons we have subdirectories in trunk/ on svn, but I
inspected .git/config
[svn-remote "svn"]
        url = https://svnserver/svn
        fetch = a/b/c/trunk/current:refs/remotes/trunk
        branches = a/b/c/branches/*:refs/remotes/*
        tags = a/b/c/tags/*:refs/remotes/tags/*
And I assume it picked up the strange trunk correctly.

I have been googling around for a while looking for instructions how
to tell git that when I check out "master" it should be "trunk" from
svn and not "branches/next_gen", or more precisely how to move master
to trunk from branches/next_gen.

I guess I could solve the problem by modifying a file in trunk on svn
and commit so that the trunk will get the highest svn revision number
again and redo the clone.

--
Svenn
