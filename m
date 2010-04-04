From: Mike Galbraith <efault@gmx.de>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sun, 04 Apr 2010 06:27:47 +0200
Message-ID: <1270355267.6307.43.camel@marge.simson.net>
References: <201004030005.35737.elendil@planet.nl>
	 <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
	 <201004040123.06877.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sun Apr 04 06:28:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyHRO-0001b8-BD
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 06:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810Ab0DDE1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 00:27:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:55557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750791Ab0DDE1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 00:27:51 -0400
Received: (qmail invoked by alias); 04 Apr 2010 04:27:48 -0000
Received: from p4FE1A6AC.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [79.225.166.172]
  by mail.gmx.net (mp006) with SMTP; 04 Apr 2010 06:27:48 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1/9vTAn8yD9wbo8R/rsKBan8da2cMeb9RLhaGb3Nf
	yDNT9n/ZcOl9oG
In-Reply-To: <201004040123.06877.elendil@planet.nl>
X-Mailer: Evolution 2.24.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143914>

On Sun, 2010-04-04 at 01:23 +0200, Frans Pop wrote:
> On Saturday 03 April 2010, Michael Witten wrote:
> > On Fri, Apr 2, 2010 at 16:05, Frans Pop <elendil@planet.nl> wrote:
> > > I haven't had the patience to let it finish
> >
> > There's your problem.
> 
> Yes, I had seen that. But there's a difference between taking much more 
> time and slowing down to such an extend that it never finishes.
> 
> I've tried it today on my linux-2.6 repo as well and the same thing 
> happened. At first the progress is not fast but reasonable. When it gets 
> to about 45% percent it starts slowing down a lot: from ~1500 objects per 
> update of the counters to ~300 objects per update. And who knows what the 
> progress is going to be when it reaches 70% or 90%: 10 per update?
> 
> With a total of over 2 milion objects in the repository such a low speed is 
> simply not going to work, ever. So I maintain that it is effectively 
> unusable.

As a data point, when I do gc, I routinely use --aggressive.  It takes a
while here, but not forever.  (I'm a tad short of 2 million objects)

Repo is mainline + next + tip + stable >= 2.6.22 + local branches.

git@marge:..git/linux-2.6> time git gc --aggressive
Counting objects: 1909894, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (1889774/1889774), done.
Writing objects: 100% (1909894/1909894), done.
Total 1909894 (delta 1674098), reused 0 (delta 0)

real    22m24.943s
user    55m33.756s
sys     0m8.149s

git is 1.7.0.3

	-Mike
