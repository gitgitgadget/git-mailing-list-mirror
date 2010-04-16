From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-send-email.txt: Add EXAMPLES section. Write 1st level
 sections in uppercase
Date: Fri, 16 Apr 2010 10:01:57 +0200
Message-ID: <4BC81975.9000907@drmicha.warpmail.net>
References: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Fri Apr 16 10:05:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2gY7-0000Jr-9N
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 10:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab0DPIFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 04:05:04 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55920 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757109Ab0DPIE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 04:04:59 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B1BFFEB01B;
	Fri, 16 Apr 2010 04:04:58 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 16 Apr 2010 04:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3SRHCQ6cjWc8gquyKQU8SZqOaws=; b=Iu1UNDcN6JHFEbWWzyqNHXYugEg2Q8F7SCbE+X8Y8ylprirnXubCQ39zBVmmXswRkBVCq1PIeAy0zCxAi1ZDJaHP+dB1anPaePuhRZ7P1o7+ooxwY3mqAjCfI8VRxTffg1BD+jAJWTX5AbnmpB3SIz895lsl1IDR5HlldilKlvI=
X-Sasl-enc: ZK9zkRHjeu9msHgrBqEWaFDoxmYqGxkgd9PYEQP//Y47 1271405098
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2C3674D36C;
	Fri, 16 Apr 2010 04:04:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145056>

jari.aalto@cante.net venit, vidit, dixit 15.04.2010 17:37:
> From: Jari Aalto <jari.aalto@cante.net>
> 
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-send-email.txt |   36 ++++++++++++++++++++++++++++++++++--
>  1 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index ced35b2..8b33eb0 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -299,8 +299,40 @@ sendemail.confirm::
>  	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
>  	in the previous section for the meaning of these values.
>  
> +EXAMPLES
> +--------
>  
> -Author
> +To batch send all patches to a mailig list, no copies to oneself,
> +messages in a relaxed single thread format (no nesting) and don't ask
> +any confirmations:

That sentence is linguistically screwed, but...

> +
> +	git send-email \
> +		--from $EMAIL \
> +		--to address@list.example.com \
> +		--suppress-cc=author \
> +		--suppress-from \
> +		--no-chain-reply-to \
> +		--confirm=never \
> +		outgoing/
> +

... I don't think this is a good example at all. All options are
explained in the man page, so what is the point in listing and
explaining some of them here? If we really want an introductory example,
we want one with few options, where the default behaviour is explained.

> +Tip: in case the patches in a branch need rework, you might consider
> +adjusting the subjects of each patch to "[PATCH v<number>]" with
> +options '--subject-prefix'. 

That is a git.git convention, and it applies to format-patch, not
send-email.

> The 'merge-base' inside command
> +substitution is there to find out the initial commit of the branch:
> +
> +	git checkout BRANCH
> +
> +	git format-patch \
> +		--subject-prefix="PATCH v2" \
> +		--signoff \
> +		-M \
> +		--output-directory outgoing/
> +		$(git merge-base HEAD master)..
> +

This is a useful example (although it mixes several issues), but one for
format-patch, not send-email. You assume you branched off master. Using
@{upstream} might be a more general option.

> +Then proceed as in in the first example the send the patches out
> +again.
> +
> +AUTHOR
>  ------
>  Written by Ryan Anderson <ryan@michonline.com>
>  
> @@ -308,7 +340,7 @@ git-send-email is originally based upon
>  send_lots_of_email.pl by Greg Kroah-Hartman.
>  
>  
> -Documentation
> +DOCUMENTATION
>  --------------
>  Documentation by Ryan Anderson
>  
