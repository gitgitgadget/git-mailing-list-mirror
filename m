From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sun, 12 Sep 2010 14:25:44 -0700
Message-ID: <7vmxrmd57r.fsf@alter.siamese.dyndns.org>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
 <20100830030819.GA25415@sigill.intra.peff.net>
 <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 23:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouu3z-00053b-Cd
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 23:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0ILVZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 17:25:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab0ILVZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 17:25:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E893D55BB;
	Sun, 12 Sep 2010 17:25:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XGngUw25AlnH
	hY6NwzumIId7r+s=; b=ClZkM8oPqgePAN4mzlIvURTcrHgrWR6uF3ZdEG498Zkp
	tur6Xp1T99/ja/WHuH8SZIlLhlHbctl/UaZieI/QvCu3iRruafAr+4xznyc+3qwU
	plxYHSJna2mR70oQ8fefrzK4+d4IqD8He5UMnX/M+ih7L1G5QZW3fiPDkhNQZBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZZ+q0S
	X5oHN/YuhKi+ZlDf86y/D8x5PU2dxSKRZRRdCMXwrqvy1kL0DgwQMiJHeou9BONg
	UXmLEDRxGAAveAqiSAgUnMyCgB47kjCk6fUIwdeJslFKY6NnUhyKsSa233cQFqcL
	XJIs4+QplWKkqGXWFmdMl/D2C3c7++6MRKMn4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B1D9D55BA;
	Sun, 12 Sep 2010 17:25:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48936D55B9; Sun, 12 Sep
 2010 17:25:46 -0400 (EDT)
In-Reply-To: <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat\, 11 Sep
 2010 15\:56\:13 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50A5B4E2-BEB4-11DF-8B4D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156058>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I just like the UI of having each commit "pop up" where I can either
> page up/down within the commit, or dismiss it with "q" and go to the
> next one.
>
> You can't do both of those in a pager, up/down goes across commits,
> and "q" quits the whole pager.

I would throw this not into the incomplete scriptability category but i=
nto
the "user does not know how to use his pager" category.  With "/^commit=
 .*"
you can not only advance to the next commit with "/<RET>", you can go b=
ack
to the previous one with "?<RET>", and keep going in the same direction
with "n".

>>> Maybe we should have something like:
>>>
>>> =C2=A0 =C2=A0 git log --for-each=3Dless a..b

If anything that shouldn't be an option to "log", but to "rev-list", as
you are aiming for scriptability.  But

    git rev-list --for-each=3D'cmd that takes commit as its argument'

wouldn't be much of an improvement over "git rev-list | xargs -n1 'cmd'=
"
pipeline from the _scriptability_ point of view.

So no.
