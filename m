From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] Documentation: add setup instructions for Travis CI
Date: Thu, 14 Apr 2016 10:45:26 -0700
Message-ID: <xmqqr3e8gk3t.fsf@gitster.mtv.corp.google.com>
References: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com>
	<xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYBK-MNYZRo+LsBqng47usGPQTyBe01W2SrKDrs3435sQ@mail.gmail.com>
	<vpqmvowwo0w.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:45:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlKh-0002W0-71
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 19:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbcDNRpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 13:45:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755421AbcDNRpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 13:45:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E57CB1289F;
	Thu, 14 Apr 2016 13:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+E3SAtK+qGdqBFig6xK/fyjvQLA=; b=Fm1Dy0
	yHFf9BuqfZXw0S4kH92chwcAli1zWsWVSVwSRtpITTmngFk+ejUm3Vf2InEA3Wab
	olOat6ic7dxZuK02anyP2FutE4iH5H/Saw1jIFhg8xsfXY8oyGYWx3FVBKnMQdsE
	6fN3UG4J2TAdbJSuiBwZUUWReSLnkB719oq98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pTVp1pkYWaJT40wOB/ApMuzNAV8NbKc8
	x6dXmwTO6+cEiRfw2ZLFIJVQCHcZfog8ZvIrCDYtgOfXiwf/UK4l6Pj7Q8Zl9Hv4
	H0TJJKwgb9wDrUdCgEUHNc/BJ/Q5gSSAiFqB+ykIR+XOUceIYt17vqVYRPK6a50P
	RkGke66r0tY=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D85291289C;
	Thu, 14 Apr 2016 13:45:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18DB212896;
	Thu, 14 Apr 2016 13:45:28 -0400 (EDT)
In-Reply-To: <vpqmvowwo0w.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	14 Apr 2016 11:14:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACE33F56-0268-11E6-A46B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291539>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Apr 13, 2016 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> here, create a "GitHub-Travis CI hints" section just before "MUA
>>> specific hints" section,
>>
>> Somebody (I think it was you, Lars?) at GitMerge suggested to break
>> up the SubmittingPatches document into more than one, i.e.
>> the MUA hints and the Github-Travis hints could become their own documents,
>> and the SubmittingPatches could just contain the bare essentials.
>
> I didn't see it on-list, but there's a PR doing that here:
>
> https://github.com/git/git/pull/223

I guess submitGit did not work well there ;-)?

To save one round-trip, I do not think it is unreasonable to treat
submitGit as the first-class MUA that sits next to other recommended
ways to send the patches to the list.  It is a rough equivalent to
"format-patch and then send-email".  As long as what appears on list
is the authoritative and final form of contribution, those on the
receiving end should not (and would not) care how the patch e-mail
was prepared and sent.
