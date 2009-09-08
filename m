From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 00/14] git notes
Date: Mon, 07 Sep 2009 21:16:39 -0700
Message-ID: <7vd462qdeg.fsf@alter.siamese.dyndns.org>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <200909080512.34634.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 06:17:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mks8u-0002qQ-RN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 06:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZIHEQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 00:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbZIHEQ7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 00:16:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZIHEQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 00:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 455452A62C;
	Tue,  8 Sep 2009 00:17:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=WTMYhrzBfZThVPmB3vbLfuEhYyU=; b=IdHXUx
	Fu5qwtDzCqDzjrrDOwIXrYA+a/YNBHS1axwpS+t2mGRI2/QrSF9pIorHFDQ55zNM
	hw8Gjx0b0b9jCYVhU8xewCDEv/DZwsZkFgNbELZs0NFaPfxJQ9z1Vqz3tEr38Zph
	CpgKNNLwJXD4B2Ae/Yd9xVwGHRF2dWjv5G7kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9/lS9XqVWpuBjO6liaJRIVj4COfnijF
	eJHrnsiiNMZwSrZhGW0hKJnhEG4tg1/qbm3Fu2mngj0eDvYJUv0XpWuNI0NbFSat
	wZzSE7Btji5US2v3dZs1ASUcMCwE80ZvYA3wMeldIMSHoIRTJipohtFfhcdShz2N
	04v7Wylg8G4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8D742A627;
	Tue,  8 Sep 2009 00:16:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D2D12A621; Tue,  8 Sep
 2009 00:16:40 -0400 (EDT)
In-Reply-To: <200909080512.34634.johan@herland.net> (Johan Herland's message
 of "Tue\, 08 Sep 2009 05\:12\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F510968-9C2E-11DE-B237-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127967>

Johan Herland <johan@herland.net> writes:

> Furthermore, the following notes tree structures were tested:
>
> - "no-notes": Testing without any notes at all. This is only present as a
>   baseline, and to verify that the notes code does not negatively affect
>   performance when not in use.

Minor nit.

For this to be a baseline, you would need to have another algorithm before
"before", i.e., without any of these notes implementation.

Comparison with "before" alone is not meaningful.  That is like starting
with a state with unknown performance regression compared to the stock
version, and then boast improvements made by various variations.

You would need to compare overhead of various "algorithms" with the stock
git in "no-notes" case as well.  It would give us the true performance
cost of supporting notes.
