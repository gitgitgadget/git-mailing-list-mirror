From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] msvc: Fix some "expr evaluates to function" compiler
 warnings
Date: Tue, 29 Jun 2010 09:50:55 -0700
Message-ID: <7vlj9xaikw.fsf@alter.siamese.dyndns.org>
References: <4C226323.5080709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTe1j-0005Nl-Bf
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179Ab0F2QvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 12:51:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab0F2QvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F58C0268;
	Tue, 29 Jun 2010 12:51:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=MLW/0SV/VYrKMjMtyJLL9056hpc=; b=lHurP1pMQNQGrwc56P4efi/
	13w+Jh/+Tu8g+njmORR8HxP1Hi5zOYYdS/ivfx8SO2nCCyab7p96LbsNeU5Bux6k
	F81VyKf6ZRBqUTDDLxvND3GDY2Ir2167UpCn1Td9ERSJRDalLAFv9PWRHDUEhbl+
	fxeZU+gsUXBMUdjCv8tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BM/1efJWYl2unKvuP+53FvliNCnpaMzVHOuyxh8pPHI/iL66u
	1w7CyJNZWosv/V3osus7n7n2uBXDskxewoeVYpiOs42zWyE2vibKXCecxISM43I8
	+uzjYufJwFXEfL8q1XAZyqhXFstBOmZFmuRr0XkXHSETelw4h4wjDo8S8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F9CBC0264;
	Tue, 29 Jun 2010 12:51:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5C5EC025F; Tue, 29 Jun
 2010 12:50:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FC77FA4-839E-11DF-8A93-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149920>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, the following warning is issued while compiling
> notes.c:
>
>     notes.c(927) : warning C4550: expression evaluates to a \
> function which is missing an argument list
>
> along with identical warnings on lines 928, 1016 and 1017.
>
> In order to suppress the warning, we change the definition of
> combine_notes_fn, so that the symbol type is an (explicit)
> "pointer to function ...".  As a result, several other
> declarations need some minor fix-up to take account of the
> new typedef.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Looks sensible.  Thanks.
