Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BDC433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353775AbiFAQyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbiFAQyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 12:54:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40D3336E
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654102432;
        bh=3mikgHoSaHZR7vjDmeSToN4IlZZyBRRhXFk7rIxcZbA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b1FPBcvVR4Oaj4PPQcFR2g//adhoyf9Q+EY9C2RQPvx1X2rZQl/zvhFVRLTSWkRmK
         dgpbgqlfZ6umhFBoy6R02uso9fm/0hsfUwyU0LVwkrypVmLRrwQg6xyxPu48lqbq2X
         r+ULCKkdrkof1/nldxzFobq25ZQDojE51KeTEpBE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1nsqZp34sH-007zw9; Wed, 01
 Jun 2022 18:53:52 +0200
Date:   Wed, 1 Jun 2022 18:53:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/2] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
In-Reply-To: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206011850460.349@tvgsbejvaqbjf.bet>
References: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-29050784-1654102432=:349"
X-Provags-ID: V03:K1:yqqKxj23SpVuEsCHBkFHMaxOmbEg1QQI0VM4OsgBAJQD+cLVZkI
 G1chBw1kOGZZLyTCpjnt0QrYmVne7AMVz96fGt3m67UnWMoNj28rDU7ycDI48wDqqbYCj71
 3Yb8dDsd688oSNS8NAH5AkuItLMORCgkTzidEwVejVOdQY9hvxrBP6Y2c2YC2S5babNR1x6
 jRPtQ/QKi3EFqo6qZt+hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vysw+JIg6BQ=:6ZrYeIf+EWdVxOCvnNfENO
 LV0+TjkFsUOKrritJ2ZhOs0fun5LrMX/HZXGgSzMPjuyDO4oGaG9sYoHOcFCAqdGfoAPazdgf
 G/24kfuj8y6nYldrKI+nzVW+av8/rJCJPDOqIzhEXj74JFCn58/JvUa+NOPSoSvCOH+/jWQWL
 j5EoMYogf94yVhQu5KG0L2GpGXgBwITEQIeej913pnZ68N8xVBw10Kb6CwmPky/SC218Q1fEu
 1OEwYRCL12XbCkImo9PJ4ssA0awJbFpLGGh/EhPrpiNWtk2O+jHWG2LCxQYLBJy8SQZPi/48b
 ritwLjL0GOPN+/glO74Eh1xYuXwg68ZG7wW5SYcI6ngDfI6GzV1/zfcxvopvaGqPTEK/zQl9Y
 aCA3VZ/bk+p/sT2ImMDboJa6KAe8Skvqd2Q0ZwtUPXu2ffPIjJS1wye3cPVsTsVZ7PRcBeYGR
 8Sh3k2daZtHNcS1UFg62w5VV0FONlbND+w/J55S9evGaeU7W7ugBFwD/YF6Qoo5eOZLWJviFk
 /CAvoGpmDZm0K5SY54t4j2C9Jk/1opc7TJh0pFiToFU7Y6FengmX37qJdF4An8j+MrJ40NDn9
 FKW6RIv8p1NFoFUSXD7NEJbQ2YdjqEz8VImFTW34vdYvqdT4DG8GD/fSl36iiE8S+QnFEfgck
 WN6VPym5/W4C1f7zSlbA7oj8Wh2vSiLIlUiqYSz1VFSQmI0imUCcDpto9cr18CYXHcEctkD9p
 c+Zbk/iaI/ojA4gDzpC1xBEYAp1A9Iw7APe/PbIN3KoNiwzN8x1asTLbxnB5kN38aWBz2h5eK
 nabxQbNyJSy9H3kaaHV1p+sVbBkHkLijqacGbMoNYaqzCAo1dy6SimPN2RzocE/UugeN5IyUp
 XTpkRUvITsnzgCO9HhoWQ+aME8nBZXSCL3BxUFWbjGaj/54mV5QXwSrx5qkEXiNIkALLsRhoA
 k9i7YPOGGpYfF83T3ZZJRpf6aP++5I64wQ/1ypyaM0Y86WW6EQavEOoxge2M/nGQOzF/0eJ7X
 aSnVHoVObZoi18DvisPhY9+UjJvcGvn8ms2sSELX3kZ9N72/m3y9l7/AvK6XNNYYbP9TaNRvS
 Axlc3otyqQPLvJnXct2Mn6ZiPlcwEDY7b3WA97/UoGNoZmzLDpPOmvi0A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-29050784-1654102432=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 31 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   run-command: add an "ungroup" option to run_process_parallel()
>   hook API: fix v2.36.0 regression: hooks should be connected to a TTY

As I mentioned in the review of the first patch, this introduces a feature
with enough code that it is quite easy for more regressions to lurk in
there.

One thing that is notably missing from the cover letter is a discussion
how the current approach compares to either reverting the patches that
introduced the regression or alternatively patching the code in `hook.c`
to avoid using the `run_processes_parallel()` API altogether.

Ciao,
Johannes

--8323328-29050784-1654102432=:349--
