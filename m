From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] CodingGuidelines: on comparison
Date: Fri, 02 May 2014 11:18:34 -0700
Message-ID: <xmqqk3a4avt1.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-8-git-send-email-gitster@pobox.com>
	<20140501213657.GC14441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 20:20:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgI2m-0005gJ-6n
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 20:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbaEBSSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 14:18:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62041 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaEBSSj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 14:18:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65EDD10FF0;
	Fri,  2 May 2014 14:18:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=abQv0HrmWljcP3IwqvJB1wx9HSE=; b=N9tMrU
	rVcmhdR3qXY0wnoZwZG5lHGyFLzdXES4lCirwbjVtpIxr4BXP5dl3icoAVX3qpGl
	7Pr5vdaDWXxiwIk5iPaZ6VQQ91dmUKYmqoleBmNWI25GBUlpNguoAcZkbOKqDvP/
	PcZ+HGk2psaEZfQ3CpkjMcJuBYWFdpO3X8OzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwnknv8ieDdmOj2DlANpmwaiB5zyQJHC
	TGsOIklE37xx/vPj4ymBk+h1TtyOcURXcKvjfO7gh4QHDbzU1q96mlj/ItmnTSan
	hAfpBr0b0P837Irgp28c+x7S+Y7b977xY40NC76OqmF8YkCvOL6ybl2jLmK2I0vg
	2UTdZMK2DZ8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C76B10FEF;
	Fri,  2 May 2014 14:18:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 37C7010FEA;
	Fri,  2 May 2014 14:18:36 -0400 (EDT)
In-Reply-To: <20140501213657.GC14441@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 1 May 2014 17:36:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D551206-D226-11E3-BE4E-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247949>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 30, 2014 at 02:45:11PM -0700, Junio C Hamano wrote:
>
>> See http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=4126
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Don't you often complain about submitters referencing a discussion
> in a commit message without providing some context or summary?

Yes, but the summary of the discussion would be identical to the new
text added by the patch to the documentation tree in this case, so I
didn't find a good introductory text before "See $URL".  Perhaps

    This comes up from time to time.  See $URL for the original
    discussion.

but I do not know if that is much better.

>> + - There are two schools of thought when it comes to comparison,
>> +   especially inside a loop. Some people prefer to have less stable
>> +   value on the left hand side and more stable value on the right hand
>> +   side, e.g. if you have a loop that counts variable i down to the
>> +   lower bound,
>
> Grammar: /(less|more) stable/the &/
>
>> +   Both are valid, and we use both, even though we tend to see the
>> +   former the more preferable, the more "stable" the more stable side
>> +   becomes (comparison with a constant, "i > 0", is an extreme
>> +   example).  Just do not mix styles in the same part of the code.
>> +
>
> I had trouble parsing the first sentence. Maybe:
>
>   Both are valid, and we use both. However, the more "stable" the stable
>   side becomes, the more we tend to prefer the former (comparison with a
>   constant[...]

Thanks.  That is much better.
