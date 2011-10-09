From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Sun, 09 Oct 2011 16:18:49 -0700
Message-ID: <7vmxd9pxd2.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
 <4E8EBAFE.8020805@drmicha.warpmail.net>
 <robbat2-20111009T225253-591026811Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 01:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD2e2-0007XF-7E
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 01:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab1JIXSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 19:18:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007Ab1JIXSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 19:18:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357956C46;
	Sun,  9 Oct 2011 19:18:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fAkc5NWo+6ENXGbbTkz1mAgejdU=; b=JWrZuN
	DQVbcZZADA4z8/dUA4t12CwMG6vTdydJUWRv92FKJScmg5N5k0ZSJWVVbsLc3Qm2
	KCJIA/NLpPxE5eEoYTEDHqhmvYa4T24rDrUSTauOd8z5jKS5J70EIs7SvgITFbCq
	gsHkm6BM2x3zfSTPsoROkdOQ2QrbkwSuKE4j8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhRBfG+RxSvSyMSU3g+QCzNy5i3x9gAn
	x1hk9Ku3NSrnGcGMsmI2mnk23MRGlRgPzrzAC9a5R5BOy6OUtHxPUq6Q9LG/ns0Y
	W323f1698/QyjSjzlHF7eMBZOLWYELf5wJ0d2PceMuDhb1+H8oQ8uRcDvhIMIiml
	kus9vrEenZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB936C45;
	Sun,  9 Oct 2011 19:18:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B68636C44; Sun,  9 Oct 2011
 19:18:50 -0400 (EDT)
In-Reply-To: <robbat2-20111009T225253-591026811Z@orbis-terrarum.net> (Robin
 H. Johnson's message of "Sun, 9 Oct 2011 22:57:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C2CACBE-F2CD-11E0-BB93-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183216>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Workflow example:
> 1. Dev1 creates a commit, signs it, pushes to central repo.
> 2. Dev2 pulls, signs the tip commit, pushes it back.

I personally am not sympathetic to such a "sign every and all commits by
multiple people" workflow. If you really want to do such a thing, you can
have the second and subsequent one to create a new commit on top whose
sole purpose is to hold such a signature (commit --allow-empty --gpg-sig),
or use signed tags.
