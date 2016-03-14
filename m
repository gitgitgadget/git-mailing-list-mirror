From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: allow "ahead " to be picked up by l10n
Date: Mon, 14 Mar 2016 08:57:09 -0700
Message-ID: <xmqqk2l5aw8a.fsf@gitster.mtv.corp.google.com>
References: <56E6D8C4.2010205@drmicha.warpmail.net>
	<3b88641beff6b34ae8b86bf353e6fbb8f9e636f1.1457969307.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:57:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUs6-00041N-U1
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 16:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965657AbcCNP5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 11:57:13 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965493AbcCNP5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 11:57:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA5C24A9AE;
	Mon, 14 Mar 2016 11:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=awdIbqsbmqaDhDVIWsyaaHPtWX8=; b=srlvMn
	0rIeTZHZF8eidss5wQszx/AkVarEjstt5m5SrsKaqtoX/eK8eNe4x4jRXNYdh/T2
	9fKZeA7asIpbPKKF4gPxhZ9OelbH4sZeNz3etCk17HenpL5Cfd8Q9AWtGesvVdQL
	9zTx8KN2AkS1tELOHkybnorJmtYIqHklQhH1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d4Yvbda1Q6YjFCY1hlanQHSj0zZlxrNq
	4t9KQuh6qnlhA5pGI109sgyr9xRkQ/eLMAtaA62Q31cr7l6hoI+eMVaY5DMeQ6FB
	fCPwi3RNsrk893QAE6Q6Q5zSRx4rI1R+5t7iVCCmhPjmPLPwaQB5rlxFZORT2XVp
	aC5dNT6xAaU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D19F94A9AD;
	Mon, 14 Mar 2016 11:57:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E2264A9A7;
	Mon, 14 Mar 2016 11:57:10 -0400 (EDT)
In-Reply-To: <3b88641beff6b34ae8b86bf353e6fbb8f9e636f1.1457969307.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 14 Mar 2016 16:30:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69064130-E9FD-11E5-A5BD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288787>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The extra pair of parentheses keeps the l10n engine from picking up the
> string. Remove them so that "ahead " ends up in git.pot.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

Thanks, will apply.

>  wt-status.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index ab4f80d..ef74864 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1677,10 +1677,10 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  		color_fprintf(s->fp, header_color, LABEL(N_("behind ")));
>  		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
>  	} else if (!num_theirs) {
> -		color_fprintf(s->fp, header_color, LABEL(N_(("ahead "))));
> +		color_fprintf(s->fp, header_color, LABEL(N_("ahead ")));
>  		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
>  	} else {
> -		color_fprintf(s->fp, header_color, LABEL(N_(("ahead "))));
> +		color_fprintf(s->fp, header_color, LABEL(N_("ahead ")));
>  		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
>  		color_fprintf(s->fp, header_color, ", %s", LABEL(N_("behind ")));
>  		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
