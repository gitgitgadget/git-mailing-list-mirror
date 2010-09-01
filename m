From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v2] tests: factor HOME=$(pwd) in test-lib.sh
Date: Wed, 01 Sep 2010 08:24:25 -0700
Message-ID: <7vaao17ahi.fsf@alter.siamese.dyndns.org>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
 <1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
 <AANLkTik7d9Rhx5NudeKvVMFAYvVhGxoYzK2y+g3CP=Zj@mail.gmail.com>
 <AANLkTim6Cb4vegGYG0ZtJxXvAwBxHYGOY7bQFbGSAcXV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 17:24:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqpB4-00075e-0C
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 17:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab0IAPYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 11:24:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665Ab0IAPYg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 11:24:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D90D3D2F6A;
	Wed,  1 Sep 2010 11:24:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cAdsg+uyoCFx
	wogBkl+Z7M9KzfY=; b=X/HVhArJYkayOvOo4wxnOV+ImZEe1a7+imjsaKjt5lbW
	m95CwMrPl0ePjoSu59rX9PBqysoGLoKVlu7MkS/RZMtB0zoy4JZFL2/U9dcBKzZp
	StVqs9Waz44MFg3ScRZQX8Ob+L9SIs6WNzGGh2AfrYnz6rfMDoBavXmqcnHZ1S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N+Q5Xm
	lFYxOv8ZvNQVMig2di8h2In5afSxbZ+wRphP4Ky/0cr9XeSc7nHzVZPO+x1+OvfJ
	UmpvMQkPxSeYSZNE8qUaGHGddWZjHKe+axYP3KuXYHVoyKgrTk31dazILYhHpap8
	2PH96byoOGx9VC93pusHSy20THI0xBsaSMyas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E5AD2F69;
	Wed,  1 Sep 2010 11:24:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B9F1D2F68; Wed,  1 Sep
 2010 11:24:27 -0400 (EDT)
In-Reply-To: <AANLkTim6Cb4vegGYG0ZtJxXvAwBxHYGOY7bQFbGSAcXV@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\, 1 Sep
 2010 07\:56\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 053A547A-B5DD-11DF-9C1E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155053>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Aug 31, 2010 at 07:42, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> On Mon, Aug 30, 2010 at 23:15, Matthieu Moy <Matthieu.Moy@imag.fr> w=
rote:
>>> The same pattern is used in many tests, and makes it easy for new o=
nes to
>>> rely on $HOME being a trashable, clean, directory.
>>>
>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>>> ---
>>> Just re-ordered the patch to make this one the first.
>>>
>>> I took =C3=86var's suggestion of using $TRASH_DIRECTORY instead of =
$(pwd).
>>
>> Thanks,
>>
>> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Junio: FYI you picked up v1 of this for next/pu, not this v2.

I know.

The originals all used $(pwd) as far as I saw, and it _is_ more faithfu=
l
and correct refactoring not to use $TRASH_DIRECTORY in this patch, no?
You can choose to change it to use $TRASH but that should be done in a
separate patch.
