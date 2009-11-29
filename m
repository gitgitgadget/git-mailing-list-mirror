From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 11:49:38 -0800
Message-ID: <7v3a3x9kml.fsf@alter.siamese.dyndns.org>
References: <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
 <20091127180235.GA26633@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
 <20091127210530.GC26921@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911291121300.4985@pacific.mpi-cbg.de>
 <20091129183217.GB21520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 20:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEpmP-0007dL-2U
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 20:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbZK2Ttp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 14:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbZK2Ttp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 14:49:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZK2Ttp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 14:49:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2C8FA280F;
	Sun, 29 Nov 2009 14:49:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HT81iu/BVh6TLBFyQZ/GJiBDG28=; b=ezMdwK
	ibLevQ5UYtKU+ir9w3sRWIuU7upjr4sPMmk6EwJs69YjywM4tNRPJIUsBgWzyYfs
	DCGSaxQKC5ReNkx1al2KnQqpVRxxnklhmrxg8XICRBy3ICH1KfZ9FGsHOCXleDyz
	gBA0uVPRoPB3MAzYVHkdd+mw8GDk/ZMkPTads=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rxBq05kdTLnWZEdPDo1JpqAAuB0UxzPB
	1l9vflXGbZWT7CFvynFTYnEMJ5sFkrS277h90hH8EQ7Sl+9qL0QfkM3KtPndDrj9
	kLZJKLILsLYx6WnZiKGU+oUmVHFf/IstIV+lCYbjWEDn/Y1Dm3E4u+1pXRfCNDdv
	fJx4cCEu00Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64DD4A280E;
	Sun, 29 Nov 2009 14:49:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C27FAA2809; Sun, 29 Nov 2009
 14:49:40 -0500 (EST)
In-Reply-To: <20091129183217.GB21520@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 29 Nov 2009 13\:32\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58A6C7CE-DD20-11DE-889D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134035>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 29, 2009 at 11:28:27AM +0100, Johannes Schindelin wrote:
> ...
>> > When the number of "git grep" crash fatalities rises above zero, maybe 
>> > this line of reasoning will be relevant.
>> 
>> Sure.  Let's wait for the first crash fatality, and only react then.  No 
>> need to think ahead.
>
> ... The actual situation
> at hand is a git grep configuration variable. I am weighing the
> preference of people who use git every day and want it to work in a
> certain way against the possibility that somebody helping them will be
> slightly inconvenienced or surprised.

While my position is *not* "hurting people who help is too grave and we
shouldn't even weigh other upsides against it---bad is bad is bad, and it
is absolutely bad" (which is what I think Dscho is saying), I think
"slightly inconvenienced or surprised" is trying to make it sound a lot
lighter than it is.

Imagine you are helping somebody to track down a bug in a project whose
source happens to be under git.  You two scratch your heads together, and
you try to find if the function you are fixing have other call sites, and
you run "git grep" to find them.  You think you covered the whole tree,
identified all the callsites and made sure that the updated behaviour of
the function with your fix is consistent with all of them.  But it turns
out that you didn't check the whole tree, due to user's configuration, and
you didn't notice.

You can easily waste 30 minutes of two people until you realize what
happened.  Because the whole point of your grep.fulltree configuration is
that you can set it once and forget about it, even after you noticed that
your grep didn't look in the whole tree as you expected, the configuration
variable is not the first thing that will come to your mind.  You will
waste more minutes wondering why grep is not working as you expect, until
you finally come up with a suggestion to set the configuration to make
grep look in the full tree by default in her repository.

Put it another way, your "I can set it and forget about it" may be a way
to solve "differentiating two things is a mental burden and I do not want
to think about it".  But I do not think the "mental burden" problem is
necessarily what we want to solve.  The "set and forget" will bring
confusion.

The best solution to the "mental burden" problem may not even be "I can
set it and forget about it".  An obvious solution to that problem, that is
far easier to explain, is not to have two things to begin with, and that is
what we do: "If you want to grep in the whole tree, you go to the top and
run grep there."  Of course, its downside is that it is often cumbersome
to "got to the top" when you are somewhere deep.

That is why I think it would be a lot better solution to spend our efforts
making sure that both semantics can be called for from the command line in
a concise and clear way.  IOW, the problem I see worth solving first is
not the "mental burden" problem, but is "differentiating two things is
necessary, but it is cumbersome to say which one I want."

You probably can add both configuration and concise command line syntax,
but "solving" the "mental burden" problem will make you forget about the
need to use --full-tree option (or its quivalent that will happen in the
solution of the "cumbersome to say which one I want" problem).  On the
other hand, not "solving" the "mental burden" problem will hopefully train
your brain and your fingers to always be aware of and to say which one you
want, to the point that you do not even have to think.

For that to happen, "cumbersome to say which" problem must be solved
nicely, of course.

> ... Something that will happen much
> less frequently than the person actually _using_ git, and something
> which has much smaller negative consequences than people dying.

It is of course not _fatal_, but there are not many things that are fatal.
Saying "that is not fatal so it is Ok" is not particularly a good way to
weigh downsides against upsides.
