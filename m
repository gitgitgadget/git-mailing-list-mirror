From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL
Date: Mon, 29 Jul 2013 10:56:04 -0700
Message-ID: <7vfvux1c97.fsf@alter.siamese.dyndns.org>
References: <1375116354-14618-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:56:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rg4-0006Vv-WA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab3G2R4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:56:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab3G2R4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:56:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B84C434808;
	Mon, 29 Jul 2013 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nwiCHUDo/vNM7OXsP770od5CMvQ=; b=vMwCc3
	Gv1OncQkqJ++DowwUWdzfBtQgsf5hXwuWSpRPf/G+tMF4Gw7maKZ8Gv2L2F6IuC5
	4PlQGKuAZ2A2l6DjBGGPoXPa4Om2jgPkA2YWbwYIeFuSL0VHnRxA6fBu+pF3mCKO
	k89LEV/OM7XDRTM5hHMJMCpbS/r3vBzb9sUL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HSCOpSvxoq6QxoV1poBUPK0ui7ZhEVgl
	iQfgILM0ng+CrE6XImhKGvdrDbNkwzOZa9/OuNawaXp8USTMqK+axP/J6JpXkjbY
	w6wGxx1EYAw0YYTW61fUKUwTA5bKGBeV331hrbYB3nRMq/aF9q0o0PLNLbGKIvJk
	VLaT/nz6Gc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABFCD34807;
	Mon, 29 Jul 2013 17:56:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2D3F34802;
	Mon, 29 Jul 2013 17:56:05 +0000 (UTC)
In-Reply-To: <1375116354-14618-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Mon, 29 Jul 2013 18:45:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 241B31B2-F878-11E2-ACBD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231308>

Stefan Beller <stefanbeller@googlemail.com> writes:

> This task emerged from b04ba2bb4.
> All occurrences of the respective variables have been reviewed and none
> of them relied on the counting up mechanism, but all of them were
> using the variable as a true boolean.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---

Looked correct; thanks.


>  builtin/fsck.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 9909b6d..39fa5e8 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -611,15 +611,15 @@ static char const * const fsck_usage[] = {
>  
>  static struct option fsck_opts[] = {
>  	OPT__VERBOSE(&verbose, N_("be verbose")),
> -	OPT_BOOLEAN(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
> +	OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
>  	OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
> -	OPT_BOOLEAN(0, "tags", &show_tags, N_("report tags")),
> -	OPT_BOOLEAN(0, "root", &show_root, N_("report root nodes")),
> -	OPT_BOOLEAN(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
> -	OPT_BOOLEAN(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
> -	OPT_BOOLEAN(0, "full", &check_full, N_("also consider packs and alternate objects")),
> -	OPT_BOOLEAN(0, "strict", &check_strict, N_("enable more strict checking")),
> -	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
> +	OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
> +	OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
> +	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
> +	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
> +	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
> +	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
> +	OPT_BOOL(0, "lost-found", &write_lost_and_found,
>  				N_("write dangling objects in .git/lost-found")),
>  	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
>  	OPT_END(),
