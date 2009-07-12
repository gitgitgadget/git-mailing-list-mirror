From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Tracking setup improvements: per-remote config,
 autosetuppush
Date: Sun, 12 Jul 2009 14:17:43 -0700
Message-ID: <7vskh1lhxk.fsf@alter.siamese.dyndns.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:17:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ6Qm-0004Ki-8w
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZGLVRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZGLVRt
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:17:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZGLVRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:17:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A867A27D87;
	Sun, 12 Jul 2009 17:17:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F6F727D84; Sun,
 12 Jul 2009 17:17:45 -0400 (EDT)
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org> (Paolo
 Bonzini's message of "Sun\, 12 Jul 2009 14\:17\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7351F518-6F29-11DE-B078-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123159>

I haven't read any of these patches, other than applying them on top of
master and looking at the resulting diff in the t/ directory in the
aggregated form, and also noticing some style deviations in the C code.

The new tests not only check that the commands leave expected results in
the cases where these new variables are set (with or without command line
overrides), but also seem to have checks to see if the commands behave the
same way as before unless the new configuration variables are used.

It is very understandable for any developers (including me) to want to
demonstrate that their shiny new toys work as they specified, and writing
the positive tests (i.e. "does the feature kick in when the user does what
the manual says, and does it leave the expected result?") is a very good
discipline to protect the new features from future breakages.

But at the same time, we (again, including me) tend to forget the
importance about negative tests (e.g. "does the feature refrain from
kicking in when the user does not do what the additional part of the
manual says, iow, uses the traditional way of running the commands, and
does it leave the expected result without the new feature's effect?")
because (1) it is rather boring, and (2) we believe too much in ourselves'
ability not to break things.

So I already am liking the series even before reading a single line of
code.  Makes me hope that the changes are done with the same carefulness
as the tests ;-).
