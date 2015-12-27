From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Sun, 27 Dec 2015 12:21:22 -0800
Message-ID: <xmqqege7bq2l.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	<xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
	<20151216024605.GA618@sigill.intra.peff.net>
	<xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
	<xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
	<20151217074443.GA4830@sigill.intra.peff.net>
	<CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
	<xmqqy4cnfyds.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AF-7ULixapHmTtCia9x0HTtJ1nmnAER9A3BeLVjQM_Mg@mail.gmail.com>
	<xmqqh9jae94o.fsf@gitster.mtv.corp.google.com>
	<xmqqio3obody.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AO0BumZQmwWNVHL-viGLY=ExE3syJOt1h75zeQug95mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 21:21:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDHot-0008Be-7c
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 21:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbbL0UVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 15:21:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751914AbbL0UV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 15:21:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0C8D3679A;
	Sun, 27 Dec 2015 15:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l6V8m+fNfwNKnjV1/EtDs9EhNrc=; b=ZDk/8x
	GgLzjdR4LiyWM1Ya721TK2ejkxNgICzehnYoEc3AAjkC55qQiqmVtwt3gigvVzLc
	sPmzOm86oKTLpxtPnwzDQH31fkdpedKLp85t5K+F4DOr1c8eIzTzrHchoZMCm6lQ
	v5mWIU7QNjHXIOd55/YxUqB+sH7LcDAi2Trmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZBIyFw4PzURcMlf0jOBjuf2RPaoWWAbN
	PU2lD8xDCftY4y0LnZWm+NszQAxNx0I04txkjar4wnYfU/7Itvyjuh0harc+MfaY
	kwFjSTc7QXg2GJpoLM+w82v2z5uPgojE1/2xNFrQMLTmH8ONIRc0amOywPBmdDdB
	8fjBNYEtqNE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8CA136799;
	Sun, 27 Dec 2015 15:21:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 461C036798;
	Sun, 27 Dec 2015 15:21:23 -0500 (EST)
In-Reply-To: <CACsJy8AO0BumZQmwWNVHL-viGLY=ExE3syJOt1h75zeQug95mQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 24 Dec 2015 16:49:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 65FD0A68-ACD7-11E5-B9FE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283018>

Duy Nguyen <pclouds@gmail.com> writes:

> Sounds good, except..
>
>> When write_index() writes out an index that wasn't initialized from
>> the filesystem, a new UNTR gets added only when the configuration is
>> set to 'true' and there is no in-core UNTR already.
>
> Do we really need this?

We don't; you're right.

Thanks.
