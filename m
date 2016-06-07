From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 27/38] i18n: config: unfold error messages marked for translation
Date: Tue, 07 Jun 2016 15:25:58 -0700
Message-ID: <xmqqfusoocuh.fsf@gitster.mtv.corp.google.com>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
	<1465300357-7557-28-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:27:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPRo-0003nb-Ua
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933619AbcFGW0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:26:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932782AbcFGW0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:26:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D60EE22A69;
	Tue,  7 Jun 2016 18:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mRG4wq8AmUawWzBBT4/sZ9onYm4=; b=dtJ/6G
	rtFQISQ4W/1srSMpW+4I+bDwrpF6Czd16omy/jBNa7R069O+SxhyKpNS7oMz8FL2
	hUwwM9Tf724t4M5SoJ8j1HE9DPtXfGIPkcX9Wn605wutuc/e6luiotT3RMON86IY
	7cjvmjMKlsNXkCGLXM+Av6MwupnVnBBn9sig8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxMkf3QmG74ya5PT8HkUYhAWjHOivr59
	K68Wv3nmrI1D55149S7hfKFibn+YD+jm1HNAV/f0vA7VRRE/A6+Sn2OjzYB2ZW84
	rePU7YI0fqDJ270qjYAAIx3nNAhy8l65AvxfkYqNp8+Ewnzbec4ov/m8mdsAEZHi
	gNPQMn3h/2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC4C822A68;
	Tue,  7 Jun 2016 18:26:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0F0E22A66;
	Tue,  7 Jun 2016 18:26:00 -0400 (EDT)
In-Reply-To: <1465300357-7557-28-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Tue, 7 Jun 2016 11:52:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0253A08-2CFE-11E6-978E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296739>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Introduced in 473166b ("config: add 'origin_type' to config_source
> struct", 2016-02-19), Git can inform the user about the origin of a
> config error, but the implementation does not allow translators to
> translate the keywords 'file', 'blob, 'standard input', and
> 'submodule-blob'. Moreover, for the second message, a reason for the
> error is appended to the message, not allowing translators to translate
> that reason either.
>
> Unfold the message into several templates for each known origin_type.
> That would result in better translation at the expense of code
> verbosity.
>
> Add enum git_config_oringin_type to ease management of the various
> configuration origin types (blob, file, etc).
>
> For the first instance, use xstrfmt() function to prepare the message
> string, instead of doing something like it's done for the second one,
> because intelligibility and code conciseness are improved for that
> instance.

Hmph, this step somehow interacts badly with what is queued on 'pu'.
