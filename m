From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] column doc: rewrite documentation for column.ui
Date: Tue, 25 Jun 2013 15:18:11 -0700
Message-ID: <7vobatzvfg.fsf@alter.siamese.dyndns.org>
References: <1372175676-5423-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:18:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrbZ4-0006In-Li
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab3FYWSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:18:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab3FYWSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:18:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4751F2BB6B;
	Tue, 25 Jun 2013 22:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0iQPYy4nBvt0nveawW2rjFl7X+M=; b=KU8K49
	nR2e8oBhh5GDkcIRIuHacatmFB4tnc4ZhGjbt1TmfKGkM9y8TE9TXiG8VeK/4pCz
	gD/WST4H2SkQbgguCflfg+he5qWcgvV36KqGkD6EwrYmq+q8MJsXmDZLCIvODQYX
	T2ylhvJ2B11Ml3HOhZm3NzSLhPQNB/ubZGgDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wNLcAqx8Wboo/gTZUEp3ZRJ5AdyOq1u1
	4gxAaRlUv9FG0t6vHOiKXVtXNgSFsInRDMpYRa80h+ufPpO5wy9W893EFXAknmaf
	s8bhw4Mbw/Yxlhf3mZMVsYE/1vbOu4cwui2gTRmervay10AZ8p/tX5I/H69cVlQ0
	N/YjaZU8bys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A6EA2BB6A;
	Tue, 25 Jun 2013 22:18:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 973522BB68;
	Tue, 25 Jun 2013 22:18:12 +0000 (UTC)
In-Reply-To: <1372175676-5423-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 25 Jun 2013 21:24:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FDBBB42-DDE5-11E2-A2AC-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229007>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The configuration option column.ui is very poorly documented, and it is
> unclear what the defaults are, and what option can be combined with
> what.  Rewrite it by splitting up the options into three sections
> clearly showing how COL_ENABLED, COL_LAYOUT_MASK, and COL_DENSE work.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Thanks.

One micronit (read: if you think the suggested change is a good
idea, I could just locally amend it) is that it would read better
and also easier to maintain to say

	These options control

without "three".  Both 'man' and 'html' output looked good.


>  Documentation/config.txt | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1153585..5a10169 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -934,6 +934,9 @@ column.ui::
>  	This variable consists of a list of tokens separated by spaces
>  	or commas:
>  +
> +These three options control when the feature should be enabled
> +(defaults to 'never'):
> ++
>  --
>  `always`;;
>  	always show in columns
> @@ -941,19 +944,30 @@ column.ui::
>  	never show in columns
>  `auto`;;
>  	show in columns if the output is to the terminal
> +--
> ++
> +These three options control layout (defaults to 'column').  Setting
> +layout implies 'always' if none of 'always', 'never', or 'auto' are
> +specified.
> ++
> +--
>  `column`;;
> -	fill columns before rows (default)
> +	fill columns before rows
>  `row`;;
>  	fill rows before columns
>  `plain`;;
>  	show in one column
> +--
> ++
> +Finally, these options can be combined with a layout option (defaults
> +to 'nodense'):
> ++
> +--
>  `dense`;;
>  	make unequal size columns to utilize more space
>  `nodense`;;
>  	make equal size columns
>  --
> -+
> -This option defaults to 'never'.
>  
>  column.branch::
>  	Specify whether to output branch listing in `git branch` in columns.
