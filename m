From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 14:06:56 -0700
Message-ID: <7vk3n6zgr3.fsf@alter.siamese.dyndns.org>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
	<1368196178-5807-5-git-send-email-artagnon@gmail.com>
	<7vmws2529j.fsf@alter.siamese.dyndns.org>
	<CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
	<7vr4he3kpz.fsf@alter.siamese.dyndns.org>
	<CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
	<7vk3n6206h.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
	<20130510190705.GA3478@elie>
	<CALkWK0kZWrY5_B3mxuVV1cA-AqvkqJpjRAuSovXLi6OCA+3ybQ@mail.gmail.com>
	<20130510191639.GB3478@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 23:07:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauWw-0006wI-Gb
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab3EJVHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:07:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231Ab3EJVG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 993A21E00E;
	Fri, 10 May 2013 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zYv3Igj8N0kQ5ywQtFbKQReAbIk=; b=TwWT0W
	TkLLZo2rCtbwVnpnjjw4f6htRuLeCk7/5PefBNHAP3w5koedrfi47azxapfgvXrg
	zEdi1+OLqkkhAWb50Isb9ezvWSKUCZ2Z/Tb0UFxPcJ8yTKvOoEX7xqULXj8lXYxn
	Zu8Uodh/Do7gNMwYihOhPanonrJmBorGhYgpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kI19Mgta4tDy4ywNMFzBy5b5rvwDOgMB
	VCpo4jyRz8jET+h1KAt12tFdU7pZndktWhsaSPpnCv8uFHa5oICdstDW+cU9rxqS
	tfayMml+OVFkmQJj7DRsvacNMDN5CEoHS/iWzo7MPk7u1z+wiiMnab2mVP39pq/A
	jOXlVLnEUYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 908A91E00D;
	Fri, 10 May 2013 21:06:58 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2AB31E00C;
	Fri, 10 May 2013 21:06:57 +0000 (UTC)
In-Reply-To: <20130510191639.GB3478@elie> (Jonathan Nieder's message of "Fri,
	10 May 2013 12:16:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CFB03F8-B9B5-11E2-BB94-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223915>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>>                           Can we do better by not printing the -v
>> output of the passing tests though?
>
> Not for my use.  The output from comprable tests before is often
> useful for comparison.

Perhaps.

But the output from passing "-v" before the test that breaks is not
very useful for two reasons.

 - Often they are identical between passing and failing runs because
   the resulting states in their trash directories are truly the
   same, in which case the output is just being too noisy.

 - Some other times, the output from passing and failing runs look
   identical but only because earlier tests are sloppy and not
   showing differences that happens to matter as precondition to the
   failing test, in which case the output is too sketchy to be
   useful.

In the latter case, where a breakage needs deeper inspection, I
haven't found a way better than to stop the test _before_ the broken
one (by temporarily inserting "exit" just before it), run it once
again so that the trash directory just before the failing test is
left behind, and go there to manually inspect the states in the
trash directories of passing and failing ones to compare where in
the earlier tests that passed left a subtle differences that were
not detected but still caused to make a difference to the broken
test.

I am not saying "it is not very useful, so remove it" but "it is not
very useful, and I wish somebody clever thinks of a way to make it
more useful", though ;-)
