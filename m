From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line style of the context
Date: Wed, 27 Jan 2016 10:19:55 -0800
Message-ID: <xmqqio2e996c.fsf@gitster.mtv.corp.google.com>
References: <cover.1453709205.git.johannes.schindelin@gmx.de>
	<cover.1453819314.git.johannes.schindelin@gmx.de>
	<13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de>
	<xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
	<xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601270856150.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOUhY-00033M-2G
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 19:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395AbcA0SUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 13:20:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934217AbcA0ST7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 13:19:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4A933D449;
	Wed, 27 Jan 2016 13:19:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1XsUqjcDe3ZgK0l7rF6OPEQqL7E=; b=wcDJgN
	JLlQzmzEgn+0TxmfdtT0X5g5YeDA/EClFexFxu520aO0+PdJzjDHR8/SPMqfHrlq
	380QYjWt+9QB8mkyM4P6FDbjrsOQ76lv/y5cFdPEG2KPYFgamvU/5niPy3b3UMYo
	nzyGTgtdPvrsAQVnAG8+RsmrB/WY93LycrNj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXBPEpYYbtIdmRAFIA8rD0Fk6n+6nlmy
	h6Fo4SlYXn3MTw99sY8sPqd5zDjvEwPSY/ptHuI1X8z0Q03AnzxVx+mYVJexQ5Em
	W0jTH3yG/x+wT2/LTFMxaQ++aSYco9hO+OhJNlLR0jMr3uwfVmm9uR/4bw24yCC1
	Z9JCTbQ1Jx4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5C9A3D445;
	Wed, 27 Jan 2016 13:19:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D471C3D443;
	Wed, 27 Jan 2016 13:19:56 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601270856150.2964@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Jan 2016 08:58:59 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91C0561A-C522-11E5-900C-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284946>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Just in case it was unclear, none of the comment above means I want
>> any part of the patch redone--I am happy with this patch as-is.
>
> Thanks for saying that... I was about to try to make things clearer, but I
> could not think of a better term than "needs_cr".

I don't, either ;-).

The primary reason I respond with the "I find this a bit confusing
but it probably is just me" (not just to this patch) is to give an
example of a review comment that demonstrates to the others that the
reviewer understood what is in the patch and the issues around the
change better than a mere unsubstantiated "These look OK to me.",
which does not tell us how carefully the proposed change was
reviewed by the reviewer--such a review does not allow me to "trust
the review that is already done by others" and apply the patches
with minimum cursory scanning and I end up having to carefully read
them myself.
