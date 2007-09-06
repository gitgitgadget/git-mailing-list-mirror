From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase from ambiguous ref discards changes
Date: Thu, 06 Sep 2007 16:26:52 -0700
Message-ID: <7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
References: <1189115308.30308.9.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQka-0004Np-Q5
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbXIFX07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 19:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXIFX07
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:26:59 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592AbXIFX07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:26:59 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 003F012FC36;
	Thu,  6 Sep 2007 19:27:15 -0400 (EDT)
In-Reply-To: <1189115308.30308.9.camel@koto.keithp.com> (Keith Packard's
	message of "Thu, 06 Sep 2007 14:48:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57946>

Keith Packard <keithp@keithp.com> writes:

> So, I started with a very simple repository
>
> ---*--- master
>     \
>      -- origin/master
>
> From master, I did
>
> $ git-rebase origin/master
> warning: refname 'master' is ambiguous.
> First, rewinding head to replay your work on top of it...
> HEAD is now at 2a8592f... Fix G33 GTT stolen mem range
> Fast-forwarded master to origin/master.
> ...
> Seems like there's something going on when 'master' is ambiguous, or
> perhaps some other problem.
>
> This is all from version 1.5.3, but I think I've seen this on 1.5.2 as
> well.

We haven't touched this area for a long time (like "v1.3.0" or
"since March 2006").  I wish you told us about this earlier.

I'd like to reproduce this, but I need to be sure what your
"ambiguous" situation is really like.  What ambiguous "master"s
do you have?  IOW, what does:

	git show-ref | grep master

say?  I have 11 lines of output from the above and I have never
seen a problem like this.

Perhaps you have ".git/master" by mistake?
