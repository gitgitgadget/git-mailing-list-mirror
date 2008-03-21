From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Thu, 20 Mar 2008 21:48:16 -0700
Message-ID: <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:49:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZBn-0000vW-3D
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYCUEsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbYCUEsb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:48:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYCUEsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:48:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 794472572;
	Fri, 21 Mar 2008 00:48:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D06292571; Fri, 21 Mar 2008 00:48:24 -0400 (EDT)
In-Reply-To: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
 (Govind Salinas's message of "Thu, 20 Mar 2008 19:45:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77710>

"Govind Salinas" <govind@sophiasuchtig.com> writes:

> diff --git a/pretty.c b/pretty.c
> index 703f521..fd155ec 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -478,6 +478,9 @@ static size_t format_commit_item(struct strbuf
> *sb, const char *placeholder,
>  	case 'n':		/* newline */
>  		strbuf_addch(sb, '\n');
>  		return 1;
> +	case 'z':		/* null */
> +		strbuf_addch(sb, '\0');
> +		return 1;
>  	}
>
>  	/* these depend on the commit */

I do not like this at all.  Why aren't we doing %XX (2 hexadecimal digits
for an octet)?
