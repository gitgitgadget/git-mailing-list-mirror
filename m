From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] SunOS grep does not understand -C<n>
Date: Thu, 23 Jul 2009 23:27:00 -0700
Message-ID: <7vbpnasiiz.fsf@alter.siamese.dyndns.org>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
 <20090724054144.GC6563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 08:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUEG4-0002xa-Cy
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 08:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbZGXG1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 02:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbZGXG1L
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 02:27:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZGXG1K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 02:27:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B11A11CFF;
	Fri, 24 Jul 2009 02:27:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A4A0A11CFE; Fri,
 24 Jul 2009 02:27:03 -0400 (EDT)
In-Reply-To: <20090724054144.GC6563@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 24 Jul 2009 01\:41\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03EC47C8-781B-11DE-BF9A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123905>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 23, 2009 at 10:30:07PM -0700, Junio C Hamano wrote:
>
>> I noticed that the first "grep -C1" test in t7002 does not pass on my 
>> SunOS-5.11-i86pc, and that is not because our way to spawn external
>> grep is broken, but because the native grep does not understand -C<n>.
>> 
>> Is it just me and my installation (i.e. I might have failed to install
>> saner grep from the distribution that everybody uses), or everybody on
>> SunOS is using this option himself because our Makefile doesn't do that
>> automatically for them?
>> 
>> Just in case it is the latter, here is a proposed patch.
>
> Yes, I've been building with NO_EXTERNAL_GREP for my test box. The grep
> from Solaris 8, at least, doesn't understand '-e' either, which causes
> it to fail many other tests.

Thanks.

Just to double check, do we have "grep -e" (not "git grep -e") that makes
Solaris fail?  I didn't notice.  Or do you mean "git grep -e" fails
without NO_EXTERNAL_GREP?
