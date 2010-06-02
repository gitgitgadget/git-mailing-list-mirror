From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Wed, 02 Jun 2010 16:37:20 -0700
Message-ID: <7vwruh9fbj.fsf@alter.siamese.dyndns.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.9164.chriscool@tuxfamily.org>
 <20100601083549.GA28377@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:37:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxVF-0000tg-F4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293Ab0FBXhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 19:37:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933137Ab0FBXhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 19:37:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91094B7330;
	Wed,  2 Jun 2010 19:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=K9+Lt4aYXDltTbFLm+nhAN3Np
	eU=; b=HLo0nygNdxVO6OzSo5OdtSH8taLI5uThMubFfnwzM94n4wdXZpDDDYJcj
	eFKmOC4UW9ppxS/1Uq9ZGitrKDd3q06dKP24z6XW7sYf8FSkYj6UO6L3wFaOubLP
	oYr0yd/TpiL1Sa0P+TGfsegLwqpfv9DkZiGPsRAmGOcJqYSVNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ClI0iQNR/Vr3GNvk6xI
	u7PJ0YoQ9epHMjCMjo5KNt80JKwo8i0YD5ydHACK/QdxquyyEFxbqaaSkJg00Pm1
	uKKbbc8L08m0NuRgsJ/vHjkrIIM4uGQnvqYQEOnoSUNOBAnzIqM9OwjA84G4kHD5
	GrnvAMryCMJO6hWb41LSKp8s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2213EB7328;
	Wed,  2 Jun 2010 19:37:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D0A1B7321; Wed,  2 Jun
 2010 19:37:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CEB23D7A-6E9F-11DF-8443-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148281>

Jonathan Nieder <jrnieder@gmail.com> writes:

> As a side effect, this unfortunately changes the meaning of
> =E2=80=98git log --oneline --decorate --no-walk -5 --all=E2=80=99: in=
stead of listing
> five refs, after this patch that command would list the five most
> recent commits.

It indeed is a change in behaviour, but in this case it is probably not
such a big deal.

The order "--all" (or "--branches" for that matter) lists refs doesn't
have any logical relationship with the order of importance from the end
user's point of view (they're just alphabetical), and asking for "first
five" won't make much sense unless you are learning or testing the
combinations of options, i.e. not in real life, I think.

Thanks.
