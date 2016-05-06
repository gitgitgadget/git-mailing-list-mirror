From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Fri, 06 May 2016 15:15:23 -0700
Message-ID: <xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:15:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayo21-0003TD-R4
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 00:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbcEFWP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 18:15:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758670AbcEFWP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 18:15:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B64318D3E;
	Fri,  6 May 2016 18:15:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Tpr9UZjDvTILREhJidI0aWLxDc=; b=vqA/hw
	d+H6TWp4gTgH/lJHDNZRbKkpSUtlbuzkRMb1vlLepLI5INBNVLUXD5VlKrTCpI51
	jn/phbHa5ilKlUyEv+3e5WdsQOcwwTEgEKgVr4Ux3TPHpWgRFpUeSc5Tj/fGsVHt
	YyWrKfMqg6aatVC354BtFXy/lBCUt0nKM8IHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n2rxva21P//2nj21qe8woIASNeoZ+1+O
	0aLBsQt5UhU/DyNLPGmIK0ASPIaIT1t7X96rdLXlDJSY1CttZhTWsXkcUE/6KWj+
	cJV+nb5F0Zuqemo1ClslCyMi8Eh+oOUnsnW1aIcYcO8p3lwQ+a0aLsUS233eh9ft
	ZYnBYRN74pY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2372118D3D;
	Fri,  6 May 2016 18:15:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A7EB18D3C;
	Fri,  6 May 2016 18:15:24 -0400 (EDT)
In-Reply-To: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> (Pranit
	Bauva's message of "Fri, 6 May 2016 20:19:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07DBC63C-13D8-11E6-A1DD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293864>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> A very interesting fact to note:
> I made a mistake by dropping of the first argument 'term' in the function
> one_of() and compiled and the test suite passed fully (which was pointed
> out by Christian). This shows that the test coverage is incomplete. 
> I am
> currently writing tests to improve on that coverage. It will be included
> separately.
>
> Link to v4: http://thread.gmane.org/gmane.comp.version-control.git/293488
>
> Changes wrt v4:
>  * Stick with 'subcommand' in the commit message.
>  * Rename enum as 'subcommand' to make it singular.

I've already said what needs to be said on this.

>  * s/bug/BUG/g
>  * Drop _() in the default of switch case
>  * Use some suggestions for commit message no. 2 and also include why I am
>    using subcommand.

I am not particularly impressed by the rationale, though.

As a starter project to show that you learned how to add a new mode
to bisect--helper, check-term-format may be a small enough function
that is easy to dip the toe into the codebase, so in that sense it
may be an appropriate first step, but otherwise it is not all that
interesting, especially when we _know_ that it will be discarded.
