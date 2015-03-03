From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and git rebase
Date: Tue, 03 Mar 2015 15:15:15 -0800
Message-ID: <xmqq61ahad18.fsf@gitster.dls.corp.google.com>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
	<20150303210900.GP890@serenity.lan>
	<CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
	<20150303214653.GQ890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Botsko <botsko@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:15:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSw2G-0003xF-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbbCCXPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:15:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757547AbbCCXPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:15:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 911E83DF37;
	Tue,  3 Mar 2015 18:15:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oTISPc8ZQCs7APnKlpwz2pG6p9E=; b=BJyCzh
	Kon8l/eK8QXWidpipl8T0lhKiqYf2+q4MZ1YJ5PmLz7wEFQRIsKKkULXBeeVla23
	vVK2iB6Izt84fqsjOmgLqrxRsIdO0OsrTTurKy5e6JddxrHBuFrC5A+JkKq6Kk34
	3z5pKk22w6oGOxP7/1Hdwk2DMaaF8Ujkyxzmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eHrcD73LAclmnyeJRVcYbKAo4zCQs9RE
	OYfKYdPHW04Yy4Fn2rtA0H2DoGJSWYOroipbsuuPmm2hSFCZsXvRgtA36GuStkOt
	p80wYS05/r9JkKxrGavviLaxG2AzWR/77fb3g9vIyJnHBbYtZDPybibHLDyiGrCB
	XwflRmdsonw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 862D43DF36;
	Tue,  3 Mar 2015 18:15:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C5493DF34;
	Tue,  3 Mar 2015 18:15:16 -0500 (EST)
In-Reply-To: <20150303214653.GQ890@serenity.lan> (John Keeping's message of
	"Tue, 3 Mar 2015 21:46:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 27732830-C1FB-11E4-85CA-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264706>

John Keeping <john@keeping.me.uk> writes:

> git-rebase assumes that if you give an explicit upstream then you want
> precisely what you asked for.  From git-rebase(1):
>
> 	If either <upstream> or --root is given on the command line,
> 	then the default is `--no-fork-point`, otherwise the default is
> 	`--fork-point`.

Correct.

You ask it to rebase the history without guessing by being explicit;
the command guesses when you are not explicit and being lazy ;-).
