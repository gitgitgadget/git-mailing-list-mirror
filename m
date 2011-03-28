From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 13:45:29 -0400
Message-ID: <AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
 <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
 <4D909DD1.2050904@viscovery.net> <AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
 <vpq62r3i1z4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:45:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4GVq-0000ck-0F
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab1C1Rpv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 13:45:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65209 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab1C1Rpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 13:45:50 -0400
Received: by eyx24 with SMTP id 24so1235621eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Cu+ifH9JgFGWlYmMH75UEbeWLO5GY0qo706Xr/i0l5o=;
        b=a+Vj2VsI2sDOoxXhJuckL1cuN6j/kxUop68UHgcppPl50KgkrZR9Gw7s9ltvNMnyZD
         VF7bnm58yK5oORTbOpyqkmgBAat1o/+ttnjJX0it0bw1gsLrkVhsWvcDdk658NCbdw72
         aofgVLXSicIfi2Zick2fCSnLkV4IEkC24isXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=XdNxMzYep5n9zEnIeUtSBkCqTcxNUQLPaqW5cHLej06E5ZQfWvLDAZ+5PJX3uutttS
         HZrzXIwgWhMbjYR20d5mDp8Oo81isup8qy7J4AMAh7X/Qk8p4qYBiR75/34MF1s2O5T6
         Rjeqko6mzsFm8EuoP/GLFW14gGVyhpkffZTuM=
Received: by 10.213.104.103 with SMTP id n39mr1914185ebo.144.1301334349122;
 Mon, 28 Mar 2011 10:45:49 -0700 (PDT)
Received: by 10.213.105.76 with HTTP; Mon, 28 Mar 2011 10:45:29 -0700 (PDT)
In-Reply-To: <vpq62r3i1z4.fsf@bauges.imag.fr>
X-Google-Sender-Auth: 21Xx3ymzlgg348QnCcGO0kzMqZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170166>

If branch bar is broken, do a bisect on branch bar. The fact that
branch foo works in inconsequential.

On Mon, Mar 28, 2011 at 1:33 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Andrew Garber <andrew@andrewgarber.com> writes:
>
>> On Mon, Mar 28, 2011 at 10:40 AM, Johannes Sixt <j.sixt@viscovery.ne=
t> wrote:
>>
>>> =C2=A0 =C2=A0 =C2=A0o--o--o--B
>>> =C2=A0 =C2=A0 /
>>> =C2=A0--o--o--o--o--G
>>>
>>> When I have this history and I mark B as bad and G as good, will I =
now
>>> find the first bad or the first good commit?
>>
>> That kind of situation shouldn't occur: IMO, bisect should only deal
>> with a single branch (the current branch).
>
> Why?
>
> It's not uncommon in real life to face the "it works in branch foo bu=
t
> not in branch bar, where did it break?" problem. And one expects a gr=
eat
> tool such as Git to be able to answer it.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
