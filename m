From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 09:12:46 -0800
Message-ID: <xmqqvbk9b81d.fsf@gitster.dls.corp.google.com>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
	<20150114121915.GB30383@peff.net> <20150114123536.GA31530@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Henning Moll <newsScott@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:12:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRV0-0004qf-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbbANRMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:12:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751109AbbANRMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:12:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 727A12B455;
	Wed, 14 Jan 2015 12:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yxWYB7n6lDLfC0raIW+a2vup72Y=; b=tEYhpG
	8/7Yu7Aho2NwNJQhxgVZ5wKAcEVo/AyoEDX4P5LX/JWW4H6jW+3+ZTjGs0m1oToi
	3g2Vn/10UY6WglWoSKmeYq0OwX4wuKgGuy0ZSFbvUdn/9VNQ36uQxt7NbFshYnPi
	v6h+rHlsMsMExVAhqDGp+UOeE++pjFqD5bwBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jpg8v7fYXh6vo2aOMbVqa23vwwo3kLIi
	dzdyz/Sa6SubCYEnfffpt3qcFrYns/G7jpNiVF/hLqsZXpB1WYTgAEMsIKfsbKPJ
	o7QVWZ6vIArdyyUJCFiJAwX9W2hr4uXjnu6f71j0nfsuQovY1G9+tj1Tq6Al0btu
	/+7ehZ2V+y0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6877D2B454;
	Wed, 14 Jan 2015 12:12:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0ECF2B453;
	Wed, 14 Jan 2015 12:12:47 -0500 (EST)
In-Reply-To: <20150114123536.GA31530@peff.net> (Jeff King's message of "Wed,
	14 Jan 2015 07:35:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 901EBC48-9C10-11E4-8747-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262391>

Jeff King <peff@peff.net> writes:

> What happens if we rebase with it?
>
>   $ git checkout 01319837
>   $ git rebase -i HEAD^
>
> will yield a todo file with the 8-character unambiguous abbreviation.
>
> So I guess all is working as intended there. Perhaps you really were
> just very unlucky and an earlier step of the rebase created a
> conflicting sha1.

That would mean 75c69766 (rebase -i: fix short SHA-1 collision,
2013-08-23) did not fix what it intended to fix, no?  Is the symptom
coming from pre-1.8.4.2 version of Git?
