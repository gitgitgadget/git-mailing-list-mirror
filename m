From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] "commit --template" fixes
Date: Sun, 01 Apr 2012 15:28:39 -0700
Message-ID: <7vaa2vhyso.fsf@alter.siamese.dyndns.org>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
 <1333136719-12657-1-git-send-email-gitster@pobox.com>
 <4F775ACF.50007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 00:29:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SETGn-0005Ti-7y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 00:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab2DAW2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 18:28:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2DAW2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 18:28:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9724174FB;
	Sun,  1 Apr 2012 18:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mp7hexHfvEdnAQUe0klMUnECIq8=; b=pmOVb5
	FiDxTlOFQisnOaa/XpQrH07y8gn386az8cjv3OF0KHV1BhPqx1apM8PgmMCRr6MX
	Ehx7TXw/Gj+kirY2NoOblZLvNroleGrdWsr7FuSU8jmJS4+W3wKmgWHoUAWejBD8
	y4KPvEuhTmuA2cbDG8EA8tc+8sDojS7L+nDEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=th1UKkbbBQh5y+ZeiNHUdO+3j2zwn4pA
	eOSbPrcF25hSROZTV8+H50rPIloanQj/yV2R+zQ2sXEHS181NhiYdZvK7P1rEatc
	ISkGFhXGPHDAJ85Qq6OKSpN2yltLm5vG1jScUKcsro5xYd/G5C5LGJCjHyK2yvkv
	IM03n3U5NHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE6D74FA;
	Sun,  1 Apr 2012 18:28:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0990C74F9; Sun,  1 Apr 2012
 18:28:40 -0400 (EDT)
In-Reply-To: <4F775ACF.50007@gmail.com> (Adam Monsen's message of "Sat, 31
 Mar 2012 12:28:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0889C8F6-7C4A-11E1-84C8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194489>

Adam Monsen <haircut@gmail.com> writes:

> ...
> * I don't know the kosher procedure to add this commit to your patch
>   series for further review, so hopefully this works.
> * I'm not sure if the "Helped-by:" lines are kosher, I'm happy to
>   remove them if not.

One established way to do this is to have a discussion like the above
(mostly elided), followed by a "scissors" line "-- >8 --", and then the
output from format-patch with most headers except for "Subject: " removed
(as From: and Date: will be taken from your e-mailed message anyway, and
the first "From <commit object name> <magic constant date>" is a signal to
allow automated tools to tell if it is a format-patch output or a random
mbox file, and is not appropriate if you are sending it over e-mail).

>
> From 91a62baa1fe89032e7a3598e5d39241f3eb8f84b Mon Sep 17 00:00:00 2001
> From: Adam Monsen <haircut@gmail.com>
> Date: Sat, 31 Mar 2012 12:09:29 -0700
> Subject: [PATCH] git-commit.txt: clarify -t requires editing message
>
> Make it clear that, when using commit --template, the message *must* be
> changed or the commit will be aborted.
>
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Ivan Heffner <iheffner@gmail.com>
> Signed-off-by: Adam Monsen <haircut@gmail.com>
> ---
> I wrapped the text at 77 characters because that was the longest
> line in the file (according to wc -L).
>
> I used ":set noet nosta ts=8 sw=8 tw=77" in Vim.

When rewording or clarifying only a handful of words in the documentation,
it is often better to avoid reflowing lines in the same patch.  It makes
it harder to see what you really changed, and what is merely reflowed.

I'll queue it as-is, though.  Thanks.

This is a tangent, but we might want to rephrase the first sentence
without using the word "version"; every time I read this paragraph, the
"initial version" makes me go "Huh?" because the word sounds as if it is
talking about commits in the context of SCM, which is not the case here.

I know that the description wanted to avoid use of the word "template" to
explain what the template is, but still...

>  Documentation/git-commit.txt |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 5cc84a1..f584a62 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -132,11 +132,11 @@ OPTIONS
>  
>  -t <file>::
>  --template=<file>::
> -	Use the contents of the given file as the initial version
> -	of the commit message. The editor is invoked and you can
> -	make subsequent changes. If a message is specified using
> -	the `-m` or `-F` options, this option has no effect. This
> -	overrides the `commit.template` configuration variable.
> +	Use the contents of the given file as the initial version of the
> +	commit message. The editor is invoked so you can make subsequent
> +	changes. If you make no changes, the commit is aborted. If a message
> +	is specified using the `-m` or `-F` options, this option has no
> +	effect. This overrides the `commit.template` configuration variable.
>  
>  -s::
>  --signoff::
