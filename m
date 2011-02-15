From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Mon, 14 Feb 2011 16:36:52 -0800
Message-ID: <7v62smqgkb.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vd3mz33xb.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1102111811300.26684@debian>
 <alpine.DEB.2.00.1102132047500.4253@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 01:37:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp8ut-0003Po-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 01:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab1BOAhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 19:37:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1BOAhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 19:37:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22FAE479A;
	Mon, 14 Feb 2011 19:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=quqisAZrvB98AIN1warNjXWnYfs=; b=g1qKjZ
	4RwZlEbke+h9DMyb3+OMJkfidlw/AvoGDsBMpTyeZwEtLVNgLkCQ0VTjvdTjtftt
	HDKtFgZeXMLqwWY/clPcXpzaaAx+s6T/kM6IeGh1+MoaBE4EH4IsIxxGSsPiZrMK
	217idqt7fEIEyS76YQRe4vZiDFTyc4FOxJR4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nH9QivYUt3Lkute1gF7PfTIRJh62NF4d
	bpXMXXKo5499+UFhr+wPyIDLSoURRuaA3eCxXYgBgk/Xv2MmegY8/BoDgBiNZKaH
	AHi4r1jNCEt6gAN+2GRh+/DIslXOYAudRkLgyWmqXDcHopqZtK9YJyiApBwHCNfo
	vKw0bU6Le7A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B61DA4793;
	Mon, 14 Feb 2011 19:38:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B0D634790; Mon, 14 Feb 2011
 19:37:58 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1102132047500.4253@debian> (Martin von
 Zweigbergk's message of "Sun\, 13 Feb 2011 20\:54\:55 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB09C46E-389B-11E0-9E73-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166801>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Improve the situation by allowing options to be combined with sub
> commands both before and after the sub command itself. Persist the new
> value to make sure it is remembered across interruptions.

I somehow suspected that it would be much more messy, but with your
refactoring, things do not look that bad as I feared ;-)

The only use case it might be useful, however, is to start without -v,
realize that a verbose output may help you resolve conflicts better, and
continuing with the verbose option, which conceptually should be helpful.

But in practice I doubt the ability to ask for -v output in the middle
would be so helpful, so doing this may not be worth it.

I am not a regular rebaser anymore, so I wouldn't be a good judge beyond
just my gut feeling.  Comments from heavy rebase users who often see
conflicts are appreciated.
