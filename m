From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #05; Tue, 18)
Date: Thu, 20 Dec 2012 10:13:37 -0800
Message-ID: <7vwqwc617y.fsf@alter.siamese.dyndns.org>
References: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
 <20121220145941.GC27211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlkd5-00054J-9H
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab2LTSNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:13:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab2LTSNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:13:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4FD6951B;
	Thu, 20 Dec 2012 13:13:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hyPBFmfQ7Vd6rngGD/wcDgVbfwU=; b=aBJkG/
	YZXfsrZtlmg8W0FHd1dcWdRikuzWkRtlJS04ymP1eJRSZPWWOtjMj4Y3yLou+C95
	OM4auUjxS3UmrW5LwQ8ymhGLFT4wyLcWeg/lXhm9Nn/sonX9uH3SAVcqIKCePmZG
	fHAfl2YN4fO0wNabDdmUOxNenyB7Ew/X3eeWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vAC87T5X4YKYh7cLqbv3FxykgjmTBJ8D
	B3p2x5ftmpjIojKPC9ruaoeNpxvAOcKhYJe+w+zEv9rCwa3XRKBCvvR6MSys0uTp
	uIpvtDpB7xJVJfsMVsIZ5SpRPoBxtkWjfGtR680u9fFjw3RS3HiaDh0lsdPmc4vy
	utTjg/ZkMyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23A2951A;
	Thu, 20 Dec 2012 13:13:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C7BC9517; Thu, 20 Dec 2012
 13:13:39 -0500 (EST)
In-Reply-To: <20121220145941.GC27211@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Dec 2012 09:59:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA9976BE-4AD0-11E2-89C2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211909>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 18, 2012 at 12:31:43PM -0800, Junio C Hamano wrote:
>
>> * jk/error-const-return (2012-12-15) 2 commits
>>  - silence some -Wuninitialized false positives
>>  - make error()'s constant return value more visible
>> 
>>  Help compilers' flow analysis by making it more explicit that
>>  error() always returns -1, to reduce false "variable used
>>  uninitialized" warnings.
>> 
>>  This is still an RFC.
>
> What's your opinion on this?

Ugly but not too much so, and it would be useful.

The only thing that makes it ugly is that it promises error() will
return -1 and nothing else forever, but at this point in the
evolution of the codebase, I think we are pretty much committed to
it anyway, so I do not think it is a problem.
