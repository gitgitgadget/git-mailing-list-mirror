From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Mon, 10 Nov 2014 09:49:34 -0800
Message-ID: <xmqqbnof9c9d.fsf@gitster.dls.corp.google.com>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
	<20141109092344.4864.88180.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 18:49:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnt5y-0004K1-5T
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 18:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbaKJRti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 12:49:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752910AbaKJRth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 12:49:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56F281C60B;
	Mon, 10 Nov 2014 12:49:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=StEBB9pFeDc3Br+9AdV+xJc+fhY=; b=ainDPh
	HGxv6toyXClrv0ozXIJpzcie7v0G9UqVKoht8EkHAEKpqBODZfQyyoz2s22w04Gy
	OUrFU2n3xYEgowJrnP7xypOOT+umV8C5yBwQ5Jqra4IxiuLLqJk7SRutLboFl6IC
	Hu8ux+dtumLF+r45LTOLvBQP4sQYH4c1za0F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E4fLBKuOPVzEWbE4S7SAp2tsZ8WWKgqc
	N5xp28UnHXtVvz0QQ5kyemZLxcZWHlogcc2uf6DlnNtnFx5Fxe1ERAQi1J/2Mag4
	X9oga9cKL/S0/8ZreFcgnpHX+UANrUevIKidWDvl7UovCgPLl5wMgpeUMNNmSmb7
	mGMvNqrW9Mo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D4591C609;
	Mon, 10 Nov 2014 12:49:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBDC41C608;
	Mon, 10 Nov 2014 12:49:35 -0500 (EST)
In-Reply-To: <20141109092344.4864.88180.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 09 Nov 2014 10:23:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF4B473C-6901-11E4-8D02-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <chriscool@tuxfamily.org> writes:

> Make sure we look for trailers before any conflict line
> by reusing the ignore_non_trailer() function.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

It makes sense to unify the logic to decide where the trailer block
is, I would think.  I however don't think I helped this change in
any way, not more than "maintained the codebase as a solid
foundation to build new features on", but at that point it would
apply to any other change and not worth mentioning ;-).
