From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 1/5] Show help: -a and -g option, and 'git help
 <concept>' usage.
Date: Tue, 02 Apr 2013 16:15:18 -0700
Message-ID: <7vd2uc8qyh.fsf@alter.siamese.dyndns.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
 <1364942392-576-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, "W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 01:16:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNAQm-0008CL-0P
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 01:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab3DBXPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 19:15:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413Ab3DBXPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 19:15:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B251F12C30;
	Tue,  2 Apr 2013 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=h4mlZ0/zR0fYQ/I9xzQUl+3vuvk=; b=d0EEsjLFVrNaU2eF36/G
	GC/FdYmhV6htqzlvZMMkytWIvESX7jhtBljTuv4m7CFPKu2siXXgnRPll//gugu9
	RpvicgtFLTWCe+jW50gh+6/YpnTCgyJcEhwBMP8aXqxJrGCg8/xeRsfZSUTbb+wg
	HppdgZ5WBdrvTvjk1o+94nU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xgsPJjc8qW8UErxg/lOILMcIly5mgWnJByVoHTmwGdCLRP
	hPCnKY+XRN5EaYU7hel4aTjl5mp3ROHyPXG6ConQBRFZRReecntmuPL2RBOgsLjk
	1YY8p7PXN39hc+6w2KkoWheSkiQQUpRqpSBXUtv9eZauciZs71KMvnPP4ftvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A88A912C2F;
	Tue,  2 Apr 2013 23:15:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1642912C2E; Tue,  2 Apr
 2013 23:15:19 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3018155A-9BEB-11E2-ACB9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219903>

Philip Oakley <philipoakley@iee.org> writes:

> Prepare for the addition of the -g --guides option to git help
> and show that help is available for both concept guides, and commands.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---

This should come at the end after you taught the "-g" option, I
think.  If we stopped with 1/5, then the message will promise "git
help -g" does something useful, while the code is not yet ready.

>  git.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index 39ba6b1..2f8aa41 100644
> --- a/git.c
> +++ b/git.c
> @@ -13,7 +13,9 @@ const char git_usage_string[] =
>  	"           <command> [<args>]";
>  
>  const char git_more_info_string[] =
> -	N_("See 'git help <command>' for more information on a specific command.");
> +	N_("'git help -a' and 'git help -g' lists available subcommands and some\n"
> +	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
> +	   "to read about a specific subcommand or concept.");
>  
>  static struct startup_info git_startup_info;
>  static int use_pager = -1;
