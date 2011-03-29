From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revision.c: make --no-notes reset --notes list
Date: Tue, 29 Mar 2011 15:04:26 -0700
Message-ID: <7v8vvxpor9.fsf@alter.siamese.dyndns.org>
References: <20110329205307.GA30959@sigill.intra.peff.net>
 <20110329205942.GF23466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4h1n-000795-OZ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab1C2WEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:04:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab1C2WEi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:04:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DE0E4D81;
	Tue, 29 Mar 2011 18:06:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=97/mdzZRwth73sKYUa7NeTMaoy4=; b=CjC5AUHo5pbs1nUSiBEH
	scWRCAu+62uPTEkfcUhxirUjNl14qly2SbkQGoo4sux+qrdazYuRLH34NtH2e60+
	tkawCq2QGAFciRJis6yHJAYm6ETF9t/3CdxY8BOpL0Jd3d/W+pOshs/0Hj/U7l82
	cQ6AA83qEQ79zu1Q0GLg3tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZNUWmDwuAf9IXej5bVX9F0a9II4N/58g/23Cjkd+WoHZyp
	Af1/8H1yJd4+I1stGolwqNdo2X4pRJwZnmLxvil72ypJ6+SN0RUKUN92+ws0siYf
	V7oq+8KBTO4xeVZ11JLhR1juG2Bs8BqRuYUxfQIrsYAlDhgMfXVvqZrW5+x8g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF2654D7C;
	Tue, 29 Mar 2011 18:06:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C3B64D77; Tue, 29 Mar 2011
 18:06:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C731E7A6-5A50-11E0-9991-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170331>

Jeff King <peff@peff.net> writes:

> Technically this is a regression for:
>
>   git log --show-notes=foo --no-notes --show-notes=bar
>
> which used to show both. But I consider that behavior useless and crazy,
> and since the --no-notes actually did nothing there, why would anyone
> have been using it?

I suspect that nobody would complain; we could even ridicule whoever claim
to have been depending on the buggy behaviour.

    It was a _bug_ that 'git log' still showed A when it is ran with
    '--show-notes=A --no-notes --show-notes=B'

may even be more appropriate description of this change.

Thanks for bringing in a bit more sanity to the world.
