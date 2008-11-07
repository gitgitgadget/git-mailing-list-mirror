From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Fri, 07 Nov 2008 15:16:53 -0800
Message-ID: <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
References: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:18:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyaav-0005fG-A2
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYKGXRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbYKGXRF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:17:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYKGXRD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 18:17:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E54DB94218;
	Fri,  7 Nov 2008 18:17:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF2A294217; Fri, 
 7 Nov 2008 18:16:54 -0500 (EST)
In-Reply-To: <20081107220730.GA15942@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 7 Nov 2008 17:07:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F89C2A8-AD22-11DD-B500-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100360>

Jeff King <peff@peff.net> writes:

> The FAQ even says "don't do this until you know what you are doing." So
> the safety valve is configurable, so that those who know what they are
> doing can switch it off.

"We are breaking your existing working setup but you can add a new
configuration to unbreak it" should not be done lightly.  I think as the
end result it is a reasonable thing to aim for for this particular
feature, but we do need a transition plan patch in between that introduces
a step that warns but not forbids.  We can ship 1.6.1 with it and then
switch the default to forbid in 1.6.3, for example.

> Patch 4/4 is the interesting one. 1/4 is a cleanup I saw while fixing
> tests. 2/4 is a cleanup to prepare for 3/4. And 3/4 fixes a bunch of
> tests which were inadvertently doing such a push (but didn't care
> because they didn't look at the working directory).

I wonder if you can use the tests 3/4 touches as the test for your "keep
existing setup" configuration variable, pretending that they are old
timer's repositories?
