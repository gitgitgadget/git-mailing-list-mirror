Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F951F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF0SVD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:21:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:57993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfF0SVD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561659645;
        bh=TsXyfC35RIrY26VtmvAOwVYtCXl/V/WZKRH1aNte3cY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VG83pmrYTG7UQtwUTxchyAvy8U40SppGQQzAMYozn/H5ZUE5FgsTfcAYyQARnqMSI
         nkvrWhfekmfVK0jcgUYuMCJDsF7005xPgBiZf2rIIoB7bjHtdTnRr8oVnkzPlE0P5d
         LVwMJVITN7L1Zqllo4tmMXPxW/UH13Ser9Am5cyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1hdHDV0VVU-007kKw; Thu, 27
 Jun 2019 20:20:45 +0200
Date:   Thu, 27 Jun 2019 20:21:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 0/7] grep: move from kwset to optional PCRE v2
In-Reply-To: <871rzf8034.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906272012470.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1906261601270.44@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1906271113090.44@tvgsbejvaqbjf.bet> <871rzf8034.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-334934356-1561659667=:44"
X-Provags-ID: V03:K1:HF8dO/fPNdw4aPlvHKpHV/BaoqcswO35CCOqNd+lRy/W7zILezP
 H/CSWAUx/LTZsbKySoPSIogSNHik947p9g291+ITbB24B9Z3MEAaoGfAy84cLeYYASDSRGn
 V3iAdE+XfXnIYrrMU5RRlvHUaPvykrnOEjU6kCoSFHdN2xQcpdAi9Ys1tFsZyDmy9ImB+AL
 Dfk/gWBR33XFIhePK2EXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tXYo76dFJHs=:lX3MN5Otl9NhjZ1N3+pTGY
 qM+Z4/HeTG88yBF4MMiXSsMFU96BhI43OfQ9vLcSfcbXHyc4r8AHa+kF1xiqD44tpdcYLWVdt
 MeF7Y8C7coXCkoDDxBIAsVM7emO/4UMjjMBj2rfRhYyXx8ERpbz1IHDqMe/Jpde4L8a0ctKq4
 yk/lolrTGM93EZefzL2jnFcRj2B7KhC/vdPakjooYxj/fGnrvj+mVbF7LQVWSlgaHhujkbsuS
 7FEeX1OwRuhph2IYQ0QJbm2SHwwBf1xT6OKOSLWNwzoaZDFz8CLYjXrsO7KxfeFYUIbfm0TFr
 i/4zAv5ppqEgQv2TK1zKsRjxm73wsLm5I9zP7w5UqVLH3fC5YCF+N4R2+2ZTfCNTKay6u9xZc
 r2QhmpBFUPlzaD3YkjkNTLnyZDiE7n6z5yYCo3F51BuwbF6BxRImVADDJLLKD7m867cK5mcVc
 /50NKqVxo0mZ6L3nTFfbg/zMBD8q35mbbGTJOeO72OpuARz4Lac9VR2UAyLVFiWDMggYzuMcz
 sfJzBQATQXE4o5/JlGNdrrvfK/y4G02Le39sHunmohVzS9JntUuyA09t9KJ45VYlMb8ukjYI9
 6LJ7AvS0zNKt3K2ds5oOEsCDripfE4hjZIb+tJLBV8AtT2OPWz3tGLtohgqwJE/v6yxCwkny2
 OW54SkdTVX9almaMu7nTHyZ3xGFjLfEB8ZcxS7WeW/GPDbupxoF9y0jv1H7yPS+ushyW5dqsj
 +kJb7xVGdq2w4cEKkkH8FiizPbexVYfUQpf00Jso72MDJ4Fhuddntd4OkPr280MauxoB8DQIn
 baKlqYCfcNvsEPA2BflXV99+S6Q5nZsO/QuZaDf4szbyN2IegjPc/fUXtCJ631/YdzMxSDtQR
 YjQjkj1WPYpycVjFkhgpann2ulgH3VXQv9ow+epSwlUSRIO+5J9Uu2wYr8TcwWENU20ng9Sln
 fBQ03qnGiic+65GXkALsMYyTODBCF5gY4QsuGPPyugCi+z9TE8EtBhceQuXzlqLeGPtS6VFwT
 1i3onEwxsxcaaGd+dQEwqwWplo3I58fmJqT6YWr00XVgklwDrWtikd5AJYYG50JOat6+g13u1
 E460JgugC8fJvGispU7+guhKeEthwiEzMf9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-334934356-1561659667=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 27 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Jun 27 2019, Johannes Schindelin wrote:
>
> > On Wed, 26 Jun 2019, Johannes Schindelin wrote:
> >
> >> On Wed, 26 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> > This speeds things up a lot, but as shown in the patches & tests
> >> > changed modifies the behavior where we have \0 in *patterns* (only
> >> > possible with 'grep -f <file>').
> >>
> >> I agree that it is not worth a lot to care about NULs in search patte=
rns.
> >>
> >> So I am in favor of the goal of this patch series.
> >
> > There seems to be a Windows-specific test failure:
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&=
view=3Dms.vss-test-web.build-test-results-tab&runId=3D28232&resultId=3D101=
315&paneView=3Ddebug
> >
> > The output is this:
> >
> > -- snip --
> > not ok 5 - log --grep does not find non-reencoded values (latin1)
> >
> > expecting success:
> > 	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$utf8_e >actua=
l
> > &&
> > 	test_must_be_empty actual
> >
> > ++ git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D=C3=A9
> > fatal: pcre2_match failed with error code -8: UTF-8 error: byte 2 top =
bits
> > not 0x80
> > -- snap --
> >
> > Any quick ideas? (I _could_ imagine that it is yet another case of pas=
sing
> > non-UTF-8-encoded stuff via command-line vs via file, which does not w=
ork
> > on Windows.)
>
> This is an existing issue that my patches just happen to uncover. I'm
> working on a v2 which'll fix it.

I just found yet another problem. When using a libpcre2 _without_ JIT
support, I get this:

=2D- snip --
$ sh t4210-log-i18n.sh -i -V -x || tail -20
test-results/t4210-log-i18n.out
ok 1 - create commits in different encodings
ok 2 - log --grep searches in log output encoding (utf8)
ok 3 # skip log --grep searches in log output encoding (latin1) (missing !=
MINGW)
ok 4 # skip log --grep does not find non-reencoded values (utf8) (missing =
!MINGW)
not ok 5 - log --grep does not find non-reencoded values (latin1)
#
#               git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$ut=
f8_e
#               >actual &&
#               test_must_be_empty actual
#
ok 3 # skip log --grep searches in log output encoding (latin1) (missing !=
MINGW)

skipping test: log --grep does not find non-reencoded values (utf8)
        git log --encoding=3Dutf8 --format=3D%s --grep=3D$latin1_e >actual=
 &&
        test_must_be_empty actual

ok 4 # skip log --grep does not find non-reencoded values (utf8) (missing =
!MINGW)

expecting success:
        git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$utf8_e >ac=
tual &&
        test_must_be_empty actual

++ git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D=C3=A9
fatal: pcre2_match failed with error code -8: UTF-8 error: byte 2 top bits=
 not 0x80
error: last command exited with $?=3D128
not ok 5 - log --grep does not find non-reencoded values (latin1)
#
#               git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$ut=
f8_e
#               >actual &&
#               test_must_be_empty actual
#
=2D- snap --

This is actually a correct error, as we specifically feed non-UTF-8 text
to PCRE2, but we do turn on the PCRE2_UTF flag.

Funnily enough, this error only occurs when `pcre2_jit_on =3D=3D 0`, i.e. =
when
we hit the code path that calls `pcre2_match()`. When the alternative code
path is used, `pcre2_jit_match()` is called, and it does _not_ print that
error.

Whatever the bug in libpcre2 that causes the JIT code path to fail on the
Unicode validation, it points to the problem in this code in
`compile_pcre2_pattern()`:

=2D- snip --
        if (is_utf8_locale() && has_non_ascii(p->pattern))
                options |=3D PCRE2_UTF;
=2D- snap --

It only asks whether there is a non-ASCII character in pattern, but we
never bother to see whether the haystack is also encoded in UTF-8. In this
case, it is not...

Ciao,
Dscho

P.S.: Yes, yes, I know, we should run PCRE2 with JIT, and I am trying to
figure out why it is not enabled on Windows when I specifically asked
`./configure` to enable it... Investigating now.

-

--8323328-334934356-1561659667=:44--
