From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [patch 04/16] Without this patch at least IBM VisualAge C 5.0
 (I have 5.0.2) on AIX 5.1 fails to compile git.
Date: Wed, 28 Apr 2010 10:55:54 +0200
Message-ID: <4BD7F81A.4030906@spacetec.no>
References: <20100427135708.258636000@mlists.thewrittenword.com> <20100427135823.017417000@mlists.thewrittenword.com> <4BD70C1A.80709@spacetec.no> <20100428084027.GC36271@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 10:58:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O735j-0005IY-Ri
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 10:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab0D1I5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 04:57:52 -0400
Received: from puck.spacetec.no ([192.51.5.29]:43087 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751826Ab0D1I5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 04:57:51 -0400
Received: (qmail 18145 invoked from network); 28 Apr 2010 08:57:48 -0000
Received: from elpis.spacetec.no (tor@192.168.100.35)
  by puck.spacetec.no with ESMTPA; 28 Apr 2010 08:57:48 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
In-Reply-To: <20100428084027.GC36271@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145977>

Gary V. Vaughan wrote:
> On Tue, Apr 27, 2010 at 06:08:58PM +0200, Tor Arntsen wrote:
>> On Tue, Apr 27, 2010 at 15:57, Gary V. Vaughan <git@mlists.thewrittenword.com> wrote:
>>> enum style is inconsistent already, with some enums declared on one
>>> line, some over 3 lines with the enum values all on the middle line,
>>> sometimes with 1 enum value per line... and independently of that the
>>> trailing comma is sometimes present and other times absent, often
>>> mixing with/without trailing comma styles in a single file, and
>>> sometimes in consecutive enum declarations.
>>>
>>> Clearly, omitting the comma is the more portable style, and this patch
>>> changes all enum declarations to use the portable omitted dangling
>>> comma style consistently.
>> The patch is against master. Are we supposed to make patches against
>> master or maint? (I thought I saw the latter somewhere. I'm pretty
>> new in here though..)
> 
> No, the patch is against the latest 7.1.1 stable release (not yet shown
> on the website last time I checked, however):
> 
> 	http://www.kernel.org/pub/software/scm/git/git-1.7.1.tar.bz2

Ok. That would correspond to master from git anyway. I make my patches
against a git checkout, and I was just throwing out the question to
the general audience, for my own knowledge.

[..]
 with -pthread, which won't work for this system.
> 
> Did you apply the whole series of patches?  If so, then it is a bug in
> my pthread.patch if --enable-pthreads=-lpthreads is necessary.  This
> configure line builds successfully on all the architectures I have
> access to (note, pthread support is probed automatically by configure):

No, I only applied and tested the enum patch. I looked through those
patches I mentioned though. Looks fine to me.

[..]
>> 2: The compiler cannot build on AIX 5.1 without the following
>> additional patch (against master. maint has similar problems but
>> files have been moved):
> 
> I maintained a similar patch for our packaging of older git releases
> too, but noticed that it wasn't necessary on our machines anymore...
> perhaps recent compiler patches on our hosts have relaxed the
> requirement for non-C++ comment syntax?

That could be. I have this exact version (5.0.2) because of software
we build for some customers. We need to have exactly the same compilers
(as we provide source as well). There are always certain bugs and issues
with different versions of compilers, so we and the customers figure out
the issues with them and then rigidly stick to a specific version fromthen
on (until we may have to evaluate another version, for different reasons).

> However, I do confirm that this is a problem I have encountered in the
> past.

If you check the Git log for the git repo you'll see that there have
been similar patches in the past, it looks like the C99 comments fixed
in my patch has just managed to sneak by since then.

-Tor

>> From a8989213b4c8baa53c14c1f227b916910265c517 Mon Sep 17 00:00:00 2001
>> From: Tor Arntsen <tor@spacetec.no>
>> Date: Tue, 27 Apr 2010 16:05:12 +0000
>> Subject: [PATCH 2/2] C99 comments changed to old-style C comments
>>
>> Signed-off-by: Tor Arntsen <tor@spacetec.no>
>> ---
>>  builtin/blame.c        |    2 +-
>>  builtin/for-each-ref.c |    4 ++--
>>  remote.c               |    2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> Cheers,
