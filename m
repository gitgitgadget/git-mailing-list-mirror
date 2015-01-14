From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Wed, 14 Jan 2015 11:09:38 -0800
Message-ID: <xmqq61c99o25.fsf@gitster.dls.corp.google.com>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBTK5-00005X-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 20:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbbANTJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 14:09:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbbANTJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 14:09:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E07B2B391;
	Wed, 14 Jan 2015 14:09:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DcRJCYmYW/mJPsmbja99odqsn+U=; b=iW4+jX
	pp4AcMjZex/g7ujVfcPK53XaMRVRyQP82LxNEDHjF8Br1qjzW/Lr0m3dig6h4L7C
	aYZrTYGrdjO7SAmP836vCbM8bQqzG0RJuRVB6LG8A7hI9PpyADtbY7CsL82U35/G
	KIS4rWd6sKpZ67uMNG/A+GERHZpZcV6bK9OLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MLpgd/cHLWrG5cXUIP/zqtOAgcUtmyD3
	rSR05UEbpKp34Mc9mveztmZ5RJNrrR8VTTcaHdrKrOwWWDEm6Fvh3sh6v6SNSXWW
	B6GSekL3AdPOWqZnDtgxCf48XM3+R0WEktaR44PpnNU5PH4W1bLyHISc748QZiYO
	mNREFTpSOSo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 544A32B390;
	Wed, 14 Jan 2015 14:09:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C48A82B38E;
	Wed, 14 Jan 2015 14:09:39 -0500 (EST)
In-Reply-To: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 14 Jan 2015 23:59:27 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E38759FC-9C20-11E4-BA18-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262415>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> * "cache.h" - is unnecessary because it already included at "builtin.h"
>
> * "exec_cmd.h" - was added at a47d1813 (Allow a relative builtin template
> directory., 15 Nov 2007). init-db used 'git_exec_path' routine from
> "exec_cmd.h", but later it was removed at 2de9de5e (Move code interpreting
> path relative to exec-dir to new function system_path()., 14 Jul 2008). So
> we no need in it anymore.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

Makes sense. Thanks.

>  builtin/init-db.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 280454a..2978b36 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -3,9 +3,7 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> -#include "cache.h"
>  #include "builtin.h"
> -#include "exec_cmd.h"
>  #include "parse-options.h"
>  
>  #ifndef DEFAULT_GIT_TEMPLATE_DIR
