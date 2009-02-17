From: Junio C Hamano <gitster@pobox.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 16:57:55 -0800
Message-ID: <7veixxev70.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <20090215232013.GA11543@zakalwe.fi>
 <20090216000443.GB3503@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
 <loom.20090216T101457-231@post.gmane.org>
 <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com>
 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com>
 <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
 <4999FFCE.3060605@gmail.com>
 <alpine.DEB.1.00.0902170112580.10279@pacific.mpi-cbg.de>
 <499A07C4.5000908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEJE-0000gK-6e
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZBQA6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbZBQA6H
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:58:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbZBQA6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:58:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96B87987FE;
	Mon, 16 Feb 2009 19:58:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E394F987F7; Mon,
 16 Feb 2009 19:57:56 -0500 (EST)
In-Reply-To: <499A07C4.5000908@gmail.com> (Sergio Callegari's message of
 "Tue, 17 Feb 2009 01:41:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 071DDB4A-FC8E-11DD-A1F0-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110284>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> Johannes Schindelin wrote:
>> Of course, you can go on and on and on with the detached HEAD ide,
>> but so far you haven't convinced me that this is a sensible thing to
>> do.
>>
> I will not... it's time to sleep where I am! And I am just a user of
> git and you are a developer, which makes me think that you might know
> much better.
> But the exchange was insightful, thanks.
>
> Rather, I'll turn again the question...
>
> Let us assume that I am working on branch B and that my worktree is
> based on commit XYZ. Let's also assume that someone pushes behind my
> shoulders and moves the tip of B (or even deletes B alltogether)
> either in one or in multiple pushes.  Is there an easy way so that I
> can now find out at what commit (XYZ) I was before the push(es)?

I am afraind that you are going on-and-on-and-on Dscho warned you about.

What commit XYZ your next commit should build on is already recorded by
HEAD (which in turn often refers to the tip of the branch you have checked
out by pointing at it).

HEAD (and the tip of the branch) is *supposed* to be updated by operations
you do from the work tree *alone*, not by push from sideways.  Therefore
there is no such duplicated information kept.

The index is an obvious place to save that duplicated information if you
really wanted to, and you are welcome to try it again, but I have to warn
you that we have already tried this once and the fallout was not very
pretty.
