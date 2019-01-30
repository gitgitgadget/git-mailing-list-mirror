Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A97E1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbfA3Spt (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 13:45:49 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:37598 "EHLO
        nwk-aaemail-lapp01.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733116AbfA3Spt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 13:45:49 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
        by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UIbGH6045526;
        Wed, 30 Jan 2019 10:45:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-type : sender : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=aTIdsMVPf2ppS9P2zmexn4a/rqYTAwV8UhtMy2/woAI=;
 b=s6dtOzO3fJ1nn1L5jG5T4SJbS8NEd2ECaaTJxxFwQa3GfCXWsu03Y5qWMRGnsx/8Y2Ec
 cjEn1SdD1iSi0rwQl3OEroOaChCgi+W2aHkrTbHnNRyTGB46dZepC9tWZalg5VwwoySt
 FvvYpZlKtfa+J8Yci+t5sIsRT+xPy9KHcv8q8nURK9MOwGgEwKk/GwMMUcav2Z9Dn11N
 4XRv8F9N5I+LCoHNaXTb/XvbsIWJRCKFHGbhtWqupAOVcHsVjmBKNLZa3iiJ6KgwcNF2
 KqUj5KLTVlpJeeYM+AFSZ+VaHbxWyAoKhvMZ79VM7RhT5zw/lBsSAQQ8VKLGNF19fIfm IQ== 
Received: from ma1-mtap-s02.corp.apple.com (ma1-mtap-s02.corp.apple.com [17.40.76.6])
        by nwk-aaemail-lapp01.apple.com with ESMTP id 2q8qc89k53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 10:45:41 -0800
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Received: from nwk-mmpp-sz12.apple.com
 (nwk-mmpp-sz12.apple.com [17.128.115.204]) by ma1-mtap-s02.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5004D4QS22D00@ma1-mtap-s02.corp.apple.com>; Wed,
 30 Jan 2019 10:45:40 -0800 (PST)
Received: from process_viserion-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500M00Q42SA00@nwk-mmpp-sz12.apple.com>; Wed,
 30 Jan 2019 10:45:38 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: 4df6244c4c4ff15bfbe305f6ad4f9707
X-Va-R-CD: 548ec5b29d701e5458e59af91772ff94
X-Va-CD: 0
X-Va-ID: 2b416624-5c2d-4195-8d3f-bf823384c63b
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: 4df6244c4c4ff15bfbe305f6ad4f9707
X-V-R-CD: 548ec5b29d701e5458e59af91772ff94
X-V-CD: 0
X-V-ID: 3838eae1-b88d-4837-bb5f-11b5809ff3fd
Received: from process_milters-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500L00Q3EMT00@nwk-mmpp-sz12.apple.com>; Wed,
 30 Jan 2019 10:45:38 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_14:,, signatures=0
Received: from [17.235.14.120] (unknown [17.235.14.120])
 by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPSA id <0PM5002L0QS11460@nwk-mmpp-sz12.apple.com>; Wed,
 30 Jan 2019 10:45:38 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing
 git-svn
From:   Jeremy Sequoia <jeremyhu@apple.com>
X-Mailer: iPhone Mail (16E187)
In-reply-to: <nycvar.QRO.7.76.6.1901301344430.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 10:45:36 -0800
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Content-transfer-encoding: quoted-printable
Message-id: <76E751A1-20C9-451B-919E-FF6B3FB5A384@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-3-jeremyhu@apple.com>
 <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
 <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
 <nycvar.QRO.7.76.6.1901301344430.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_14:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone...

> On Jan 30, 2019, at 04:51, Johannes Schindelin <Johannes.Schindelin@gmx.de=
> wrote:
>=20
> Hi Jeremy,
>=20
> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
>=20
>>> On Jan 29, 2019, at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>>>=20
>>>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>>>> ---
>>>> t/test-lib.sh | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>=20
>>> This obviously won't be acceptable as-is to my tree.  Shouldn't this
>>> be something to be dealt with in config.mak.uname or something that
>>> is meant to define platform-specific customization?
>>=20
>> The issue here is that we're not locating relocatable perl modules
>> during testing.  This is a general problem with testing RUNTIME_PREFIX
>> configurations, and a more general solution to this sledgehammer would
>> be appropriate.  I don't think config.mak.uname really makes sense since
>> it's a general RUNTIME_PREFIX issue and not specifically a darwin issue.
>=20
> First of all, as others have pointed out, this code is very, very specific=

> to Darwin (not only xcode-select but also Library/Perl/ are very, very
> specific to that platform, I would even argue it is not even
> Darwin-specific but instead macOS specific because bare-bones Darwin does
> not have Library/Perl/, does it?).

Yes.  I first pointed that out in my emails to Peff and in my 00 email ;).  P=
eff requested that I send  all of our changes (even ones I considered not up=
streamable) in order to discuss possible generalized solutions that could ap=
ply to others as well.

> So you *definitely* want to put that code into guards testing for that
> platform (I do not think config.mak.uname is the correct place, though, as=

> it should be accessible to test scripts when run directly, i.e. not
> through `make`).

It isn=E2=80=99t applicable to anyone outside of Apple internal build engine=
ers (or maybe folks like OpenDarwin building from our OSS perl and python dr=
ops too) as it is specific to Apple=E2=80=99s build systems.

However a generalized solution would be useful to others.

> But let's take a huge step back first: why? What is the exact problem this=

> commit tries to solve? The commit message unfortunately does not really
> leave me any wiser.
>=20
> So I am left with the unfortunate position of having to guess, which is
> not really a good use of both of our time. If I allow myself to indulge in=

> the guessing game, I would guess that whatever `perl` executable is used
> in your scenario picks up some unfortunate environment variable that
> overrides its internal defaults where to look for Perl modules.

The issue is with RUNTIME_PREFIX.  git=E2=80=99s RUNTINE_PREFIX support assu=
mes that it is the only thing being relocated.  However, with Xcode, svn and=
 its perl modules are relocated as well.  In order to test git-svn, we need t=
o locate those perl modules.  Patch 10 takes care of this when running from t=
he installed location, but we have no svn in the appropriate relative locati=
on from the build directory, so we add the explicit path here.

> And that simply should not be the case. We are very careful to set
> GITPERLLIB in bin-wrappers/, *not* PERL5LIB.
>=20
> And when we build Git on macOS agents in Travis or Azure Pipelines and
> then run the test suite, I fail to see any Perl-related error that looks
> like it could be solved by this here patch.
>=20
> In short: this commit is in dear want of a more substantive commit
> message, and most likely in search for a different solution.

Yes, a number of these patches (like this one) were requested to be sent to t=
he list in order to spark a discussion for another generalized solution and n=
ot to be merged into mainline.

Is there a notation that would help to call that out on the commit?  I figur=
ed it was pretty obvious that this was one of those.

>=20
> Ciao,
> Johannes
>=20
>>=20
>>>=20
>>>>=20
>>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>>> index 0f1faa24b2..4060a53f56 100644
>>>> --- a/t/test-lib.sh
>>>> +++ b/t/test-lib.sh
>>>> @@ -1017,6 +1017,9 @@ fi
>>>>=20
>>>> GITPERLLIB=3D"$GIT_BUILD_DIR"/perl/build/lib
>>>> export GITPERLLIB
>>>> +PERL_VERSION=3D$(grep DEFAULT /usr/local/versioner/perl/versions | sed=
 's:^.*=3D *\([^ ]*\)$:\1:')
>>>> +PERL5LIB=3D"$GIT_BUILD_DIR"/perl:"$(xcode-select -p)"/Library/Perl/$PE=
RL_VERSION
>>>> +export PERL5LIB
>>>> test -d "$GIT_BUILD_DIR"/templates/blt || {
>>>>    error "You haven't built things yet, have you?"
>>>> }
>>=20
>>=20
