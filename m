From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Mon, 10 Jun 2013 15:57:00 -0700
Message-ID: <7vobbdefr7.fsf@alter.siamese.dyndns.org>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
	<1370889365-6239-7-git-send-email-richih.mailinglist@gmail.com>
	<7vli6hg2ut.fsf@alter.siamese.dyndns.org>
	<CAD77+gTv-x7ZKAR3PycDWNhqeWcnEFEhK290ndxeyqqkBfWfeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 00:57:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmB1S-00017K-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 00:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab3FJW5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 18:57:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3FJW5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 18:57:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D536E264EC;
	Mon, 10 Jun 2013 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5hihMZtXFghf2ZU/kepD/b2MsnE=; b=Es3S1v
	rsQJUenU9OuCu53nrysIzTpcjHWCv6eUUFp7/c197V0CtWisWA3Sm9TZoh+W1t9e
	DXpE4hkK1cCaas3Gq0FPrE9ZW1I9vPRqDAbVAfAm1TtBsgSCgGaW18swVMfFNWjj
	eWaaZHY+1xP/90mGizT9Sidn6vJQcQHY921jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obcHlMC53aSpuutvC/piuOVPp3Dy7Kd7
	0dqlia3MGB9fgrI65izpEbudF5g1GcRtsCvICn8XX825HI0FZkzD+y3GEecz3DTL
	/R/zGCBNXQ+PRt4v2aT8KyM5ntnnbIxtxtalsIVYjVBDfjUFRjyujIyTaB0S4pqA
	UczyAcRz+rE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBB1D264EB;
	Mon, 10 Jun 2013 22:57:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3569E264E9;
	Mon, 10 Jun 2013 22:57:02 +0000 (UTC)
In-Reply-To: <CAD77+gTv-x7ZKAR3PycDWNhqeWcnEFEhK290ndxeyqqkBfWfeQ@mail.gmail.com>
	(Richard Hartmann's message of "Mon, 10 Jun 2013 23:46:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10365230-D221-11E2-9795-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227398>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> On Mon, Jun 10, 2013 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
>> I think offsetting the actual commands to the right is correct, but
>> "if these match" and "if this is empty" should be flushed to left as
>> this patch shows.
>
> I actually considered this and decided against it as it seemed to be
> deliberate. Should I re-roll and re-send?
>
> I will gladly re-send the whole, or part of the, series once I know
> which patches are OK and which need more work.

[PATCH 1/6] templates: Fewer subprocesses in pre-commit hook

  I agree with Peff that "less fork" is a bad justification for this
  change, and also

                echo 'First line
        second line
        third lie'

  looks somewhat bad.

[PATCH 2/6] templates: Reformat pre-commit hook's message

  I think it is a good thing to make the output short by widening.

[PATCH 3/6] templates: Fix spelling in pre-commit hook

  Good.

[PATCH 4/6] Documentation: Update manpage for pre-commit hook

  I debated myself if it should say "The hook _by default_ prevents
  addition of non-ASCII filenames", hinting that it can be
  configured out if it is unwanted.

  Other than that, I think it is a good addition.

[PATCH 5/6] templates: Fix ASCII art in pre-rebase hook

  Good, but see Peff's comments on the explanation.

[PATCH 6/6] template: Fix comment indentation in pre-rebase hook

  After reading the original once again, it is fine as-is without
  the change at all, I think.  Alternatively, "if these match" and
  "if this is empty" lines can be flushed to the left, which also is
  readable.

Thanks.
