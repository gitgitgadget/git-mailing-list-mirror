From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Fri, 28 Sep 2012 16:18:58 -0700
Message-ID: <7vehllka71.fsf@alter.siamese.dyndns.org>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net> <m24nmh4x1t.fsf@igel.home>
 <20120928223152.GA7906@sigill.intra.peff.net>
 <7vipaxkayf.fsf@alter.siamese.dyndns.org>
 <20120928230410.GA9851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 29 01:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THjpx-0006Gr-Sb
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 01:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab2I1XTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 19:19:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514Ab2I1XTB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 19:19:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDD599511;
	Fri, 28 Sep 2012 19:19:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P3torBQtLV/9tg9PmnGNMLrWdr8=; b=vrBzqo
	PqtWveeSOrt7pE0xfrYk344XL3g4NrZiQ45FLwPbobere0/xw5BRnRM4YxInC3E6
	jiPQfO1BlDZlEOJS9+pdWkbMlpossu4315Pm2XLw6v/ZaqgWM86t8zuM1VcM0iav
	tfYXz4M/Dn/aoWS+6hSMaFo5qr009VSo+llFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K1PJkJjPvxIFDeyaKw5IhD5LVwrpWKok
	X7MmccIqF49HT/kFC6rMItHHxLLa1xZ1p4QKyhlx9s6zJpnM1FSXg/1Zx+FXsvsj
	g8QhPIZaC7LW7vX5j4bJ/zDWdU4dLYX2GILbfeQMLu7+/KyjvbGL0/zmdp9DKHk4
	qAzoTEQdb0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAEC69510;
	Fri, 28 Sep 2012 19:19:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D2E9950E; Fri, 28 Sep 2012
 19:19:00 -0400 (EDT)
In-Reply-To: <20120928230410.GA9851@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 28 Sep 2012 19:04:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E271886E-09C2-11E2-B9B5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206617>

Jeff King <peff@peff.net> writes:

> I think the weird tcl-catches-stderr thing kicks in (at least it did for
> me in a simple experiment). But like I said, I am not an expert.

OK, I'll believe you ;-)
