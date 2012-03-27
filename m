From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 11:03:11 -0700
Message-ID: <7vlimlj50g.fsf@alter.siamese.dyndns.org>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <4F715ABD.4080102@viscovery.net>
 <CAJMEqRAQZwaeMNai9wckmPE2mRVVpttzEobZrsn29fMAo+LRRQ@mail.gmail.com>
 <7v7gy6krei.fsf@alter.siamese.dyndns.org>
 <CAJMEqRDodYQa_4vZ0+BZYS1+zL3e1iFXAMPgONbg8miEEs9wJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCajt-0005ht-06
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab2C0SDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:03:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab2C0SDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:03:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36A5F65CA;
	Tue, 27 Mar 2012 14:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0UpaepxUVbQit/TTNxNDuZqAshw=; b=T/2aiu
	fvIk+NzrOP5LaFJIbH93gkP3Q1DFc+nx8jAspwzV44E2ic/KkGR1s+juhVZ67VQE
	RJRwSdMTSh1Zv9naRyb8hE00gTn+0TP0tmNFFMVTH81gPBvhfnb0/fYY2HfzRArN
	R/Yf7iEbCG1Lwwa4+9ZkweQj7sCrqwIJSqEgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5ihEr/GTKt8fDT29Y66vlwkm6m2f/aA
	QWx0MIt1yBlfw59WvN/JeYTSY4kW0pjSMuIeSAXkQ6QgeJmsyMN2vGZDtwk7H1uk
	OnIn0cS9lLxik+VMKPEJPHIda0rLfKttN6T/ACXplxDQi4inpjVpjR+eXbh/iWwk
	0b3jLQhf+Bk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E6FF65C9;
	Tue, 27 Mar 2012 14:03:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7D1F65C8; Tue, 27 Mar 2012
 14:03:12 -0400 (EDT)
In-Reply-To: <CAJMEqRDodYQa_4vZ0+BZYS1+zL3e1iFXAMPgONbg8miEEs9wJQ@mail.gmail.com> (James
 Pickens's message of "Tue, 27 Mar 2012 10:48:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E8D842E-7837-11E1-949F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194066>

James Pickens <jepicken@gmail.com> writes:

> On Tue, Mar 27, 2012 at 8:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> James Pickens <jepicken@gmail.com> writes:
>>> I'm not claiming that it's sane to have a broken PATH, but as I
>>> mentioned in an earlier email, sometimes my PATH gets broken through
>>> no fault of my own, and it would be nice if Git could be more helpful
>>> in that case.
>>
>> Hrm, so which was more helpful in diagnosing the broken PATH? Git by
>> letting you be aware that there is some problem, or your shell by keeping
>> me oblivious of the issue?
>
> In this case the broken parts of my PATH were completely uninteresting
> to me - they didn't contain any executables that I would ever use.  So
> if it didn't break my Git aliases, I could have continued working with
> the broken PATH and never known or cared that it was broken.
>
> But I get your point - sometimes it's more helpful to let the user
> know something is amiss than try to guess what was intended.

That was not the "point" of my question.  In fact, there was no point.  I
may be a mean person and may often throw rhetorical questions to embarrass
others, but I am not *that* mean to always ask only rhetorical questions ;-).

Judging from your answer, it would have been better for you if Git didn't
even tell you that there was an error due to an unreadable directory.  And
if that is the case, "Git could be more helpful in that case" will lead us
in one direction (i.e. "we simply ignore EACCESS and treat it as ENOENT"),
which is a quite different direction from what others discussed and
suggested in the thread (i.e. "we give more detailed diagnosis, perhaps
saying "your PATH has /usr/local/bin but it cannot be read, so we cannot
tell git-frotz exists there or not").

I just wanted to see what was the desired behaviour you have in mind.
