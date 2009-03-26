From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Documentation: rename docbook-xsl-172 attribute to
 git-asciidoc-no-roff
Date: Thu, 26 Mar 2009 09:47:53 -0700
Message-ID: <7vocvop6x2.fsf@gitster.siamese.dyndns.org>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
 <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com>
 <20090324090440.GC1799@coredump.intra.peff.net>
 <B70DE0F1-8CDA-46FC-9EF8-41B0FAC39631@pobox.com>
 <20090326094322.GB14292@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmsmX-0002Gl-Pj
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758961AbZCZQsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbZCZQsE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:48:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945AbZCZQsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 12:48:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6447691F1;
	Thu, 26 Mar 2009 12:47:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 90BBF91EC; Thu,
 26 Mar 2009 12:47:55 -0400 (EDT)
In-Reply-To: <20090326094322.GB14292@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 26 Mar 2009 05:43:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD253CE2-1A25-11DE-9C48-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114799>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 24, 2009 at 02:48:52PM -0500, Chris Johnsen wrote:
>
>> I am not opposed to providing more version-specific controls, but I am not 
>> sure which versions are important enough to justify their own variables. 
>> Are you indicating that 1.73 is important enough because it was a "return 
>> to sanity" after 1.72?
>
> No, mainly because it is what is shipped in the last version of Debian,
> which means it is a major enough version that there will be a lot of
> people using it.
>
> But let's just start with adding the tweakable knobs (which your series
> is already doing), and see in what ways they need to be tweaked for
> popular platforms before going overboard.

When I was trying out the series yesterday, I was wondering if this is
something we can autodetect.

Output from "asciidoc --version" is easily machine parsable for giving
asciidoc7compatible aka ASCIIDOC8, but I couldn't come up with anything
simpler than probing a few hardcoded paths under /usr/share/sgml; that
approach is unacceptable because would not work if your stylesheets are in
somewhere we do not know about.  Ideally, we should be able to ask the
tools we invoke (e.g. xmlto) to get that information.
