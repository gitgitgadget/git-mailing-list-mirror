From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across
 --continue
Date: Mon, 26 Jan 2009 12:47:26 -0800
Message-ID: <7viqo14wwx.fsf@gitster.siamese.dyndns.org>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
 <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYRZ-0000E5-Qk
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZAZUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbZAZUvF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:51:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbZAZUvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:51:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 812B21CC94;
	Mon, 26 Jan 2009 15:51:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 625A51D626; Mon,
 26 Jan 2009 15:47:28 -0500 (EST)
In-Reply-To: <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Mon, 26 Jan 2009 10:05:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AEB3FAA-EBEB-11DD-9EFA-7C9C113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107272>

Thomas Rast <trast@student.ethz.ch> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> d911d14 (rebase -i: learn to rebase root commit, 2009-01-02) tried to
> remember the --root flag across a merge conflict in a broken way.
> Introduce a flag file $DOTEST/rebase-root to fix and clarify.
>
> While at it, also make sure $UPSTREAM is always initialized to guard
> against existing values in the environment.
>
> [tr: added tests]
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Junio C Hamano wrote:
>> Since you never use the value stored in "$DOTEST/upstream" for anything
>> else anyway, how about doing something like this instead?  It would make
>> the meaning of the file used as a state variable much clearer.
>
> Yes, thanks, a patch precisely "like this" is in fact the right fix.
>
> I came up with some tests that try a conflicted --root rebase of each
> flavour, to guard against the problem in the future.  I wasn't
> entirely sure how to shape this into a patch, but here's a version
> that forges patch message and sign-off in your name.
>
> Dscho, with that confusion cleared, you can add my Ack to your 1/2
> (unchanged, though I'm afraid you'll get a textual conflict).

Ok, so I'll queue this to 'master' as a bugfix.

Thanks.
