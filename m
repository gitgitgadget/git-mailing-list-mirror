From: Jose Ricardo <josericardo.jr@gmail.com>
Subject: Custom Merge
Date: Mon, 23 Apr 2012 12:25:50 +0000 (UTC)
Message-ID: <loom.20120423T141242-348@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:30:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIPF-00035f-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2DWMaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 08:30:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:37096 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483Ab2DWMaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:30:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SMIP5-00030J-88
	for git@vger.kernel.org; Mon, 23 Apr 2012 14:30:06 +0200
Received: from 187126163164.user.veloxzone.com.br ([187126163164.user.veloxzone.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 14:30:03 +0200
Received: from josericardo.jr by 187126163164.user.veloxzone.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 14:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 187.126.163.164 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.163 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196113>

Hi everyone!

In my project, I have a lot of image files, that I wanted to process using 
a different tool. For this, after reading some posts about custom merge 
drivers in this forum, I make the following modifications:

In the file .gitconfig I added the following lines:


[merge "imgfile"]
        name = Driver for image files
        driver = /usr/local/bin/git-merge-img.sh %O %A %B %L
        recursive = binary

and in the .gitinfoattributes I put:

*.png   merge=imgfile

As I can see, it works calling my custom script during a merge between
 two branches that have a .png file. Unfortunately, even after a successfully 
merge, the final image is not merged with the one in the other branch. 
In order to test it, I've called my script using three images, giving me the 
corrected result.

I don't know if it could help but instead of changing the content of the file
 I create another one with the same name during a merge operation.

Does anyone could help me pointing what could be wrong with this?

Thanks a lot!
