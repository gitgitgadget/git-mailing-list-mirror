From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve on the 'invalid object' error message at commit
 time
Date: Tue, 14 Jul 2009 12:43:10 -0700
Message-ID: <7vab37giep.fsf@alter.siamese.dyndns.org>
References: <1247577632053-3255106.post@n2.nabble.com>
 <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
 <alpine.LFD.2.01.0907141119190.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Florian Breitwieser <florian.bw@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 21:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQnuQ-0005Mb-JD
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 21:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166AbZGNTnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbZGNTnT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 15:43:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbZGNTnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 15:43:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC77C6259;
	Tue, 14 Jul 2009 15:43:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09FD16258; Tue, 14 Jul 2009
 15:43:11 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907141119190.13838@localhost.localdomain>
 (Linus Torvalds's message of "Tue\, 14 Jul 2009 11\:25\:17 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9400D92E-70AE-11DE-93AA-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123269>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... one thing that I 
> started wondering about was whether the problem Florian saw was about one 
> of the files he had done "git add" on, or whether it was a tree entry that 
> was the result of "find_subtree()".

Same here.

Historically, cache-tree had issues that same corner case codepaths forgot
invalidating subtrees when they should that could have led to kinds of
bugs that are hard to diagnose.  I think the API got harder to make that
kind of mistakes while we squashed those bugs, though.
