From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 14:18:58 -0800
Message-ID: <7v8vk55a99.fsf@alter.siamese.dyndns.org>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <20120214211402.GC23291@sigill.intra.peff.net>
 <CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:19:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQiK-0005WF-42
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338Ab2BNWTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:19:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757230Ab2BNWTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:19:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A4C46FB2;
	Tue, 14 Feb 2012 17:19:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6wkZo1ypC+/ScPBgFVq870uNiM=; b=QE9axG
	+DcB4v2oHwceuSLMzmBupxBkwas9wfknW5grwJZoFT0ARMN5FxLNHwtY2lmvGwU+
	oMbRVscAdFLKJRuTz1aDJ/8TO+M6bgshTafugQTJ7GyemQa/YBSk1hCK59RhqIf0
	xOyQ/H13GlKGna8290LLEsurt44djmHDztt8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nL0bQsiNbYvbWeB5hs/w/uFiWfOOmF0u
	iYF1kLHUYOnxC82hBiv/AnWCkYCXhnvHMJuJ2AzRSbtXIH4R2qClypdhgTRLNP8G
	bIMdeuluEpbdnX7B5pIQCdS18jBMz2njgpeFbROEsa9Sa7Qxq9QGOuiyEox359l2
	09pCABi85is=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE2C6FB1;
	Tue, 14 Feb 2012 17:19:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21A606FB0; Tue, 14 Feb 2012
 17:19:00 -0500 (EST)
In-Reply-To: <CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 14 Feb 2012 23:52:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4E1242C-5759-11E1-B4D1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190777>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Feb 14, 2012 at 11:14 PM, Jeff King <peff@peff.net> wrote:
> ...
>>     The answer can
>>     be a simple "nobody bothered to write them", and that's OK.
>
>  That can be derived from the word "add". You can't add something that
> is already there.

You are correct to say that you cannot add something that is already
there, but that does not mean you explained why that new thing is a good
thing to add.  In other words, you can add a new thing that we did not
have, but it would not result in a good addition if that new thing is
irrelevant. Relevance needs to be explained.

I do think in this particular case, the new check *is* relevant, because

    Although we did have "blame" test to see how the name part is shown,
    we had no "blame -e" test to see how the email part is shown.

I do not understand why you are resisting to explain how your addition
adds value to the system with such a simple two-liner, and instead are
endlessly arguing.  Is it to make sure you are the one to utter the last
word in the thread?

As I am sort of getting tired of seeing you making things more difficult
for yourself, I'll refrain from commenting on this topic at least for a
few days to wait until things cool down.
