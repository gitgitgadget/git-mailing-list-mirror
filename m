From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Mon, 14 Dec 2015 13:30:05 -0800
Message-ID: <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Mon Dec 14 22:30:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ahF-0003zL-BR
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbbLNVaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:30:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932207AbbLNVaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:30:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11C45332CC;
	Mon, 14 Dec 2015 16:30:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IlN9SiSOEVaaEurIUwejeW8Jk6c=; b=XRDKde
	tefvgLkQjRdTEI95BJwizlIOxDJ+Anfj2sbo/Q6lEqduDd2Rl4btugFOH0f9Z3dh
	vj0TIAnoBvvXGzH1LWGNPwIOqEcdwFyetch6LLv6z4ccnLD2ez1nQqEWmK42HPWY
	ofGQ9eSVjWfnK5PSVcepglxn5pr7+j5fEeIWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ce6UZxf2zVioYZfuyuV6H8HOE+29ZgsQ
	RqZZ4WwvPQoa2s9bg/wzLzpwnbX/DNFlVOLi174wEJZFyoWWazoQZWPo26GKdoK4
	c5Y50J0FLwN9lmaxT6PKnPqc5ZVdiTXyUr0y0GVpgQnxZrOp32kPi//gyM9o88Vc
	8GEKkBCtGJE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6242332CB;
	Mon, 14 Dec 2015 16:30:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28689332CA;
	Mon, 14 Dec 2015 16:30:07 -0500 (EST)
In-Reply-To: <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Dec 2015 11:44:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8A3CC88-A2A9-11E5-9A20-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282422>

Junio C Hamano <gitster@pobox.com> writes:

> If you stop thinking that "update-index --untracked-cache" is
> somehow a "configuration", things will get clearer to you.
> ...
>> "git update-index --[no-|force-]untracked-cache" is a bad way, so
>> let's make it easy for people to not use it at all.
>
> As I disagree with that basic premise, I have to disagree with the
> conclusion as well.

Having said all that, I do not think an option to "update-index"
must be the _only_ interface to tell the index to use (or ignore)
the untracked cache.  Two obvious places that can also have the same
command line option would be "git init" and "git clone".  If either
the per-user configuration (or the per-site one the administrator
sets) gave the default for these two commands, that would make it
unnecessary to use "update-index", unless you are experimenting or
working around bugs in the implementation.

The primary reason why I do not like your "configuration decides" is
it will be a huge source of confusions and bugs.  Imagine what
should happen in this sequence, and when should a stale cached
information be discarded?

 - the configuration is set to 'yes'.
 - the index is updated and written by various commands.
 - more work is done in the working tree without updating the index.
 - the configuration is set to 'no'.
 - more work is done in the working tree without updating the index.
 - the configuration is set to 'yes'.
 - more work is done in the working tree without updating the index.
 - somebody asks "what untracked paths are there?"

In the "configuration decides" world, I am not sure how a sane
implementation efficiently invalidates the cache as needed, without
the config subsystem having intimate knowledge with the untracked
cache (so far, the config subsystem is merely a key-value store and
does not care _what_ it stores; you would want to invalidate the
cache in the index when somebody sets the variable to 'no', which
means the config subsystem needs to know that this variable is
special).
