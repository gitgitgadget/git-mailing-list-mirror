From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Thu, 28 Mar 2013 09:54:20 -0700
Message-ID: <7vhajvv51f.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULG6K-00084F-8T
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101Ab3C1Qy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:54:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756535Ab3C1QyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:54:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A04CAFDD;
	Thu, 28 Mar 2013 12:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=azCn6SK5do+C2BTJTR2Bs7o5RcM=; b=jWlkhw
	tOtmc1o5oFkww0eXCRZ8FkAJTRm853ioPexoNY/9U5uO9T+CK7H+3BTJRI4OOTMx
	NXv6h4F4YEoL1+w5RUVuMAfWsjXY192E8cxsXu1Py1rCVY25im23p8gGjfjZ2og6
	FrVC/ztOdEg0YCTgRGBcEf6qSlkINpz/+MX6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZlEfubXFCP5I0Lcs/6pRQi23U5JmVyW
	KEDr2DB4C8mCxKpytgaH+3YsbETVmTRijal+TK0rvZf9fJyCG2/whZ9FXpPzBepT
	zQ+Hg8xYhTuXIRIOhyDu9AGVvLaaUMGHrZry1cm5LIuqqwidIsamxXxaA3wCK1d4
	dLf4sG/rzIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CCB9AFDC;
	Thu, 28 Mar 2013 12:54:22 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11EF4AFDB; Thu, 28 Mar 2013
 12:54:21 -0400 (EDT)
In-Reply-To: <20130328153547.GA3337@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 11:35:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2396050C-97C8-11E2-9B64-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219436>

Jeff King <peff@peff.net> writes:

> Sometimes it's annoyingly verbose to break down a compound function. But
> I think in this case, you can make your tests more robust by just
> checking the affirmative that the ref is still where we expect it to be,
> like:
>
>   check_push_result up_repo $the_first_commit heads/master
>
> Sorry if that was a bit long-winded. I think that practically speaking,
> it is not a likely source of problems in this case. But it's an
> anti-pattern in our tests that I think is worth mentioning.

Thanks.  That is one of the reasons why we do not want to see too
many custom test helper functions.
