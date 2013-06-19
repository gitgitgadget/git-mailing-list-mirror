From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/t5528-push-default: remove redundant test_config lines
Date: Wed, 19 Jun 2013 12:26:57 -0700
Message-ID: <7vbo71zyta.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 21:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpO26-0007Yh-PS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 21:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935106Ab3FST1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 15:27:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935093Ab3FST1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 15:27:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A9CD1B5E9;
	Wed, 19 Jun 2013 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PTaOMZKBcxVjDy9aOTbn0p7Y+eo=; b=k5o+5P
	/6dlTwkSXvgI3TlNLTQTxhT0Xn1t5r14suzEnpLn7dFFJhcBsfSvQcpI6lLhOFNf
	4k0bOqchFugrTUUd43dEMmrO/OfECeHD4FZFZNhlEhwfBL3K0nedQj9g9MTxqSDL
	VpK2fhhqzhlCO/kt6GvXhwWVwQHWfFu7K9Ifg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHekX8PdXk0CvSRXa+SbaSxLFTFzDSW9
	NZLqh/P7RR7P08Wipe1BwKHTtDxfA4bk5aoZs18BRWaKmhDl6d4WMCjV/dVjOz0M
	5jMbTw+8z33kOvnILdlZtOzbhqcyfPbsUeF6O54Tx765y8jeH4usHL13FLhxDCFK
	tZ0H9U/uA2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1711B5E7;
	Wed, 19 Jun 2013 19:27:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BCE41B5E1;
	Wed, 19 Jun 2013 19:26:59 +0000 (UTC)
In-Reply-To: <1371640304-26019-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 16:41:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3617279E-D916-11E2-AA98-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228416>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The line
>
>   test_config push.default upstream
>
> appears unnecessarily in two tests, as the final test_push_failure sets
> push.default before pushing anyway.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5528-push-default.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index 4736da8..69ce6bf 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -48,7 +48,6 @@ test_expect_success '"upstream" pushes to configured upstream' '
>  test_expect_success '"upstream" does not push on unconfigured remote' '
>  	git checkout master &&
>  	test_unconfig branch.master.remote &&
> -	test_config push.default upstream &&
>  	test_commit three &&
>  	test_push_failure upstream
>  '
> @@ -57,7 +56,6 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
>  	git checkout master &&
>  	test_config branch.master.remote parent1 &&
>  	test_unconfig branch.master.merge &&
> -	test_config push.default upstream
>  	test_commit four &&
>  	test_push_failure upstream
>  '

Makes sense, but I wonder if the only remaining test_config should
also be eradicated in the test after this one.

    test_expect_success '"upstream" does not push when remotes do not match' '
            git checkout master &&
            test_config branch.master.remote parent1 &&
            test_config branch.master.merge refs/heads/foo &&
            test_config push.default upstream &&
            test_commit five &&
            test_must_fail git push parent2
    '

It uses test_must_fail but that is only because test_push_failure is
not equipped to handle anything other than "git push" without
arguments.  If the helper were updated to do something like this:

	strategy=$1; shift
	...
	test_must_fail git -c push.default="$strategy" push "$@"

then "test_config push.default" here can be removed and all the
tests will end with test_push_success or test_push_failure.
