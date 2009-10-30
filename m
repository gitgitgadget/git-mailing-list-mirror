From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My custom cccmd
Date: Fri, 30 Oct 2009 14:52:29 -0700
Message-ID: <7vr5skim76.fsf@alter.siamese.dyndns.org>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
 <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
 <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
 <94a0d4530910250804w3a7da36eke10710eb1cbb03c1@mail.gmail.com>
 <7vzl7c4i81.fsf@alter.siamese.dyndns.org>
 <94a0d4530910300139l2f20e3aaw2f89e0b809a7246c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:52:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zOl-0002Ge-Pl
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbZJ3Vwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbZJ3Vwc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:52:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927AbZJ3Vwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:52:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD4B6D2A8;
	Fri, 30 Oct 2009 17:52:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/4hrHSWjx3sYFPsjrNAoqSPUoLk=; b=tyjISIzy1+kSN4bfCEYcA+d
	MT2IrpLrbgOh+w3BdTTDAm9i34fBWIz5S/RqYaVwmz37S6IKgzHdru04Tp6XK3cL
	JI/jvH8D87sV++4isQifhSnYDCNJXYPhc6J5+qVUvDmEqe/KleEog7NAQTKaPDf0
	F/G+oJXULGqotLyElJvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Pc2gV03QpSODi8+Eagrp/CjCSjZbDdoEv8SAeNuNpTpohNABe
	6/oM493nSWTD22nmVWnbmJzCxsiG3WgFWup1ZBwzs2YCxRZOD24JhjTx/8UtMrNK
	6TpIH/h5uOr3dL+Jevb7wQk93aXWeCwSfjEwHNKBnlHbrhYh3nM0gj0uzE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F4E96D2A6;
	Fri, 30 Oct 2009 17:52:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97B206D2A5; Fri, 30 Oct
 2009 17:52:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 880A96E2-C59E-11DE-BF45-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131759>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Oct 27, 2009 at 11:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> I explored this a bit more and I've come to the conclusion that we
>>> actually don't wand to discard the previous commits in the patch
>>> series. Let's think about this example:
>>> 0001 <- John
>>> 0002 <- Me overriding some changes from John
>>>
>>> In this case we want John to appear in the CC list of 0002, because we
>>> are changing his code.
>> ...
>> In such a case, I would imagine that the reviewers would want to see a
>> cleaned up series that does not have his patch that is irrelevant for
>> understanding the final result.  John might want to know about it, if only
>> to raise objection to the way how you arranged your series.  For that
>> reason, I think it makes sense to Cc him.
>>
>> But it is a rather a convoluted logic, if you ask me.  You find John and
>> Cc him, primarily so that he can point out that you should be redoing the
>> series not to have his patch as an intermediate state in the series to
>> begin with, because his commit does not contribute to the end result.
>>
>> It might make more sense if your tool told you about such a case directly,
>> rather than helping you find John so that he can tell you ;-).
>
> But that's not the purpose of the cccmd tool.
>
> I agree that such "patch series simplificator" tool would be very
> useful, but that's out of scope for this. Isn't it?

Exactly.

So you agree that you _do_ want to "discard the previous commits in the
patch series", because not doing so would mean the result would be a
half-cooked "patch series simplificator" that tries to do something that
is outside the scope of cccmd, right?

The "discarding the previous commits" happens to match what I suggested
earlier that lead to your "explored this a bit more":

On Thu, Oct 15, 2009 at 11:37 PM, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Thu, Oct 15, 2009 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  #2. If you have two patch series that updates one file twice, some
>>     changes in your second patch could even be an update to the changes
>>     you introduced in your first patch.  After you fix issue #1, you
>>     would probably want to fix this by excluding the commits you have
>>     already sent the blames for.

so I think we are in agreement.
