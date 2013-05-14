From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 13:36:22 -0700
Message-ID: <7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 22:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLxW-0007ev-HW
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758423Ab3ENUg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:36:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757884Ab3ENUgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:36:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF8491E817;
	Tue, 14 May 2013 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/rr21WBjJcE2+ZrJ0rnrTDjaWHg=; b=sNR+1q
	uAj8+QheuPFfvS8aqi/AjOT15NrJ3tSHrYyfTBf0/KpEhkbzp+NFehWy+BTBZ5+J
	OCREHvEFpcWuHtEHSBcxaESbvx/zxeXmOvpaAMhcjvvm3t1tWwBmJ8Rjl9/nHtvK
	Mdmn2TIiT7Na3rw6+vOw4I4/ig+yKAo0M0vUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v5jfUc0/1Ik1ENHxAcFCsrFTg8AJmvUs
	HVYxM0GUYfT1OoYnyYbbObq0haA3eAxOGkDk06tdZclqwZl3dIRG9/1bsJoj/iVq
	hJS1EEcIvaAhrPZv7yJV4nN99IiRdQn1O5VYqbzlC2v3eroAE6NME2fijE1PuTSC
	CdFHDv2lsB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A30301E816;
	Tue, 14 May 2013 20:36:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16AB71E812;
	Tue, 14 May 2013 20:36:24 +0000 (UTC)
In-Reply-To: <CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 15:06:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F18B5FF2-BCD5-11E2-84F1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224343>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 14, 2013 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> If a clone exists with the old organization (v1.8.2) it will prevent the
>>> new shared repository organization from working, so let's remove this
>>> repository, which is not used any more.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>
>> What happens with and without this patch to an existing user from
>> 1.8.2 days, when she does what?
>
> I already explained it would prevent the new shared repository
> organization from working, so the old organization would be used; the
> repositories won't be shared.
>
>> A sample answer (to show the level of descriptiveness, not the
>> content, I am epecting) might go something like "Because the
>> organization is different, it will barf whenever she tries to
>> incrementally update from the other side. By removing the old one
>> 1.8.3 contrib/ does not understand, at least we can unstuck her; she
>> ends up reimporting the whole history, though."
>
> Bazaar won't barf, the repositories will be duplicated, so the shared
> feature won't work.

But by removing the old incarnation, you are getting rid of the copy
for which the shared feature will not work, so with patch, "won't
work" is no longer an issue.  Is the user making a trade-off by
using Git with this patch?  What is she losing by removal, if
anything?
