From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/18] Change style of some regular expressions to make them clearer
Date: Thu, 06 Jun 2013 21:51:05 -0700
Message-ID: <7v7gi6wmkm.fsf@alter.siamese.dyndns.org>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cQvWJ8RRsqKEMooV_AntTBZ1Pi=WA_1LFU955J+9jDzTg@mail.gmail.com>
	<7vbo7iwt3h.fsf@alter.siamese.dyndns.org>
	<CAPig+cRyHc0SiWrHKQ3w4jCW5a-2p=k0TsjeRBe_kyw+DfnrqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukodu-00020y-Hx
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab3FGEvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 00:51:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab3FGEvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 00:51:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E447C2004A;
	Fri,  7 Jun 2013 04:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W+dKN/DYhmM1w4bK5GKW0t9Gha8=; b=IybAVI
	8KBfXYyOb7PsVuVcR1sDbHdHrge6nm5AQ0dVfd6pAq638OkV98Z48Rc/us04gDeZ
	UNWkHSwDpfvyVqbMcnadw2h94TqjAVC2SMI3yrwobQsV6NouddmpdbnNF4gRVcaa
	Vqb/ImZyDtiMMKJjx0rqKGkF2M1/2Xx1ba2TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrmtY2xLhLKIo+iaQRNx10IXixEQNxfe
	Tw4hCjpoE9TVG2wbr8YqorvS0skY0Cu9tAiCQ+iQwXN5HEintN3BO0j6j3l/iioz
	2xBul743RtdzBlGSaJ3E6wWCldr4ySH8Auv1bDmWDCgAwyq1yEMiVzSpEzMfx3bg
	N4sxNxs24Tk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB94520049;
	Fri,  7 Jun 2013 04:51:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61FF420045;
	Fri,  7 Jun 2013 04:51:07 +0000 (UTC)
In-Reply-To: <CAPig+cRyHc0SiWrHKQ3w4jCW5a-2p=k0TsjeRBe_kyw+DfnrqA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 7 Jun 2013 00:39:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDACE20C-CF2D-11E2-9229-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226589>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jun 6, 2013 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>> -                       if (my ($child, $parents) = $line =~ m/^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
>>>> -                               foreach my $parent (split(' ', $parents)) {
>>>> +                       if (my ($child, $parents) = $line =~ /^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
>>>> +                               foreach my $parent (split(/ /, $parents)) {
>>>
>>> This is a behavior-altering change. split(' ',...) is handled as a
>>> special case[*1*] which strips leading whitespace and then splits on
>>> /\s+/ (run of whitespace). Changing it to split(/ /,...) makes it
>>> match only a single space (rather than a run of whitespace).
>>
>> I initially had the same reaction, but this is reading the output of
>> the "rev-list --parents" command, whose fields are separated by one
>> SP each, so there is indeed no behaviour change.
>
> True. This potentially subtle point may deserve mention in the commit
> message (or this particular change can be dropped).

I agree that the log message should mention it; but the resulting
code is more correct than the original, so I do not see a need to
drop it, or add any in-code comment to it.
