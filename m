From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] git-rebase.txt: "--onto" option updated
Date: Fri, 08 Jun 2012 10:07:15 -0700
Message-ID: <7vipf1d96k.fsf@alter.siamese.dyndns.org>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:07:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd2ei-0007d9-QW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 19:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762181Ab2FHRHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 13:07:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762120Ab2FHRHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 13:07:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 876DC8058;
	Fri,  8 Jun 2012 13:07:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOxcrUJmZO+WXHsKwCqk+muZ7lc=; b=Toh9cM
	jZsfgC48qCfxAZT9PgkM1VoVKszxLEXKY7HqVN4HzFekvSMYMq7Z4i48do4tlgiF
	UmWcCloSuDip6lqev4gpZy1XIMJQvWA7QUHGhX948ezckt04EX4EDXUP2012O5OA
	Vb48y/bj1Q3k9NTsALa8oTrLnrdsyTwTtQj60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5L5aAAZVRVZ3Y6vZI+j4JDXFgdJI0J6
	mgXKFuwCp+UUx8SLZs01HFmJAwhf+6f+p8AgOEKUOyqCkPLTD4yRxOR/emOHgXIC
	ETj7D2Dy4SDUh7eWnBw6OkWHyfPrG6gN1R9Koiq54RdTiRdfWFeiwuDVYVFhGmce
	a8Q22s5twUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D9EB8057;
	Fri,  8 Jun 2012 13:07:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F28218056; Fri,  8 Jun 2012
 13:07:16 -0400 (EDT)
In-Reply-To: <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Lucien Kong's message of "Fri, 8 Jun 2012 16:53:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66742868-B18C-11E1-A8CF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199515>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> The description of the option "--onto" is changed to be consistent
> with the format of the other options.
> ...
>  OPTIONS
>  -------
> -<newbase>::
> -	Starting point at which to create the new commits. If the
> -	--onto option is not specified, the starting point is
> -	<upstream>.  May be any valid commit, and not just an
> -	existing branch name.
> +--onto <newbase>::
> +	With this option, git rebase takes all commits from <branch>,
> +	that are not in <upstream>, and transplants them on top of
> +	<newbase>. <newbase is the starting point at which to create
> +	the new commits. If the --onto option is not specified, the
> +	starting point is <upstream>.  May be any valid commit, and
> +	not just an existing branch name.
>  +
>  As a special case, you may use "A\...B" as a shortcut for the
>  merge base of A and B if there is exactly one merge base. You can

This is doing two unrelated things in a single patch, isn't it?

I would imagine that a patch that is about "to be consistent with
the format" would be a one-liner

	-<newbase>::
        +--onto <newbase>::

without anything else.  The change this patch makes to the
explanation is much larger, but that is not justified in the
proposed commit log message.

Besides, I find the new explanatory text much harder to understand
than the original one.
