From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: Read gpg settings for signed commit verification
Date: Wed, 27 Mar 2013 09:15:58 -0700
Message-ID: <7vip4com2p.fsf@alter.siamese.dyndns.org>
References: <8C726954D36902459248B0627BF2E66F45D70C3E4E@AUSP01VMBX10.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>,
	Jacob Sarvis <jsarvis@openspan.com>
To: Hans Brigman <hbrigman@openspan.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKt1b-0008GA-9v
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab3C0QQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:16:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab3C0QQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:16:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C496A61D;
	Wed, 27 Mar 2013 12:16:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CtjXPNOTx8NEYPbvwig4eORdBv4=; b=tqiiqO
	NhfgbXkHrOyWDvRhFegR0BMGZEtje0TIvzK2p/i4XihSX1Ad0BBMZHBj2czG+8Cu
	1cCdsT2HY7GE2rBoel7qoBclJYIMHMk4PGVGXBt/YH3GC/VrAaug1bG7Sx9UTPq7
	6EAxbTt6Lqei6dOBJ08DOSwaZMZuQbVVa0S4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ygMoRkF6LIbz+CGQ5yvx2ft9gMkf/0qC
	FLnkVkvG+JBzNdTw4Nu+Zt7ByEye8IH6+6aBbqP8R90RmWuJL1VYOvliAq1itus/
	xZWsnu3xKqo9Ai/DJ75xa1xUh0QiXQLG0JMCyx+f2TggTBLxU+MUiwOqL38DiDnQ
	AXSQ9Z0a7Pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50ACAA61B;
	Wed, 27 Mar 2013 12:16:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD303A619; Wed, 27 Mar 2013
 12:15:59 -0400 (EDT)
In-Reply-To: <8C726954D36902459248B0627BF2E66F45D70C3E4E@AUSP01VMBX10.collaborationhost.net> (Hans Brigman's message of "Wed, 27 Mar 2013 10:13:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CDB6C88-96F9-11E2-BF5A-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219266>

Hans Brigman <hbrigman@openspan.com> writes:

> Content-Type: multipart/mixed; boundary="_002_8C726954D36902459248B0627BF2E66F45D70C3E4EAUSP01VMBX10c_"

No multipart/anything please.  We prefer to see text/plain.

In general, please follow Documentation/SubmittingPatches.

> From: Jacob Sarvis<jsarvis@openspan.com>

Missing SP between name and e-mail.

>
> log: Read gpg settings for signed commit verification

That's the same as the e-mail subject; drop it.

>
> Commit signature verification fails when alternative gpg.program
> signs the commit, but gpg attempts to verify the signature.
> "show --show-signature" and "log --show-signature" do not read
> the gpg.program setting from git config.
> Commit signing, tag signing, and tag verification use this setting
> properly.
>
> Make log and show commands pass through settings to gpg interface.
>
> Signed-off-by: Hans Brigman <hbrigman@openspan.com>

Needs the author's Sign-off before yours.

> ---
>  builtin/log.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8f0b2e8..31f5a9e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -23,6 +23,7 @@
>  #include "streaming.h"
>  #include "version.h"
>  #include "mailmap.h"
> +#include "gpg-interface.h"
>  
>  /* Set a default date-time format for git log ("log.date" config variable) */
>  static const char *default_date_mode = NULL;
> @@ -364,7 +365,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		use_mailmap_config = git_config_bool(var, value);
>  		return 0;
>  	}
> -
> +	if (git_gpg_config(var, value, cb) < 0)
> +		return -1;
>  	if (grep_config(var, value, cb) < 0)
>  		return -1;

Hmph.  I do not particularly like the way the call to grep_config()
loses information by not ignoring its return value and always
returning -1, but I'll let it pass for this patch.

>  	return git_diff_ui_config(var, value, cb);
