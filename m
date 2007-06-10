From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/7] Softrefs: Add softrefs header file with API
 documentation
Date: Sun, 10 Jun 2007 16:00:02 +0200
Message-ID: <200706101600.02673.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092021.43314.johan@herland.net>
 <Pine.LNX.4.64.0706100750440.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 16:00:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNxi-0005Uv-Qs
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbXFJOAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbXFJOAJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:00:09 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35937 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbXFJOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:00:07 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00J05AW6J600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:00:06 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00EJJAW31110@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:00:03 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00DTNAW2C050@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:00:03 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706100750440.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49733>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 9 Jun 2007, Johan Herland wrote:
> 
> > See patch for documentation.
> 
> This is preposterous. Either you substitute the patch for a documentation, 
> or you document it in the commit message. I consider commit messages like 
> "See patch for documentation" as reasonable as all those CVS "** no 
> message **" abominations.

Well, I could have copied documentation from the header file into the commit
message

> > + * The softrefs db consists of two files: .git/softrefs.unsorted and
> > + * .git/softrefs.sorted. Both files use the same format; one softref per line
> > + * of the form "<from-sha1> <to-sha1>\n". Each sha1 sum is 40 bytes long; this
> > + * makes each entry exactly 82 bytes long (including the space between the sha1 + * sums and the terminating linefeed).
> > + *
> > + * The entries in .git/softrefs.sorted are sorted on <from-sha1>, in order to
> > + * make lookup fast.
> > + *
> > + * The entries in .git/softrefs.unsorted are _not_ sorted. This is to make
> > + * insertion fast.
> 
> This sure sounds like you buy the disadvantages of both. Last time I 
> checked, it was recommended to look at your needs and pick _one_ 
> appropriate data structure fitting _all_ your needs.

First, the unsorted file is bounded in size to make sure it never gets
large enough to really impact performance
Second, I'd ask you to look at the performance numbers (in patch #0)
before commenting on the performance.

> Besides, your lines are way too long. Yes, it is not in 
> Documentation/SubmittingPatches, but even just a cursory look into the 
> existing source shows you that it is mostly 80-chars-per-line. I think it 
> goes without saying that you should try to imitate the existing practices 
> in any project, and since you have to read the source to get acquainted 
> with it _anyway_, it would only be a duplication to have it in 
> SubmittingPatches, too.

I have indeed tried to follow the 80-chars-per-line rule. In softrefs.h
I fail to see a _single_ line exceeding 80 chars per line. In the other
files I believe the number of long lines is comparable to other files
in the git repo.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
