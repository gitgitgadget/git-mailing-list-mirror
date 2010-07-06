From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 7/7] t/README: Document the do's and don'ts of tests
Date: Tue, 6 Jul 2010 15:19:50 +0200
Message-ID: <201007061519.51632.jnareb@gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com> <m3sk3xm2jr.fsf@localhost.localdomain> <AANLkTikFOAWINvKINvPbbrqBNlmjDcn7uJVQ7doVbhem@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 15:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW84S-0004LN-NB
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 15:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab0GFNUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 09:20:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46053 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0GFNUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 09:20:13 -0400
Received: by bwz1 with SMTP id 1so3504117bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8x7/AkucbpCigtx5Pv83fgn4uo1ub4HWu97Rr31VMUE=;
        b=g/kN5b92K/HbZLitRuv/TvJSYM6H1iruAlWeH1BwDnu7fiC1/5vCOmx8tc6Eeo4ist
         bAgJGfvLEgRPaN0j9tuNFyicCZHiP0zNxs0pVGDZ1ZMZAp/8QlD6xiAZepnOeCHJrICN
         U6BeMX+cd+uP2r/upC9ypMeTQlZBaAKfVmJEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DGOlqQYDTtIVGhyZO4BTsGU0Qn1V/Y/ZBy8wJ97H3BUsTGl13XRtj0nNMg91/KwKa+
         HlIDb56hYZf96S5w1Km4+fNWuruG+c+GGGX9xeshlmtwMtYR+07i7ltTzrU0HVkWb3+2
         nz0YBZEKIXfl1c5k5NUPUEv4vx1MVnkqZB53A=
Received: by 10.204.178.82 with SMTP id bl18mr3651803bkb.118.1278422400863;
        Tue, 06 Jul 2010 06:20:00 -0700 (PDT)
Received: from [192.168.1.15] (abwo240.neoplus.adsl.tpnet.pl [83.8.238.240])
        by mx.google.com with ESMTPS id r10sm23013888bkh.12.2010.07.06.06.19.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 06:19:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikFOAWINvKINvPbbrqBNlmjDcn7uJVQ7doVbhem@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150351>

On Tue, 6 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jul 6, 2010 at 08:35, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> +Do:
>>>> +
>>>> + - Put as much code as possible inside test_expect_success and ot=
her
>>>> + =C2=A0 assertions.
>>>> +
>>>> + =C2=A0 Even code that isn't a test per se, but merely some setup=
 code
>>>> + =C2=A0 should be inside a test assertion if at all possible. Tes=
t scripts
>>>> + =C2=A0 should only have trivial code outside of their assertions=
=2E
>>>
>>> Let's make it even stronger; "should only have trivial" -> "shouldn=
't have
>>> any ... unless there is a good reason."
>>
>> I think that the only thing that can and *should* be put outside
>> test_expect_* is creating helper file: test vectors ('expect' files)=
,
>> configuration files, files that are to be arguments to commands, etc=
=2E
>> Is it covered by "there is a good reason"? =C2=A0Isn't it too severe=
?
>=20
> Personally I'd put `..>expect && ..>actual && test_cmp' inside
> test_expect_* too if they're only going to be used by that test, but
> outside them at the top of the file if they're files that are used by
> multiple tests for the duration of the test run.

I agree with putting e.g. `echo "sth" >expect` inside test_expect_*.
It is also obvious that `.. >actual` should be inside test_expect_*.

What I was thinking about was generating larger files, by using e.g.

  cat >expected <<\EOF
 =20
  ...
  EOF

Putting them inside test_expect_* would make it IMHO less clear, less
readable.


Sidenote: we should probably describe <<\EOF vs <<EOF here-docs and
when to use one or another in t/README.

>> There probably should be description when to put creating such files
>> in test script, and when to put them as pre-made files in tXXXX/
>> subdirectory (non US-ASCII is one reason to put it as pre-made file)=
=2E
>=20
> I don't know which one would be preferrable. We have a lot of things
> in t/t*/* that could be generated by a test, and vice-versa.

Probably because those tests were written by diferent people, and there
were no clear policy / guidelines description in t/README :-)


Thanks a lot for your work!

--=20
Jakub Narebski
Poland
