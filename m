From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 02:18:47 +0200
Message-ID: <85644dqoig.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0707181004330.?= =?ISO-8859-1?Q?=04=0427?=
	=?ISO-8859-1?Q?353@woody.linux-?= =?ISO-8859-1?Q?foundation.org>?=
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
	=?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
	<85tzrxslms.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 02:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICPAN-0000GK-Mz
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 02:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbXGVATA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbXGVATA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 20:19:00 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:42041 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753277AbXGVAS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 20:18:59 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 1E7672CB4BC;
	Sun, 22 Jul 2007 02:18:58 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 09177114459;
	Sun, 22 Jul 2007 02:18:58 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id DE85935E5A9;
	Sun, 22 Jul 2007 02:18:57 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 98B511D1E182; Sun, 22 Jul 2007 02:18:48 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 21 Jul 2007 16\:50\:42 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3722/Sun Jul 22 01:57:48 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53200>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 21 Jul 2007, David Kastrup wrote:
>> 
>> tree1:
>>      0?0000 .   -> dir1
>>      100644 a.c -> blob1
>>      040000 a   -> tree2
>>      100644 abc -> blob3
>
> No. Totally broken. That "." entry not only doesn't buy you
> anything, it is *impossible*. You cannot make an object point to
> itself. Not possible.

It does not point to itself.  The name "." points to an entry of type
"dir", no content is involved.  trees in the repository have content,
and _only_ content.  directories in the repository imply existence,
and _only_ existence.

> Tell me how to calculate the SHA1 for the result.

Since "." has no content (as long as we don't decide to track any file
permissions at one point of time), _all_ entries "." will have the
same SHA1.

> Also, tell me what the *point* is. There is none.

The point is to have a reflection of the physical existence of a
directory.  Not just as a manner of accommodating slashes in a flat
filespace, allowing certain slash-related operations to be carried out
efficiently.

>> Linus, a directory is simply non-existent inside of git.
>
> You need to learn git first.
>
> A directory doesn't exist IN THE INDEX (until my patches). But you
> need to learn about the object database and the SHA1's. That's the
> real meat of git, and it sure as hell knows about directories.

I have written up a complete explanation about the underlying concept
in a separate thread, maybe it would make sense reading that before
investing too much time meddling over details that don't fit the large
picture.  The point is that the object database and the SHA1 values
track _trees_, not _directories_.  And a _tree_ is just a hashing
mechanism in the repository for files.  Its existence is solely
dependent on the existence of its contents.  The only synchronization
with directories is that when a tree becomes empty, git attempts to do
an rmdir on the corresponding directory.  And of course, if git needs
to check out a file, it creates the necessary parent directories.

Now since the physical _contents_ of a directory are already tracked
in _trees_ by git, the only missing part is the _existence_ of the
directory itself: a directory must exist as long as there is a tree
(and thus content) connected with it, but the reverse does not hold:
without a tree, the directory can still exist.  Which we can represent
by a repository entry named "." without content (the content is
already catered for by the _tree_).  This must _not_ be represented by
a _tree_ node since there is no content, and a tree without content by
_definition_ does not exist.

I must be really bad at explaining things, or I am losing a fight
against preconceptions fixed beyond my imagination.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
