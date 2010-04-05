From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Sun, 04 Apr 2010 20:57:14 -0700
Message-ID: <7vy6h2pn51.fsf@alter.siamese.dyndns.org>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <h2rfabb9a1e1004041915u3754016cr10e874c12f2a24e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 05:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NydRP-0005sR-Do
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 05:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0DED52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 23:57:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0DED50 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 23:57:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13531A8715;
	Sun,  4 Apr 2010 23:57:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9VO1PyOEVnUv
	HF+UbauU512ecKs=; b=Iw8yClYBd3WD05ZUJOSUK9LE99Vs3+43ixlVR1ckyHwh
	MPAcQ05Nh/ufOhc2r6isUo0DblE9DoDEC9A9r0yEavwrpzKSGxnK5suIVtsclt2W
	ym0vF5haQLf2gZDw2GxEbbStRsJvXkK17Y+rEOwyj9ZZMzMIx/wGQNAsBgi0aYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ag9mqc
	Dyzw+slKC3VwEu1zOM46uRWXvXpPKVpVIKT51yhG7mCY386likprRu0XtGiH21lB
	L4FBUQYjEFbUKdNJXur7NB6wwtqKQ3ECDqQwJ5jxyECa9PwQk2Ev51bGnHDPS1+P
	xxQqMTX3hmqjUfsRI95OgrFzP9fVlJnHS26J4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C691FA8713;
	Sun,  4 Apr 2010 23:57:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B6DFA870E; Sun,  4 Apr
 2010 23:57:15 -0400 (EDT)
In-Reply-To: <h2rfabb9a1e1004041915u3754016cr10e874c12f2a24e6@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 4 Apr 2010 21\:15\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55B07BDC-4067-11DF-99C2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143967>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Apr 4, 2010 at 21:11, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> As a Porcelain, "git commit" has some leeway to enforce sensible pol=
icy on
>> the users, and "forbid commit that does not explain anything" is one=
 such
>> policy. =C2=A0It is not generally a good idea to expose the full cap=
abilities
>> of plumbing to Porcelain if it leads to bad user behaviour, and such
>> "artificial" limitations are safety features we do not want to remov=
e.
>
> You contradict yourself:

I personally don't mind very much removing --allow-empty, though.
