From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Tue, 01 Dec 2015 18:24:10 -0800
Message-ID: <xmqqtwo16111.fsf@gitster.mtv.corp.google.com>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
	<5655D755.8060503@atlas-elektronik.com>
	<5655DAE7.2000008@informatik.uni-hamburg.de>
	<20151202005826.GE28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>,
	stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3x5e-0006nO-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 03:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbbLBCYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 21:24:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755946AbbLBCYO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 21:24:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A1DF30BD1;
	Tue,  1 Dec 2015 21:24:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CK9kfgHj5SpzpFKwI6gDuBYUKRQ=; b=vybnbT
	d5viNmR66P9upl8u31pkzlIRZL28qnAfOt64PQj6seFgAmjcVvMs0DJY8P24DmUl
	qdLHuu9zsauak7ef1di0eyMXKVqFk9UyiyLeDoeYXdJEtJoEXf+5O7LGSkGXmuch
	RWguqmRfIEfPllrQglIJzeXrKb9fG/QELOXRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n8gDVZo1eKA/ezFX2IW0pF/AzR/V36cG
	yI891hp3HD4bD2Vn0abDsuOsM8ehJQGfPTJdRAQiBIod9SQ0b56kA+MSxFX4QwPx
	g5o66b8s1eWudkj+ka+yytP7fAg64qlxyto9kRDjPBo2cd5zOKrf+d44K/05rRPj
	Td2JpvkeX/w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32B3A30BCE;
	Tue,  1 Dec 2015 21:24:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB7C230BC9;
	Tue,  1 Dec 2015 21:24:11 -0500 (EST)
In-Reply-To: <20151202005826.GE28197@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Dec 2015 19:58:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C6317DC4-989B-11E5-B0D2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281876>

Jeff King <peff@peff.net> writes:

> The "[]" convention is a microformat used by Linux kernel folks. So it's
> not "whoops, we are stripping stuff not added by git". It is respecting
> a microformat used by the tool's authors.
>
> That being said, if we were choosing a default from scratch today, it
> might go the other way. But we aren't, and we have to deal with the
> burden of breaking existing scripts by flipping it.

And I do think it no longer is sensible to expect that it still is
kernel-only convention.  Any project that uses e-mail based workflow
with Git have known how "[]" microformat works, may even have taken
advantage of it to build their workflow around it, and flipping the
default will only hurt them.

A project that chooses not to follow the convention can easily tweak
a knob to keep using different conventions, so I do not see anything
to change here.
