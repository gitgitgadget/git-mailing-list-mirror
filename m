From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for  git clone
Date: Wed, 13 May 2009 23:35:29 -0700
Message-ID: <7v8wl0xkcu.fsf@alter.siamese.dyndns.org>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	<200905121557.18542.Hugo.Mildenberger@namir.de>
	<81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	<200905121900.00625.Hugo.Mildenberger@namir.de>
	<81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	<20090512172452.GA32594@blimp.localdomain>
	<20090513180853.GB26288@blimp.localdomain>
	<20090513205333.GA21631@blimp.localdomain>
	<7vfxf81ppd.fsf@alter.siamese.dyndns.org>
	<81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UXc-000131-5x
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760397AbZENGfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760857AbZENGfa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:35:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43173 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbZENGf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:35:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514063529.VYR17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 May 2009 02:35:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id rJbV1b0074aMwMQ03JbVBW; Thu, 14 May 2009 02:35:29 -0400
X-Authority-Analysis: v=1.0 c=1 a=uSRkTckIU-MA:10 a=csnF2-1mRMQA:10
 a=pGLkceISAAAA:8 a=Zg5buz5CgJwnP-EqSw0A:9 a=3DhIJwVEIZSTU0kYceL6CRnpChgA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com> (Alex Riesen's message of "Thu\, 14 May 2009 07\:54\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119152>

Alex Riesen <raa.lkml@gmail.com> writes:

>> What's the point of this change, now that you have a fix in 1/2?  Who are
>> you helping with this patch?
>
> Without this the _automatically_ generated names for cloned repositories
> have all the whitespace around them.

Even if it has whitespace around its name, that's what you got from the
upstream (a valid source of clone), and wasn't it you who said something
about UNIX tradition of allowing LF and others in the filename?

If clone reports "ok we created this new repository" so that the caller
can capture it, then the whole process should be able to cope with
automatically generated names with or without the patch, shouldn't it?

Or are you trying to help a human user who gives a pathname ridden with
excess whitespaces to "git clone", and that pathname _happens_ to work as
a valid clone source, creating a new repository whose name is ridden with
excess whitespaces the same way as the input pathname?  After all, the
user deliberately gave them to us, and the repository we cloned from had
these excesses in its name (iow, without the excess whitespaces the clone
itself wouldn't have worked).  In such a case, is it really helping him to
remove these whitespaces as excesses?

I do not understand the point of this patch and that is why I asked who
you are trying to help.
