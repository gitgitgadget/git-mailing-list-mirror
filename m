From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git config: clarify bool types
Date: Tue, 17 Mar 2009 18:13:15 -0700
Message-ID: <7vk56nocpg.fsf@gitster.siamese.dyndns.org>
References: <1237331631-29822-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkMv-0006b2-W8
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbZCRBNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbZCRBNY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:13:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZCRBNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:13:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F334A2CC9;
	Tue, 17 Mar 2009 21:13:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0D63BA2CC6; Tue,
 17 Mar 2009 21:13:16 -0400 (EDT)
In-Reply-To: <1237331631-29822-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 18 Mar 2009 01:13:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8CE22A6-1359-11DE-A1BB-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113550>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The value is what it is, the --bool and --bool-or-int options don't
> specify the value type, just how it is interpreted. For example: a value
> of '1' can be interpreted as 'true'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> This applies on top of the 'next' branch.
>
>  builtin-config.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-config.c b/builtin-config.c
> index 1a3baa1..c3a0176 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -66,9 +66,9 @@ static struct option builtin_config_options[] = {
>  	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
>  	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
>  	OPT_GROUP("Type"),
> -	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
> +	OPT_BIT(0, "bool", &types, "value is intepreted as bool (\"true\" or \"false\")", TYPE_BOOL),

I'd rater see it say something like:

	Output the value as boolean (true or false)

so that it is consistent with others you can see in the context.
E.g. get-color explains it to order the command to "find the color".

"Interpret" is fine too.  The point is not about the choice of verb but
use of imperative mood.
