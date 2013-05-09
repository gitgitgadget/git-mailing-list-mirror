From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fast-export: improve argument parsing
Date: Thu, 09 May 2013 16:27:37 -0700
Message-ID: <7vy5bn68eu.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
	<7vzjw37q7o.fsf@alter.siamese.dyndns.org>
	<CAMP44s2RYPENwsPAcoaKjmHxkuVA52vvRrQ_stmT_qY-Pmt6HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaaFV-0002TO-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944Ab3EIX1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:27:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882Ab3EIX1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:27:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFCB81D49A;
	Thu,  9 May 2013 23:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ppWrPF5RXuniJYUDTIpNv6wyWmI=; b=a6QI3j
	94uquQtN7bHDnkwkuFI4xfRQUh+1qKLVGa2ASk+EOMN7sKxYFyEZXArRLLY47MDn
	/xg3pPux6tHl4SsLPWj1Lj1jGANzUmJnrrxwET+yed77l2/yhghpvMY2eKSzSDh7
	nE0h0TtsxrGRRmIeOjKJglRY1Q07hZ6eEGzBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Njh1GvJgkUYmnFDNRdzrQ3ykjs4ms+IE
	u2LRNcRbasxTM8+5iHm3zM2IDRW5c9fayW4OTH6Du1CgM6Jw3MuJCoi4kpv5eVMg
	ODc/OEhZ6e1Yo6fQiVtnz/opzYFm9vuMX7hvrXsrzaErtZYr2TmtoAhAIORe4OYG
	FPudWeFRgIY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6BDA1D499;
	Thu,  9 May 2013 23:27:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38A381D498;
	Thu,  9 May 2013 23:27:39 +0000 (UTC)
In-Reply-To: <CAMP44s2RYPENwsPAcoaKjmHxkuVA52vvRrQ_stmT_qY-Pmt6HA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 9 May 2013 18:02:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09F096E0-B900-11E2-ACC0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223804>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 9, 2013 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> We don't want to pass arguments specific to fast-export to
>>> setup_revisions.
>>
>> Interesting.  What bad things happen with the current order?
>>
>> Does "fast-export --export-marks=foo" causes setup_revisions() to
>> mistakenly eat --export-marks=foo and barf?
>
> No, apparently it skips them. But try 'git fast-export --export-marks
> marks HEAD'.

That is the kind of thing that needs to be said, not in the
discussion but in the history, either in the log or in a new test,
or both.
