From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 5/7] bisect: introduce --no-checkout support into
 porcelain.
Date: Wed, 03 Aug 2011 17:32:22 -0700
Message-ID: <7vy5za6mp5.fsf@alter.siamese.dyndns.org>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
 <1312408626-8600-6-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 02:32:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QolrS-0004ex-LR
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 02:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab1HDAc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 20:32:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756122Ab1HDAcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 20:32:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C903E5EC7;
	Wed,  3 Aug 2011 20:32:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wo5KOGhgYguN/IMXxtjtRde0j9Y=; b=AvPDBG
	ZgDxYzvqcix+bNhnzJvmu2UqGJbNGNYtpcZlMihw82BcvNIRAqo0r/B9fkv0ok5u
	rkeiT4YlXGpnUvPFJxgE/i3EuZkTMxf5ke3Ms7NosrFDvCaQyKQKyux4uWOBBcfj
	v/Mq6FC6NZqVvR5+e5acEV/2Bka7F4MixOxYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgZ5MQuM1F2BKP/J4GRxAiFLSIjlCOcR
	Dyo21StzB3vv5l0V0x3zuTCKj5r+4dJIye5ACVhgYnWPeh9j6zgD2luFJisE/5d2
	RQ8ohLUhE81kOIj/S0RfhcT4HFypEzQi4W+ARGmnI50ph0goZydmPbei84OvnNsC
	FIvQ1gSEv4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03485EC6;
	Wed,  3 Aug 2011 20:32:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5199A5EC5; Wed,  3 Aug 2011
 20:32:24 -0400 (EDT)
In-Reply-To: <1312408626-8600-6-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Thu, 4 Aug 2011 07:57:04 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 393355B2-BE31-11E0-84CC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178647>

Jon Seymour <jon.seymour@gmail.com> writes:

> +bisect_head()
> +{
> +	if test -f "$GIT_DIR/BISECT_HEAD"; then
> +		echo BISECT_HEAD;
> +	else

	if test -f ...
        then
        	echo BISECT_HEAD
	else

> +	    --no-checkout)
> +		mode=--no-checkout;

You seem to be very fond of extraneous semicolons.

Also I very much prefer to write "then" on its own line, indented at the
same level as "if". Consistently doing so will make your if statement a
lot easier to read when some of them need to have multi-line conditionals.
