Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35672C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC8720735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="vu40+0HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgEEM0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 08:26:43 -0400
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:57723 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbgEEM0m (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 08:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1588681601; bh=r+4QpngwjChrvs1klJVaePqBbZNuhbIzLW1hR8+PRWo=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=vu40+0HOn0uDCjk4MF+6KdjMjJsrcOhJ3YLZeSjmkQvV7vZDP8AB+KRutvrSrksWd
         Tfv9y+1mQXXW9BIlZxqcZSvT0M+P92FmKeJgfzDW9nynyWnwt9P0sNR99LxQUk1jUg
         C/iezVqU2jMlzelCAqxnu0JsvN0iKhOI3Ars0MPLe1afu3acrqWigTC3snKI1VR8l3
         m9lT4V9jbJop6zeRVEL6HkLGKNvyMj099ZIBzmFHzX+vDu5r3E3xji1u2G6pJ0CWRa
         cUVV2zmiAawboUH4MWOwc0rMG5Jemj2v0bZU3YaSvApagfvkkr/7BOltSZzVuWXERK
         YySx5cfoQagjw==
Received: from [192.168.1.127] (unknown [192.222.216.4])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 1AABAAC03CA;
        Tue,  5 May 2020 12:26:41 +0000 (UTC)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Git 2.26.2 and failed self tests on OS X
From:   Philippe Blain <philippe.blain@me.com>
In-Reply-To: <20200505041033.w2q7h5k7otetfrus@tb-raspi4>
Date:   Tue, 5 May 2020 08:26:38 -0400
Cc:     Jeffrey Walton <noloader@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Carlo_Marcelo_Arenas_Bel=F3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6880B7C-78B7-4D90-91E3-1CED85325FF2@me.com>
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com> <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com> <20200504190830.g2tlrognjw6ddipo@tb-raspi4> <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com> <20200504201944.gh3zykhil3txdwnk@tb-raspi4> <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com> <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com> <20200505041033.w2q7h5k7otetfrus@tb-raspi4>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2005050100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

> Le 5 mai 2020 =E0 00:10, Torsten B=F6gershausen <tboegi@web.de> a =
=E9crit :
>=20
> On Mon, May 04, 2020 at 05:39:50PM -0400, Jeffrey Walton wrote:
>> On Mon, May 4, 2020 at 4:30 PM Jeffrey Walton <noloader@gmail.com> =
wrote:
>>>=20
>>> On Mon, May 4, 2020 at 4:19 PM Torsten B=F6gershausen =
<tboegi@web.de> wrote:
>>>> On Mon, May 04, 2020 at 03:20:11PM -0400, Jeffrey Walton wrote:
>>>>> ...
>>>>>> Does
>>>>>> ./t3902-quoted.sh   -v -d
>>>>>> give anything useful ?
>>>>>=20
>>>>> Yes, it looks like the command reveals a couple of problems.
>>>>>=20
>>>>> fatal: iconv_open(UTF-8,UTF-8-MAC) failed, but needed:
>>>>>    precomposed unicode is not supported.
>>>>>    If you want to use decomposed unicode, run
>>>>>    "git config core.precomposeunicode false"

I also came across this error a few months ago with the=20
conda-forge build of Git [1], which for the moment builds against their =
own
build of (GNU) iconv.

>>>>=20
>>>> I am quite sure, that the trouble starts here.
>>>> It seems as if you are building iconv yourself ?
>>>> And that iconv does not include "UTF-8-MAC", which is a specialty
>>>> for Mac.
>>>=20
>>> Oh, thanks. I was not aware.
>>>=20
>>> I'll open a bug report with the iconv folks letting them know
>>> configure has some gaps on OS X.
>>=20
>> Thanks again Torsten.
>>=20
>> I am not seeing an option to enable the encoding in iConv. Would you
>> happen to know what is needed?
>>=20
>> Thanks again.
>>=20
>> $ cd libiconv-1.16
>> $ ./configure --help
>> `configure' configures libiconv 1.16 to adapt to many kinds of =
systems.
>=20
> Hej Jeffrey,
> I am not an iconv expert - and don't intend to become one.
> The UTF-8-MAC conversion does probably only exist in the
> code for iconv shipped on Mac OS - so it could happen that this
> code is not open source.

Yes, this encoding only exists in the Apple fork of iconv,
which is open-source (probably because of the original=20
license); tarballs can be found at [2]. However in typical Apple fashion
the versioning of their iconv fork is kind of undecipherable and hard to =
relate to the
upstream iconv versioning.=20

Also, I searched the iconv mailing list [3] when I came across this =
error and the consensus
seemed to be that they do not intend to add this encoding upstream.

Cheers,

Philippe.

[1] https://github.com/conda-forge/git-feedstock/issues/50
[2] https://opensource.apple.com/tarballs/libiconv/
[3] =
https://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=3Dutf-8-mac&submit=3D=
Search%21&idxname=3Dbug-gnu-libiconv&max=3D20&result=3Dnormal&sort=3Dscore=
