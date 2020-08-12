Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF09BC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC33A2080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="xg/5BR0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHLMmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:42:50 -0400
Received: from ms11p00im-hyfv17291101.me.com ([17.58.38.40]:55264 "EHLO
        ms11p00im-hyfv17291101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgHLMmu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Aug 2020 08:42:50 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 08:42:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1597235699; bh=fVx+9n5p2qyd1YygOh18kE+QVukrQRAnCcptD14mr6Y=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=xg/5BR0NY9QgMlFhmWQH2AIz67iqDimqHLK2CgderP8E2op8Ef3TRk6zsE58fxKNM
         PVAGkzwdo0s3YWG5Oou51z/1nxpBl4vp4I6Kz3/VY0LARdpEkYQ8wrMbCzCE1QSjHE
         CCsNmbg/X6tm7WysnXnpykH7QaAHIekE3XxIp2slYKSrat+uwr4sFKWKwlZ9CNaql3
         fLGFBl2Fq8xlI5UFGjDmhahK1T8RVqt85hgBbXZIv8BUVJrpztXDScTiNu6hTdBprL
         mKrBbdvCi2wawXkLJwOEtwpg7s6/NpxGcxMCtoXdFTBfq2/TR8ERYhLRLSV5TDICCi
         w/yFdGKKjPQXg==
Received: from [10.0.1.11] (pool-72-92-234-38.prvdri.fios.verizon.net [72.92.234.38])
        by ms11p00im-hyfv17291101.me.com (Postfix) with ESMTPSA id 6F5656C0277;
        Wed, 12 Aug 2020 12:34:59 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: git reflog --date
From:   Craig H Maynard <chmaynard@me.com>
In-Reply-To: <20200812091436.GA18444@coredump.intra.peff.net>
Date:   Wed, 12 Aug 2020 08:34:57 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <44B5E44C-E1D8-439F-9C5B-6C5EA9CF7620@me.com>
References: <730B4EB4-AA72-4097-9487-D6B8623BB8E5@me.com>
 <20200812091436.GA18444@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-12_04:2020-08-11,2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2008120090
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for this helpful information. I'll read the docs more carefully =
from now on. -Craig


> On Aug 12, 2020, at 5:14 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Aug 11, 2020 at 08:28:55PM -0400, Craig H Maynard wrote:
>=20
>> I'm using git version 2.28.0. I don't see any mention of this 'git =
reflog' option in the online Git docs:
>>=20
>> git reflog --date=3Diso
>>=20
>> Am I missing something?
>=20
> The reflog command defaults to "reflog show" if no command is given
> (from the "Description" section of "git help reflog"):
>=20
>  The "show" subcommand (which is also the default, in the absence of
>  any subcommands) shows the log of the reference provided in the
>  command-line (or HEAD, by default). The reflog covers all recent
>  actions, and in addition the HEAD reflog records branch switching. =
git
>  reflog show is an alias for git log -g --abbrev-commit
>  --pretty=3Doneline; see git-log(1) for more information.
>=20
> And the implication that it takes the same options as git-log is =
spelled
> out explicitly in the Options section:
>=20
>   Options for show
>     git reflog show accepts any of the options accepted by git log.
>=20
> You can find a more detailed description of --date in the git-log
> manpage.
>=20
> -Peff

