From: Patrick Boettcher <pboettcher@kernellabs.com>
Subject: git mv oddities (minor bugs)
Date: Fri, 15 Jan 2010 17:49:18 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1001151728070.9232@pub3.ifh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 17:49:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVpMV-0001CN-2Y
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 17:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526Ab0AOQtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 11:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173Ab0AOQtW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 11:49:22 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:57017 "EHLO znsun1.ifh.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730Ab0AOQtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 11:49:22 -0500
Received: from pub3.ifh.de (pub3.ifh.de [141.34.15.119])
	by znsun1.ifh.de (8.12.11.20060614/8.12.11) with ESMTP id o0FGnIX0005224
	for <git@vger.kernel.org>; Fri, 15 Jan 2010 17:49:19 +0100 (MET)
Received: by pub3.ifh.de (Postfix, from userid 11503)
	id 8DCDF1581BE; Fri, 15 Jan 2010 17:49:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pub3.ifh.de (Postfix) with ESMTP id 78DA615819A
	for <git@vger.kernel.org>; Fri, 15 Jan 2010 17:49:18 +0100 (CET)
X-X-Sender: pboettch@pub3.ifh.de
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137082>

Hi all,

I'm currently using a lot of git mv to clean up some code. This includes 
renaming of files and moving them to new pathes inside the clone.

Everything's working very fine except two very small things I've 
encountered:

1) git mv from/file to/subdir/ - subdir does not exists

Instead of git telling me that 'subdir' does not exist it is executing the 
mv and 'file' is now called 'to/subdir' .

I'm almost sure this is a bug: the trailing / seems to be ignored.

2) git mv from/file to/subdir/new_name - subdir does not exists

Git is telling me the following:
fatal: renaming 'from/file' failed: No such file or directory

This is a little bit misleading as it is 'to/subdir' which is "No such 
file or directory" .

I'm not sure what to do with this one - changing the error message a 
little bit might a good idea.

I'm using:

$ git --version
git version 1.6.4.4

I was looking for a bug tracker at git-scm.org - didn't find any. So I'm 
not sure where to log my findings. How should I continue?

--

Patrick Boettcher - Kernel Labs
http://www.kernellabs.com/
