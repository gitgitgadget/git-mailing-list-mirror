From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 15:27:33 -0700
Message-ID: <20060618222732.GJ25520@h4x0r5.com>
References: <449557B6.1080907@garzik.org> <20060618164300.GI25520@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 00:28:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs5l0-0007cl-7k
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 00:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFRW2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFRW2f
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 18:28:35 -0400
Received: from h4x0r5.com ([70.85.31.202]:32269 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751116AbWFRW2e (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 18:28:34 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Fs5jy-0005Yp-4s; Sun, 18 Jun 2006 15:27:34 -0700
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20060618164300.GI25520@h4x0r5.com>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22108>

On Sun, Jun 18, 2006 at 09:43:00AM -0700, Ryan Anderson wrote:
> 
> The fix is to drop the "-f" from git checkout, and things should work
> correctly.  ("-f" should really not be a normal thing to use. For
> switching branches, "git checkout" should be sufficient, and should
> result ina working tree that doesn't contain nearly as many potential
> conflict sources.

I wrote all of that from memory, but I figured I should really test it:

$ git branch tmp v2.6.12
$ git checkout tmp
$ git pull . master
Updating from 9ee1c939d1cb936b1f98e8d81aeffab57bae46ab to
553698f944ed715dfe023b4cef07601f0ce735f0
Checking files out...
 100% (14284/14284) done
 Fast forward
(Watch insanely large diffstat blow by)
$ git status
# On branch refs/heads/tmp
nothing to commit
$ git branch
  master
  origin
  ryan
* tmp

So, I think all you need to do is drop the "-f" from the call to
checkout, and the issues will be fixed, for your particular use case.




-- 

Ryan Anderson
  sometimes Pug Majere
