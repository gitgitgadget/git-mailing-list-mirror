From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Fri, 08 Jan 2016 11:43:24 -0800
Message-ID: <xmqqpoxb26xv.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
	<xmqqbn97cyh3.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD35VZ3QCLg525RCpacDrRHqt7EhxV1MeL-9xxHf8BCZ+A@mail.gmail.com>
	<xmqqd1thp683.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD2eJjR4QxtE0x8BbKOAGwi4cwERG7bF89apPbJye356AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 20:43:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHcwf-0002H4-H8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 20:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbcAHTn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 14:43:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933025AbcAHTn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 14:43:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41C8D3A9BC;
	Fri,  8 Jan 2016 14:43:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzO0eFmZnxpd2HGg2Em4SwNt4Ag=; b=P2pYCy
	tlW3Q2jHEiLJ585VSsxsITwfDJWSWZav00gDmimtSyNyKySgoiqNsGc7/5SJtjKr
	8qACEpvqGv1VUfuEXIleozb1r+mOqTs62ESpm37FNvRuU7IGR861T3xKIXAkMwYh
	7L/gMeHXdTO/aWLuVpoie/g3eyOYxCFjlHgH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMeN8oqBwTaLYmCCvMgEVb7kBfqsb8Vw
	WhYRq7KfJ+1ybzELkkVBDKSiUAGpSUtE0uKR9UAE8lZinWQ5x3fhYqfoysC+gKrY
	us4vDwCc4c7W8Ie7oa+VCZD/4QZvPLrJymNFauVkReV6qwEFZ71bTXNxoVDXFNi2
	+7QXbGe0vHw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 371A93A9BB;
	Fri,  8 Jan 2016 14:43:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A6FC43A9BA;
	Fri,  8 Jan 2016 14:43:25 -0500 (EST)
In-Reply-To: <CAP8UFD2eJjR4QxtE0x8BbKOAGwi4cwERG7bF89apPbJye356AQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 8 Jan 2016 18:52:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15639960-B640-11E5-9EE9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283578>

Christian Couder <christian.couder@gmail.com> writes:

> I just tried Duy's approach by moving into read_index_from() the code
> I had put in wt_status_collect_untracked() and it doesn't work because
> "git status" calls read_index_from() before calling
> git_default_core_config().

I didn't expect to (and didn't want to) see the configuration be
dead by git_default_core_config() in the first place, though.
I instead was expecting that it would be done through the caching
layer, e.g. by calling git_config_get_maybe_bool() interface when
read_index_from() wants to see if it needs to muck with the existing
(or missing) extension.
