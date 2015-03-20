From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Convert parts of refs.c to struct object_id
Date: Fri, 20 Mar 2015 12:52:20 -0700
Message-ID: <xmqq8uere9aj.fsf@gitster.dls.corp.google.com>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:52:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2y6-0006Tq-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbbCTTwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:52:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750925AbbCTTwY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 15:52:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 930DA409F5;
	Fri, 20 Mar 2015 15:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFSlh5B3rjzsFvkhxVLa2PVVNRo=; b=EzqCSH
	I0mBh7mKl+zIFv6tT11KE6K9TtS9fsLnsRYXDTmBp7+h95nfeXokYR6BCsHib3Bp
	WNBAR2Vyj9CKulIDzgD4MVJqQM0GVj+TARY1c3ZBI1Uddf0uq/w9uvqq+KiDTogH
	YpNq/rawiGf8yB2OSPOKPW8RQ2qxrt2QXmAFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chD2UwJ+WQRZ/lnxCCa0JvIZ8+Cv/Dk6
	+3+uUy4t8a+VXsLSZtMgWg81dKTTFMtlREtY/zKvqJCDO0WHIEnhKyR9fbvI7UPs
	wLQdPEjgc2eNYyLCxEhjy3rwLQkMzqBDKttB2bqBTMAW8umIXe1PnxgzyfLyUxdj
	6Hodp9CYnNU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 860FD409F4;
	Fri, 20 Mar 2015 15:52:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEC34409F3;
	Fri, 20 Mar 2015 15:52:21 -0400 (EDT)
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Fri, 20 Mar 2015 19:28:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F8FD25E-CF3A-11E4-8B6F-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265958>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is part 1 of n in converting code to use struct object_id.

OK --- 'n' up there looked funny ;-)

I'd like to see the series reviewed by those who recently worked
heavily on the subsystem involved (namely, refs API); please do not
forget to include area experts to Cc the next time around when you
update the other areas with the same theme.  On the other hand, once
the "struct object_id" design is settled and everybody agrees that
it is good enough, those who were involved in the review of that
framework do not necessarily have to be on the Cc list (of course
they are welcome to participate).  But reviews by area experts are
more important to avoid breaking the users in the individual areas
that are now going to use the new object-id infrastructure.

Thanks.
