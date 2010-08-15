From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 15:22:15 -0700
Message-ID: <7veidzfre0.fsf@alter.siamese.dyndns.org>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino> <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
 <87tymwzjbk.fsf@catnip.gol.com>
 <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
 <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
 <AANLkTik+yGn_0PR9uO2_EsZgQPW187P4qmZx4fJSbAWO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Ralf Ebert <info@ralfebert.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 00:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oklb9-0000Xq-28
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 00:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab0HOWW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 18:22:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab0HOWW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 18:22:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 915ABCD3C7;
	Sun, 15 Aug 2010 18:22:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=76UCCuw4hd9V
	U/7ReTupnQb5Oik=; b=l2wgZH6QfV0t76A78xkDfRxAZsbHbTSUvSWsBsnbiaLc
	oVBsz4ZoNVmRHpbCE5sQ0NiP2x66KROJ3R1hPiLqKIOrcBfbSikWEEqLvqfSdwd7
	BNOxl8kM8LH3MLFAYW14sXRN7ctd8N6611DwTjSC45Rr1tANco9tGplFl7ndAWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wIvDyY
	C3OB6SDJTcEc7oz93V5e0O5oh0Aw+6afSs5u8AnOzxTYex5t3d3qCXIHXasaaD7t
	pjWt68qOWcLb4UN8Op0YONU3iEt9f09oqxw8oWQY5lYK2TPVuYR9oo7OWzNstKaN
	yvtKhjVLR8LGXDtZhcmEb10fzZcFH8T7L+4sc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41451CD3C6;
	Sun, 15 Aug 2010 18:22:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F59BCD3C4; Sun, 15 Aug
 2010 18:22:16 -0400 (EDT)
In-Reply-To: <AANLkTik+yGn_0PR9uO2_EsZgQPW187P4qmZx4fJSbAWO@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 15 Aug
 2010 20\:51\:03 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 938F741E-A8BB-11DF-8205-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153625>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So it's a question of whether git-reset should do all reset-y things
> without complaining, even when that infringes on git-checkout's
> domain.

I'm not sure about "domain"; do not think we should also forbid for the
same argument "git reset --soft" because it violates update-ref's domai=
n?

I changed my mind; I do not like "git reset --hard <commit> -- <pathspe=
c>"
doing "checkout <commit> -- <pathspec>", unless we limit this when <com=
mit>
is not given (or perhaps when <commit> is the same as HEAD).  Otherwise=
 it
would make things harder to explain.  So let's forget about it now.
