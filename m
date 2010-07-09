From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] tests: Use skip_all=<reason> to skip tests
Date: Fri, 9 Jul 2010 23:28:35 +0000
Message-ID: <AANLkTinAG4FgzsWyLtcVPu9Lz3e9Jp_PLlGRCuJeIWPN@mail.gmail.com>
References: <4C36ECDB.9090707@drmicha.warpmail.net>
	<1278675688-4702-1-git-send-email-avarab@gmail.com>
	<7v4og8mtpd.fsf@alter.siamese.dyndns.org>
	<AANLkTilPkKI9KdEc84Zhh3Vn7_B7CYT3UDSkSv7JwGJG@mail.gmail.com>
	<7vlj9kl1bv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 01:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXMzr-0001vu-VQ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 01:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab0GIX2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 19:28:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50181 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab0GIX2g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 19:28:36 -0400
Received: by iwn7 with SMTP id 7so2735390iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6j1hCXLF7gsl+z5qoDQl3t3X0pf3I1dcgviHTTHvi/Y=;
        b=Gggf1kdiKtvqoWMIpP/XD13QRvsoS02bZrYdyMoEIlr3Qrx4S5bL1Vu9AhoHMABKOe
         5+g6YsNTk3HGq41Gsjmo65UWQiqoa0RASNl0ZrjjAulZmuTTpE0SqNqAynAsvpLsb08m
         9yieKp2NSdJtHmrFZa2DskVA/At8ln9NEpYEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lS7lR09zwWu+QSQJcb7bt5y8MwhetP4k5t75G+UtvFXxqyprW+YM4Fni/ltF9ycwHZ
         TI1RAVQrEFvpjL282ZYGq0GqeZVGNb9Yprfe4s72wLpeQz8s6AycatzK4p69jYT7Q/Ny
         NfZAecQjkuqyiv03gZGa9EjCr2sjgvrDcU5CQ=
Received: by 10.231.35.195 with SMTP id q3mr10405632ibd.22.1278718115537; Fri, 
	09 Jul 2010 16:28:35 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 9 Jul 2010 16:28:35 -0700 (PDT)
In-Reply-To: <7vlj9kl1bv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150698>

On Fri, Jul 9, 2010 at 22:47, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Jul 9, 2010 at 17:49, Junio C Hamano <gitster@pobox.com> wro=
te:
>> ...
>>> Among 63 assignments to $skip_all that are all over in t/*.sh scrip=
ts, the
>>> only ones that are not immediately followed by test_done are in
>>> lib-git-svn.sh (chooses one among 3 messages), lib-httpd.sh (sets a=
 trap
>>> before calling test_done), and t3600-rm (makes a mental note to rep=
ort
>>> that one test was skipped long before all the tests run).
>> ...
>> =C2=A0 =C2=A0 $ perl -MTest::More -E 'plan tests =3D> 6; pass "gette=
xt stuff ok"
>> for 1..2; SKIP: { skip "Can not test without locale files", 2 } pass
>> "moo" for 1..2'
>> =C2=A0 =C2=A0 1..6
>> =C2=A0 =C2=A0 ok 1 - gettext stuff ok
>> =C2=A0 =C2=A0 ok 2 - gettext stuff ok
>> =C2=A0 =C2=A0 ok 3 # skip Can not test without locale files
>> =C2=A0 =C2=A0 ok 4 # skip Can not test without locale files
>> =C2=A0 =C2=A0 ok 5 - moo
>> =C2=A0 =C2=A0 ok 6 - moo
>
> Now you are talking.
>
> What t3600-rm does becomes a lot more natural to express with somethi=
ng
> like this. =C2=A0Any test with "prerequisite" missing will automatica=
lly get
> "this test was skipped because you lack this prerequisite" for free. =
=C2=A0We
> can lose skip_all=3D assignment there but move the logic to test-lib.=
sh,
> which is a good thing.

Right we already do this in the case of t3600-rm.sh. I think in the
general case that using test_set_prereq + 3 arg test_expect_success
(i.e. declare prereq) is a lot better than arranging tests so that you
can skip a lot of dependency-heavy tests at the end.

> But that is orthogonal to what you call an API, i.e. your assignment =
to
> the global variable $skip_all that is immediately followed by test_do=
ne,
> no? =C2=A0The conversion you did for that does not help counting the =
remainder
> of the tests that are skipped anyway, so you will need to redo that
> conversion altogether if you ever want to be able to show "these test=
s
> through the end of the scripts were skipped".

Right, those two are completely orthogonal. That sort of API would
look something like this:

    #!/bin/sh

    plan=3D6

    . ./test-lib.sh

    for i in {1..2}; do
        test_expect_success 'gettext stuff ok' 'true'
    done

    # something came up, skip the remainder
    skip_all=3D"Oh noes"
    test_done

(or test_done 'Oh noes', or something).

At that point it knows to output 4 skip lines with the message "Oh
noes" because we've only run two tests so far.
