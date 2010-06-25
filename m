From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v5 1/5] test-lib: Adjust output to be valid TAP format
Date: Fri, 25 Jun 2010 21:24:47 +0000
Message-ID: <AANLkTilYoGtTIr9lIQD4sx4PRjlWYjIwSDMquREzv6eq@mail.gmail.com>
References: <AANLkTinVp6kivNzbdUj-7EXjKrolBqvtsNROo-dCSydn@mail.gmail.com>
	<1277416332-12072-1-git-send-email-avarab@gmail.com>
	<7v6317koy2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 23:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSGOL-0006Px-Hp
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 23:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0FYVYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 17:24:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34560 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab0FYVYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 17:24:48 -0400
Received: by iwn41 with SMTP id 41so2406696iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k4jpiC1kI/m9OgXUVl9tlfA8k5cQSiumQLY8SzzvfEI=;
        b=Ig61wMJALcwONjLMAdL19CK9K6MsUG/ZdgUKQDWHf+Rm9ULqHsH3VWrRUIQLhmj43P
         tyG0uPAS/dkTo6kMSJfiZM/tssidafWm/mB85y+jq8Ky3qOqubvEnrmWm6oanEC526TV
         S7R3fc6yXCsVSnM6ajwtSO5vU8dFtI0HPa0Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ppx9Zw+cH1usYkDXvMB04P+P9LdHyhf0/xjL98KTUXhMC8FMB9t2FPFsKikT4+vnpX
         vEeq9GSahi/wWO1e/HCz5PhrEdy9sKBN3riAPIyP4t3IRf8PnhD8CGz3nGxou76zyAMn
         eYxNiltQ5kxLimdSFw9NPRePpn34Ptvw/K8HU=
Received: by 10.231.148.145 with SMTP id p17mr1322286ibv.28.1277501087727; 
	Fri, 25 Jun 2010 14:24:47 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 25 Jun 2010 14:24:47 -0700 (PDT)
In-Reply-To: <7v6317koy2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149708>

On Fri, Jun 25, 2010 at 17:21, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> diff --git a/t/README b/t/README
>> index 0e4e8d8..aa4ed28 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -18,25 +18,48 @@ The easiest way to run tests is to say "make". =C2=
=A0This runs all
>> ...
>
> This describes the general framework of tests from the point of view =
of a
> person who runs them and reads their output well. =C2=A0I'll replace =
ab/tap
> topic with these five patches.
>
> I'd however like to ask you to update the sections in t/README to hel=
p
> test writers. =C2=A0You have gained enough experience with patches 4 =
and 5 (and
> with patch 2 for Perl tests) to know what kind of script constructs, =
used
> by people who are used to the old way of writing our tests, would cau=
se
> the TAP stuff to break, and are in the ideal position to rewrite that
> section. =C2=A0Two examples of what is drastically different from the=
 old world
> order are "do not print to the standard output strings that begin wit=
h XX
> (or partial lines)" and "here is how to skip the remainder of the tes=
ts",
> but you may have a handful of more rules. =C2=A0I expect that "Writin=
g Tests"
> through "Test harness library" sections would be affected.
>
> Earlier I kept wondering if this series is worth the trouble. =C2=A0H=
aving to
> learn and follow the set of these new rules is exactly what I meant b=
y
> "trouble". =C2=A0Let's make sure that the new rules are clear, small,=
 and easy
> to follow for other contributors.

I'll write those docs, but I probably won't have time in the next few
days so I'll submit a patch for that it separately if that's OK.
