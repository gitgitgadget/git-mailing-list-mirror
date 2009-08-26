From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Wed, 26 Aug 2009 02:03:14 -0700
Message-ID: <7vy6p7eylp.fsf@alter.siamese.dyndns.org>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
 <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <7veiqzjmy7.fsf@alter.siamese.dyndns.org> <20090826050224.GK3526@vidovic> <h72td7$cu6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:03:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgEPr-00033e-O3
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbZHZJDb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 05:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbZHZJDa
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:03:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbZHZJDa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 05:03:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6154D19798;
	Wed, 26 Aug 2009 05:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=p4aoRfRwJsdQ7eoFBq66LTWqx
	rI=; b=Kaoa6GzHsCIXqbn6zwWB2tGWRvC467VHQF4nsY4Ybe2TLVWERFZWsT3VO
	plavTUpX64kqUXOY9J5a4c0GetX1D3UbbmcmekT7QGKgwyp0haE2/WZlzIwvGOYt
	dqfpokIDDKwXNSsx4as781sbkJaprrlNGI7hglm9GaIX5dRlAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=mS2+AAgefTp4S19pLNE
	lgActeQ3n2jpjHvuVpE8xPMTUueQ9+mQyTXRvvrnUr1pgyXvoaSDnS0Hynu3I9KZ
	Ip6X8pueeboLEuQbCmt3OAHgOMEiloAFzbKgVtDD1prk2ViWpvZqxPL/v6IKIftS
	lrS8TAvKd7f+Tc9WZDrXRhLA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0403219794;
	Wed, 26 Aug 2009 05:03:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5B2F19792; Wed, 26 Aug
 2009 05:03:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F4E0030-921F-11DE-8019-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127073>

Jakub Narebski <jnareb@gmail.com> writes:

> Nicolas Sebrecht wrote:
>
>> For people who _really_ want to obey to scissors by default I'll add=
 an
>> option to git-config. Whithout more comments, I'll add
>>=20
>> =C2=A0 scissors.obey
>
> mailsplit.scissors

That may be a better name.

It must take lower precedence than the command line --no-scissors optio=
n,
and that option must be given to am when rebase internally runs am, so =
that
we won't pay attention to scissors when rebasing existing commits.
