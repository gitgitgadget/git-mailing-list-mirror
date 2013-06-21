From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] t/t5505-remote: modernize subshell-style of one test
Date: Fri, 21 Jun 2013 15:04:36 -0700
Message-ID: <7vehbvktmz.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9Rj-0000Qt-IB
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946179Ab3FUWEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:04:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946171Ab3FUWEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:04:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D4522A521;
	Fri, 21 Jun 2013 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VCJlLsWSXPa/q4GXX9EOAd50Zss=; b=fzcNWM
	IAhBUTanlZ6wIaxTS8zNUBryYrW5l03/MKvEa/GyExibCG5lvz2qmmLB600mVcIH
	cig50QWSGJf0/wzlk6wCjOYSW1l9KywTREctaSaI4dYfu06Sw955LyeAX3PohQ+5
	c4u2B/SCT3rqwXuOUjuqJIQ3hCiU9d+PXoFcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Orp/H9bQULkQWFhW/LPIFXAG8izWEd7O
	t+t+oNfuKH9tyNUsQunikJ/GKVQpLzedGlHm/PdtZUfGCEqVcNV+vuhDFlLQ3do0
	UTihCtz8K0EVd8WDx+X9jtzTQ2XmBL74C/f7Ae293xdn7Rh3ViNUQHA75J+kjx6U
	HCmXKfi7wU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518222A520;
	Fri, 21 Jun 2013 22:04:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C15F2A51E;
	Fri, 21 Jun 2013 22:04:37 +0000 (UTC)
In-Reply-To: <1371813160-4200-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9070C098-DABE-11E2-A543-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228660>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Since we plan to edit the test "migrate a remote from named file in
> $GIT_DIR/remotes" in later patches, modernize the subshell-style by
> putting the parenthesis on separate lines and indenting the body.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Good, but a "style only" patch like this should consider taking
advantage of the occasion to clean up the entire file, as we do not
often get enough chance to do so without conflicting with in-flight
topics.  Is there something else that would conflict if this step
did so?

>  t/t5505-remote.sh | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index dd10ff0..4d5810f 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -691,13 +691,15 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
>  test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
>  	git clone one six &&
>  	origin_url=$(pwd)/one &&
> -	(cd six &&
> -	 git remote rm origin &&
> -	 echo "$origin_url" > .git/branches/origin &&
> -	 git remote rename origin origin &&
> -	 ! test -f .git/branches/origin &&
> -	 test "$(git config remote.origin.url)" = "$origin_url" &&
> -	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
> +	(
> +		cd six &&
> +		git remote rm origin &&
> +		echo "$origin_url" > .git/branches/origin &&

A SP between > and the filename is still there?

> +		git remote rename origin origin &&
> +		! test -f .git/branches/origin &&
> +		test "$(git config remote.origin.url)" = "$origin_url" &&
> +		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
> +	)
>  '
>  
>  test_expect_success 'remote prune to cause a dangling symref' '
