From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 09:33:26 -0700
Message-ID: <7vsiydy2i1.fsf@alter.siamese.dyndns.org>
References: <20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
	<7vvc3d1o01.fsf@alter.siamese.dyndns.org>
	<CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
	<20130812123921.GA16088@sigill.intra.peff.net>
	<CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
	<20130812154520.GA18215@sigill.intra.peff.net>
	<CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
	<20130813114635.GA16506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 13 18:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9HXN-0008K2-8c
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 18:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab3HMQdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 12:33:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab3HMQdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 12:33:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A601D38B39;
	Tue, 13 Aug 2013 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4eSub5X86czvqcWVciq3OB78fqQ=; b=RRAw2Q
	AGeP3e/DWipPTAOGWuBTa8cgR+zBjDeKhzB/coRvjX8Py6/yTgPj4zd8x2r6tDB+
	VmUlOWha2vn797BxGtuTZR51YSrru4CI2yTzrX2Zo1jUCbUdJI/tfz4d8IWL6hv0
	AqZO0NoELoRAgLpGFpyrNSJ6dPBOzzcfGvubg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J00Hiwe1ID0+IXFdChabDOALFPc6nTQE
	6/EBlNU9dovjkns/LMBQ7u7qd5/N7o4mVzwkjE2hUttk6oTCnTyGZCtPjdz/NNbE
	sOZN/iwLyBZcXV3F2ZqSqeOXKnWpwSngLkGY8Svzb/vXnnpO+D4tI0sY3jDjVGGP
	2D0/Ii/G/s0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87A5E38B38;
	Tue, 13 Aug 2013 16:33:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A659E38B35;
	Tue, 13 Aug 2013 16:33:27 +0000 (UTC)
In-Reply-To: <20130813114635.GA16506@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 13 Aug 2013 07:46:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1533EFDA-0436-11E3-BBD0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232232>

Jeff King <peff@peff.net> writes:

> I guess we could do something like:
>
>   [include "repo:...your regex here..."]
>     path = .gitconfig-only-for-some-repos
>   [include "env:USE_MY_MAGIC_CONFIG"]
>     path = .gitconfig-only-when-magic-env-set

I am not sure if "env" is very useful, but there certainly are other
possibilities (e.g. apply this only on this host, only for members
of this UNIX group, etc.), so having "repo:" prefix even if we only
support the repository path mapping in the initial version is a good
way forward.

Thanks.
