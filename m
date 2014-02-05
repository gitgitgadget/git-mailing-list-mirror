From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 12:31:34 -0800
Message-ID: <xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
	<20140205011632.GA3923@sigill.intra.peff.net>
	<xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
	<20140205201243.GA16899@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:31:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB98M-0003q4-F1
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbaBEUbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:31:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932718AbaBEUbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:31:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE3B67C74;
	Wed,  5 Feb 2014 15:31:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3/Jaqf3B+n+LAE/hHMgwX0Fc+9c=; b=x43dMw
	rXFgAzt61qZ2/r+BS1kN0pW9G32bUUMwswVX9igrqUfH6mEeBwR9ohIxFRwZTic4
	W2Zrmsg16xBlgzdVAXQVguSyd24LczE4XOtLYOC/0OWPiQzDbHIkkHs6tb1GW+/k
	vjzM9qRu1pt7QSU204yb6wrJywkN4eEvf3tHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G+YvP3t/SiVyfZCnYK68u1c/voVAbT1L
	7WAJZWqHJad2MCnFCepPB/PPKa8FknzU9q3WDemzPKMuS/5zm9NmyZuid5ypNO6D
	CdCc94ZzmbwSN1tQq7sVYIZN5WnYPOZcZlyIzyMGHlJm2Z/PmEvFYONZ0Ax0xNWg
	EfkXeWm5XMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7684267C73;
	Wed,  5 Feb 2014 15:31:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DA8A67C6C;
	Wed,  5 Feb 2014 15:31:37 -0500 (EST)
In-Reply-To: <20140205201243.GA16899@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 15:12:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82F1E2F4-8EA4-11E3-A9BD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241653>

Jeff King <peff@peff.net> writes:

> The minimal fix you posted below does make sense to me as a stopgap, and
> we can look into dropping the code entirely during the next cycle. It
> would be nice to have a test to cover this case, though.

Sounds sensible.  Run "repack -a -d" once, and then another while
forcing it to be single threaded, or something?
