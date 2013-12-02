From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] use starts_with() and ends_with()
Date: Mon, 02 Dec 2013 10:32:31 -0800
Message-ID: <xmqq1u1vrtmo.fsf@gitster.dls.corp.google.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131202150956.GA20543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 19:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnYIX-0004EL-UE
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 19:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab3LBScl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 13:32:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab3LBSck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 13:32:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B0CB529BD;
	Mon,  2 Dec 2013 13:32:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qERn4zA/cPM9FQAC5yS5JlrtnXs=; b=JRoOnu
	TgWi2FCJvd5B1SYd9kyjxqaigkuYEFVU7+6SceF9slnUuvayjYcbJ50qKu6VvMQ3
	9W7QYg2jypZet+7ntoAwHvLV+m40j7U0CeSdXSWWY2eRbXVkQDIaRGTFS2KX66HM
	nbsWXkacke2RhauW+wWjjherO1OVDc6StpqQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qf4mcp/84ZugjEc9Z43d11KIQRzuyZTs
	aoNFrXUGWCL3uuTckXvb+xac4FGnVIFpqSnnxsW2i3aLz+gXWHCQUMV50OcYcfe5
	SIigP13fAG4/9etzh5F/JXfvNd4x3r5EhU4pphVTdXg3Bqso/A+h4Q8PEtPFeK2t
	9gK5UUKWy4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F4C529BC;
	Mon,  2 Dec 2013 13:32:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 719D3529B7;
	Mon,  2 Dec 2013 13:32:32 -0500 (EST)
In-Reply-To: <20131202150956.GA20543@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Dec 2013 10:09:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BFE6150-5B80-11E3-9455-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238643>

Jeff King <peff@peff.net> writes:

> On Sun, Dec 01, 2013 at 08:49:13AM +0100, Christian Couder wrote:
>
>> This is a new patch series along the lines Junio suggested in this
>> thread:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/238054/
>> 
>> I send it now because I saw a 1.8.5 tag.
>
> This looks sane to me. Your 4/5 did not make it to the list (nor
> directly to me), though. Perhaps because it is huge?

Nor to me, either.
