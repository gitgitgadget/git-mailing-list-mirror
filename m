From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 22 Dec 2015 08:33:11 -0800
Message-ID: <xmqqh9jae94o.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Tue Dec 22 17:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBPsI-00033F-9R
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 17:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbbLVQdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 11:33:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754297AbbLVQdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 11:33:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C09C633E29;
	Tue, 22 Dec 2015 11:33:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AckCXXZ+MCsnupYnVWCoIvKN8Jc=; b=AXsE+O
	8fHujKQ57oq7j1RozP81EWq2OhcuJY520ZTKIYVWt5VLqOSRasOGnWNf5ntIhdh9
	o7TVlVx+Iza8r891xYCBElhC3c4iUFBcFDXaNbdWxzhdUQkKnIHktXBHfgySGW5m
	4KUPY/0K/WR5rGYgFsuWchFIUhqzZhVgb46f0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKy83bTrHkq3nezyHza78FGdlCECe10k
	Cnm5puus93maavRnXkSB45+ZEGLBGQqS6Pc4hPlVXtIINcD9lX6bjO3VMIEhixd5
	QPkRfbyA8gPLole/xpNwMJlyMH2A9FFEx1Ux9HSBlVg2VqX2W442VoFfxNkcCZKc
	gOsmXYa0heE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B784F33E28;
	Tue, 22 Dec 2015 11:33:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 109BE33E27;
	Tue, 22 Dec 2015 11:33:13 -0500 (EST)
In-Reply-To: <CACsJy8AF-7ULixapHmTtCia9x0HTtJ1nmnAER9A3BeLVjQM_Mg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 22 Dec 2015 15:27:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1EA9B96-A8C9-11E5-9CED-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282885>

Duy Nguyen <pclouds@gmail.com> writes:

> In that case we can just check config once in read_index_from and
> destroy UNTR extension. Or the middle ground, we check config once in
> that place, make a note in struct index_state, and make invalidate_*
> check that note instead of config file. The middle ground has an
> advantage over destroying UNTR: (probably) many operations will touch
> index but do not add or remove entries.

Or we can even teach read_index_from() to skip reading the extension
without even parsing when the configuration tells it that the
feature is force-disabled.  It can also add an empty one when the
configuration tells it that the feature is force-enabled and there
is no UNTR extension yet.
