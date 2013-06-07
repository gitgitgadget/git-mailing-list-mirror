From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 09:11:50 -0700
Message-ID: <7vvc5puchl.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<51AEBAEF.6090402@alum.mit.edu> <vpq61xr8kpl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 18:14:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkzIh-0008EJ-PC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 18:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab3FGQL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 12:11:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553Ab3FGQLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 12:11:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29A1F25D5A;
	Fri,  7 Jun 2013 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mAeLyjRRWKOfXs+X0te9VAGPybM=; b=J3m8YO
	YuzmeXL8ay+mPPpoKZrtnJwe5RvCU4ZeM76G/3Sbxd5TWe+Ws1uQZ8VYVzE8QQgM
	f2HPAx84iKw6hwpzXuvq6UujRwMu4X+bll8+aCeErc/zUdrBN7rjGpc6iT/sI9Gu
	3bZ98bRAbsJ3pwT1xE6CQbtSj7Vhd/C8Byvcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WepXJzTPCTRTC2z4lmnMxlUHiXaKCD0t
	OLVIL18O2EZAUJzR/ep2ElRqIvL4AjpMMDi0h/Em8Xi9QzBIoh2uidl4pDZ90MER
	GVRkULujiEKqgCV7g3jd34h/So6QTqtuE4V5FmayDE93n29eeojCYGxTj97Ig5aC
	Nb+21l8fO5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C2A025D59;
	Fri,  7 Jun 2013 16:11:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F15925D54;
	Fri,  7 Jun 2013 16:11:52 +0000 (UTC)
In-Reply-To: <vpq61xr8kpl.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	06 Jun 2013 14:52:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7331066-CF8C-11E2-994C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226644>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> * Ask the user to build external programs with
>
>   make GIT_ROOT=where/git/lives/
>
> * or, ask users to checkout the external program as a subdirectory of
>   git.git to build it (for example, clang's build installation ask you
>   to put clang as a subdirectory of LLVM's tree).
>
>> But my main point is that I think it would be easier to phase out
>> contrib/ if there were a good alternate way of providing visibility to
>> "satellite" projects. [...] Perhaps ranking
>> the tools based on the results of the Git user surveys would help bring
>> the most popular to the top of each category.
>
> I think this is the most important point. A good example would be
> git-multimail: for now, the shell version in contrib/ is somehow
> considered as the official hook to send emails, just because it is in
> contrib, while git-multimail is clearly superior (unless you don't have
> a python interpreter on your server).

I was envisioning to sift what are in contrib/ into these four
categories:

 (1) Ones that deserve to be Git subcommands;

 (2) Ones that are useful only in the context of using Git
     (e.g. hooks, completion scripts, credential and remote helpers);

 (3) Ones that are no longer useful;

 (4) Ones that primarily _use_ Git, not the other way around
     (i.e. opposite of category (2) which help use of Git).

The first category will live next to git-am.sh (i.e. in the longer
term when we restructure the source tree into src/, lib/, etc.,
candidates for new scripted subcommands move with the scripted
Porcelains).

The second category will be in a separate hierarchy (perhaps
addons/, hooks/, ..., but I am fine if we decide to keep them in
contrib/addons, contrib/hooks, etc.).

The last two categories will be removed; people are welcome to
decide which category between (3) and (4) each piece belongs to, and
pick up to start a standalone third-party project.

The multimail tool can be in the second category.  It helps use of
Git more than it is helped by using Git.

> I'm not opposed to Junio's proposal to restrict contrib/ (although a bit
> reluctant), but I think this should be done with care, at least to give
> potential users a way to chose which tool to use (really, nobody want to
> go use https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
> to pick the right tool. It's a great list, but not a guide).
