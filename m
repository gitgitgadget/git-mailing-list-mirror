From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Wed, 05 Sep 2007 21:01:46 +0200
Message-ID: <85abs1hr6t.fsf@lola.goethe.zz>
References: <46DACD93.9000509@trolltech.com>
	<200709022228.00733.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.64.0709022133190.28586@racer.site>
	<200709022342.42733.robin.rosenberg.lists@dewire.com>
	<46DBB2BE.8030505@eudaptics.com>
	<20070903112110.GE14853@genesis.frugalware.org>
	<86y7fohtmw.fsf@lola.quinscape.zz>
	<20070905160206.GY14853@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:02:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT08U-0007Kz-O7
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbXIETBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbXIETBx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:01:53 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:47807 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754295AbXIETBw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 15:01:52 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 0FC12302E3D;
	Wed,  5 Sep 2007 21:01:51 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id F07C223D342;
	Wed,  5 Sep 2007 21:01:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-072-218.pools.arcor-ip.net [84.61.72.218])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id AEA2219B326;
	Wed,  5 Sep 2007 21:01:46 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 369921CAD71B; Wed,  5 Sep 2007 21:01:46 +0200 (CEST)
In-Reply-To: <20070905160206.GY14853@genesis.frugalware.org> (Miklos Vajna's message of "Wed\, 5 Sep 2007 18\:02\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4166/Wed Sep  5 17:20:22 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57740>


[Vista and symbolic links]

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Mon, Sep 03, 2007 at 01:32:07PM +0200, David Kastrup <dak@gnu.org> wrote:
>> >> And if I understand the documentation correctly, then
>> >
>> >> $ mkdir foo && cd foo
>> >> $ cat ../x
>> >> x: No such file or directory
>> >
>> > correct.
>> 
>> Have you tested this, or is this from reading the documentation?
>
> umm, thanks for the notice, i was wrong:
>
> ----
> $ cat ../x
> this is makefile
> ----
>
> the situation what triggers the 'no such file' problem is:
>
> ----
> $ touch foo/Makefile
> $ mkdir bar
> $ ln -s foo/Makefile bar
> $ cd bar
> $ cat Makefile
> cat: Makefile: No such file or directory
> ----

This is under Vista?  It would be the same under Unix.  A good rule of
thumb is to create relative symbolic links _only_ when the current
work directory is identical with the target directory (and make it so
if it isn't).  Alternatively, when one is completely awake and in full
possession of all one's mental facilities.  The state that every geek
is in 90% of the time according to his own perception, and 9% of the
time according to the computer.

If you tested this on Vista, chances are that they only bungled the
documentation in this case (and of course, needing sysadmin privileges
for this would be just silly).  Not without precedence.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
