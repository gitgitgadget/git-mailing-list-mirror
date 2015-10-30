From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Squelch warning about an integer overflow
Date: Fri, 30 Oct 2015 11:21:37 -0700
Message-ID: <xmqqpozwkyj2.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<b0e4b6736cc2ec88e5f7cf587629d6a4d7e502d8.1445865176.git.johannes.schindelin@gmx.de>
	<xmqqpp01fkg5.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510301918320.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:21:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEJ6-0000B7-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760338AbbJ3SVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:21:40 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760334AbbJ3SVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:21:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEF0B24624;
	Fri, 30 Oct 2015 14:21:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GfrNrUzFgwm8kmqtlIa2SaxRs/w=; b=H5m+cT
	I682JuFk1zkIfWMBJcTraK2InLqbVl3tKmu0oJYkNK1sDWJicevWXkJYkyyma7yS
	MmGxX1tmOAffE/pRFIFdnFNk4W80VQCmmUVgf4H9hTEpSu+1N+Qn60h+46JW6lQP
	ERBuzOxI3tnk1qZ8U5L8kIJRBpoS76f26LTNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aq4h2C8vK+Fi4Gi1ApdX82Latonu8A6D
	CCHQlkJ6OnL/X0HitxXuiPmcPf/dThmOCJzCVlqN/xTELbKbHIZIhzpyoxuABloM
	OuJltMedzGCOzPi2W6xzyJtYx/dgTySVVlwmcLddyCOGOa341dBfN607c/xG7+cB
	cNNsX79hKmE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7AFA24622;
	Fri, 30 Oct 2015 14:21:38 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C36A24621;
	Fri, 30 Oct 2015 14:21:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1510301918320.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Fri, 30 Oct 2015 19:18:57 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F72D5BE-7F33-11E5-88D7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280508>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 26 Oct 2015, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > We cannot rely on long integers to have more than 32 bits...
>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> 
>> Interesting.  8192 * 1024 * 1024 does not fit within 32-bit long, of
>> course.  Perhaps we can lose L after 1024 if we are explicitly
>> saying that the result ought to be size_t (which may be larger than
>> long)?
>
> Sure. But it would make the patch harder to read.
>
> Do you insist?

Not at all.  I think the series is already in 'next', and if I
haven't merged it yet, I should.
