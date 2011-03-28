From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: fix overeager scrubbing of environment variables
Date: Mon, 28 Mar 2011 10:00:45 -0700
Message-ID: <7v4o6n18oy.fsf@alter.siamese.dyndns.org>
References: <4D8FAAAC.3050905@web.de> <20110327213756.GD25927@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:01:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4FoM-0003IA-Sk
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab1C1RA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 13:00:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809Ab1C1RA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:00:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 921AA43F1;
	Mon, 28 Mar 2011 13:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJ7ZOjGnzSCFPYla/RUvNBbiG/c=; b=aNVie3
	iv8NWe/tIOFTCoYv0ErNl6hcbmhLluiPQGj5bc48Azuvz0GUdxielqsJUVZJXTtF
	yCKlfoAWnPTviamZciPz49cvFrPwkRyZexfEgSj0uqthiAy+BEIfMvMrPvG2iAwB
	6hq7tUmMsg7jE+xEVPXxXQ+wZOtiwMgNjzPcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q8Q/PqzxSmUhuWTaY41giILAXtrnseEK
	qau+C24LJJZiJbBYpr5qc5gMPbnrk+kj1Po6nyO5VDKZkHx8vm6VaWK+wCIL7uRd
	cfksvVN3Ln14ZgE0u0rjKA0LkIvp0yXdQsCpeq8DryZnHdpVfES0r7j1EK40EFKY
	N5VmFkcAiRg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EE0C43EF;
	Mon, 28 Mar 2011 13:02:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F18E43EE; Mon, 28 Mar 2011
 13:02:33 -0400 (EDT)
In-Reply-To: <20110327213756.GD25927@elie> (Jonathan Nieder's message of
 "Sun, 27 Mar 2011 16:37:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F66735E-595D-11E0-91CB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170158>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jens Lehmann wrote:
>
>> - GIT_SKIP_TESTS
>> - GIT_TEST*
>> - GIT_PROVE_OPTS
>>
>> Let's fix that by adding them to the exception list.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> It misses a few, though:
>
>  - GIT_REMOTE_SVN_TEST_BIG_FILES
>  - GIT_NOTES_TIMING_TESTS
>  - GIT_PATCHID_TIMING_TESTS
>  - GIT_VALGRIND_OPTIONS
>
> If we were starting over I suppose those would all be GIT_TEST* but
> there's something to be said for muscle memory.

I don't think muscle memory matters as much in this case as the usual
end-user facing interfaces.  These are only for people who build and test
git, not for our end users.

I think it is Ok to do this (yes I am trying to avoid doing this myself,
as I am a bit behind and also am lazy) just as a single patch to rename
the environment variables, and filter them with a single GIT_TEST_*
pattern at the same time.

Thanks.
