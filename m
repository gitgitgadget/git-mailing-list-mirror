From: Olivier Verdier <zelbier@gmail.com>
Subject: Re: git stash and manually edited chunks
Date: Tue, 2 Nov 2010 09:37:46 +0100
Message-ID: <AANLkTiknhRGuBMFEKbVdyN83SiF9j2nNz=v-nMaD-iTb@mail.gmail.com>
References: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com>
	<vpqfwvlkmkv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 02 09:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDCNQ-0006ex-Rh
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 09:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab0KBIhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 04:37:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38463 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab0KBIht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 04:37:49 -0400
Received: by wwe15 with SMTP id 15so7073746wwe.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vX63ji8VGIlcvZ9iCALM1fX/eAhaoQqZjFY1tsSiQcM=;
        b=viYwmg/RoZZ8dKMryN0DWHwhbA0AOOjWK7glxrhZSQ1zfRoLsUgnCQi0lg3/EDEad4
         VJyPV9X7OyxN2o/W393KImzzaqaUorVQfnXXXm8AjNkcLAA/vsLXdKDgjyWlqEqDJUJd
         ypJMe66Rq9wzS+Nhi6en++W2Vm+zXUpO7uug4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cLSnOjFz9Nj5uj6DSHBciB0OxAx0LvyFCguZ+nNT0WxCg1IY1ZGdu9r5uciVrcTBJD
         k09HLFx8sbVXvulk1z35K2xzC/LtUSFqPFG/fuQFRZAaruXVDz1OlbnptKqQuRhUPTIZ
         rARG45i73Z7IsrGFeFOgb8P/i2nHM+g4UQ8VU=
Received: by 10.227.147.148 with SMTP id l20mr9364665wbv.118.1288687066901;
 Tue, 02 Nov 2010 01:37:46 -0700 (PDT)
Received: by 10.227.157.197 with HTTP; Tue, 2 Nov 2010 01:37:46 -0700 (PDT)
In-Reply-To: <vpqfwvlkmkv.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160509>

Thank you,

but that does not explain why there is a conflict *only* when I edit
the chunk manually, does it?

Besides, some people tried to reproduce my problem on Linux and they
got no conflict after edited chunks.

So it seems that it could be a bug specific to Mac OS X.

=3D=3D Olivier

On 1 November 2010 17:58, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> w=
rote:
> Olivier Verdier <zelbier@gmail.com> writes:
>
>> Hi!
>> I asked a question on stackoverflow
>> (http://stackoverflow.com/questions/4058372/git-stash-and-edited-chu=
nks)
>> and someone suggested it might be a bug...
>> For convenience, I reproduce the question here:
>>
>> =C2=A0I occasionally have the following problem, which is reproduced=
 by the
>> following sequence of commands:
>
> Let's say the state of your working tree here is A (and last commit i=
s
> HEAD).
>
>> * git add -p my_file
>> * I=C2=A0edit a chunk *manually*=C2=A0(using=C2=A0e)
>
> Here, the index contains a state which is neither in the working tree
> nor in the last commit. Let's call this state B.
>
>> * git stash --keep-index
>
> Here, the working tree takes state B.
>
>> * git stash pop
>
> Here, you're trying to apply the stash, which is somehow a diff
> between HEAD and A, on your tree which is in state B. Hence the
> conflicts.
>
>
> If you do a "git reset --hard" before the "git stash pop", you'll com=
e
> back to state HEAD, and the stash will apply without conflict.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
