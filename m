From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/14] trailer: process command line trailer arguments
Date: Thu, 06 Feb 2014 16:08:24 -0800
Message-ID: <xmqqmwi3wzrb.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.93876.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:08:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBYzg-0007TC-3B
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaBGAI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:08:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbaBGAI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:08:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08F3E6A178;
	Thu,  6 Feb 2014 19:08:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PgXANGb5hV+tyQNIfDQf9N7NfH4=; b=kX3b3f
	K6orsCuayxasjRb/OEoPqLsQ1Ef7n4/slRqfrnSJoG9dUuxLsquLb9Uf7o6gXc4d
	1MuNE7nNKYU0fGNNORx6CXEVbx2YLPiIxNn8lxac+t0QGvRpxqnLkTiQnD88ZL/g
	xjYrdbnnYDYaGLTkz7pz9zHp2kIo607aJhgqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HU4Vf+o/xHCABjfkkE2MFTyOAB17C2x/
	iGzJsBz9hcfoXTyY9FBVKvJGXfHS171Sw07n2wA1eqWv18ZsKl1zaOy34RW+3xSz
	gLgn5l9hsDg65EUm3IyysbMaXxnJwtjDPQxs4hKAY2rECjBV18kuPyAsGumWP0dj
	Y22UZ1B8hW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E410D6A177;
	Thu,  6 Feb 2014 19:08:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BCC96A176;
	Thu,  6 Feb 2014 19:08:26 -0500 (EST)
In-Reply-To: <20140206202004.325.93876.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F74046E0-8F8B-11E3-8CA6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241751>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch parses the trailer command line arguments
> and put the result into an arg_tok doubly linked
> list.

No the patch doesn't parse anything ;-).

"Parse the command line arguments and ...".

> +static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
> +{
> +	const char *end = strchr(trailer, '=');
> +	if (!end)
> +		end = strchr(trailer, ':');

How would you explain the behaviour of the above code for this
input?

	frotz: nitfol=xyzzy

Perhaps strcspn()?
