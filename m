From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 10:09:31 -0800
Message-ID: <xmqqsig62q78.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
	<xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
	<xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info>
	<xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Tu9-0001FR-4i
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbaLWSJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:09:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751406AbaLWSJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:09:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDD4028587;
	Tue, 23 Dec 2014 13:09:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=by9MgUNqCR1q/feuGatXg/092j4=; b=A1uVBo
	Btv8vllUWiYWBerunBKzSTRpGSVYZ35oJE9vt3l4iC1/mFO7kuhsVAnZDAk7aNgj
	ZVdI0iCK0dhqoc7QIV9eDCvhf+KLY/zMYRobmgkBlWSp8GYN6EEH9o+yO1Cs5p/S
	Kae7TtKTKWZaGofS81Nnvm+oBpFuJ40t84PiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tX7HRfMv69dXau5UuLUNAshcggOFmgO3
	007yj+KMpOaLoEQbCAUm/CaOHL7hxbUwgfQ1J0e/qCXI2tb89ZFwgjfutzk56JIj
	6bwJBXkkh8FmwhM7bnBslqDxI/Eic1zVMe1Po+yr4RuHaImltD9wrVu/9oIsBp6D
	+T78wqL3+xQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA8D028586;
	Tue, 23 Dec 2014 13:09:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73A4428585;
	Tue, 23 Dec 2014 13:09:40 -0500 (EST)
In-Reply-To: <xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Dec 2014 09:56:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD13BD80-8ACE-11E4-B367-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261753>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Okay, so just to clarify: you want me to
>>
>> - split the parser into
>>
>> 	- a parser that accepts only camelCased variable names when they
>> 	  come from the config (for use in fsck and receive-pack), and
>
> OK.
>
>> 	- another parser that rejects camelCased variable names and only
>> 	  accepts lower-case-dashed, intended for command-line parsing
>> 	  in fsck, index-pack and unpack-objects, and
>>
>> - consequently have a converter from the camelCased variable names we
>>   receive from the config in receive-pack so we can pass lower-case-dashed
>>   settings to index-pack and unpack-objects.
>
> I am not sure about the latter two.  This needs a design discussion
> what the command line options should be.
>
> I think the command line should be like this:
>
> 	git cmd --warn=missingTags,missingAuthor
>
> in the first place, i.e. "we may invent tokens to denote new kinds
> of errors as we improve fsck", not with "we may add options for new
> kinds of errors", i.e. the command line should not look like this:
>
> 	git cmd --missing-tags=warn --missing-author=warn
>
> And from that point of view, I see no reason to support the dashed
> variant anywhere in the code, neither in the config parser or in the
> command line parser.

Having said that, I think "missingTags" etc. should not be
configuration variable names (instead, they should be values).

Because of that, I do not think we need consistency between the way
these "tokens that denote kinds of errors fsck denotes" are spelled
and the way "configuration variable names" are spelled.

In other words, I do not think there is nothing that comes from how
our configuration variable names are spelled that gives preference
to one over the other between the two styles:

(1) Tokens are camelCased

	[fsck]
		warn = missingTagger,missingAuthor
                error = zeroPadTreeEntry

	$ git cmd --warn=missingTagger,missingAuthor

(2) Tokens are dashed-multi-words

	[fsck]
		warn = missing-tagger,missing-author
                error = zero-pad-tree-entry

	$ git cmd --warn=missing-tagger,missing-author

Do I have a strong preference between these two?

Not really.  My gut reaction is that (2) may be easier to read, but
I can be persuaded either way.

Who else has/had opinions on this?  Earlier you said that the
configuration the other way, i.e. "[fsck] warn = missingTag", was
shot down---who did shoot it?  Perhaps that person may be able to
point out where in my thinking above I am going in the wrong
direction.

Thanks.

[Footnote]

In either case, I'd recommend that we take [ ,]+ as inter-token
separator to ease the use on the command line and config file, to
allow these:

	[fsck]
		warn = missingTagger missingAuthor
		warn = missingTagger,missingAuthor

	$ git cmd --warn missingTagger,missingAuthor
	$ git cmd --warn "missingTagger missingAuthor"
