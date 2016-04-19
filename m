From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 11:43:41 -0700
Message-ID: <xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:43:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asacn-0003hT-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbcDSSnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:43:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932280AbcDSSnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:43:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98EFF13E1E;
	Tue, 19 Apr 2016 14:43:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J/8uUaDcTrlBIyk5AzyXlWFBF4A=; b=iPANky
	dlSuerr8nM4bLBqwIy/3Xy1pM4chgUp/9OHY54xswIQXiSobdEYJlDJUOivPseOA
	684Y25evln4k3cMW/OnLRTmxneEEYIDLcAsVNwfJ3Lc6aBjCmFLCUAbxBzyQ4L0l
	4uEUFL+guJ4E+HwXGgfbkiJDXhJ9RRmwIfVp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oTZlbvFLTFQBYyJmRpd58bfSYbWfuORC
	Qk3hSCRf5TV99NYldaLQsk9c1LGEdamqYbVKY5tuDvWwoT/9XJqpm4bkkm8op315
	9YTott6cibvFgZP5TqZDw5TCLM8yXKD3n4+mjiz5fNj1Wi2hogbyWoQzEii2QEj9
	uTn6bolxwNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FC3A13E1D;
	Tue, 19 Apr 2016 14:43:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 039FC13E18;
	Tue, 19 Apr 2016 14:43:42 -0400 (EDT)
In-Reply-To: <CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	(Jan Durovec's message of "Tue, 19 Apr 2016 20:04:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A40BCB56-065E-11E6-A4B8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291901>

Jan Durovec <jan.durovec@gmail.com> writes:

> On Tue, Apr 19, 2016 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> If you really want to know the preference, we prefer a preliminary
>> clean-up patch to correct existing style issues, followed by a new
>> feature patch that builds on the cleaned up codebase.
>
> Would it be acceptable the other way around? I.e. this patch followed
> by the one that fixes code style (once this gets merged)?

The reason I said "preference" and not "requirement" is because the
answer to that question is "It depends."

When the primary change is something small and urgent (e.g. an
important bugfix that needs to be merged down to 'maint' and older),
we typically do not want to keep the fix waiting for preliminary
clean-up patch to be reviewed.  Instead, we'd say "let's fix it
first on top of a known-to-be-crappy codebase, and postpone the
clean-up until the dust settles".

>From experience, we already know that sometimes clean-up happens,
but often it does not, when we take this route, and it harms the
long-term code health, but we just say an urgent fix is more
important than piling a bit more cruft on the existing technical
debt.

And that experience is why we say "preference is to have preliminary
clean-up first".

> Reason being that I don't know how to use submitGit to generate a patch
> against a state that is not already in git repo (ie. based on another
> patch).

Any submitGit users?  I think it lets you throw multiple-patch
series just fine.  In this case, you'd prepare a two patch series on
a branch, 1/2 being the clean-up and 2/2 being the new feature, and
if you give that branch to submitGit as a whole it should do the
right thing, I'd imagine.
