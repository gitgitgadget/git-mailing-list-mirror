From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [Misfeature] cloning without configuration fails and returns 0
Date: Sat, 8 Dec 2007 23:21:35 +0100
Message-ID: <9438BB94-AE9C-4F4E-A4DA-8E2121642736@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 23:22:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J183t-00051C-Iy
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 23:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXLHWV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 17:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbXLHWV4
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 17:21:56 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38268 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXLHWV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 17:21:56 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1J183W-0007Ja-JB
	for git@vger.kernel.org; Sat, 08 Dec 2007 23:21:54 +0100
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67574>

Hi,
on a new machine I have access to, I fetched tonight's git master  
(git version 1.5.3.7.g9758e) and installed it on my account in order  
to clone one of my projects.  I did not setup anything in my git  
config and stumbled on the following misfeature:

----------------------------------------------------------------------
$ git clone ssh://login@host/~/path/git/project/.git project
Initialized empty Git repository in /home/me/git/project/.git/
Password:
remote: Counting objects: 609, done.
remote: Compressing objects: 100% (465/465), done.
remote: Total 609 (delta 267), reused 462 (delta 134)
Receiving objects: 100% (609/609), 1.56 MiB | 63 KiB/s, done.
Resolving deltas: 100% (267/267), done.

*** Your name cannot be determined from your system services (gecos).

Run

   git config --global user.email "you@example.com"
   git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident  <me@fqdn> not allowed
[last 11 lines repeated 3 times!]
fatal: Not a valid object name HEAD
----------------------------------------------------------------------

Not only the same 11 lines of error message were printed 3 times, but  
also the command returned 0!

This is not user friendly at all.  So I thought I'd point this out on  
this ML.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
