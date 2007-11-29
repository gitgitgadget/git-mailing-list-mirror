From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 29 Nov 2007 14:46:33 -0800
Message-ID: <7v1wa8vfee.fsf@gitster.siamese.dyndns.org>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
	<7vabp79hjt.fsf@gitster.siamese.dyndns.org>
	<C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
	<7vd4u28z90.fsf@gitster.siamese.dyndns.org>
	<7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de>
	<Pine.LNX.4.64.0711221120300.27959@racer.site>
	<20071128221559.GC22395@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 23:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixs9u-0000ic-7u
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 23:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021AbXK2Wqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbXK2Wqn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 17:46:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53975 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853AbXK2Wqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 17:46:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D44242F0;
	Thu, 29 Nov 2007 17:47:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3712D9B2A7;
	Thu, 29 Nov 2007 17:46:57 -0500 (EST)
In-Reply-To: <20071128221559.GC22395@denkbrett.schottelius.org>
	(nico-linux-git@schottelius.org's message of "Wed, 28 Nov 2007
	23:15:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66568>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:

> ...
> [branch "otherbranch"]
>    merge = otherremote
>    push = otherremote
>    push = classmate
>    push = myremote
> --------------------------------------------------------------------------------
>
> What do you think about that approach?

Huh?

Is this a reinjection of an ancient message by some gateway?

You were already told branch.$name.merge has a defined meaning and
syntax, and you cannot make it refer to a remote shorthand without
breaking an existing setup.

Also if you want to have more than one destination repository for a
single push, I think that is already supported with remote.$name.url.

IIRC, there was a suggestion to enhance remote.$name configuration in
this way instead, so that you can use different URL for fetching and
pushing:

	[branch "foo"]
        remote = "there"
        merge = refs/heads/master

	[remote "there"]
        url = git://git.there.xz/repo.git
        push_url = git.there.xz:repo.git
        push_url = git.there.xz:backup.git
	fetch = refs/heads/*:refs/remotes/there/*

I further vaguely recall that the comments on the alternative were
positive (it might have been you who responded, or somebody else, I do
not remember).
