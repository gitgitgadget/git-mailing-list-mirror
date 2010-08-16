From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: test for regression introduced in
 v1.7.2-rc0~103^2~2
Date: Sun, 15 Aug 2010 18:49:43 -0700
Message-ID: <7vaaonfhs8.fsf@alter.siamese.dyndns.org>
References: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
 <1281748247-8180-1-git-send-email-avarab@gmail.com>
 <AANLkTi=Na_K=9oXM7iyeKodWXyXuSy-0UL792igTEjEe@mail.gmail.com>
 <7v39uggs5h.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PAW_Owy_-DSQ32sboB28373Gb_aySbpeprwLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okopr-0005Hm-Ha
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab0HPBty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 21:49:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab0HPBtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 21:49:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD02ACD893;
	Sun, 15 Aug 2010 21:49:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CPMexLW3wxJI
	3o5MY3QqB/JE5kw=; b=jQBgxkVkChHw0QbeNaaPShLe/h4Mh9hJfI6LzSXx5kby
	qdIDUBq/vGZgbOTB667O+AfGfbOUcfh6bpf/a+cd85KMyTz1Ohr+bBpefdCqut1v
	+sFOqpCmgXHigYmZVgyYjtyiwq7hwBDP9+4jq/izLAXKGQFpdquI/RvzW+TBhIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dlLujw
	IXVE3dEXiin+jn+wTJMT0CiW03gsplXRBF0TgRotrriYvaOmQki72RUwjBh7IO4E
	15Fp2JoMu4xfxVJsMjHWEtVKO13jsKD6dDqDLjKRuHH8JgVIBtXILmcMF+jymcYm
	v1dgtSqfIEk0dEYoX8rlRKJ+UIjuCYFcEMgLs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B347CD891;
	Sun, 15 Aug 2010 21:49:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA2DCCD890; Sun, 15 Aug
 2010 21:49:45 -0400 (EDT)
In-Reply-To: <AANLkTi=PAW_Owy_-DSQ32sboB28373Gb_aySbpeprwLg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 15 Aug
 2010 09\:24\:16 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E2BE22E-A8D8-11DF-A872-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153643>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> + =C2=A0 =C2=A0 # Needs an unrelated root commit
>>> + =C2=A0 =C2=A0 test_commit README &&
>>
>> This is not a "root" commit, is it?
>
> s/root/first/

It is not even the first commit, is it?  It comes on top of whatever
commits that earlier tests left.

>>> + =C2=A0 =C2=A0 >Foo.bar &&
>>> + =C2=A0 =C2=A0 git add Foo.bar &&
>>> + =C2=A0 =C2=A0 git commit --allow-empty-message </dev/null &&
>>
>> Does emptiness of the message matter?
>
> No, I was just going for a minimal test case, no commit message is
> more minimal than having one.

I do not think having to write "--allow-empty-message </dev/null" is
aiming for being minimal; it is doing something unusual after all.

If you do not remember why you added this test 6 months down the road,
wouldn't you be confused to think maybe the commit has to be unusual in
that it has to lack the message to trigger the bug?
