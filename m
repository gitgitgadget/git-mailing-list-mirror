From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] config: add '--sources' option to print the source of a config value
Date: Sat, 13 Feb 2016 13:05:53 -0800
Message-ID: <xmqqegcgs4lq.fsf@gitster.mtv.corp.google.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
	<CANoM8SWj08qKvDXhyfRXLV2iuYJ7Vjdutzjt0Q2ZNOcProqy=Q@mail.gmail.com>
	<20160213181901.GC9516@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Rappazzo <rappazzo@gmail.com>, larsxschneider@gmail.com,
	Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	ramsay@ramsayjones.plus.com,
	Eric Sunshine <sunshine@sunshineco.com>, hvoigt@hvoigt.net,
	sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 22:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUhOB-0002U0-PU
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 22:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbcBMVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 16:05:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751306AbcBMVFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 16:05:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04BF842C0A;
	Sat, 13 Feb 2016 16:05:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cM+FqUtOZqJgG7Hf9HBw4fe7MHw=; b=sy+gIK
	yRrHIXz5Ed5RPjtxbqxmwq6z0FbHixrNU1srszEm6iNkJQBk6zjUJv/tAdZ3utVs
	gjipHwMijXy5UCRM29AumDDFuv0yPmnjHix5FGmXUIVGfLo5HCjjodoLp1zjhSOo
	EpG1C2ivnYSVhL7Un3AWDk0y/uVPKpKVOiHQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcTMfX1P4UmRezox5iPjfiu3d0evH/6Z
	OENqwQu/kly7aMRpMkdkWpNrMQ27UeM6NAL/CSL4QhwQ2aMQ4Aht/x+ViwDMNWKC
	a5s/SsCv7CH6MTxy81aXY3w5vQFltxVJ71d9XZ8u5ZIsEpEi2sna2GUp/j5u93lE
	MNZdjHeJV1s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF70342C09;
	Sat, 13 Feb 2016 16:05:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E1D642C08;
	Sat, 13 Feb 2016 16:05:54 -0500 (EST)
In-Reply-To: <20160213181901.GC9516@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 13 Feb 2016 13:19:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91F57914-D295-11E5-8756-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286129>

Jeff King <peff@peff.net> writes:

> I'm actually opposed to "--verbose" because it is too vague. That is
> fine for a human, but this is also an interface that we expect scripts
> to parse, and which we therefore cannot later change without breaking
> them. I am not prepared to set "--verbose" in stone as showing the
> source file and nothing else, for all time.

Me neither.  Thanks for clearly spelling out why using --verbose for
this is not such a good idea.
