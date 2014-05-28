From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 08/11] trailer: add tests for "git interpret-trailers"
Date: Wed, 28 May 2014 12:28:33 -0700
Message-ID: <xmqqioopd7oe.fsf@gitster.dls.corp.google.com>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
	<20140525053223.5329.36492.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed May 28 21:28:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpjWl-0003rQ-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbaE1T2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:28:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51512 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbaE1T2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:28:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7428C1B9A3;
	Wed, 28 May 2014 15:28:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m7SfCN9sert0HTpGrprOZ2S/g6M=; b=T4OUpl
	kE+H6XY8r0SYQsr3c0VdYTwzH9QI2A6Ho78b0xrVhtYC7DjK1YTNzkWcl8GZA+78
	i2r69k+VNKbzCwaPJCeZGDa0hT2LqPqQe7kQ5nhqOgQ+BYxg98I4hHvWux5NeOyj
	s294tiP5sqe07N7EyzfhUBpUXjrMa+ZZ+a0tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F5OXh+bqBcVQSrqUbweOT1c8p3o7YFDf
	70orPnqtdwvjaWN/WygXYlJxjp2oDpTJNky61PGf+fI/21OSfqYTZ15WPP5V+HKD
	tJkNZkTXLqjjV4kd73YV4cRxG/f9y3YGZT9xpWSsAi+iPLFniM1DmMyPHs6cGwJ1
	+rAUuiCedao=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67A561B9A0;
	Wed, 28 May 2014 15:28:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDA4E1B998;
	Wed, 28 May 2014 15:28:34 -0400 (EDT)
In-Reply-To: <20140525053223.5329.36492.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 25 May 2014 07:32:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42C1756C-E69E-11E3-889F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250319>

Christian Couder <chriscool@tuxfamily.org> writes:

> +test_expect_success 'using "where = before" for a token in the middle of the message' '
> +	git config trailer.review.key "Reviewed-by:" &&

Don't you want to adjust this to have trailing SP, just like you
adjusted other ones like "Fixes: " in this round?
