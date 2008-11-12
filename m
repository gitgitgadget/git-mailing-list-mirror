From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 11:29:35 -0800
Message-ID: <7vljvooi8w.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029171122.GA12167@sigill.intra.peff.net>
 <20081102123519.GA21251@atjola.homenet>
 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
 <20081103071420.GD10772@coredump.intra.peff.net>
 <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
 <20081112083353.GB3817@coredump.intra.peff.net>
 <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
 <20081112110629.GA20473@coredump.intra.peff.net>
 <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
 <20081112191512.GA21401@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LR4-0006GG-HG
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYKLTaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYKLTaP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:30:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYKLTaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:30:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 679E41687C;
	Wed, 12 Nov 2008 14:30:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1968116877; Wed, 12 Nov 2008 14:29:39 -0500 (EST)
In-Reply-To: <20081112191512.GA21401@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Nov 2008 14:15:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 531E237C-B0F0-11DD-B33B-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100807>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 12, 2008 at 10:39:21AM -0500, Avery Pennarun wrote:
>
>> > I thought about that at first, too, but the working tree is even more
>> > painful. You would have to hash every changed file on the filesystem to
>> > create the tree object.
>> 
>> Is that so bad?  You have to read all those files anyway in order to
>> do a diff.
>
> I don't know for sure, as I haven't tried it. But you would need to read
> them twice (once to hash, and then once to diff) plus the extra
> computation time of hashing. So assuming you have a decent cache, you
> pay the disk access only once.
>
> Maybe it would be negligible, but I would have to see numbers to be
> convinced either way.

I think you guys are barking up a wrong tree.

The staged state, the work tree state and the committed states are three
conceptually different things.  Making them stand out as distinct entities
at the UI level is a _good thing_.

Introducing STAGED or WORKTREE psuedonym to deliberately muddy the
distinction goes against helping the users form a clear vision of what
s/he is working on at the conceptual level.
