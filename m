From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/11] trailer: process command line trailer arguments
Date: Wed, 05 Mar 2014 14:55:07 -0800
Message-ID: <xmqqa9d41cj8.fsf@gitster.dls.corp.google.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.51930.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLKie-0008Tg-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 23:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbaCEWzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 17:55:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbaCEWzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 17:55:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B413071F58;
	Wed,  5 Mar 2014 17:55:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/gELp2BcDUQcGv1/kTIAQN6sCKU=; b=gXIi0/ZhwNGuBZLmjtvP
	2GKmhKRq5Wl1/7VBcYRpxWdrWJ6J8jD8Refu47tEAwG30rQlmGjA7KGAOcmTtvZl
	VnWqotcAQbYtEC0dE9s3w6WZy4TVKjW85Cx+EqMfGTJ6UBMG/xRHjDqwq4lbUakU
	wGMkRpn15sdC7VojWIJCX6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=NlgXO2XMcTNB0mypW5N5lhwwBAnGoGPS6LWobCyYCjKbSi
	vYRgNOzMB6y71SG7Tk48X4C1wnONIdrfOxqXDXGtJNC/ULvLzJNQZr0FH8NwOOoQ
	lgr7P0Z9J7g1ph/zdYcqb/3W2rM6AnakWmtk7cZsuH/LACVH2FxGSwqUd72m0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D88A71F55;
	Wed,  5 Mar 2014 17:55:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFFA071F54;
	Wed,  5 Mar 2014 17:55:10 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 348C7B1C-A4B9-11E3-A0FF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243490>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/trailer.c b/trailer.c
> index 5b8e28b..5d69c00 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -378,3 +378,96 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
> ...
> +static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
> +					     char* tok, char* val)

Asterisk sticks to the variable, not the type.

> +static struct trailer_item *create_trailer_item(const char *string)
> +{
> ...
> +	return new_trailer_item(NULL, strbuf_detach(&tok, NULL), strbuf_detach(&val, NULL));;

Overlong line.  Perhaps that helped you to miss the double-semicolon
at the end.
