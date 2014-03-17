From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Mon, 17 Mar 2014 12:12:33 -0700
Message-ID: <xmqqeh20ej1a.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
	<1394742059-7300-1-git-send-email-zhaox383@umn.edu>
	<CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
	<xmqqiorghgaj.fsf@gitster.dls.corp.google.com>
	<CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com>
	<7v38ihuvq7.fsf@alter.siamese.dyndns.org>
	<5327027D.6090500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:12:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcxq-0003TB-J9
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaCQTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:12:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbaCQTMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:12:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9584875FD9;
	Mon, 17 Mar 2014 15:12:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H0rdezoOYAGFqihUckLj8uPbSAQ=; b=SRHJaa
	8ollG08lPdZ9kRbrCv1oVIrl7LkrYFDKgWDjbu04usib16NjRO5GQ6+95p7WrYzv
	rQI+58OJ+xU16G7UenC13HQG0YQe4UVOOHn5YE+az5uYmEEoH8XkvvFPx3OT7Emc
	c0qpmto+Ni0H2Y4z2Gt/MK7JGEk0JRqPTG1oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbz+ZpzS+qP799I6t4AyzHL5kb8vHsS4
	RyV6ZwUYq9muW3DBzgGGcM0U27sTvCTmt7Q28ZL8nqtMv7Bv57UwLrSPpfNV7Zqz
	hVr70grhiSd9g+f8STuT+d30rwGteRZqTtS23F+j2wYP6wLKBUqR4HTFz9ou3Q5P
	J/MRdyRZSJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7668D75FD8;
	Mon, 17 Mar 2014 15:12:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77EA975FD0;
	Mon, 17 Mar 2014 15:12:35 -0400 (EDT)
In-Reply-To: <5327027D.6090500@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 17 Mar 2014 15:11:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1914DDAE-AE08-11E3-B7A9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244268>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/17/2014 08:31 AM, Junio C Hamano wrote:
>
>> So in short, yes it would have been nicer if we had more micros than
>> candidates, but I do not think it was detrimental for the purpose of
>> these micro exercises that multiple candidates ended up attempting
>> the same micro.
>
> I wish I had had time to invent more microprojects.  I think we were
> lucky: since students didn't seem to learn from each other's attempts,
> the fact that many people tried the same microprojects wasn't much of a
> problem.  But if a student had arrived with a "perfect" solution to a
> well-trodden microproject on his/her first attempt, I would hate to have
> to be suspicious that the student plagiarized from somebody else's
> answer plus all of the review comments about the earlier answer,
> especially since a perfect solution would itself reduce the amount of
> interaction between the cheating student and the mailing list compared
> to a student who required several iterations.

It may probably be not a huge problem.  If anything, a cheater would
have also learned how the mailing interaction goes when trying to
plagiarise.  And not really having interacted us, a cheater would
have left us no impression on his or her communication skills, so it
would probably have been detrimental for his or her own chance to be
chosen as a student, compared to the ones who started from their own
solution and polished it by responding to reviews.

> I also hope that students
> didn't feel unwelcomed during the times when the list of untaken
> microprojects was nearly empty.

Yeah, that is why I said I was of multiple minds.  I wasn't enthused
by seeing the ones that somebody is attempting marked as "taken" in
the first place.  Solving one that others attempted in his or her
own way and interacting with reviewers seemed to have just as much
information on the candidate, at least to me.

> If we really wanted to make this system cheat-proof, there would have to
> be not only enough microprojects to go around, but also some mechanism
> to ensure that student B didn't start work on a microproject that
> student A was just about to submit a solution to.

Nah, I do not think there is any need to go there.  It is over for
this year anyway, but I do not think such a provision is necessary
for future years, if Git project will participate in future GSoCs;
see above.

> Maybe in the future our microprojects should have two parts:
>
> a. Fix ...
> b. Invent a microproject for the next student.
>
> (Just kidding.)

;-)
