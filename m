Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8953DC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6786261263
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaUrm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 May 2021 16:47:42 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24219 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhEaUrl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 16:47:41 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14VKjq2u029288
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 May 2021 16:45:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Bj=C3=B6rn_Kautler'?=" <Bjoern@kautler.net>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>, <git@vger.kernel.org>
References: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com> <07edafe5-d0a2-4a2c-12a2-28c163f6fdda@gmail.com> <YLRoAIBExd+dAe0C@sleipnir.acausal.realm> <CAKChYSrQ3u3yH0+8Fwj-84cnAFGvuSEPHx+5Mcy8Ys4sXcN14A@mail.gmail.com> <CAKChYSpGJ8WHsYRgYL9M8rr7Dp_SLrUuRsTONqNO3CTnX2DQ_Q@mail.gmail.com>
In-Reply-To: <CAKChYSpGJ8WHsYRgYL9M8rr7Dp_SLrUuRsTONqNO3CTnX2DQ_Q@mail.gmail.com>
Subject: RE: Bug when cloning a repository with a default branch called HEAD
Date:   Mon, 31 May 2021 16:45:46 -0400
Message-ID: <00a401d7565d$f20fd4b0$d62f7e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIG8zYb5MgpOfxAFZTspIndtmsMLwDD9p4SAp09IcwByCfmVgDcwlfxqm6j3eA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>-----Original Message-----
>From: <Bjoern@kautler.net>
On May 31, 2021 4:38 PM, Björn Kautler wrote:
>Subject: Re: Bug when cloning a repository with a default branch called HEAD
>It happens the same no matter whether on Windows or Linux.
>I now also have a reproduction recipe on how to get into that state.
>- Create the `whelk` repository with standard settings, nothing for default branch or anything is necessary
>- Execute this: git clone https://github.com/seveas/whelk.git
>whelk-src && git -C whelk-src remote add gitlab git@gitlab.com:<your
>namespace>/whelk.git && git -C whelk-src push gitlab
>refs/remotes/origin/*:refs/heads/* && git clone git@gitlab.com:git-spindle-test-vampire-1/whelk.git && git -C whelk fetch

According to GitHub, the default branch for this repo is "main" not "HEAD". AFAIK, HEAD is a reserved ref in git and I don't think this would or should work.

Just saying.
Randall

