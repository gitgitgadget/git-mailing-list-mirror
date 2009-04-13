From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/2] rev-parse: --abbrev-ref option to shorten ref
 name
Date: Mon, 13 Apr 2009 09:43:42 -0700
Message-ID: <7vhc0sh5c1.fsf@gitster.siamese.dyndns.org>
References: <1239618347-17158-1-git-send-email-bert.wesarg@googlemail.com>
 <1239621626-26952-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtPI4-0005rY-99
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZDMQnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbZDMQnt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:43:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZDMQnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 12:43:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A5DC5D804;
	Mon, 13 Apr 2009 12:43:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 06460D7FF; Mon,
 13 Apr 2009 12:43:43 -0400 (EDT)
In-Reply-To: <1239621626-26952-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Mon, 13 Apr 2009 13:20:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 428989BC-284A-11DE-A683-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116449>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> This applies the shorten_unambiguous_ref function to the object name.
> Default mode is controlled by core.warnAmbiguousRefs. Else it is given as
> optional argument to --abbrev-ref={strict|loose}.
>
> This should be faster than 'git for-each-ref --format="%(refname:short)" <ref>'
> for single refs.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> Cc: Jeff King <peff@peff.net>
> Cc: git@vger.kernel.org
>
> Can someone check, if I need to alter the filter, thanks.

I do not think so.

This --abbrev-ref option is similar to --symbolic in that how a ref from
the command line, if any, is output, and should not change the filter at
all.  For example, "rev-parse --abbrev-ref master -M" shouldn't filter -M
out by implying --revs-only.
