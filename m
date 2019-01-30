Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6391F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfA3UxK (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:53:10 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:40180 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfA3UxK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 15:53:10 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UKpkFP012448;
        Wed, 30 Jan 2019 12:52:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-type : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=O6cFRJVleL85+QmZj6ZHCjQUPxu5ocdCzimBUAGZdUE=;
 b=CBGWopfANuaH/Mzb/Lc2+tWRxFCs8c4VAb2tGn0i7eJv82USuAE3/SDbsegD5x11mtYC
 oMMkgaVWayZo/6Rj+xf6NNzqHwzpZ/CpStA5swy/6qFgYyUW8F810sUUu2qBTsFcWa5F
 aCBJhpnMXvX1YrTYYnC9Kmn93sOcoxv+FlATXazON1lFHEdFy9awUi6wO4RNG3Tz+HGd
 PdU8Fjz6MBmWxzt74FSdN7/CDA+q2k72bqx8MPyGADYo9VX+zqNcys/8ZJoViz8+eMOG
 /0OWtgic43uH5barXILxZPCDZ6V4D/cNwi1Fm4zQZFbXyrh4hx93ANudFov9ExoE3XPc sQ== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com [17.40.76.5])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0stuta-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 12:52:57 -0800
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5006TIWO45R80@ma1-mtap-s01.corp.apple.com>; Wed,
 30 Jan 2019 12:52:56 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500E00WD8PD00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 12:52:55 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: 4b191ea47c869588dbea83c34d5f132f
X-Va-R-CD: de96b9fcc174794f3cefb75163f7efd9
X-Va-CD: 0
X-Va-ID: 00fdffe5-56a7-4ddc-b008-12b9761618c1
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: 4b191ea47c869588dbea83c34d5f132f
X-V-R-CD: de96b9fcc174794f3cefb75163f7efd9
X-V-CD: 0
X-V-ID: 29fec78f-b650-4d9e-a37a-4e600c9ac1ff
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500E00WCWMH00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 12:52:55 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_15:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5000ZRWO6YY00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 12:52:55 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 09/13] Use symbolic links rather than hard
 links for files in libexec
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <nycvar.QRO.7.76.6.1901302010210.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 12:52:54 -0800
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net
Content-transfer-encoding: quoted-printable
Message-id: <D1597287-4622-4419-ADA4-91B051B25FA6@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-10-jeremyhu@apple.com>
 <20190130095006.GC24387@genre.crustytoothpaste.net>
 <230CA858-D709-4142-9563-20A4887F2ED8@apple.com>
 <nycvar.QRO.7.76.6.1901302010210.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 11:15, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Jeremy,
>=20
> On Wed, 30 Jan 2019, Jeremy Huddleston Sequoia wrote:
>=20
>>> On Jan 30, 2019, at 01:50, brian m. carlson
>>> <sandals@crustytoothpaste.net> wrote:
>>>=20
>>> On Tue, Jan 29, 2019 at 11:38:15AM -0800, Jeremy Huddleston Sequoia =
wrote:
>>>> See <rdar://problem/10573201>
>>>=20
>>> It's my understanding that Radars aren't public. Could you summarize =
the
>>> reasons behind this change in the commit message for those of us who
>>> don't have access to view this issue?
>>=20
>> There was a bug in some tool in our packaging pipeline that resulted =
in
>> hardlinks not being preserved.  That was fixed, but I decided to =
leave
>> these as symlinks anyways in case users did a file operation on
>> Xcode.app that didn't preserve hard links.
>>=20
>> The point here is that it would probably be nice to have hard vs soft =
be
>> a configuration option.
>=20
> Your patch does not make it a configuration option. (Or a build =
option,
> which would probably be the more appropriate thing to do here.)
>=20
> You need not spend the time on this, though, as =C3=86var already did, =
in
> ad874608d8c9 (Makefile: optionally symlink libexec/git-core binaries =
to
> bin/git, 2018-03-13), which made it in v2.18.0 already. All you need =
to do
> is to define INSTALL_SYMLINKS.

Oh great, thanks!  I missed that when doing the last rebase.


