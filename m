Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A408207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422717AbcIZSt5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:49:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33280 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422675AbcIZSt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:49:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id l131so10343630lfl.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iTl9OFDiWkcbKTQ+jHt4pClFVDR2Tm09sdrIhqxjH2c=;
        b=XZil3ljXin1ycDM9FGKDPGdav98o1zB4G0jMf0ymNsIuqOY1BhQPDrNFez4o2oijyt
         3YrtTKuMrPTwlMCIWhLOWdS5a/gp5VfFujbuZJlmr39X8bqX0pUBJvwwWLMWAywGOp59
         qoSbs44wEKbVCFLvCitw6gZl/ytLr1MMlL8G49xX3cQKdMiFc7PWdJtPxBuJ7xFYK0Ht
         hf7DR2xqifdd2SfdW2Q1kfaMRvrFR2OLfKKObASpMLfgbPd4v5sE+L+CzqSQ74lsETiP
         sg190upjjbwnBza0NrrhCGclT6NpiItr9FVn6Hz5h1LgRoCli98MiZ0cc9hJ/zsLI0fT
         V/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iTl9OFDiWkcbKTQ+jHt4pClFVDR2Tm09sdrIhqxjH2c=;
        b=i6xPnWB7PLdfEZuDjJ8tZTqmV+4etjQxn2riAqQ8U7Fe0XTvaZZLmQxS4Nx9LwN6Lc
         XnNnEVmtc9VyB/1dZGh8SiOi8Cek3bC35DA/PvT+6ye6j7BZGOD8RgZlcp6DOFVp7eW8
         smD8IXCrwXkozw5r7Ngo7/DF1VLBMV9f8uE2tu1m2GnMHF4VXa578QVv/9qe0a4e5aA7
         4MsmEJwfx+5s5F2WLeBg8pskX0vkytIB/fe882sc+skoXzT/i1tvLBQp3Tqfk6f6OYAO
         yrjXAtoJeCyz259pIK+BhEShhnJXEWeuIm8F95yRcD9/SkDcxbm/BW/m/72ESGAOVIj3
         jnGQ==
X-Gm-Message-State: AA6/9RmJ4NgwuizLzByDWz5YhKyUyscKZdVX7kvMbz4PNKe28nmYhfUZuCfg8DvqionJFw==
X-Received: by 10.28.155.212 with SMTP id d203mr16288327wme.103.1474915794071;
        Mon, 26 Sep 2016 11:49:54 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4342.dip0.t-ipconnect.de. [93.219.67.66])
        by smtp.gmail.com with ESMTPSA id y2sm23745600wji.42.2016.09.26.11.49.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 11:49:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v8 01/11] pkt-line: rename packet_write() to packet_write_fmt()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <592e18b7-ac2e-ed23-0321-57eb418d5172@gmail.com>
Date:   Mon, 26 Sep 2016 20:49:51 +0200
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <13E00B0F-41FC-4FBE-9ABD-2E9B11743E2B@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-2-larsxschneider@gmail.com> <592e18b7-ac2e-ed23-0321-57eb418d5172@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 24 Sep 2016, at 23:14, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:

> Hello Lars,
>=20
> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> packet_write() should be called packet_write_fmt() as the string
>> parameter can be formatted.
>=20
> I would say:
>=20
>  packet_write() should be called packet_write_fmt() because it
>  is printf-like function where first parameter is format string.
>=20
> Or something like that.  But such minor change might be not worth
> yet another reroll of this patch series.
>=20
> Perhaps it would be a good idea to explain the reasoning behind
> this change:
>=20
>  This is important distinction to know from the name if the
>  function accepts arbitrary binary data and/or arbitrary
>  strings to be written - packet_write[_fmt()] do not.

packet_write() should be called packet_write_fmt() because it is a
printf-like function that takes a format string as first parameter.

packet_write_fmt() should be used for text strings only. Arbitrary
binary data should use a new packet_write() function that is introduced
in a subsequent patch.

Better?


>> pkt-line.h               |  2 +-
>> shallow.c                |  2 +-
>> upload-pack.c            | 30 +++++++++++++++---------------
>> 11 files changed, 29 insertions(+), 29 deletions(-)
>=20
> Diffstat looks correct.  Was the patch generated by doing search
> and replace?

Yes.

- Lars=
