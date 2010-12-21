From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3419-*.sh: Fix arithmetic expansion syntax error
Date: Tue, 21 Dec 2010 12:24:39 -0800
Message-ID: <7vei9a98mw.fsf@alter.siamese.dyndns.org>
References: <4D10F707.1000206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, drizzd@aon.at
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 21 21:24:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8lS-0006w5-Vp
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 21:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab0LUUYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 15:24:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab0LUUYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 15:24:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF8542F21;
	Tue, 21 Dec 2010 15:25:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dEGmcC0uUv5mr4IHY9pC2Eqs11s=; b=bPRcvM
	Q6MLUSjncqPaf1a30sE86ugSKU4hzDrI6zSxi/bGUFoMxybW7zGPN444rA+NR0x2
	ni3dUpbdIpwMlb+1KNGoUrMpYlfdOqQi1aas69ci4pNJVS9V2gID9CJ14ZHn7Wa6
	RAkqx5Oakc768apDU+OxSupDT5bhcZa1IsUiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQvlLhYLgCNoprmGpS2c/IoAoldnZylZ
	LpqMP8wcb1Znv9bHfYE5jDl16B+6vBd8x+GU25wCtP2/lywgDGSH67u76aocqHpc
	3CaWTTWZaKJ/11ib8fb2qOM35AtE4aTTG7I2pvdfoMsQ6oxVlcS1ZFcOfdc34db1
	Ld/mfgMmM74=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A99A2F1F;
	Tue, 21 Dec 2010 15:25:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E9002F1E; Tue, 21 Dec 2010
 15:25:09 -0500 (EST)
In-Reply-To: <4D10F707.1000206@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 21 Dec 2010 18\:50\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A5C4D6C-0D40-11E0-A556-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164052>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Note that this test is unique in having an '#!/bin/bash' line (rather
> than '#!/bin/sh'),...

Thanks for spotting, and that is idiotic for us to have such a script.
We should fix the shebang line as well.

A quick git-grep shows that this is the only instance of this problem
(outside contrib/completion/git-completion.bash, that is).
