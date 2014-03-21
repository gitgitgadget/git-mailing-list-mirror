From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 11:53:46 -0700
Message-ID: <xmqqior7tmbp.fsf@gitster.dls.corp.google.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
	<CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
	<20140320233816.GC7774@sigill.intra.peff.net>
	<CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
	<20140321034334.GA29683@sigill.intra.peff.net>
	<CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
	<xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
	<20140321181532.GC15508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Angelico <rosuav@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4Zo-0004xA-FM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbaCUSxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:53:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaCUSxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:53:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFA8577DD8;
	Fri, 21 Mar 2014 14:53:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ikMJQ/JmMz+u2SzE/zoKWPj24jA=; b=cHoB6d
	SfetC0ZqBQt35wxms3UtrjoaqJgLTi9rypBrhjaU1zTq8xLdZr6QXEOwtfvXtV6l
	MxwOb25aClDdTli/MQOE74Zmgelj66Gb5Hp44oYWVmPxQClLQMMfYE/Lik5kErJS
	cOQB6RUDdsVsKRlWifrw4JL5xlmd60Vk0Qc+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pC6pV7SbIbZgE194ZXwqzlnfJ1LosS48
	p7NazablQ3dEMWMsjRIUFZUComuStAKp3E8kYSqF3+Pf7Uk2vjBDDbkRb5D5Xvbz
	LiH1/F5hTR787s+zuJiNW9qpWoigh+QCTQeG6wz/5Nlh+YE8aDCM0Ue/zoXf5nO1
	CYtzPpeaFns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BFD277DD7;
	Fri, 21 Mar 2014 14:53:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBCA577DD6;
	Fri, 21 Mar 2014 14:53:48 -0400 (EDT)
In-Reply-To: <20140321181532.GC15508@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Mar 2014 14:15:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 233BE348-B12A-11E3-8CEE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244722>

Jeff King <peff@peff.net> writes:

> [1] Is there a word to mean the "pluralness" of a noun or verb (similar
>     to "tense" for a verb).

I've seen "plural vs singular" often mentioned in the context of
subject and verb agreement.

en.wiktionary.org/wiki/concord talks about agreement "in gender,
number, person, or case", so "number" may be the word you are
looking for.

http://en.wikipedia.org/wiki/Grammatical_number

> Surely there is, but I could not think of
>     it. I wanted to say here that the pluralness of "what" and "are"
>     does not match (it seems like "what" is a mass noun, which usually
>     matches a singular verb).
