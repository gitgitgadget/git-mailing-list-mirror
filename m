From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] CodingGuidelines: Add note forbidding use of 'which'
 in shell scripts
Date: Mon, 27 Feb 2012 10:56:50 -0800
Message-ID: <7vty2c85ql.fsf@alter.siamese.dyndns.org>
References: <1330117921-8257-1-git-send-email-tim.henigan@gmail.com>
 <1330117921-8257-2-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25kn-0000ML-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab2B0S4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:56:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab2B0S4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:56:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2A36595;
	Mon, 27 Feb 2012 13:56:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IpJNPr2C6MzEUgjIwVL7sQj3Tbw=; b=MmV80O
	HworFq8DhcWW+Sn1VXp81Az7G8VV4PiD9rJmjJ7MEIhfw9R9xRwywrxy6M1upZI3
	DF0XWf5r3+5AvTWC00AyyDs534f4A/5jEzZ8Ra7DymSczspz+eirgxYyi6TZ/uOd
	cBn4CegBE6XlV5JGYPB8KPYUtwn0VLmxJxRvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fh91vpIC/BzdCaz4tSQ4y53hO2auEUYI
	d8wdXEpPegdVizNAegWDhY3H4KxbHMaDOF/Yi7buX9gWsF7ok8LNBb9cynPUTeom
	B4CFxPXSNkTeeSbkJ+iYnGJunYAE1CbyR5ghOItB0GtwftXu9JMK1Z1/UElVXsjr
	kueP+hBk0tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 326B16594;
	Mon, 27 Feb 2012 13:56:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DC6B6593; Mon, 27 Feb 2012
 13:56:51 -0500 (EST)
In-Reply-To: <1330117921-8257-2-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 24 Feb 2012 16:12:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF1ACA06-6174-11E1-862F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191651>

Tim Henigan <tim.henigan@gmail.com> writes:

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index a4ffe7c..3505a4b 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -44,6 +44,10 @@ For shell scripts specifically (not exhaustive):
>     properly nests.  It should have been the way Bourne spelled
>     it from day one, but unfortunately isn't.
>  
> + - The use of 'which' is not allowed.  The output of 'which' is not
> +   machine parseable and its exit code is not reliable across
> +   platforms.

It is more helpful to say "If you want to do Z, use X, not Y because Y is
broken for such and such reasons", rather than "Never use Y because Y is
broken ...".

In this case, Z is "find out if a command is available on user's $PATH",
and X is "type", I think.
