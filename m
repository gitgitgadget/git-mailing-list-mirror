From: Junio C Hamano <gitster@pobox.com>
Subject: Re: epic fsck SIGSEGV!
Date: Wed, 10 Dec 2008 23:53:56 -0800
Message-ID: <7vy6yntaej.fsf@gitster.siamese.dyndns.org>
References: <1228867861.14165.19.camel@starfruit.local>
 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
 <1228949523.27061.20.camel@starfruit.local>
 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home>
 <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 08:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAgRI-00078C-6B
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 08:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbYLKHyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 02:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbYLKHyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 02:54:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYLKHyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 02:54:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B2A718924;
	Thu, 11 Dec 2008 02:54:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 434A3188F4; Thu,
 11 Dec 2008 02:53:57 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 10 Dec 2008 19:44:37 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E1FED6E4-C758-11DD-A79B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102786>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It has gotten no real testing. Caveat emptor. And I didn't even bother to 
> check that it can run with less stack or that it makes any other 
> difference.

A quick "git fsck --full" in a copy of git.git (eh, "not-so-quick" on a
not-so-quick machine, obviously) shows that the patch does reduce minor
faults significantly.

(without patch)
83.03user 0.60system 1:23.62elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+158275minor)pagefaults 0swaps

(with object_array patch)
82.88user 0.40system 1:23.28elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+95397minor)pagefaults 0swaps
