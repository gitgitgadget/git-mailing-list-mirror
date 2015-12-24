From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Wed, 23 Dec 2015 17:56:25 -0800
Message-ID: <xmqqio3obody.fsf@gitster.mtv.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 02:57:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBv9O-0001Lt-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 02:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbbLXB43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Dec 2015 20:56:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728AbbLXB42 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 20:56:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71F6937860;
	Wed, 23 Dec 2015 20:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fmt7XYbbbfV4
	nccoAyB0TpF335k=; b=sXZeqwZcXqt5ORrsebT2CIdKmYB9PAZS/IlXUWEAaBKd
	hzVV0r1hPmaRopPVXLCP4XnYfzzTPdp3FUu4oR6TZm7VpAhCGZhxPR3e7JyJgkEm
	FTs8hz86/Bc++JRtSzriVhe+y9gEh2m5INcBqyBwb6RmwS6rrxwDt2hmsKYEKMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f8/8WR
	vzoljr6H7DjlpDq/n4+fe5p7lqDH89/6pz068UUswPDtgfBVe2JxljMaktnmHHZV
	o5Y84RSnKcqnIqSrYhk8Vq46fSnAkenkbL6fTVwBJzv6fRaBOgSbO/weDVxXRSoZ
	niiA/zS/yjRmIv+QcIM0FnnckXuUQp9ghyC/E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68E853785F;
	Wed, 23 Dec 2015 20:56:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA3043785E;
	Wed, 23 Dec 2015 20:56:26 -0500 (EST)
In-Reply-To: <xmqqh9jae94o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Dec 2015 08:33:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B04D42E-A9E1-11E5-8EAF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282971>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> In that case we can just check config once in read_index_from and
>> destroy UNTR extension. Or the middle ground, we check config once i=
n
>> that place, make a note in struct index_state, and make invalidate_*
>> check that note instead of config file. The middle ground has an
>> advantage over destroying UNTR: (probably) many operations will touc=
h
>> index but do not add or remove entries.
>
> Or we can even teach read_index_from() to skip reading the extension
> without even parsing when the configuration tells it that the
> feature is force-disabled.  It can also add an empty one when the
> configuration tells it that the feature is force-enabled and there
> is no UNTR extension yet.

Thinking about this a bit more, I am starting to feel that the
config that can be used to optionally override the presence of
in-index UNTR extension does not have to be too bad a thing,
provided if it is done with a few tweaks to the design I read in
Christian & =C3=86var's messages.

One tweak is to address the following from =C3=86var's message:

>> Once this series is applied and git is shipped with it existing
>> users that have set "git update-index --untracked-cache" will have
>> their UC feature disabled. This is because we fall back to "oh no
>> config here? Must have been disabled, rm it from the index" clause
>> which keeps our UC from going stale in the face of config
>> flip-flopping.

The above would happen only if the configuration is a boolean that
defaults to false.  I'd think we can have this a tristate instead.
That is, config.untrackedCache can be explicitly set to 'true',
'false', or 'keep'.  And make a missing config.untrackedCache
default to 'keep'.

When read_index_from() reads an existing index:

    When the configuration is set to 'true':
        an existing UNTR is kept, otherwise a new UNTR gets added.
    When the configuration is set to 'false:
        an existing UNTR is dropped.
    When the configuration is set to 'keep':
        an existing UNTR is kept, otherwise nothing happens.

When write_index() writes out an index that wasn't initialized from
the filesystem, a new UNTR gets added only when the configuration is
set to 'true' and there is no in-core UNTR already.

That way, those who use /etc/gitconfig to force the feature over
their users would be able to set it to 'true', those who have been
using the feature in some but not all of their repositories won't
see any different behaviour until they muck with the configuration
(and if they are paranoid and want to opt out of their administrator's
setting, they can set it to 'keep' in their $HOME/.gitconfig to make
sure their repositories are not affected).

Orthogonal to the "config overrides the existing users' practice"
issue, I still think that [PATCH v2 10/10] goes too far to remove
the safety based on the working tree location.  Checking kernel
version and other thing may be too much, but the check based on the
working tree location is a cheap way to make sure that those who do
unusual things (namely, use $GIT_DIR/$GIT_WORK_TREE or their
equivalents to tell Git that the working tree for this invocation is
at a place different from what UNTR data was prepared for) are not
harmed by incorrectly reusing the cached data for an unrelated
location.  So another tweak I'd feel better to see is to resurrect
that safety.

I wouldn't have as much issue with such a scheme as I had with the
earlier description of the design in the Christian's series.

Thanks.
