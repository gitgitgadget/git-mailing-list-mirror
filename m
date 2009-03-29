From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag 
 variants
Date: Sun, 29 Mar 2009 14:32:11 -0700
Message-ID: <7vwsa8ow10.fsf@gitster.siamese.dyndns.org>
References: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
 <40aa078e0903291305p28ec2ae8xf0cb465e593af0b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 23:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo2di-0003w5-1w
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 23:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZC2VcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZC2VcX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 17:32:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032AbZC2VcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 17:32:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 43A4FA864;
	Sun, 29 Mar 2009 17:32:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 817B0A860; Sun,
 29 Mar 2009 17:32:13 -0400 (EDT)
In-Reply-To: <40aa078e0903291305p28ec2ae8xf0cb465e593af0b0@mail.gmail.com>
 (Erik Faye-Lund's message of "Sun, 29 Mar 2009 22:05:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1442D66E-1CA9-11DE-8CCA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115038>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> OK, I see now that the previous patch-series has been merged to "pu".
> Is there a reason why this updated patch-series hasn't superseded it?

Even if the tested program crashes, it is Ok to test them inside
expect_failure, so I'd suggest not commenting the first two out.

But running the tests with the first patch applied to the same base as
where v1 was applied gives this, which is a more serious issue:

    $ sh t9301-fast-export.sh 2>&1 | tail -n 2
    * still have 4 known breakage(s)
    * failed 6 among remaining 15 test(s)

In other words, the changes to the set-up part seem to break unrelated
tests.  Why can such an update supersede the previous one?
