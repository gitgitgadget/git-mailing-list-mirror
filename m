From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/16] ls-remote doc: fix example invocation on git.git
Date: Fri, 21 Jun 2013 15:38:46 -0700
Message-ID: <7vk3lnjdhl.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-10-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9zC-0004Se-JR
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423759Ab3FUWi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423755Ab3FUWit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:38:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6082AF30;
	Fri, 21 Jun 2013 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lKWDUFXhiSHdkVx+/PkH+oBwIVk=; b=RwTwav
	VHfz59fa8Ii/8K+aG7I86f/+viSqk7/OvOJIrSbLg/5uD+iCNd+/WTje4rsQ/z/A
	DeBqkrHCXJeR3NN9pEW0KQwCCtHYhPjMWsdj07PaiAvnqNWZhZgNLMJgYvK9Gorl
	sc8QBwERr6P1qW8EoUEucWSUNm8qohAGzEsXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rd2lMLszEngRXMs5WA//0H5zQvhz2aST
	OlW1a5X7xIf7VM/4aBttSlL//Qrf28ylyMDBcI0NMceZJGA0fCG1nSn7+KyJKR2F
	9b2HsNlHJUlPzny0MlbwbWNg4c8xHHOX3ZpXQnLZrnJDmbswnL7XpsSPLtrwiBPn
	/i+dlUFyiQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12AAD2AF2E;
	Fri, 21 Jun 2013 22:38:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 631152AF2D;
	Fri, 21 Jun 2013 22:38:48 +0000 (UTC)
In-Reply-To: <1371813160-4200-10-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56CAAFDE-DAC3-11E2-98B7-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228667>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Under the EXAMPLES section, there is one invocation on the git.git
> repository that attempts to list the refs master, pu, and rc.  The ref
> rc does not exist in today's repository, so remove it.

Hmph, I am on the fence but slightly on the negative side.  It is
just an example to show how to use the command and how the command
may respond.  If you ask your repository about --tags today, you
will not get the v0.99 tags or a blob that has my public gpg key,
and the readers would understand it.

Removing the output line for rc without changing the command line
would be a good change, though.  We do not demonstrate that these
are patterns that filter, and do not explain that not having rc over
there is not an error.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 774de5e..a24b8b6 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -67,10 +67,9 @@ EXAMPLES
>  	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
>  	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
>  	0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
> -	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
> +	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu
>  	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
>  	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
> -	b1d096f2926c4e37c9c0b6a7bf2119bedaa277cb	refs/heads/rc
>  	$ echo http://www.kernel.org/pub/scm/git/git.git >.git/branches/public
>  	$ git ls-remote --tags public v\*
>  	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
