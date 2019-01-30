Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8F11F453
	for <e@80x24.org>; Wed, 30 Jan 2019 00:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfA3ABb (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 19:01:31 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:36864 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfA3ABb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 19:01:31 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TNqDgh007320;
        Tue, 29 Jan 2019 16:01:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-type : sender : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=q9qiTZvNGkKcdFOuB1JrS8kzH1pfBfxI17WSn632DQU=;
 b=uYT0F7rLXFOdEL2DRHz/ywHe4TMnhT6v0RgA7hX+oYnYF4iih/RdvEOi69pQ3OnaBdiJ
 1ZGjotMJSq4F7HSZndUhu/uoZ7JtJfR3uY8rVV/t8rgJSWWv9xCYzFQO70uIuQCwLBzl
 J4L350CKJ8ts9CId3RsQW6fiSJmJcrz2DClWbL1xcUAZocO54SBET93sD59vQEesTG4Y
 lXPHJUhrLGKmmVfPZ80Y6O6LsyqTrtlbFuvbSIbr2Xl6wuNnSbb9MtxQenPdJibFxBSA
 pIfwDzPX2bQi0t2LlC/Y/L0eBg35ASDOpc1Q9/YC4Ncm3XYAiwqIcrcsRcIvt3cNTipe hw== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9832ssf2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 16:01:26 -0800
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM4000D0AQC3080@ma1-mtap-s03.corp.apple.com>; Tue,
 29 Jan 2019 16:01:25 -0800 (PST)
Received: from process_viserion-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM400D00AO6NV00@nwk-mmpp-sz10.apple.com>; Tue,
 29 Jan 2019 16:01:25 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 2a2ad196771b1a60191026596f6db635
X-Va-E-CD: 4df6244c4c4ff15bfbe305f6ad4f9707
X-Va-R-CD: 548ec5b29d701e5458e59af91772ff94
X-Va-CD: 0
X-Va-ID: cf31428c-5a03-46a0-8ce0-64cb1edf7d07
X-V-A:  
X-V-T-CD: 2a2ad196771b1a60191026596f6db635
X-V-E-CD: 4df6244c4c4ff15bfbe305f6ad4f9707
X-V-R-CD: 548ec5b29d701e5458e59af91772ff94
X-V-CD: 0
X-V-ID: 86c18bdc-25e8-484d-8e5f-dfd233f42b41
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM400D00AO3JN00@nwk-mmpp-sz10.apple.com>; Tue,
 29 Jan 2019 16:01:25 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_18:,, signatures=0
Received: from [17.114.129.255] (unknown [17.114.129.255])
 by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPSA id <0PM400D22AQCK200@nwk-mmpp-sz10.apple.com>; Tue,
 29 Jan 2019 16:01:25 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing
 git-svn
From:   Jeremy Sequoia <jeremyhu@apple.com>
X-Mailer: iPhone Mail (16E187)
In-reply-to: <20190129235947.GG13764@szeder.dev>
Date:   Tue, 29 Jan 2019 16:01:23 -0800
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Content-transfer-encoding: quoted-printable
Message-id: <20C7B5F4-58DA-43E4-9332-B206C0D070F0@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-3-jeremyhu@apple.com>
 <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
 <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
 <20190129235947.GG13764@szeder.dev>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_18:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone...

> On Jan 29, 2019, at 15:59, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:=

>=20
>> On Tue, Jan 29, 2019 at 03:46:07PM -0800, Jeremy Huddleston Sequoia wrote=
:
>>=20
>>=20
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
>> during testing.  This is a general problem with testing
>> RUNTIME_PREFIX configurations, and a more general solution to this
>> sledgehammer would be appropriate.  I don't think config.mak.uname
>> really makes sense since it's a general RUNTIME_PREFIX issue and not
>> specifically a darwin issue.
>=20
> But this patch is very darwin-specific ...
>=20
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
>=20
> ... because what other platforms could possibly have 'xcode-select'
> installed!?  Consequently:
>=20
>  $ ./t0000-basic.sh=20
>  grep: /usr/local/versioner/perl/versions: No such file or directory
>  ./t0000-basic.sh: 1154: ./test-lib.sh: xcode-select: not found
>  ok 1 - verify that the running shell supports "local"
>  ok 2 - .git/objects should be empty after git init in an empty repo
>  ok 3 - .git/objects should have 3 subdirectories
>  ok 4 - success is reported like this
>  not ok 5 - pretend we have a fully passing test suite
>  <...>
>  # failed 29 among 82 test(s)

Yes.  This is one of the patches that I said in the 00 message would certain=
ly not be upstreamable but for which we should find a general solution to th=
e problem if one is available.

>=20
>=20
>=20
>>>> +export PERL5LIB
>>>> test -d "$GIT_BUILD_DIR"/templates/blt || {
>>>>    error "You haven't built things yet, have you?"
>>>> }
>>=20
