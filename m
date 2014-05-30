From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Fri, 30 May 2014 11:45:36 -0700
Message-ID: <xmqqa99z9kbz.fsf@gitster.dls.corp.google.com>
References: <1401320757-9360-1-git-send-email-pasha.bolokhov@gmail.com>
	<20140529201334.GA17355@sigill.intra.peff.net>
	<CAKpPgveDfNq+kxWCukULPqvn7H2XsfS8maC0ExzvHzFGiEAPbg@mail.gmail.com>
	<20140530020444.GH28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pasha Bolokhov <pasha.bolokhov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 20:45:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRoI-0004QI-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbaE3Spn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:45:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53132 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413AbaE3Spm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:45:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9C681A560;
	Fri, 30 May 2014 14:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOJqIP+O/+VnfQH+IeQN2U7Ou3o=; b=kiNANo
	fXc7ViGXueysoBy9a/N8vjcnaeBxo5CsUvg0vb4UB0ja0fuL1PDVBXYKNhLdvDEy
	oIPrtxW6oLofAxYAIWrg50d9zw//4CoMTdpBMGhAjFsb4rwrYa8WM0equbIH7aeF
	oP0YpteZeQSmdmRfTXX0RjRcXIOBNQqJK7H/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QVpbI97nrCk64KmV9nlZD8FIbKIY3/Ys
	p5BOhUtFWBPhnIyj283AVE8sNnVL7ji0G8e9r/gf7Rvkcs+4SovkdiP4zQCFYlkQ
	Em3GzG5DiPwWDdtspFfM3IvGTcghobXAktUVS9uM1z+LoqZy7tDTnmEn+FsnPCKK
	ZTc0JETgRXI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFD2A1A55F;
	Fri, 30 May 2014 14:45:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 523601A559;
	Fri, 30 May 2014 14:45:38 -0400 (EDT)
In-Reply-To: <20140530020444.GH28683@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 May 2014 22:04:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97C073C8-E82A-11E3-81DB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250466>

Jeff King <peff@peff.net> writes:

> On Thu, May 29, 2014 at 02:34:33PM -0700, Pasha Bolokhov wrote:
>
>> > However, I doubt it makes that much of a difference in practice, so
>> > unless it's measurable, I would certainly go with the version that is
>> > more readable (and correct, of course).
>> 
>>     Sorry, just to recap, you would go with the existing version
>> (which needs correction), or with the one that is being suggested? (I
>> agree I can format the style a tiny bit better in the latter one)
>
> I actually think the original left-to-right is a little easier to
> follow, but I do not feel strongly. I mainly meant "argue based on
> readability and correctness, do not argue based on speed".

Sensible.

> I'd be OK with either, though I have a slight preference for the first,
> just because I find the "bslash ^= 1" bit of yours, while clever, a bit
> hard to follow.

FWIW, I think I agree.
