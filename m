From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] completion: add git status
Date: Fri, 03 Jun 2016 10:54:50 -0700
Message-ID: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
	<9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
	<1464880296.3720.0.camel@virtuell-zuhause.de>
	<xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
	<8f5e515b-8efc-0160-820e-d81885fc6c36@virtuell-zuhause.de>
	<xmqqzir2p6yv.fsf@gitster.mtv.corp.google.com>
	<20160603171711.GC3858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:55:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8tJF-00005z-JB
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbcFCRyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 13:54:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcFCRyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:54:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0E891EE0E;
	Fri,  3 Jun 2016 13:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfeGYvOurnmtFMXFhEhYOoms3EY=; b=HLyQKj
	ibqDgh5iVnxgXZqlNnub5PwFb9nik/TMxZmD9Tns+WyRq4Z8FutyFARl2Kv381vF
	hOniq7+Sg2Y/BK15HiQDeFGQCfFVkNonpPBzVBjFh/y1WeaJ3vDDuC6wxDNHUlNi
	g3EQ6JbdBe+q1/7LRc/a0IVm2mM8GZnm+8Hn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQz3sniXnh88iZ3UoyEea1Aq+5aiWtUl
	xZGdt1NtrQlnql36uafz2wIk5KSBi0daYb2+z8njt3ydNHAhZQ+Jrh67aDur+Vx1
	eWyxWAsQmQ0ZkvgOK54xGX4T0k56QGjHVrqUonb3orF4IU4dEAs7f3Q5cAZCXFI4
	WSehJOszY8U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B844B1EE0D;
	Fri,  3 Jun 2016 13:54:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EA671EE0C;
	Fri,  3 Jun 2016 13:54:52 -0400 (EDT)
In-Reply-To: <20160603171711.GC3858@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 3 Jun 2016 13:17:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45CD8B50-29B4-11E6-B904-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296358>

Jeff King <peff@peff.net> writes:

> I know not everybody will the "natural thing" I claim, and if it were
> easy to support everywhere, I don't mind doing it. But I suspect
> (without thinking very hard on it) that it would make those case
> statements a bit harder to read and maintain.

Oh, I agree with that 100%.  I didn't mean to suggest (let alone to
demand) to support the possible truncations.

I simply was hoping that Thomas would respond with your "For a user
who uses tab completion, it is natural to use --unt<TAB> so by the
time we use find-on-command-line, we can expect the fully-spelled
form" when I asked about "--unt=no"; that would give us a warm and
fuzzy confirmation that the patch author has thought things through
when designing the new feature.
