From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Fri, 13 Mar 2009 09:58:46 +0000
Message-ID: <efe2b6d70903130258t2594b027m5812e9a5895f477e@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4EC-0000lF-V5
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZCMJ6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 05:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZCMJ6u
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 05:58:50 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:49451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZCMJ6t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 05:58:49 -0400
Received: by fk-out-0910.google.com with SMTP id f33so1011370fkf.5
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=20/VUCd4ijZmmdwn10y5m1Aa+OepYFB6XCmE1cABO10=;
        b=XLhh94xKSdoJWTpgsl/j/stQqjK3pkHq0j51lr+Z5L4WryMqQarpvIU/3zLFN+PZOo
         3F15AZOBJCBUoL9QNi8bMHqLassODgeoQJFYNSpDAaSxRs3XLroptcEWeN7EFAdFGZ95
         VcT/YxJQ59isMhRUE6Fp+U9WK2zN5Vuqe7NOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h+1ncMMVUE87b0onBlEd+bt6cbAs4tZhh4xm59NOn9vlcbMwKOPY2FDecqBwQ2Kd9U
         tRHxhhKB2jqdKhWZFQutLq6nXRkvBRblmofeI+m8kemFbDB2FVlbJqFEnBaVESGaSEyR
         SDGXbTFtFCG4LzW1sZhkrlXvGPn2KP+tdNWh0=
Received: by 10.204.68.207 with SMTP id w15mr311791bki.10.1236938326354; Fri, 
	13 Mar 2009 02:58:46 -0700 (PDT)
In-Reply-To: <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113161>

On Thu, Mar 12, 2009 at 6:45 AM, John Tapsell <johnflux@gmail.com> wrot=
e:
> 2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
>> On Wed, Mar 11, 2009 at 9:35 AM, John Tapsell <johnflux@gmail.com> w=
rote:
>> What I use is the multiprecision floating point number class. double=
s
>> don't seem to be long enough.
>
> Hmm, really really? =A0Sometimes this sort of thing can be fixed by j=
ust
> readjusting the formulas. =A0What formulas are you using that require
> more precision than doubles?

I'll have to reply to this later when I have more time. However, there
is a (rather verbose)
file in the  doc directory which describes them - in texmacs format,
but I've just uploaded
a pdf version as well. It is BayesianSearch_Debugging.pdf. The
description of this code starts in
section 2.2 (since I wrote that, I have generalised it to the DAG case
as in git).


> A little bit of math trickery helps here :-)
>
> y =3D =A0x^b
>
> log(y) =3D log(x^b) =3D b * log(x)
> e^log(y) =3D e^(b log(x))
>
> y =3D exp(b * log(x))
>
> So as long as you have 'exp' and 'log' functions, you can raise x to
> the power of b, even if b is fractional.

Sadly gmp does not have log or exp. mpfr does, but it does not have a p=
ython
interface.

Alex
