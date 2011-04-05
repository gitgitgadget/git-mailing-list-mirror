From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Tue, 05 Apr 2011 11:18:58 -0700
Message-ID: <7vtyecmui5.fsf@alter.siamese.dyndns.org>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110328142121.GB14763@sigill.intra.peff.net>
 <201103301739.12691.trast@student.ethz.ch>
 <201104040943.10030.robert.david.public@gmail.com>
 <7vwrj999dv.fsf@alter.siamese.dyndns.org>
 <20110405170729.GC9965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert David <robert.david.public@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 20:19:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Aqb-0001lc-PD
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 20:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777Ab1DESTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 14:19:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab1DESTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 14:19:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7353941A3;
	Tue,  5 Apr 2011 14:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U6UrwNepo8GngGnmtkOCux971/s=; b=Xf/Qi1
	8qpMB/P5bG7zKGtt0k1ioI8mtr94qbxY3Habgb+ZMkHb0cE3jec8iwlkWmXHGgDb
	7i6jE44R6TfmMMB8MNonwAcTgEdNncam3dXsWClf7Jtd7g7QYRs71do+j/lkwU+J
	BfpGbmyKp4Tej5a/pAEeu6bCY482aiqybu+oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hmcyLJHIts5acjGE/JrGBR8VOqL40v3W
	RtrbZlXq/ZNBJ1qULGu9fs22zpHIbPMT+FJwQn59i85awg0sk9mCKJwMAGprw2Bj
	UbQTDmudgXip0zEt2AFUhWlIPZ9xRA1N6e6rBkhxEEGnp0ZQsCBptDDnPStCFGrm
	5idiaCAhQsU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2E3A4199;
	Tue,  5 Apr 2011 14:21:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D4D04197; Tue,  5 Apr 2011
 14:20:53 -0400 (EDT)
In-Reply-To: <20110405170729.GC9965@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Apr 2011 13:07:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76DCA78A-5FB1-11E0-ADAF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170898>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 04, 2011 at 11:09:00AM -0700, Junio C Hamano wrote:
>
>> I am afraid to say that the above schedule is too ambitious and does not
>> leave any time for reviews and re-rolls.  Please keep in mind that
>> historically patch series by more experienced contributors of substantial
>> size (comparable or even smaller scale than the topic you are proposing)
>> all typically took three or four review-reroll cycles, if not less, and we
>> don't automatically get extra review bandwidth just because GSoC is going
>> on.
>
> I agree. I think it's important to take review-reroll cycles into
> account. Not just in terms of allocating time, but also considering the
> latency, and keeping the student's pipeline full of work while waiting
> on review.

During the course of GSoC program, one will learn that other community
members do not have any obligation to keep one's pipeline full [*1*], and
learn how to cope with it.  Measuring the availability of others so that
one can make optimum use of others' time is a skill to be learned to be
successful in interacting with the open source community.

It takes people skills, not just "hacking" [*2*].

>   Week 3: build new functionality Y on top of X
>
> Obviously "Y" is going to depend somewhat on the refactoring of "X". But
> you can say in the RFC/PATCH for Y that X is still ongoing, and to
> review with that in mind. And that keeps the student doing something
> during week 3 while reviews for X flow in.

Yes.

> In the past, students haven't been very engaged with the list community,
> and I think that has hurt us. The code gets dumped as a whole at the
> end, and review is a lot harder, and GSoC is over, so the student ends
> up busy with going back to school.

While GSoC's "success" criteria (from stipend payment point of view) may
be to finish the defined task for the project, the program's larger
objective is to give an opportunity to students to learn how to work with
the open source community, so in that sense, I'd call that a total
failure.

I agree that we should help fixing that.

[Footnote]

*1* The mentor is special, has that obligation, and fulfils the obligation
by exercising his open source community skills and guiding the student to
break down the project into smaller subtasks to match the bandwidth of the
community.

*2* That incidentally is what I learned from working with Linus during the
early 2 months of git's life.  "People skill" is not just "being nice,
polite and diplomatic", none of which describes Linus ;-).

I think the most important skills include

 * being observant and know what others are doing, how busy they are, what
   patches are in flight that may have potential interactions with your
   work, and at what velocity these patches are progressing; and

 * clearly communicate what you are doing, in what order, for what reason,
   and where the boundaries of your goals are, and demonstrate that you
   are dedicated to the cause of the project.

The former would help you avoid duplicated work (if somebody is doing what
you can take advantage of and it is going at a reasonable pace, you can
spend your time on areas that do not depend on his work in the meantime
and wait) and unnecessary conflicts. The latter would make it more likely
that others would want to help you by correcting flaws in your design
assumptions and filling the gap that you are planning to punt, and help
these others to avoid duplicated work and unnecessary conflicts while
helping you.
