From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSOC proposal
Date: Thu, 24 Mar 2011 16:47:41 -0700
Message-ID: <7vtyes6pya.fsf@alter.siamese.dyndns.org>
References: <20110324220104.GA18721@paksenarrion.iveqy.com>
 <4D8BD358.1030603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:48:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2uG5-0003Nx-8f
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 00:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934337Ab1CXXrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 19:47:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757372Ab1CXXrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 19:47:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75A084194;
	Thu, 24 Mar 2011 19:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NbK0MxKplG45wKQh3O3euBFw3so=; b=JSY8zX
	LKsB3jxvNDaG8rJkd1lwz1P25BeU+z4iGFVvZB/og9/Q0icJaTXoRN5kC/2nZPxr
	o5z/6oot8kpiFb+U94RqGJFGZmNqP3rCpWIagNXEXguAdFFfTo8X0QMuQIdu34sY
	ZV724rgwchKA+JnxtOYyM9ZociWVgPtfio7zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dQyc0pM+TXFwneCS8cP8YmSWTuQFvl5T
	vtItM6S3ATXgtv5KKD1G/u+IvsVGn0cx04yiCuf79nn/eBil6kvgCzHWVOlgVgWU
	EYCnkOaQ1YZotHwZRC2qnco8nXMLH6jZP/PeTA5xS6Ghh3wcHUyTCw3pTOczcT+p
	GcdqQKhCpaw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 411F34193;
	Thu, 24 Mar 2011 19:49:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A7334192; Thu, 24 Mar 2011
 19:49:24 -0400 (EDT)
In-Reply-To: <4D8BD358.1030603@web.de> (Jens Lehmann's message of "Fri, 25
 Mar 2011 00:27:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BC0B55C-5671-11E0-9781-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169956>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> == Preventing false "pointers" ==
>> It's far too easy to push a gitrepo pointing to a submodule version that
>> is not existing on the server. Prevent this by checking for available
>> submodule versions before acceptingt the push.
>
> Yes, requiring to force such a push is an issue raised quite often (I
> think addressing this issue would be a good starting point for people
> who want to get involved in enhancing the submodule experience).

You need to be careful, though.

That check can only be sanely done at a hosting site that hosts _both_ the
superproject and the submodule repositories.  It might make more sense to
have this check on the side that pushes, which by definition should have
both superprojet and the submodule.  Fail, or prompt to confirm, a push
from the superproject when it is detected that the submodule commits bound
to the commits in the superproject have not been pushed out.

> (And, as every year, it's a good idea for a prospective student to get
> involved in the git community before his application is accepted ...
> sending some patches is a good way to do that, maybe regarding one of
> the first two issues raised here? ;-)

While I agree that it is a good idea, I think the advice is about a few
weeks too late for this year already.
