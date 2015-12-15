From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 15:03:14 -0800
Message-ID: <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ycv-0004yS-UF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965615AbbLOXDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2015 18:03:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965526AbbLOXDR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 18:03:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A06A1328E1;
	Tue, 15 Dec 2015 18:03:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/Rf62YQjW+42
	8oMsEbMEpylOZGY=; b=GmpdBQfjKIYRTO6da5ZyGIHoYCgbIox5OZ7gRSfFN5a3
	AW5HMd4TkS4DwRlY71yFK4l+68S2V56UHzV18N6M2rfzIdNZ4YN33qFnrDwy1MWk
	JJMJ73YeoPDku+WBoq1boXjMzxyuuvlgaFmXA7GK8/nybYuB71Hvw79wF1DusOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bR/4m0
	pkX0T6E6aGQRvbdVsvWSXA9YH6yic8ibDO1D7huDYiDvsIa0tJYSTiOow/SGOHFD
	AlxFA65ilxb6JVcGCUrqIyyEIzSVMMkPWQqInx4YD+/PUYSeyZ15TBWaQDzH2bZA
	7vYZ2LdoL/fif8asfIg+FwKx0ypPZrKVz4TAg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 977D0328E0;
	Tue, 15 Dec 2015 18:03:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 099A1328DF;
	Tue, 15 Dec 2015 18:03:16 -0500 (EST)
In-Reply-To: <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 15 Dec
 2015 22:53:09
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06473F22-A380-11E5-8DDD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282503>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Of course hindsight is 20/20, but I think that given what's been
> covered in this thread it's been established that it's categorically
> better that if we introduce features like these that they be
> configured through the normal configuration facility rather than the
> configuration being sticky to the index.

I doubt that any such thing has been established at all in this
thread.  It may be true that you and perhaps Christian loudly
repeated it, but loudly repeating something and establishing
something as a fact are slightly different.

The thing is, I do not necessarily view this as "configuration".
The way I see the feature is that you say "--untracked" when you
want the states of untracked paths be kept track of in the index,
just like you say "git add Makefile" when you want the state of
'Makefile' be kept track of in the index.  Either the index keeps
track of it, or it doesn't, based solely on user's request, and the
bit to tell us which is the case is already in the index, exactly
because that is part of the data that is kept track of in the index.

> Since the change in performance really isn't noticeable except on
> really large repositories, which are more likely to have someone
> involved watching the changelog on upgrades I think that's OK.

Especially it is dubious to me that the trade-off you are making
with this design is a good one.  In order to avoid paying a one-time
cost to run "update-index --untracked-cache" at sites that _do_ want
to use that feature (and after that, if you teach "git init" and
"git clone" to pay attention to the "give you the default"
configuration to run it for you, so that your users won't have to),
you are forcing all codepaths that makes any write to the index (not
just "init"-time) to make an extra check with the configuration all
the time for everybody, because you made the presence of the
untracked cache data in the index not usable as a sign that the user
wants to use that feature.  If the feature is something only those
with really large repositories care about, is it a good trade-off to
make everybody pay the runtime cost and make code more complex and
fragile?  I am not yet convinced.
