From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: clean up force-with-lease wording
Date: Thu, 26 Mar 2015 11:40:36 -0700
Message-ID: <xmqq1tkbzjob.fsf@gitster.dls.corp.google.com>
References: <1427382909-7414-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, phil.hord@gmail.com
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 19:40:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbChw-00087r-WE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 19:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbbCZSkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 14:40:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752258AbbCZSkj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 14:40:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D510C1C5B8;
	Thu, 26 Mar 2015 14:40:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7I4AencvADpWMXk3S002UigH6pk=; b=gyv4DJ
	HzmFi30iqvxDETVMjx77ZpSDTUFAJPb6h8MucABuTEiKLL0BOhGymplCwywAlAbL
	8nP5ZLYFE2TUTNN66qzF2jxT5VCrsrSAwK2Xtj2I5crqDZixBtv1cQhIaxFkOHNX
	BOANdMMZ6gMIGOdrKIMPmWpNtbhQYraog/PwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwrk1NjXpUSXNFCc62QNolbWCbEJk9as
	LNLUGdokgIPK4hD003WAqrG7Fsh+05pH1m/EnGBGymKkHPbLAQtSM9GQBpm4qxiE
	t4mppKYXRLVM3zNrMdUhQTBzs0YMN3qV8iNt6F0u38pX9SZZCp1mZ8nbVWuv2XOr
	9QZ1miOrBsU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC01A1C5B7;
	Thu, 26 Mar 2015 14:40:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09C291C5B6;
	Thu, 26 Mar 2015 14:40:37 -0400 (EDT)
In-Reply-To: <1427382909-7414-1-git-send-email-hordp@cisco.com> (Phil Hord's
	message of "Thu, 26 Mar 2015 11:15:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98B08602-D3E7-11E4-B83C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266341>

Phil Hord <hordp@cisco.com> writes:

> The help text for the --force-with-lease option to git-push
> does not parse cleanly.  Clean up the wording and syntax to
> be more sensible.  Also remove redundant information in the
> "--force-with-lease alone" description.
>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---

Thanks.  The updated text reads well.

Will queue.

>  Documentation/git-push.txt | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 5171086..863c30c 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -157,9 +157,8 @@ already exists on the remote side.
>  	Usually, "git push" refuses to update a remote ref that is
>  	not an ancestor of the local ref used to overwrite it.
>  +
> -This option bypasses the check, but instead requires that the
> -current value of the ref to be the expected value.  "git push"
> -fails otherwise.
> +This option overrides this restriction if the current value of the
> +remote ref is the expected value.  "git push" fails otherwise.
>  +
>  Imagine that you have to rebase what you have already published.
>  You will have to bypass the "must fast-forward" rule in order to
> @@ -171,15 +170,14 @@ commit, and blindly pushing with `--force` will lose her work.
>  This option allows you to say that you expect the history you are
>  updating is what you rebased and want to replace. If the remote ref
>  still points at the commit you specified, you can be sure that no
> -other people did anything to the ref (it is like taking a "lease" on
> -the ref without explicitly locking it, and you update the ref while
> -making sure that your earlier "lease" is still valid).
> +other people did anything to the ref. It is like taking a "lease" on
> +the ref without explicitly locking it, and the remote ref is updated
> +only if the "lease" is still valid.
>  +
>  `--force-with-lease` alone, without specifying the details, will protect
>  all remote refs that are going to be updated by requiring their
>  current value to be the same as the remote-tracking branch we have
> -for them, unless specified with a `--force-with-lease=<refname>:<expect>`
> -option that explicitly states what the expected value is.
> +for them.
>  +
>  `--force-with-lease=<refname>`, without specifying the expected value, will
>  protect the named ref (alone), if it is going to be updated, by
