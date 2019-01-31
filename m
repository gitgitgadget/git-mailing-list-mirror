Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712B91F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfAaSRY (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:17:24 -0500
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:55038 "EHLO
        ma1-aaemail-dr-lapp01.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbfAaSRX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Jan 2019 13:17:23 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0VI6gT2000476;
        Thu, 31 Jan 2019 10:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-type : sender : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=6WkorwMF7iMouZcReIFCZpSm5ZoYCBuaRrGUzgxeBl4=;
 b=kCArVHopGX9buNvVE4Yu0ZqXn7jNdVOC24dB5rQRYr6Erw/vWick1+FRGu42w9W8KLV3
 hxUPqpc7/HK1JmoTGld4UMggAYHvA7tuvooQL487aNuZSTtQHbsbG7iCayRHZJmdnVIS
 sKFVzvyAgMeNAN2xXU6U98k5M0oMyvMqdbS5mHb3Gfnec9OZdeJHT8L+dAubMdCy0VKB
 valM5LgBpGXfCOodU5wCWVlBoulbB5eYBc7Fwd/Qf4aw0UW288tkYNg34uY80sPZH1GM
 UiY/dsrgTp9RA7ve4bQ5vuH1plY69dCIeuAUa+e3XI1HcO5UMP8MV1I6xEBA0+YXBHMj 8Q== 
Received: from ma1-mtap-s02.corp.apple.com (ma1-mtap-s02.corp.apple.com [17.40.76.6])
        by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 2q8q3cmvum-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 31 Jan 2019 10:17:15 -0800
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Received: from nwk-mmpp-sz09.apple.com
 (nwk-mmpp-sz09.apple.com [17.128.115.80]) by ma1-mtap-s02.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM700HQVK4OQ020@ma1-mtap-s02.corp.apple.com>; Thu,
 31 Jan 2019 10:17:14 -0800 (PST)
Received: from process_viserion-daemon.nwk-mmpp-sz09.apple.com by
 nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM700B00JHYV200@nwk-mmpp-sz09.apple.com>; Thu,
 31 Jan 2019 10:17:14 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 870e2c9ccb5cba399604c8bab4417fc4
X-Va-E-CD: 9770a944a70acd20bbc6bfe75bee6297
X-Va-R-CD: e44873b1b593e4364a6cb0f5e2f68737
X-Va-CD: 0
X-Va-ID: 4ad64043-5bd1-459c-98c0-f44ba8466296
X-V-A:  
X-V-T-CD: 870e2c9ccb5cba399604c8bab4417fc4
X-V-E-CD: 9770a944a70acd20bbc6bfe75bee6297
X-V-R-CD: e44873b1b593e4364a6cb0f5e2f68737
X-V-CD: 0
X-V-ID: 543bee05-bb2b-4548-bc0e-dcc4818cd810
Received: from process_milters-daemon.nwk-mmpp-sz09.apple.com by
 nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM700K00JOZ3K00@nwk-mmpp-sz09.apple.com>; Thu,
 31 Jan 2019 10:17:14 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-31_09:,, signatures=0
Received: from [17.235.38.225] (unknown [17.235.38.225])
 by nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPSA id <0PM700MANK4Q6X80@nwk-mmpp-sz09.apple.com>; Thu,
 31 Jan 2019 10:17:14 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches *.S
 on case insensitive filesystem
From:   Jeremy Sequoia <jeremyhu@apple.com>
X-Mailer: iPhone Mail (16E189)
In-reply-to: <xmqq4l9o4sm7.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 Jan 2019 10:17:13 -0800
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-transfer-encoding: quoted-printable
Message-id: <F67B3B30-64D8-4B0D-A4FD-7263415B0064@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-2-jeremyhu@apple.com>
 <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
 <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
 <nycvar.QRO.7.76.6.1901301340270.41@tvgsbejvaqbjf.bet>
 <8B5241CB-2E1E-4521-8FE1-A84C4896AE82@apple.com>
 <xmqq4l9o4sm7.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_09:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone...

> On Jan 31, 2019, at 09:57, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>=20
>>> What you probably want instead is
>>>=20
>>>    # Accommodate for case-insensitive filesystems where *.s would catch
>>>    !ppc/sha1ppc.S
>>>=20
>>> after the `*.[aos]` line.
>>=20
>> Thanks for the suggestion.  I didn't know that was possible with
>> .gitignore.  That's a much better solution.
>=20
> I still do not see what problem you need a "solution" for in the
> first place---I saw a few comments asking it in the thread, but saw
> no answer.  ppc/sha1ppc.S is already tracked, so any modification
> you make in the working tree can be added to the index with "git
> add" and "git status" would report when you have modification to
> that file in the working tree, without any such extra entry in
> .gitignore, no?

I originally saw this because the .gitignore was present in the tarball, and=
 we would only update to new versions by pulling in the newer tarball.  This=
 resulted in *.S not being included in our repo.

When I switched to having upstream be a subtree instead of an extracted tarb=
all, I noticed this difference when comparing the source code difference bet=
ween the tarball based approach and the git subtree approach.

This would have implications for anyone doing something similar or to anyone=
 intending to add new assembly files to the tree (since they wouldn=E2=80=99=
t show up in status or get added with add -A),=
