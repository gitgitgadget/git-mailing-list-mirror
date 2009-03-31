From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 13:26:01 -0700
Message-ID: <7vy6ul4exy.fsf@gitster.siamese.dyndns.org>
References: <20090331112637.GA1910@coredump.intra.peff.net>
 <7vvdpp6623.fsf@gitster.siamese.dyndns.org>
 <20090331160842.GA9019@coredump.intra.peff.net>
 <7veiwd61k1.fsf@gitster.siamese.dyndns.org>
 <20090331184604.GA10701@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:27:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokYf-00008z-9J
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZCaU0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZCaU0L
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:26:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbZCaU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:26:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D237A6AFA;
	Tue, 31 Mar 2009 16:26:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2ABB2A6AF6; Tue,
 31 Mar 2009 16:26:02 -0400 (EDT)
In-Reply-To: <20090331184604.GA10701@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 31 Mar 2009 14:46:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A3D9762-1E32-11DE-B661-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115310>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 31, 2009 at 10:32:14AM -0700, Junio C Hamano wrote:
>
>> My point was if I belong only to my personal group and git.git work tree
>> is owned by junio.junio to begin with, you would never be able to notice
>> any breakage with such a test.
>
> Ah, I see. Yes, you would need to belong to at least two groups to make
> such a test feasible.
>
> Such a requirement is generally outside the scope of running the
> test suite; do you want to just ditch the g+s test, then, or do you want
> me to work up something conditional based on the Makefile flag?

For now, I'd suggest teaching the test not to care about g+s bit.
After all, they are about giving correct mode bits to files and
directories.  Correct mode bits for group do not mean anything if you make
them owned by a wrong group, but that is not something we have tested so
far, and can be a separate test anyway.
