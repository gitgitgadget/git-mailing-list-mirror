From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git .lock file error
Date: Thu, 30 Sep 2010 13:15:23 -0700
Message-ID: <7vbp7fhtt0.fsf@alter.siamese.dyndns.org>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
 <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
 <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
 <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nate Parsons <parsons.nate@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 22:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1PXW-0002Pf-WF
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 22:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab0I3UPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 16:15:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab0I3UPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 16:15:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32BC5DA482;
	Thu, 30 Sep 2010 16:15:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vxRqB05ZrlTj
	CZycS8fWkRjsCL4=; b=rs11SI1xj9NRTkeNU8DH++F+SP19KEYD/CR6Kixw8ifx
	QmdYy9s9gYXw5KEUf2Fw2vsr4jnJlRxm7tyflVoWKS47DKzQxcx39SVVuc45GotS
	tVyBTBVdvO2WoPJp7kuKxRU07OMNxOJG/6jFVj7Kxx2J+UliH3MqDA5KuGCI7Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=grsi9A
	qxyOdQHbj+vUQA76ooJwVml9PuEegZAZ3SQ6tOKGTVaVmaCNAiGwRsCFhiVWbMUZ
	eK0uBCrTrQ1bmhcZW8U0Hjvxvm1vSGkTKxWR7JX4ZMyUEeTqzFN1rA8TAXBc/chD
	wTOF6NAq+/zHNgL0h+5VW3B8Vfa2xVGkeQDbo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1A46DA481;
	Thu, 30 Sep 2010 16:15:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18303DA47D; Thu, 30 Sep
 2010 16:15:24 -0400 (EDT)
In-Reply-To: <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 30 Sep
 2010 19\:13\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 78188580-CCCF-11DF-BDE7-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157710>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Sep 30, 2010 at 18:00, Nate Parsons <parsons.nate@gmail.com> =
wrote:
>> OK, so this is definitely a win32 issue. I believe that the perl
>> script is simply creating .lock files too fast for Windows to keep u=
p.
>> Simply trying again fixes the problem for me.
>
> Sounds like something that might do with a non-hacky solution, but I
> don't know what that would be.
>
> ...
> FWIW I think this is more readable, but maybe we want to retry on all
> platforms:
>
>     my $fh;
>     if ($^O eq 'MSWin32' or $^O eq 'cygwin') {
>         # Try 10 times to open our lock file, in case Windows is lagg=
ing
>         for my $try (1..10) {
>             sysopen($fh, $db_lock, O_RDWR | O_CREAT);
>             last if $fh;
>         }
>     } else {
>         sysopen($fh, $db_lock, O_RDWR | O_CREAT);
>     }

What exactly does "Windows is lagging" mean in the above?

Why does sysopen() randomly fail and why does it succeed (sometimes) wh=
en
it immediately gets retried with the same argument?  Is this a shared l=
ock
and is used by some other processes that drive git?  Why does the issue
manifest only on Windows?  If there are competing processes, wouldn't i=
t
exacerbate the situation to run a tight loop to try grabbing the lock
without waiting, like the above patch does?
