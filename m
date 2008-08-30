From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gui: show diffs with a minimum of 1 context line
Date: Sat, 30 Aug 2008 10:30:51 -0700
Message-ID: <7vljyeif5g.fsf@gitster.siamese.dyndns.org>
References: <20080830164527.GA25370@localhost>
 <7vtzd2ifot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUJ1-0000Fh-7e
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbYH3RbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbYH3RbD
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:31:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbYH3RbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:31:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E1D9F67A3C;
	Sat, 30 Aug 2008 13:30:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F02967A37; Sat, 30 Aug 2008 13:30:53 -0400 (EDT)
In-Reply-To: <7vtzd2ifot.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 30 Aug 2008 10:19:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68BBE8B6-76B9-11DD-8EE7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94393>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect there are some things "git-apply" should be able to _figure out_

s/able to/& do to/;

> that the user is giving it a -U0 patch and automatically flip unidiff_zero
> option on.  For example, if the _first_ hunk of a patch does not begin
> with "@@ -0,0 +N,M @@" nor with "@@ -1,L +N,M @@" (i.e. the hunk claims to
> apply not at the beginning) and the hunk does not have leading context
> lines, _and_ if that first hunk does not have trailing context lines, then

Eh, what was I smoking.  In short, if the first hunk does not have _any_
context lines and still says it is intended to apply to somewhere not at
the beginning, then that is a -U0 patch.
