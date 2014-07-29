From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 10:00:22 -0700
Message-ID: <xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
	<CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
	<20140729025940.GA8640@vauxhall.crustytoothpaste.net>
	<20140729092301.GA13134@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCAlQ-0007CT-P0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbaG2RAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:00:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60554 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaG2RAc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:00:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65E342BE79;
	Tue, 29 Jul 2014 13:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=plpRZonMJnTEjSbop79V4h9D5ko=; b=o9PR2Z
	kr3Cfk4jOZhnE9KkJU9urvsH8nLxQsueob7P9LeLoDb8DQtSZXxcJQI75BhYM8Lj
	XW/Zvra9K/P52FfY5EYjgKZj0MWfOLdW4Nh8DFvvNUnXh1jOhV+lZma0U0t8e6R/
	bUp37YL7Z645HiVpISMILNj8Z9Pfs9GQ9IxYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JYQAJhU0Hna27SyM6CiLOmzR5h/yd5yf
	y+3a6jR/pLK8w7+tQI0cuhSkNCIxpi/b2iG75G0y+16o5gb9PXfGo7AJA2/29JTB
	hVyXV7jH7iE23gTZD6bxf4xy0Fqm4uMQVg2E5wswzQHlTx2c/9e6hIaQltDLq6ln
	x7/7PMR68FY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A7F62BE78;
	Tue, 29 Jul 2014 13:00:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B17BC2BE6D;
	Tue, 29 Jul 2014 13:00:24 -0400 (EDT)
In-Reply-To: <20140729092301.GA13134@peff.net> (Jeff King's message of "Tue,
	29 Jul 2014 05:23:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D5552DC8-1741-11E4-87B7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254447>

Jeff King <peff@peff.net> writes:

> So perhaps we could do something better on the viewing side, and
> "simplify" combined merges for files with all-identical parents.

Or you can ask to show the difference with the first parent, no?

I do not think giving a single-parent diff when --cc/-c is asked
for, which is a clear indication that the caller is aware that the
commit in question is a merge, is such a good idea.
