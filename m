From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/9] user-manual: Use request-pull to generate "please
 pull" text
Date: Sun, 17 Feb 2013 18:50:54 -0800
Message-ID: <7vk3q6cp2p.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <edd0062a7f54300cccd0123dc108e9a0f39bdccc.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Gp8-0004SL-LP
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab3BRCu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:50:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab3BRCu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:50:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65B81BCF3;
	Sun, 17 Feb 2013 21:50:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dX7UZzqVEsytoRm6TjUU2NNTUmI=; b=dwK4Xb
	LQ1t6bgeIvPYogXOvGLzGC1GMHtSL1VwJswV2C0IW/Kt/mfkkssnadIcI1SL0aOI
	7vVeoRrWriHjn0RZ+Xwyrp/xEfbBwW89SbJDvEkWNI0qAvpc1bGaH6MRBziJgf3u
	A8DHW2qkZ2PAbtG1ph+mYMajFed8Mjj3S8xWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JsG2tHVB2dm7v+mLenZyEP8V0kTV7eS1
	tA8QxYV23/H40ur9wFLmLGBbht3qvRecImh1O3Az5e4h0INnQ1jPMqdXIcdoin2H
	d2k7zlAloF9TH+TJxEjnNzUxrr4h9GfiA+K1wXI5QwyWoRH0oHahXjRzWgYJ7HYq
	D/hhvhAYDn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58EE6BCEE;
	Sun, 17 Feb 2013 21:50:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C905CBCDF; Sun, 17 Feb 2013
 21:50:56 -0500 (EST)
In-Reply-To: <edd0062a7f54300cccd0123dc108e9a0f39bdccc.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:15:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04CF14DA-7976-11E2-9864-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216434>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> Less work and more error checking (e.g. does a merge base exist?).
> Add an explicit push before request-pull to satisfy request-pull,
> which checks to make sure the references are publically available.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index d9276d7..cf09ddf 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2304,16 +2304,11 @@ these changes, just apply directly to the `release` branch, and then
>  merge that into the `test` branch.
>  
>  To create diffstat and shortlog summaries of changes to include in a "please
> -pull" request to Linus you can use:
> +pull" request to Linus you can use linkgit:git-request-pull[1]:

The command you refer to does the _whole_ thing, not just to create
diffstat and shortlog summaries to be included.

>  -------------------------------------------------
> +$ git push mytree
> +$ git request-pull origin mytree release
>  -------------------------------------------------

The introductory text to tell the reader what they are being taught
needs to be updated a bit more, I think.

	After pushing your work to "mytree", you can use request-pull
	command to prepare a "please pull" request message to send
	to Linus, like so:

or something.

>  
>  Here are some of the scripts that simplify all this even further.
