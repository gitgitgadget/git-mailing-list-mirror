From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative
Date: Wed, 07 Jan 2015 11:02:19 -0800
Message-ID: <xmqq7fwyjtxg.fsf@gitster.dls.corp.google.com>
References: <548B7967.3060201@shysecurity.com>
	<54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com>
	<54A2FDC8.5010504@shysecurity.com> <54AC0B2B.90107@shysecurity.com>
	<xmqqiogijwdp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: kelson@shysecurity.com
X-From: git-owner@vger.kernel.org Wed Jan 07 20:03:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8vsg-0006AO-Nb
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 20:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbbAGTCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 14:02:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751859AbbAGTCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 14:02:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7B9F2C1A2;
	Wed,  7 Jan 2015 14:02:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g1FcSNqLVQq+wEjo2dTMXLqBP8Y=; b=D8Yybz
	RN6n9rJMvDJhPdQvGNUzJbwOO8WqIQzBl0tbwxU0GnMmCCwv8CbPu6WgHcy1UpSU
	qtm8QFhrEQcl8HBCA0wPwTczvrAwZsL3fANf5G+CyFnEl1HTVDHmnKw0eZGm5RGh
	4AOEoAAFL0ovOrmlWLM+PgyV8f0fIHlayH26M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uR48PW3/5V58T73LkSGDe9LaiuC0GvOF
	xRqpRl7d5WQ1vNOCuNB8/YrhYhjHx0aZUoI1moU8mMhVodK7gXL/PXiv9g+q++F0
	9D8UeKtGrlYNC1CDXaB23UPju9umdsk6xNV1Y2HkglwMt66L1eQ2FT6QZtPalBei
	7Uvjhvbu03Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADFDC2C1A1;
	Wed,  7 Jan 2015 14:02:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBACA2C17B;
	Wed,  7 Jan 2015 14:02:20 -0500 (EST)
In-Reply-To: <xmqqiogijwdp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 07 Jan 2015 10:09:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B508D690-969F-11E4-8661-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262144>

Junio C Hamano <gitster@pobox.com> writes:

> Patch 2/2 also seems to share similar line-wrapping breakages that
> make it unappliable, but more importantly, the configuration that is
> supposed to correspond to --relative option only parses a boolean.
> Is that the right design, or should it also be able to substitute a
> command line `--relative=<path>` with an argument?
>
> The last was a half-way rhetorical question and my answer is that
> boolean-only is the best you could do...
> ...
> [Footnote]
>
> *1* Actually, you could declare that "diff.relative=true/" means the
>     'true/' directory while "diff.relative=true" means the boolean
>     'true' aka 'diff --relative', but I think it is too confusing.
>     Let's not make it worse by going that route.

Addendum.

It was only a "half-way rhetorical question", because I am willing
to be persuaded that diff.relative=true/ vs diff.relative=true is
*not* too subtle/confusing to be a good idea, if enough people whose
judgement I trust agrees.
