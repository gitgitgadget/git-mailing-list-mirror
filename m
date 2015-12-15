From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 11:40:59 -0800
Message-ID: <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Dec 15 20:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8vTF-0004mP-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 20:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbbLOTlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2015 14:41:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753616AbbLOTlH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 14:41:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF67731E8A;
	Tue, 15 Dec 2015 14:41:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=if+I6c7KgP0+
	MZMm0bEZnIUDmHo=; b=abzNh1+RvAdBjucj/qrM5UJEULE1KuYkuM8LU5nzuDT0
	m0gNOwSJ/mrPE1yWlF7j9o98zY8YjB2Tw9rGMmR/sogG/zZjQb58bPHqmxvnOxbB
	aZbKTHdnOm4QWnNqhbB0vQ0BVx8nfn7yVSIXmweR7JFCrW8Hnp+fl9hbEc+sWlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K5GSmV
	1tvFtsuZFlIG6Q4gbw3U5ENyTPzvB7saZxqN0ioOoUA85P1Kbm9FaA17UCgZIa2y
	liHv87VeDUqzTsr/PbgqVvH7Oz/c9NkHoAnbO/FkY/7DZuT4myYGkjpD6IKs56sf
	ftoyh7VTF9SJwI2oLZxq/WASrI4NunWUvl0qc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6EFC31E88;
	Tue, 15 Dec 2015 14:41:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C51131E87;
	Tue, 15 Dec 2015 14:41:06 -0500 (EST)
In-Reply-To: <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 15 Dec
 2015 14:04:16
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C866F326-A363-11E5-B0AC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282495>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The way the "config decides" patch series deals with this is that if
> you have the UC information in the index and the configuration is set
> to core.untrackedCache=3Dfalse the UC will be removed from the index.
>
> Otherwise you would indeed easily end up with a stale cache,...

Yeah, that's "correctness" thing; it goes without saying that it
would be unacceptable if the series did not get this right.

I still have a problem with the approach from "design cleanliness"
point of view, primarily that the index already has a bit to tell us
if the user already said that she wants to use the feature, but
because you want to make config win, the code needs to always read
the config to allow it to disable the feature in the index, just in
case the data that is already in the index says otherwise, and the
code has to keep doing that even after the data is removed [*1*].
Unfortunately, I do not think you can solve the "design cleanliness"
problem unless you give up "we want /etc/gitconfig override".

In any case I think we already have agreed to disagree on this
point, so there is no use discussing it any longer from my side.  I
am not closing the door to this series, but I am not convinced,
either.  At least not yet.

> Once this series is applied and git is shipped with it, existing
> users that have set "git update-index --untracked-cache" will have
> their UC feature disabled.

Well, the fix to that is merely just a one-shot thing away, so it
would not be too much of a hassle, no [*2*]?  So I do not think it
would be such a big issue.

> We *could* make even that use-case work by detecting the legacy marke=
r
> for the UC in the index (the uname info), then we'd do a one-time "gi=
t
> config --local core.untrackedCache true" and remove the marker.

I do not think we want to go there---that would mean you would need
to revamp the repository format version because the old tools would
be now unusable on the index/config combo your version mucked with.


[Footnote]

*1* I also do not want to see that design pattern imitated and used
    in other parts of the system, and this gives a precedent for
    people to copy.

*2* Yet, those who are broken by this series may say "it is
    unacceptable that we have to survey all existing repositories
    and selectively add the configuration to the ones that have
    enabled the feature before updating.", the same way you complain
    against the "index already knows" approach.
