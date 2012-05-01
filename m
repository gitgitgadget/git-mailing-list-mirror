From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Location-agnostic submodules
Date: Tue, 01 May 2012 10:57:07 -0700
Message-ID: <7v4nrzaioc.fsf@alter.siamese.dyndns.org>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org>
 <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com>
 <20120430220244.GL22827@pape.arcanes.fr.eu.org>
 <CABURp0rUKubfWXxX2ABG2E4dRTEQh4zA0bZFOeXGwv2m4b0YaA@mail.gmail.com>
 <732A8D2DB3374CD6BC12A5E7C4384313@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Phil Hord" <phil.hord@gmail.com>,
	"Pierre Thierry" <pierre@nothos.net>, <git@vger.kernel.org>,
	"Jens Lehmann" <Jens.Lehmann@web.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue May 01 19:57:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHKB-0007hm-NL
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415Ab2EAR5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:57:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758408Ab2EAR5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:57:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11576859;
	Tue,  1 May 2012 13:57:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r0o+MTtioK4MMqUHyEZH6z5pGuo=; b=ILRV1D
	u3TdMFp39hh2lahfBhb1AA1UE0a/YufnxcSZ/1vKh5KNtgxwzLOLdYnnDczK9ySd
	L9e5SBHvV/hudijn9YImeANx01DbqXUA664fFGyp4HxlRGEw9Mo1VfTn403N7PuK
	X7ShC5vLuPef81WjSQnT+7EuD+NePP1yHOAog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jv8+Mx9xxxQuA02vqMs2Ec1nCZZqkRp+
	kf4SDyhYqSWdAqtVRLF/2g79jf8x/f3AE8Usl6WAixFuYyQH/r+367wCBM0boT3g
	qGdpET5uOtmcUVG0HPlIen899L7v2M7fe1500ZlEIJ0vRYkptojKCHZ0OPIsvzof
	6p52A51gAS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D77AB6858;
	Tue,  1 May 2012 13:57:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69D486857; Tue,  1 May 2012
 13:57:08 -0400 (EDT)
In-Reply-To: <732A8D2DB3374CD6BC12A5E7C4384313@PhilipOakley> (Philip Oakley's
 message of "Tue, 1 May 2012 18:19:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11CC6CAA-93B7-11E1-9B33-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196716>

"Philip Oakley" <philipoakley@iee.org> writes:

> Would an alternative be something like:
>    git submodule update <module> --from <remote>
>
> so that the user can state which of the current submodule's remotes
> should be used for fetching the desired update.

Are you assuming that the <remote> in the above example will be different
per invocation for a single user?  I would imagine not---it would be more
like "the upstream has this URL in .gitmodules, but this other mirror is
closer to my network environment", i.e.

	cd <module's directory> && git config remote.origin.url $there

no?
