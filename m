From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update t3508 status
Date: Tue, 29 Jun 2010 09:40:13 -0700
Message-ID: <7v4oglbxn6.fsf@alter.siamese.dyndns.org>
References: <1277775091-13313-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 29 18:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdrM-0007Nc-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab0F2QkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 12:40:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab0F2QkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:40:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C8A0C010E;
	Tue, 29 Jun 2010 12:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6UDnKP/uprduWWiLTALExgE1WuY=; b=JAhNMa
	WdFiSwzkmDI8sEFVdONQ/CxmPuKF+zL1KXkqCglEq7UFCemFQjgoqS7CDaWYvqVU
	kGp2FNzUfH4joLjah7/6IUUthXmI2ftA1yQa90HlGOha5vnI+pJKmHUEpS1wQUDt
	9YlZfvka1hKf9MxDxkgj9+xRTV8ULYSvRAwrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pSvidiQG5YjMjrDdHSTymlE0s/SMHfGF
	SlPU8RKA1wIkrgZAtIK5N8IEwd8DoBmeFX0yLEqoxVMFw7FVLhyF9rIIJp8nGZl3
	7oIHK4wZOTD+7bDw4WIgfcxAqZ1FiXr7v6N9BYinuxBYiGhMXAHcUPsJ8gtib9Ds
	KrZ//02xq68=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3658DC010D;
	Tue, 29 Jun 2010 12:40:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 621FCC010C; Tue, 29 Jun
 2010 12:40:15 -0400 (EDT)
In-Reply-To: <1277775091-13313-1-git-send-email-newren@gmail.com>
 (newren@gmail.com's message of "Mon\, 28 Jun 2010 19\:31\:31 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00DB528E-839D-11DF-B691-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149917>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> Test #8 of t3508-cherry-pick-many-commits.sh has been fixed since
> 3af0bba8bff88ec1b078aae966a59af26c7a0718.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Curious.

This test is broken in the second parent of 3af0bba8b (i.e. the tip of
cc/cherry-pick-stdin), but in 3af0bba8b, i.e. the merge result, it does
seem to be fine.

What am I missing???

> ---
>  t/t3508-cherry-pick-many-commits.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index 93d7189..f90ed3d 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -82,7 +82,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
>  	git diff --quiet HEAD first
>  '
>  
> -test_expect_failure 'cherry-pick -3 fourth works' '
> +test_expect_success 'cherry-pick -3 fourth works' '
>  	git checkout -f master &&
>  	git reset --hard first &&
>  	test_tick &&
