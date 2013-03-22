From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag> behavior
Date: Fri, 22 Mar 2013 08:23:31 -0700
Message-ID: <7v38vn8nm4.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <loom.20130321T212911-611@post.gmane.org>
 <cdc4f45e7520ce1fc48588c260214717@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Nanasy <max.nanasy@gmail.com>, <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 16:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3p4-00023T-QL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 16:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328Ab3CVPXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 11:23:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933109Ab3CVPXe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 11:23:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A8CA3AF;
	Fri, 22 Mar 2013 11:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kDZqxemV2exOpxtUq0i8a9SZ6Wg=; b=uzbRG8
	x4PhDvDIdzIQuLeQJF26qXI4syqGNNy9f2l/yBzeOL7JNh2noV7T1miU3TwixYHN
	RDE0T6LGOZpL1WiabwCT85vYjChFLyQMAzo282r4q6Efqt1HioFlADKgoItfbzaB
	jF6f/UNL+fR5TiXOTpeVJmndD7eRXKVw2rkH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=heZs59ff0Wu5HM8aiXxITXfyTqUh+dqn
	NCD1U0i1ohf8sDwkXTHdPuzqXwufRvI9IGn/7PkMCGtvV0/VXHrzbj5yC1rim/31
	X7bkAk3EOqltiRqWMjfjK9cSPhGvTfzLFs8MC7DNF5pKS+dttzF7b6UE/0/0lRLQ
	VY12j0GnhQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA105A3AB;
	Fri, 22 Mar 2013 11:23:33 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45F4DA3A8; Fri, 22 Mar 2013
 11:23:33 -0400 (EDT)
In-Reply-To: <cdc4f45e7520ce1fc48588c260214717@meuh.org> (Yann Droneaud's
 message of "Fri, 22 Mar 2013 10:16:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75607A2A-9304-11E2-A33B-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218814>

Yann Droneaud <ydroneaud@opteya.com> writes:

> Thanks. I wasn't aware of the --no-ff-only option and
> thought --no-ff would be the opposite of --ff-only,
> or at least disable it given the order of the options.
>
> Please find a patch to document option --no-ff-only
>
>   Documentation/merge-options.txt | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/merge-options.txt
> b/Documentation/merge-options.txt
> index 0bcbe0a..20a31cf 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -37,6 +37,10 @@ set to `no` at the beginning of them.
>  	current `HEAD` is already up-to-date or the merge can be
>  	resolved as a fast-forward.
>
> +--no-ff-only::
> +	Disable `--ff-only` behavior, eg. allows creation of merge commit.
> +	This is the default behavior.
> +

We should follow the usual

	--option::
        --no-option::
        	description for both

convention for this one, before or after fixing the existing --ff/--no-ff
description.

>   --log[=<n>]::
>   --no-log::
>  	In addition to branch names, populate the log message with
