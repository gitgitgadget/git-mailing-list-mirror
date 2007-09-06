From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 06 Sep 2007 07:55:14 +0200
Message-ID: <85veaofid9.fsf@lola.goethe.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
	<7v1wdciy3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAKn-0007Df-Nh
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbXIFFzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbXIFFzR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:55:17 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:32844 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753334AbXIFFzP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 01:55:15 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id B8367302985;
	Thu,  6 Sep 2007 07:55:14 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id A953E212FB7;
	Thu,  6 Sep 2007 07:55:14 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 7E2D236E868;
	Thu,  6 Sep 2007 07:55:14 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 263451CAD71B; Thu,  6 Sep 2007 07:55:14 +0200 (CEST)
In-Reply-To: <7v1wdciy3w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 05 Sep 2007 14\:46\:59 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57823>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>>> This patch does not add invocation of the "auto repacking".  It
>>> is left to key Porcelain commands that could produce tons of
>>> loose objects to add a call to "git gc --auto" after they are
>>> done their work.  Obvious candidates are:
>>> 
>>> 	git add
>>
>> Nope!  'git add' creates loose objects which are not yet reachable from 
>> anywhere.  They won't get repacked until a commit is made.
>
> Bzzt, I am releaved to see you are sometimes wrong ;-)
>
> They are reachable from the index and are not subject to
> pruning.

Hm.  Isn't it possible to work with several index files at once?  I
seem to remember that even git-add does this itself.  So what is it
that protects objects in such a temporary index from being garbage
collected by a different git process running on the same repository?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
