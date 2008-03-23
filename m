From: Johan Herland <johan@herland.net>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 17:20:44 +0100
Message-ID: <200803231720.44320.johan@herland.net>
References: <47E64F71.3020204@jwatt.org> <47E668E1.80804@jwatt.org>
 <alpine.LSU.1.00.0803231534050.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 17:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdSxl-0002hL-9w
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 17:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbYCWQVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbYCWQVn
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 12:21:43 -0400
Received: from smtp.getmail.no ([84.208.20.33]:61685 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbYCWQVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 12:21:42 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY600J1LYS54600@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 23 Mar 2008 17:21:41 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY6001PVYQKPJ90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 23 Mar 2008 17:20:44 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY600I8AYQKPS20@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 23 Mar 2008 17:20:44 +0100 (CET)
In-reply-to: <alpine.LSU.1.00.0803231534050.4353@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77922>

On Sunday 23 March 2008, Johannes Schindelin wrote:
> On Sun, 23 Mar 2008, Jonathan Watt wrote:
> > Elijah Newren wrote:
> If you want to push into non-bare repositories, then please, please, 
> please read the tutorials on that subject.

I have personally no problem with the current default behaviour of push (in the few cases I push into non-bare repos, I've set up the proper hooks to do what I want), but I frequently get questions from colleagues about why Git behaves like this.

I'm starting to think it's worth changing the default behaviour of push as follows:

Upon receiving a push into a non-bare repository, if the working copy is on the same branch as is being pushed, then refuse the push with a helpful message describing why the push was refused, and how to resolve this issue (i.e. referring to the tutorials you mention).

This would:
- Not clobber the working copy
- Tell newbies what happened and why
- Hopefully make this issue pop up less frequently
- Not affect you if you only push into bare repos
- Not affect you if you take care to never push into a checked-out branch

Of course, you should be able to set a config option to get the old behaviour, and from there you can write hooks to either update the working copy, or detach HEAD, or whatever you please.


Is this acceptable to people?

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
