From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Tue, 24 Mar 2009 02:13:18 -0700
Message-ID: <7vhc1j2si9.fsf@gitster.siamese.dyndns.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
 <20090323144650.GA20058@pvv.org> <7v4oxk6wk2.fsf@gitster.siamese.dyndns.org>
 <7vljqv2t05.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:15:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2iq-0001RG-D3
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbZCXJN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbZCXJN1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:13:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbZCXJN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:13:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67CF6907B;
	Tue, 24 Mar 2009 05:13:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9A13907A; Tue,
 24 Mar 2009 05:13:19 -0400 (EDT)
In-Reply-To: <7vljqv2t05.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 Mar 2009 02:02:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 05F81744-1854-11DE-B6F2-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114437>

Junio C Hamano <gitster@pobox.com> writes:

>   $ git push --dry-run sf.net
>   warning: You did not specify any refspecs to push, and the current remote
>   warning: has not configured any push refspecs. The default action in this
>   warning: case is to push all matching refspecs, that is, all branches
>   warning: that exist both locally and remotely will be updated.  This may
>   warning: not necessarily be what you want to happen.
>   warning:
>   warning: You can specify what action you want to take in this case, and
>   warning: avoid seeing this message again, by configuring 'push.default' to:
>   warning:   'nothing'  : Do not push anythig
>   warning:   'matching' : Push all matching branches (default)
>   warning:   'tracking' : Push the current branch to whatever it is tracking
>   warning:   'current'  : Push the current branch
>   fatal: 'sf.net' does not appear to be a git repository
>   fatal: The remote end hung up unexpectedly
>
> The final, most important error messages are dwarfed out by the warning
> that talks about setting configuration on the remote that does not even
> exist.

Actually, I take it back.  It is still annoying, but the point of these
warning lines is to warn even for a one-off push you make to a place
without having any [remote "sf.net"] entry anywhere in the config.  In the
worst case, the above "sf.net" may even be just a full URL of the remote,
and we do want to trigger the warning.

So this is not even a usability bug.  Sorry for a thinko.
