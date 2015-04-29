From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 10:13:06 -0700
Message-ID: <xmqqegn26eot.fsf@gitster.dls.corp.google.com>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
	<20150428055506.GJ24580@peff.net>
	<CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
	<20150429043947.GA10702@peff.net> <20150429045600.GA10781@peff.net>
	<xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>
	<20150429154857.GA13518@peff.net>
	<xmqqioce6gon.fsf@gitster.dls.corp.google.com>
	<20150429164315.GA26682@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olivier ROLAND <cyrus-dev@edla.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 19:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnVXx-0001wk-Go
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 19:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966146AbbD2RNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 13:13:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965622AbbD2RNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 13:13:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D3F4C98A;
	Wed, 29 Apr 2015 13:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u216p4DTJZQza8P/99xAWtiX1Gw=; b=P1n2uD
	K6BXZFglBYZN7KZfCqPD4Pe1KqSzWyOpqUOapR8OgF5E0SgQ2qEIR8r+0R99sCJd
	bCS8SaSTkVgqd4+JythtUMKH+BtmELwU7FEhYXEbwb/fBSZ165ZT9oxlgZomD3Qu
	N3a1RyY6OFLXr3UCi5JDzojWmQ2d1FT51diDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qGgWhsctWqgHEB8Q7TJs7/yg1UJ6huWD
	ugkEs3Uvc6viQ4lz5GWMj9Y9TiVC+r9KKk9Mjzqiv3aSQfXxCA9gi/EU+cNKXbuY
	bphK8ljxLpPbyD1qK5aOW8/wmceiLZyGwsm3dwV3xKbOZelTYbEgrqEkXG6BsAHl
	/oWOqBTR1nc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 079854C988;
	Wed, 29 Apr 2015 13:13:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F1504C985;
	Wed, 29 Apr 2015 13:13:09 -0400 (EDT)
In-Reply-To: <20150429164315.GA26682@peff.net> (Jeff King's message of "Wed,
	29 Apr 2015 12:43:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02559000-EE93-11E4-9EA3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267984>

Jeff King <peff@peff.net> writes:

> ... would behave incorrectly without "-r". I would be shocked if that ever
> happens in real life, but I think it doesn't hurt to be careful.

Ahh, OK.  I overlooked the continued-line possibility.

> $$ is always the pid of the main shell process,...

Thanks for straightening me out---I was too lazy to run strace ;-)

> ... But I can imagine a shell that is smart
> enough to realize a fork is not required in this instance.

Yup.  I think that is a natural thing to optimize for implementors
of shells.

Thanks.
