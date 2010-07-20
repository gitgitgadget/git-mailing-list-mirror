From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t3700: convert two uses of negation operator '!' to use 
	test_must_fail
Date: Tue, 20 Jul 2010 17:52:42 +0000
Message-ID: <AANLkTilpspywp68veHtYbtfZytHr_0IThksmtkGAjWRg@mail.gmail.com>
References: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil>
	<AANLkTil9jA8Dva_KqW67c1ZgWk9_a5S1rBViui8Jn0Os@mail.gmail.com>
	<fVE942wHC3SFihkQG8AthPTKiTZtYJ9zmR2TT7F5OlkGD4IA9xPcMA@cipher.nrlssc.navy.mil>
	<20100720163822.GA8492@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 19:52:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGzp-00027Y-Ud
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab0GTRwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 13:52:44 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49839 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab0GTRwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 13:52:43 -0400
Received: by pvc7 with SMTP id 7so2248953pvc.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rid7ZrCoFiK5xCgYRjjCbNgWrWToNPPHp90LRCeHNMg=;
        b=lZ787fTNzavkqZ36cQLvlO4ZPjy1kH9MiamNir1xA+5QM5RsWzsGWb9P+iK65E2kLP
         KV+9O+m7KuxjJ/ijaOd0BLdMvrHvXTGoKaqSIFinMiHw4vOodS/mDxfJnA4uY9yJAHxI
         fa6L/I2USnhgxPLtFnAtsxu7Fw3tlSZxEvcXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nF420Li7/Hwj3OAGkPf0pS/lkce5hXIa867mMfBBnAoMVQRyHMxLJVqHdS/8z9RYsz
         erneXV/+InEQ5NwcV9gs2ZczFwB+OQahfGliz1IeRGVP4eR8als0Kv2ena5om+0VJM96
         AW78ZDPRhZGtlrm5gRl+cjVzCzly1oIWWUiF4=
Received: by 10.114.196.9 with SMTP id t9mr9965141waf.159.1279648362204; Tue, 
	20 Jul 2010 10:52:42 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 10:52:42 -0700 (PDT)
In-Reply-To: <20100720163822.GA8492@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151337>

On Tue, Jul 20, 2010 at 16:38, Jared Hance <jaredhance@gmail.com> wrote=
:
> On Tue, Jul 20, 2010 at 11:32:33AM -0500, Brandon Casey wrote:
>> I think you have misunderstood the explanation of test_must_fail. =C2=
=A0The
>> paragraph you quoted actually recommends using test_must_fail instea=
d
>> of "! <git-command>".
>>
>> It says:
>>
>> =C2=A0 =C2=A0Use this instead of "! <git-command>" to fail when git =
commands
>> =C2=A0 =C2=A0segfault.
>>
>> Or with a slight rewording:
>>
>> =C2=A0 =C2=A0Use test_must_fail instead of "! <git-command>" since t=
est_must_fail
>> =C2=A0 =C2=A0will fail when <git-command> segfaults.
>
> I think the wording of description of test_must_fail is slightly
> ambiguous. I read it to mean that:
>
> =C2=A0 =C2=A0Use test_must_fail only when you are testing to see if g=
it will
> =C2=A0 =C2=A0segfault.

I've interpreted it to mean that as well, but it's starting to look
like a good example of a garden path sentence.

Anyway, it looks like we're wrong and Brandon was right. But I'm going
to submit a doc patch to t/README. Here's the existing use of !
v.s. test_must_fail:

    $ cat *.sh | grep -c 'test_must_fail git'
    863
    $ cat *sh | grep -c '! git '
    30

I.e. ! is only used to negate non-git commands like test.

The example in the comments for test_must_fail in test-lib.sh backs thi=
s up:

    # Writing this as "! git checkout ../outerspace" is wrong, because
    # the failure could be due to a segv.  We want a controlled failure=
=2E

> Rather than:
>
> =C2=A0 =C2=A0Use test_must_fail to be safe from git segfaults.
