From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: add 'revisions' and 'everyday' to 'git help'
Date: Thu, 24 Mar 2016 13:08:43 -0700
Message-ID: <xmqq7fgr8wqc.fsf@gitster.mtv.corp.google.com>
References: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
	<1458844034-12855-3-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:08:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBYq-0004u0-R9
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 21:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbcCXUIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 16:08:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbcCXUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 16:08:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D7D34D741;
	Thu, 24 Mar 2016 16:08:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qPgUsJcmXleJidS6Z5qTnKS+Ifg=; b=N110Wd
	eoWTmzLeTbIoNCVfZ+9feNskI/zcCF75hhOu3uE9NjqtBOGVzZpGpWoqA1+UkNYO
	/yEQV7sK/wXFBDOxTMH9Lz4MDFKjG3grhK4FW5zCWcd31BhsEABLzwXLKyOA08IU
	wmGEzaIdOovw6kCpyogR6vWNGc2G36I1C8bpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5QOj3hsYFMhWFtaMLkcWYcd/sIbtBHY
	uRGJ0cS3Krdztw6FiLucSuEdKBPx5M5uzw99Rx12VNQgMG622k6DbGA5NNVgnOC1
	sEe4iuf1mYMCHphXHG2jVMqHO8NrLbx6fM0cI2GSMSJgU91Oh0jCNd77QS87awTK
	AynYf6l+eYU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34F7F4D740;
	Thu, 24 Mar 2016 16:08:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A30744D73E;
	Thu, 24 Mar 2016 16:08:44 -0400 (EDT)
In-Reply-To: <1458844034-12855-3-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Thu, 24 Mar 2016 19:27:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3620C32E-F1FC-11E5-853D-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289794>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It is somewhat silly that we have to maintain this list to be in
sync with the set of documents we offer.  Wouldn't it make more
sense to go in the direction of _removing_ this list of hardcoded
words here?

The first step may be to teach a new subcommand to "git help"
to show a list of these words, and then _git_help can use it to
lazily compute the list just like __git_commands does.

But this change itself is not wrong per-se; will queue to see where
follow-up discussion will lead us to.

Thanks.


> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 70f4171..ffe6004 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1346,8 +1346,8 @@ _git_help ()
>  	__git_compute_all_commands
>  	__gitcomp "$__git_all_commands $(__git_aliases)
>  		attributes cli core-tutorial cvs-migration
> -		diffcore gitk glossary hooks ignore modules
> -		namespaces repository-layout tutorial tutorial-2
> +		diffcore everyday gitk glossary hooks ignore modules
> +		namespaces repository-layout revisions tutorial tutorial-2
>  		workflows
>  		"
>  }
