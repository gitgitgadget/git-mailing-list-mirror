From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/19] mingw: skip test in t1508 that fails due to path conversion
Date: Wed, 27 Jan 2016 12:23:33 -0800
Message-ID: <xmqqzivq7ovu.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<5aea04c3f348e3891a01b6908bf6562a26f9dd1e.1453818790.git.johannes.schindelin@gmx.de>
	<xmqqk2mwatjd.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601270943390.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:23:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOWd1-0004Df-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965486AbcA0UXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:23:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964904AbcA0UXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 15:23:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BBF33E059;
	Wed, 27 Jan 2016 15:23:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hx9vDRy9bLZDLlGv0MSLkbwDvTc=; b=ps22YG
	nxfUB8s6h9kE4ypDrgfRsKJH+nfPRMPyV53iGkzwof1kWz765t2t25MXfSv7Sft+
	LpbIViheF0S7TDqOZDXo5E/V2bPzi/AJYAReLtOCchSBaMlCJPj5iHhbl4sEoOGz
	waOnMHQ47CR4NULOCFh1BeKucv9QEXmksVHtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R5Z2yr0hOpUb9oErUCID2DEDC7uk9XXe
	EMarJ9xb++YP9/CzwNUixfBu0L0ws0wr0ztpYqowNwCB5Ga/YdGSkQT0UQNdwchY
	oYGHu97sy/TPgmKt8KuZk1L9klIcSdtzQ75BFaTcsqEUiTMizsMfrpzCKvQ+vcTd
	ut3EjT5/xEs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33A293E058;
	Wed, 27 Jan 2016 15:23:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AAE2F3E054;
	Wed, 27 Jan 2016 15:23:34 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601270943390.2964@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Jan 2016 09:50:07 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7151CC6-C533-11E5-ABBD-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 26 Jan 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > @@ -35,7 +35,10 @@ test_expect_success 'setup' '
>> >  	git checkout -b upstream-branch &&
>> >  	test_commit upstream-one &&
>> >  	test_commit upstream-two &&
>> > -	git checkout -b @/at-test &&
>> > +	if ! test_have_prereq MINGW
>> > +	then
>> > +		git checkout -b @/at-slash
>> 
>> I presume that this is meant to be "@/at-test", not "@/at-slash".
>
> Oh my. That's what you get for redoing patches from scratch. Sorry about
> that!

Heh.  That is why it makes me feel uneasy, after asking you to fetch
from me and fix it up, to hear that you will send in a new reroll.
