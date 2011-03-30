From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] remote: separate the concept of push and fetch
 mirrors
Date: Wed, 30 Mar 2011 15:22:35 -0700
Message-ID: <7v62r0meok.fsf@alter.siamese.dyndns.org>
References: <20110330195139.GA814@sigill.intra.peff.net>
 <20110330195318.GB30624@sigill.intra.peff.net>
 <7vhbakmj5k.fsf@alter.siamese.dyndns.org>
 <20110330205734.GA2940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: chris <jugg@hotmail.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53mx-0000Ur-AL
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187Ab1C3WWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:22:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145Ab1C3WWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:22:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEDA94E90;
	Wed, 30 Mar 2011 18:24:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2OZRCtTJi4NvV2mTTA6bcelSSes=; b=doA3/K
	HYxZb2MNhXhv3SGbOeai1tUi0HmG9wTltTC6XdrHFWlVbRaRuXkt0b2QlNHXlvMW
	rll1REXwtaYnYYux+joqEGa3hJsAEBUroyUGLxQtae0hGIyT0ED7M1anqCojGRCP
	syVlSBtu9rYkHCxQOZZPuM8nggU+U69bL+US4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0E7RohdgSrxKTBJwYtHx7OmCpCwvQtK
	V1TAQLQFHPmbT7rYUP0224SwDIJHgLn5AMoyhFFCdkP4kAxxh0OKFk9b9Owg9kCu
	ug8zy9gkOJG0J1RWQZHJetWGNz53PoxKz4cVkjWnc1vGMBK0nzfLpreCvXDmDdvW
	vRQOWUTnjBE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 651004E8E;
	Wed, 30 Mar 2011 18:24:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 19F0E4E8B; Wed, 30 Mar 2011
 18:24:25 -0400 (EDT)
In-Reply-To: <20110330205734.GA2940@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Mar 2011 16:57:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BAE2B10-5B1C-11E0-8C54-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170431>

Jeff King <peff@peff.net> writes:

> I think the problem is not that users lack common sense. It is that we
> give them an option called "--mirror" that sets up a bogus config in
> some circumstances. So it is the git developers who lack common sense, I
> think. :)
>
> Specifically, 84bb2df should not have started setting "remote.*.mirror",
> as it was already about fetching into a bare repository. And probably
> --mirror in a non-bare repo should have complained from the beginning.

What I meant was that what 84bb2df did was sufficient for people who know
which one they wanted and stuck with what they said they wanted.

What would we call a person who first asks "I want a push mirror to save
away my work" and then says "now let's fetch from there", without
realizing that such a fetch will obliterate his work?  I agree that it
probably is asking a bit more than "common sense"; it perhaps requires an
ability to think for 5 minutes what oneself is doing ;-).

> But hey, hindsight is 20/20.

Indeed.

Thanks.
