From: Johan Herland <johan@herland.net>
Subject: Re: branch description
Date: Wed, 16 Apr 2008 10:29:18 +0200
Message-ID: <200804161029.18601.johan@herland.net>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <m3abjushvs.fsf@localhost.localdomain>
 <1c5969370804152046h8d67630m697ca71b523b04d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 10:30:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm322-0003j9-CZ
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 10:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYDPI3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 04:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbYDPI3c
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 04:29:32 -0400
Received: from smtp.getmail.no ([84.208.20.33]:60613 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbYDPI3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 04:29:31 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZE00C03SX5JP00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 16 Apr 2008 10:29:29 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZE00119SWUKR10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 16 Apr 2008 10:29:18 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZE004XMSWUKGF0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 16 Apr 2008 10:29:18 +0200 (CEST)
In-reply-to: <1c5969370804152046h8d67630m697ca71b523b04d9@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79684>

On Wednesday 16 April 2008, Matt Graham wrote:
> On Tue, Apr 15, 2008 at 9:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >  I think it wouldb be better to put branches descriptions somewhere
> >  outside object repository, be it .git/info/ref_names of .git/config.
> 
> I agree that outside the object repository would be better.
> Propogating branch descriptions doesn't seem all that useful.  I
> wouldn't usually expect to want a branch for the same purpose as the
> upstream repository and it would seem weird to get a default
> description of it coming along with the branch.  Just like I give my
> branches my own name, I would expect to have to give them my own
> description.

On the contrary, when I clone/pull from some repo, I would very much like to
have a copy of its branch description stored locally. Of course, these
descriptions should be renamed along with their corresponding branch upon
entering my repo. To illustrate: Suppose I clone/pull "refs/heads/foo" from
a remote repo "bob". The branch will be stored as "refs/remotes/bob/foo" in
my repo. Now, if "refs/heads/foo" on "bob" has a branch description, I would
like to have that branch description copied into my repo, but referring to
"refs/remotes/bob/foo" instead of "refs/heads/foo", of course.

Now, when it comes to my own local branches, I agree with you: If I make a
new local branch "refs/heads/foo" that tracks "refs/remotes/bob/foo", I will
probably not want git to copy the branch description automatically.

However, I do agree that putting branch description inside the working tree
is not the right solution. So far, the best proposal I've seen, is Hommey's
suggestion of storing the description after the sha1 in the ref file itself.
Of course, git would have to be taught (a) to handle ref files with
descriptions, and (b) to propagate descriptions along with refs.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
