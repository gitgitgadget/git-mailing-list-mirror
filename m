From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 16:11:36 -0800
Message-ID: <7viqpzbhvr.fsf@gitster.siamese.dyndns.org>
References: <49382612.3010207@fs.ei.tum.de>
 <7vhc5jeo60.fsf@gitster.siamese.dyndns.org> <49385908.5020202@fs.ei.tum.de>
 <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org> <49386ABE.2050404@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Dec 05 01:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8OJY-0001QN-9M
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 01:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYLEALn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbYLEALn
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 19:11:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYLEALn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 19:11:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AB2A6181FC;
	Thu,  4 Dec 2008 19:11:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 442E6180C5; Thu, 
 4 Dec 2008 19:11:37 -0500 (EST)
In-Reply-To: <49386ABE.2050404@fs.ei.tum.de> (Simon Schubert's message of
 "Fri, 05 Dec 2008 00:41:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4AFFEBD0-C261-11DD-B871-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102379>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> Junio C Hamano wrote:
>> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
>>
>>> You mean not storing/restoring the flags across an invocation?  No,
>>> that's a different thing.  My patch only adds the --directory option,
>>> it does not fix the previously existing bug.
>>
>> The question is if it _introduces_ a bug that the directory given in the
>> initial invocation of "git am --directory=foo" is lost if an patch does
>> not apply and you need to manually resolve and continue.
>>
>> If it does not introduce such a bug, you do not have the same issue as the
>> old patch.  Otherwise you have the same issue as the old patch.  The
>> question was if you have the same issue or you don't.  Yes?  No?
>
> Yes, that's the issue.  In this regard it behaves bug-compatible with
> the -p and -C options.

If that is the case, and assuming that propagating -C/-p would be a good
idea (which I am not sure yet), the patch I sent out earlier (which was
flawed somewhat; it should use "$git_apply_opt_extra" where it invokes the
"git apply" command) with necessary fix would serve as the basis to
implement --directory=<dir>?
