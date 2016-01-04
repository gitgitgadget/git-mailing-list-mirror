From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Mon, 04 Jan 2016 10:34:36 -0800
Message-ID: <xmqq60z9p51f.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<20151220074559.GF30662@sigill.intra.peff.net>
	<xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
	<20151221065944.GA3550@sigill.intra.peff.net>
	<xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1512301535550.14434@virtualbox>
	<xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601011604070.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:34:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG9xz-0003IM-BS
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 19:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbcADSeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 13:34:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752592AbcADSej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 13:34:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52F6934DAB;
	Mon,  4 Jan 2016 13:34:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=15/kFOaZenHzXtTBrS9tWIsJbJk=; b=T058T3
	gu8jaou2aY09zYyYDigIh/Ip1MSzwLryAHkfZ0aHg1wOru2MTCibYKLmL3jq6jLA
	WJ8eMiiZ0DbJafmCyQ9ZR9DydeRZ8rSW7KiYdFwv3CARYtpALOqk1Uwov9hLlGym
	iqJ18FMdcFddysXLGIUf/DTotb6QSK0EfENsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q1+SeeVHlQAE9b8zejl0pfejj4agGdI3
	2nmWVrn1FPfY7L3zNGR8Tl5N9rIcSkLYxsbRllewe3Ij1jZjdRo6vstY2NW0HcjS
	eMMJxOPWVpOvOuxXBBJnFnB/k8ztzTsCxtI4H7Mv4ws6zGpEKllivoEcr6epp2Jr
	8ja9sXBKV5w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B04434DAA;
	Mon,  4 Jan 2016 13:34:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C708234DA6;
	Mon,  4 Jan 2016 13:34:37 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601011604070.14434@virtualbox> (Johannes
	Schindelin's message of "Fri, 1 Jan 2016 16:04:25 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF4B5D2C-B311-11E5-B135-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283314>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I do not know fcreate_or_truncate() is a good name, though.
>
> So what would be a good name?

Have been thinking about it, but I did not come up with anything.  I
just know fcreate_or_truncate() is not a good name for multiple
reasons I already explained X-<.  sane_fopen_for_writing() perhaps?
