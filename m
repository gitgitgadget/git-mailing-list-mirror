From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is
 supported
Date: Thu, 08 Jul 2010 12:40:02 -0700
Message-ID: <7viq4ppxt9.fsf@alter.siamese.dyndns.org>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:40:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwxH-0004gP-RQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758307Ab0GHTkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 15:40:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab0GHTkL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 15:40:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A850C22D2;
	Thu,  8 Jul 2010 15:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=yMDK3ZfnT39etGlXIwM7ZPLw2
	qM=; b=ABxWPYjBeQJuqXeoECZxXXe91E8uK1+qp+sctAoUZXvUehft/rHoYhN/v
	XHlX7/3Bx2ctUCaUPxFSWSml33Dpk3jjL8l/Q2F4Tl58Ou++OuaqndN1bNPEqSQy
	aGfHOrBDVqbmFUnDreD00CkT7Zt/6BvZ21hcCqrHOUU0K+WAlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=xTxLZruacahBCnYlKuB
	21YecJodOn5MMAI2tq0ENX3J1oDqJECaiFFBfvqoGHqf25epGxCRf7PoUQOSSxy2
	Nrg6Wns59z58o+28Is6jtU5Dy6gNdwuvQKmmDBHpU61eOR8J70nHsTUnSbYEL2sO
	kLCbrV9m7XPAOK5kyT28bpZw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D940AC22CD;
	Thu,  8 Jul 2010 15:40:06 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AE06C22CC; Thu,  8 Jul
 2010 15:40:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C876F7E-8AC8-11DF-8398-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150605>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +if git grep ile a
> +then
> +	test_expect_success 'git grep ile a' 'git grep ile a'
> +else
> +	test_expect_failure 'git grep ile a' 'git grep ile a'
> +fi

So if command "X" is known to succeed, we run it inside expect_success
and if not we run it inside expect_failure?

What kind of idiocy is that, I have to wonder...
