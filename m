From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 02:37:36 +0100
Message-ID: <AANLkTik6-AFN1T7GYz6z4ad=pPCZG4Z5LWung0qYwe2X@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
	<7vk4gq45bo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 02:37:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsQ9H-0004LZ-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 02:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab1BXBhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 20:37:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab1BXBhi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 20:37:38 -0500
Received: by fxm17 with SMTP id 17so85416fxm.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 17:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ptUpTpXEqa7jtPF6ekE3b1P31RTV6qjd5N10dG+16a8=;
        b=nEAEeVh1YRcKeqi3bJ49uCWUs2a9Mo7OuBMCyfhGbWIjqTWQCkLqNC+ujoMRwjSkPR
         phPh0HSyS8v8oEg6nZIhWiC2RGfXOxYJ/WjGZGLzRT4qkQPQTVUxUfJyfOQG/AjKRUd7
         E23c2Rvm/OfNaThUTxh/sH/79PzbENmjuauzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OuOzkt1bDYcXrzn2rUbEdVt7saSHM76MUm2MPLVlPIm9y9oui32Uq9d4C3pdugMi42
         9P+G7zruxaKfAYnmlCy9PdOazCuDGRlgFhElXw2bZgqu/1bZtdf5byhgNqjRRnXirsMe
         hh2TvTO0qSjMbdm15afV8VYJiQvzteepCKEYU=
Received: by 10.223.70.136 with SMTP id d8mr281821faj.3.1298511456770; Wed, 23
 Feb 2011 17:37:36 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 23 Feb 2011 17:37:36 -0800 (PST)
In-Reply-To: <7vk4gq45bo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167765>

On Thu, Feb 24, 2011 at 01:57, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> And then there's the issue that unlike the C patches these will not =
be
>> a no-op that'll be optimized away by the compiler. We'll be calling =
an
>> external program for displaying messages. While this is a trivial co=
st
>> on Unix (especially in the context we're using it, i.e. not in tight
>> loops) it's more expensive on Windows.
>>
>> I don't see any way to deal with that short of implementing some
>> pre-processor, but I think the cost is worth it, but others might
>> disagree of course.
>
> Count me one of the others then. =C2=A0Don't we already preprocess ou=
r scripts
> before installing anyway?

Yes, but only for simple variable substitution. Substituting all the
gettext calls out when we're not compiling with them would be way more
complex than what we do now, but possible. Anyway I'm not going to do
it.

>> Anyway, I can submit these patches (around 53) real soon, or wait
>> until the current series settles. It's the same to me, which would y=
ou
>> prefer?
>
> One thing at a time is of course preferred.

I'll wait then. No point in submitting them if you won't be merging
them down until the other things cool down.

> I actually want to stagger the current 70+ patches into two batches. =
=C2=A0Have
> the first handful, after polishing them really shiny, merged to maste=
r,
> and possibly rebase topics that are only in 'pu' and that are not mea=
nt
> for 'maint' on top of the result (so that they can use _() in newly a=
dded
> messages), and then merge "mark strings in git-foo with _()" patches =
in.
>
> I suspect it won't be the same to you. =C2=A0At least, it shouldn't.
>
> Other topics that fix real bugs or add features continue to trickle d=
own
> from 'next' to 'master' and you would need to re-roll what you have t=
oday.
> If you wait (or if we have you wait) for too long, the re-roll would
> become just as unpleasant as my merging the i18n topic to 'pu'.

Right, once we're confident (which at least I am) that the first few
patches really are no-op's I think it would be easier for everyone to
merge them down sooner than later.

>> =C2=A0 =C2=A0 Warning: you are leaving 1 commit behind that are not =
connected to
>> =C2=A0 =C2=A0 any of your branches:
>>
>> For the singular this should be "1 commit behind which is not
>> corrected to any of your branches".
>
> Heh, thanks. =C2=A0I would think "s/ that are /, /" would fix it rath=
er
> nicely.

s/corrected/connected/ also :)
