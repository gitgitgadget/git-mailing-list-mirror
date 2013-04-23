From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 09:03:42 -0700
Message-ID: <7vobd5jktd.fsf@alter.siamese.dyndns.org>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
	<CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
	<CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
	<87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr>
	<7vmwsqns4p.fsf@alter.siamese.dyndns.org>
	<CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
	<7vehe2m88a.fsf@alter.siamese.dyndns.org>
	<CALkWK0noVfRoXAH75r4yBijXSHD5yusLcKgGC=8bjOW6=qCMng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUfh8-0001Rc-LR
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab3DWQDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:03:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466Ab3DWQDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:03:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C62D918CF9;
	Tue, 23 Apr 2013 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s9K/2sDEvVTFXOq38Cve10pCQWo=; b=ueWyM7
	xQpMzGdPRbQcIqmec5+tOgsgBGZeSdb1gqkQB2iiLEKUP4C2lwHId2qhiRF3bTRa
	STR9/VlUf06DJefpEVGw9w0yAM3qi0NUmXT/YMJOp5pA2PLO/vRVFr2X1kKNScvn
	gj9Q/5Svilx358l30/20EhFgVjTAnPf6OcCV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uiAVzEmq8yF05rHFIywTnAJmDmwoB2Fs
	JxnLa4pO5CEc+ddpeQf/1BUUqArnAss9kvkyKj+P1SqDKBFMkDlyGaLcedJBXlXY
	Q8M2TbuC6bVWISsyRKrqky56dRiL7Z/WsgXhd8UC8zfIWSg8YLURnfT/sjsUKhmg
	6mYb5JnHO9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8AF18CF8;
	Tue, 23 Apr 2013 16:03:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25BBE18CF7;
	Tue, 23 Apr 2013 16:03:44 +0000 (UTC)
In-Reply-To: <CALkWK0noVfRoXAH75r4yBijXSHD5yusLcKgGC=8bjOW6=qCMng@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 23 Apr 2013 13:23:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F96695E-AC2F-11E2-8199-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222183>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Further, this can speed up tree-rename detection greatly (in fact, I'm
> thinking the first implementation will depend on this information
> being present).  I inspect M^{tree} and I want to know how it's
> composed from M^1^{tree} and M^2^{tree}.  Simple.  In M^{tree}, look
> for trees that have this additional data filled in: then we can just
> short-circuit the rename detection to matching the similarity of this
> tree with M^1^{tree} and M^2^{tree}.

If you need the history context (i.e. M, M^1, M^2) around it to
interpret that additional information, isn't it essentially the same
as storing renames in the merge commit M?

Not very impressed, at least not yet.
