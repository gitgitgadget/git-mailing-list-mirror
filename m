From: Anuradha Dissanayake <falconne@gmail.com>
Subject: Inexplicable merge conflict produced when when lines next to each other are changed
Date: Tue, 28 Apr 2015 07:34:30 +0000 (UTC)
Message-ID: <loom.20150428T093059-405@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 09:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn0MW-0003v1-9i
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbbD1HzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 03:55:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:38828 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbbD1HzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:55:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Yn0MC-0003dX-43
	for git@vger.kernel.org; Tue, 28 Apr 2015 09:55:10 +0200
Received: from 122.58.23.232 ([122.58.23.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 09:55:04 +0200
Received: from falconne by 122.58.23.232 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 09:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 122.58.23.232 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267913>

I posted this question to StackOverflow a while ago but no one answered 
it so I thought I'd try here.

Let's say I have a file with this content in master:

_____
Line 1
Line 2
Line 3
Line 4 
_____

Now say I create and checkout a new branch called Test. In this branch I 
change the file to this:

_____
Line 1
Line 2
Line 3 Modified
Line 4 
_____

and I commit this and switch back to master. In master I change the file 
to:

_____
Line 1
Line 2
Line 3
Line 4 Modified 
_____

and I commit. Now if I merge branch Test into master, I get a conflict.

Why can't git auto resolve this, as those are two entirely independent 
lines? If I tell git to edit conflicts using BeyondCompare as the 
difftool, BeyondCompare autoresolves this without even telling the user, 
since this isn't a real conflict (other merge tools we use at our 
company do so also). Is there a way to get git to autoresolve these? 
I've tried the recursive and resolve merge strategies but neither do it.

It's an issue in our company because there are certain files where 
multiple developers change lines in close proximity and this causes many 
unnecessary conflicts when they pull.
