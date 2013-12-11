From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Wed, 11 Dec 2013 15:16:24 -0800
Message-ID: <xmqqa9g7t1vb.fsf@gitster.dls.corp.google.com>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
	<52A0D199.1010403@web.de>
	<CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
	<52A0D9F5.3030101@web.de>
	<CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
	<52A18F69.70002@web.de>
	<CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>
	<20131209225950.GG9606@sandbox-ub>
	<xmqqhaahvas2.fsf@gitster.dls.corp.google.com>
	<52A8E124.4000002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 00:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqt1B-0007tT-QH
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 00:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab3LKXQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 18:16:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab3LKXQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 18:16:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4307F5A1B2;
	Wed, 11 Dec 2013 18:16:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PthBNkkHB+OchfnbzwhpJx6+QaU=; b=s/5ffZ
	UQX2PK62T/bT37oLRudGLC/l03xRL5A0L0ONJJgZhfwR9Dmy9ogAjPiG7SxprO8c
	LFIf9UylYnayEyY37LOboHajiX/N/O0ge2KRm8Wa4434Qa3suy8ezwOdSm/iV6m8
	2P3HuT+mngaEIz16hj8gYmuNuE9BK+zwUXFQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x4bUDaz/coewdKIxZ91vFVNFYzlPElvT
	cLNtg6Trkd+BG6pUrhQ7VFnhyqLMAMpA8Wa5oNEfMNn9EFqFh0OTcHHssG7dW24H
	UNR9oyP6S/1GvO4U5vY4QUOGS654j0qV52aNs3U4H2lM01zJsgcfGR4cai7s3jcc
	ITKewommbR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2328E5A1B1;
	Wed, 11 Dec 2013 18:16:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 243345A1AD;
	Wed, 11 Dec 2013 18:16:26 -0500 (EST)
In-Reply-To: <52A8E124.4000002@web.de> (Jens Lehmann's message of "Wed, 11 Dec
	2013 23:03:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41FA0E54-62BA-11E3-BAA4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239217>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> I think this is closely related to Martin's list of wishes we
>> earlier saw in the thread: remind the user to push necessary
>> submodule tip before the top-level commit that needs that commit in
>> the submodule is pushed out.  Giving projects a way to implement
>> such a policy decision would be good, and having a default policy,
>> if we can find one that would be reasonable for any submodule users,
>> would be even better.  Would adding a generic pre-push hook at the
>> top-level sufficient for that kind of thing, I have to wonder.
>
> That could call "git push --dry-run --recurse-submodules=check" to
> deny the push if the submodule commit isn't on a remote branch.
> that would only work for a single hardcoded remote, as the remote
> itself does not seem to be passed to the pre-push hook.
>
> So me thinks adding a configuration option for the --recurse-submodule
> option of push is the best way to achieve that. This could be set to
> "check" ...

Yes, that uses only a single hard-coded decision, and making the
branch name or remote name customizable is not enough, as you are
still hardcoding "if ... isn't on" part. It is not far-fetched to
imagine a project wants to add more restrictions to what commit in
the submodule history can be bound to a tree of a published commit
in the top-level project (e.g. "must be a tagged release point",
"must be older at least by more than two weeks", "must be signed by
one of these developers' keys", etc.).

So I am not yet convinced that a simple "option" that supplies a few
parameters to a single hard-coded policy is sufficient in the long
run.
