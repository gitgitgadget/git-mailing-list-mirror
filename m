From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 09 Sep 2008 13:42:52 -0700
Message-ID: <7vljy159v7.fsf@gitster.siamese.dyndns.org>
References: <20080909132212.GA25476@cuci.nl>
 <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl>
 <20080909195930.GA2785@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:44:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdA4P-0002BP-TJ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYIIUnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYIIUnF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:43:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYIIUnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:43:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C7D7C5A3D2;
	Tue,  9 Sep 2008 16:43:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EE63B5A3CF; Tue,  9 Sep 2008 16:42:55 -0400 (EDT)
In-Reply-To: <20080909195930.GA2785@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 9 Sep 2008 15:59:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E50B06F6-7EAF-11DD-A07B-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95426>

Jeff King <peff@peff.net> writes:

> And yes, you can get _too_ general to the point where your semantics
> become meaningless. But I don't think that is the case here. You are
> defining the origin field as "by the way, the difference between state X
> and state Y was used to make this commit". cherry-pick just happens to
> make Y=X^, but something like rebase could use a series.
>
> As for "git vs changeset": this is git. So you have a sequence of tree
> states whether that is what you want or not. Thus you are specifying
> the difference between _some_ pair of commits. I don't see any benefit
> to restricting it to a commit and one of its parents.

As for "by the way ... was used to make this commit": this is git.  So how
you arrived at the tree state you record in a commit *does not matter*.

Not only that, it is not just "the difference between state X and Y" that
you used to come to that tree.  Another thing that is involved is the
specific cherry-pick implementation back when the commit was made.  That
was what gave you the tree.

To my ears, it rhymes rather well with a famous quote from $gmane/217:

    You're freezing your (crappy) algorithm at tree creation time, and
    basically making it pointless to ever create something better later,
    because even if hardware and software improves, you've codified that
    "we have to have crappy information".

After reading the discussion so far, I am still not convinced if this is a
good idea, nor this time around it is that much different from what the
previous "prior" link discussion tried to do.
