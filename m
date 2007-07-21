From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 20:08:32 +0200
Message-ID: <85lkd9sk7z.fsf@lola.goethe.zz>
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
	<85tzrxslms.fsf@lola.goethe.zz> <46A247C1.4000902@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 20:08:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICJNs-0005dR-6l
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 20:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXGUSIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 14:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbXGUSIi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 14:08:38 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:41218 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbXGUSIh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 14:08:37 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id EB61D1838D5;
	Sat, 21 Jul 2007 20:08:35 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id D32AA2C6A03;
	Sat, 21 Jul 2007 20:08:35 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id B0BE53425E2;
	Sat, 21 Jul 2007 20:08:35 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 59EF91CE0427; Sat, 21 Jul 2007 20:08:32 +0200 (CEST)
In-Reply-To: <46A247C1.4000902@fs.ei.tum.de> (Simon Schubert's message of "Sat\, 21 Jul 2007 19\:52\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3715/Sat Jul 21 14:39:12 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53178>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> David Kastrup wrote:
>> But I also want to have directories represented within git, because
>> not doing so leads to awkward problems.  And the proper way as I see
>> it is _not_ to mess with trees and stick them with "stay when empty"
>> flags or similar.  This messes up the whole elegance of git's flat
>> name space.  The proper way is to create a distinct object that
>> represents a physical directory.  We don't need to represent the
>> contents of it: those are already tracked in the flat namespace fine,
>> with trees serving as an implementation detail.
>>
>> All we need to represent is ".".
>
> What I still don't get is: How do you carry this information about
> "this directory should not be removed" from one checkout to the next
> commit?

I don't.  The only information in the file system is whether a
directory exists or not.  "Should not removed" is not a property that
is tracked.

> When creating a .gitignore, this file exists in the workdir.  Of
> course you add some data to the index to stage it.  But how does
> this work with your "." "file"?  You can't put that in the
> filesystem.

Either the directory is in the file system or it is not.  Like with
every other file.  And either git tracks the directory, in which case
it will notice its addition (when doing git-add) and removal (when
doing git-rm or git-commit -a) or git doesn't track the directory.

When git tracks the directory (a matter of gitignore settings for
implicit tracking, and git-add for explicit tracking), and considers
it existent, it will not touch it.  If it tracks it but considers it
removed in particular commit, it will attempt to remove it.

    Fineprint: actually, things are more involved here: git does not
    actually attempt to remove directories at the time it deletes them
    from the tree: this is sort of pointless since the sort order
    means that there might still be files it needs to take out from
    the physical directory).  Instead, like before, git attempts to
    remove a physical directory whenever the corresponding tree in git
    becomes empty, and it is a prerequisite to delete a possibly
    tracked directory from it.

After it has attempted to remove it, it will leave it alone since it
is now no longer tracking it.  If you add and remove a contained file,
it will again try to remove the directory.  If you add _both_
directory and a contained file, just removing the contained file will
not make git attempt to delete the directory.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
