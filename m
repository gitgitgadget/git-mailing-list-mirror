From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] parse-options: disallow --no-no-sth
Date: Tue, 28 Feb 2012 13:15:10 -0800
Message-ID: <7vlinmy80x.fsf@alter.siamese.dyndns.org>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org>
 <87d390smpa.fsf@thomas.inf.ethz.ch> <7v8vjob3ff.fsf@alter.siamese.dyndns.org>
 <4F4BC3B3.7080000@lsrfire.ath.cx> <7vzkc457g3.fsf@alter.siamese.dyndns.org>
 <4F4D3545.6060704@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Feb 28 22:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2UTP-0000Am-OQ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 22:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113Ab2B1VPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 16:15:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965001Ab2B1VPN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 16:15:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A9317E5B;
	Tue, 28 Feb 2012 16:15:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KW1PPTtnHIo+
	CXO3vWjD5R/f7qA=; b=btvbH4n5QGp/SiM04qACcB7g3ClX7/B8nxa1FaWXUQQn
	wi411Mld2vBGTqTJ17o7rDS2KOQHZq89VEx6f3Qx2/2Yz6F67NGY44taqexWM8W4
	rAvYeGrOyQ4qfwfsPEI6S6uPFYolLdrXgRDxftvvNCXFhqACRZRG/AsUgnWRE3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qQNIfi
	pCr6olthPOd9CzR5yd9rEYvUeoE6j4GGUDCqmbR5EG3fNI42T8QI+wWNeTn734B6
	2M0rH0Y6r05oWQCI/d+UQKvuSMoiUnRInBN9JW6r+Nvbo+8+7c6gZYMAHac1zvVY
	Si7O81aBExU0sUq+dWWauhsqvtAuydGNX4IrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40E3B7E5A;
	Tue, 28 Feb 2012 16:15:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5E0B7E59; Tue, 28 Feb 2012
 16:15:11 -0500 (EST)
In-Reply-To: <4F4D3545.6060704@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 28 Feb 2012 21:12:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CD2F716-6251-11E1-A703-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191786>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Now that options whose definition starts with "no-" can be negated
> by removing said "no-", there is no need anymore to allow them to
> be negated by adding a second "no-", which just looks silly.

Thanks.  But accepting them silently and do what the user would have
expected, especially if we do not advertise it, would not hurt anybody,
no?
