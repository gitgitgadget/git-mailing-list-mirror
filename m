From: "H. Peter Anvin" <hpa@zytor.com>
Subject: First cut at git port to Cygwin
Date: Wed, 28 Sep 2005 17:53:36 -0700
Message-ID: <433B3B10.5050407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 02:55:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKmgH-0005GU-EN
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 02:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVI2Axp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVI2Axp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 20:53:45 -0400
Received: from terminus.zytor.com ([209.128.68.124]:19096 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751290AbVI2Axo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 20:53:44 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8T0rfne001298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2005 17:53:41 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9452>

I have made a first cut at a git port to Cygwin.  It looks like the 
"git-diff-tree -p" problem has been resolved independently, or at least 
I can't reproduce it on a fresh Cygwin install (running on XP Home), but 
I have added support for running without the IPv6 and the getaddrinfo() API.

There are still funnies.  In particular, Cygwin and Samba handle 
symlinks differently, so you can't trivially share a repository via 
Samba.  Linus' "symbolic refs" changes should eventually take care of that.

Another funny which I haven't been able to figure out yet is that 'gitk' 
scrunches all its output up into a few pixels at the top of the window. 
  If I maximize the window, I can manually resize most of the panes and 
the output looks correct, but the highlighted text in the top panes show 
up in black on a really really dark blue background and is thus illegible.

I have set up a git-on-Cygwin temporary tree at:

http://www.kernel.org/pub/scm/git/git-cygwin.git

	-hpa
