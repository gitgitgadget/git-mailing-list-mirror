From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tags "problem"
Date: Fri, 14 Sep 2007 14:14:27 -0700
Message-ID: <7vfy1h9cgc.fsf@gitster.siamese.dyndns.org>
References: <46EAE189.5000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWIUs-00074j-W8
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 23:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbXINVOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 17:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757133AbXINVOg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 17:14:36 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbXINVOg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 17:14:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E390135004;
	Fri, 14 Sep 2007 17:14:51 -0400 (EDT)
In-Reply-To: <46EAE189.5000804@gmail.com> (Rene Herman's message of "Fri, 14
	Sep 2007 21:31:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58184>

Rene Herman <rene.herman@gmail.com> writes:

> Hi people.
>
> (please keep me in CC)
>
> Was just busy constructing a tree and noticed a "problem" -- no doubt
> caused by me, but help appreciated.
>
> I clone linus' kernel tree into ./local, then do a
>
> 	git checkout -b v22 v2.6.22
>
> to get a 2.6.22 branch. I like to have a simple "git pull" while on
> this branch pull from the upstream stable tree, so as advised earlier,
> I put:
>
> [branch "v22"]
>         remote = linux-2.6.22.y
>         merge = refs/heads/master
> [remote "linux-2.6.22.y"]
>         url =
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y.git
>         fetch = refs/heads/master
>
> in ./git/config. "git pull" now indeed works nicely.

Perhaps more canonical would be to make the latter fetch as:

	fetch = refs/heads/*:refs/remotes/linux-2.6.22.y/*

> I just noticed now though that this doesn't automatiically fetches
> tags as well.

I suspect that fetch without remote tracking does not auto-fetch
the tags.
