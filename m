From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and
 error-handling in send_message's sendmail code
Date: Sun, 19 Apr 2009 18:58:57 -0700
Message-ID: <7vfxg4nl0e.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <7vljpwp0jr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 04:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvioJ-0003UM-NA
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 04:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbZDTB7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 21:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZDTB7E
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 21:59:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZDTB7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 21:59:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FF1010F17;
	Sun, 19 Apr 2009 21:59:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CDD4410F16; Sun,
 19 Apr 2009 21:58:58 -0400 (EDT)
In-Reply-To: <7vljpwp0jr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 19 Apr 2009 18:38:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1A2FF26-2D4E-11DE-9B6B-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116925>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> +
>> +		(my $pid = open my $pipe, '|-')
>> +			// die "Could not fork to run '$smtp_server': $!\n";
>
> Have I already rejected this "5.10 or later" construct in the previous
> round?  If I haven't, please consider now I have.

Sorry, I should have checked myself.  defined-or "//" is 5.8.1 or later.

Now the real question was if we still support anything older, and if so
what is the bottom version?

I certainly can go with "5.8.1 or later", but I vaguely recall during the
gitweb discussion we said anything without the utf-8 support is unusable
for gitweb, but I think we also said that the rest of the git codebase
should support running with something older (5.6.1, perhaps).

Anybody?
