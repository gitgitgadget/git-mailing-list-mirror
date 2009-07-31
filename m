From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: git-send-email: correct statement
 about standard ports
Date: Fri, 31 Jul 2009 09:04:39 -0700
Message-ID: <7vzlaku9d4.fsf@alter.siamese.dyndns.org>
References: <1248995334-28545-1-git-send-email-wjl@icecavern.net>
 <1248995334-28545-2-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWubE-00007e-PZ
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZGaQEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 12:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbZGaQEo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:04:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbZGaQEn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 12:04:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E464418BEA;
	Fri, 31 Jul 2009 12:04:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCE6918BE9; Fri, 31 Jul 2009
 12:04:40 -0400 (EDT)
In-Reply-To: <1248995334-28545-2-git-send-email-wjl@icecavern.net> (Wesley J.
 Landaker's message of "Thu\, 30 Jul 2009 17\:08\:54 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC91B1F0-7DEB-11DE-83CF-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124574>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 1c94351..6415d94 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -142,8 +142,9 @@ user is prompted for a password while the input is masked for privacy.
>  
>  --smtp-server-port=<port>::
>  	Specifies a port different from the default port (SMTP
> -	servers typically listen to smtp port 25 and ssmtp port
> -	465); symbolic port names (e.g. "submission" instead of 587)
> +	servers typically listen to smtp port 25, but may also listen to
> +	submission port 587, or a non-standard SSL smtp port like 465);
> +	symbolic port names (e.g. "submission" instead of 587)
>  	are also accepted. The port can also be set with the
>  	'sendemail.smtpserverport' configuration variable.

As you noted, port 465 has been used as a well-known de-facto port to run
SMTP over SSL at many places.  I do not think it would help anybody by
clarifying that it is a "non-standard" port here.  This is not a place to
educate people on which port they should run their SMTP servers.

But I do not care deeply enough, and I can let it pass.

I have much more trouble with that "like 465" than I have with "non
standard".

The purpose of listing the specific numbers in this sectiono is to give
practical hints.  We could just have said "we can take the port number
your SMTP server listens to with this option, and it is up to you to
figure out which port you want to talk to".  We try to be helpful instead,
so that the people can try to see if the suggested ports match their
situation without having to consult outside references.  That's the whole
reason for having specific numbers in this section.

And in that context, 465 is much more special than any other "non standard
port on which a random ISP may happen to run its SMTP over SSL service".

I think you would help people better to say:

	... submission port 587, or a widely used non-standard SMTP over
	SSL port 465.

if you want to really say non-standard, that is.
