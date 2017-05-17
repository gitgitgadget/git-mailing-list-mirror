Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A861201A7
	for <e@80x24.org>; Wed, 17 May 2017 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbdEQQq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 12:46:29 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34241 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754588AbdEQQqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 12:46:21 -0400
Received: by mail-pg0-f50.google.com with SMTP id u28so9685088pgn.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qK9jsJBDz7YYep3DZR3rS86akIjalH2VQWjhAZX3CIw=;
        b=P+v4ADy/970cIAXaksms9MA9NMpZrDEYX0Na7YRsZsLnGevpq1ZQHR9adQFk3vIDcQ
         RNgASvzo1fcwH7IEm0cQH/e05ut2cyXRHG95Wv7JHUiQgxQR84GjLUzSMEosAPrcM1gZ
         bFVjmI8ZklHtw/6pxKHd9sp/yfpuGLSjaU5U6Cb5v2wPpTwUtUUFtMi/r8UCptG/E6Pp
         y612EFqlfKvxUmPzXSr154eAMbvd/eVA+367m5SHQqQWG56ZkB50wkXaPQ+hraVbjlJu
         UxYQckgXENgRI/ewp1gcW10YkhdiA7jJzFVbjGzSgEK9UszRfctvcPwhT1MYsA+7dCgx
         vkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qK9jsJBDz7YYep3DZR3rS86akIjalH2VQWjhAZX3CIw=;
        b=qBx/EsdLuzjYITycIagqaUWfdUKDKuO06hmzRnN1G2fNdzwPC/A9aWAcWNR771P11u
         /Mjqy/oFScJQudCwJ6EUgAAghIAH8n/yhpvcGYEsaGmik82Rb9t+70IKMYVd10reseeK
         rn/raw09iBlXggCYQY1qYvws4O860xPHoo21ttE7oeziupT2NsFV4BHbh3AIFcm/6+z5
         vKxOSzyBMRZXDoy8CTPTuvUZRWxJDYPQVXrNFFcQhifvVta4YwzN/zJc+4vmD4qE5myn
         6UjiHAlX3JPIPk7HlWcsRhzOj/g3jYgZOtLMs95EOrSbUdVNQlkBKGcW4XssFBqEf7cM
         U2jQ==
X-Gm-Message-State: AODbwcC82Cdg4g0Gc8zthKELxl6V1TDhe2trEw6fBjiVhsIfmcXc0lY+
        /pf8AI8TTcrSr4DroM0Imbh7wlgYWEAG
X-Received: by 10.98.104.4 with SMTP id d4mr4661923pfc.94.1495039580466; Wed,
 17 May 2017 09:46:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 09:46:20 -0700 (PDT)
In-Reply-To: <f56871ab01d7a9b07631f143ae902605a1e247f4.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <f56871ab01d7a9b07631f143ae902605a1e247f4.1495014840.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 09:46:20 -0700
Message-ID: <CAGZ79kaMYVp7SLq3MspC6f45=QUZM=mJMxNDfwVj+1cgEhMQ6Q@mail.gmail.com>
Subject: Re: [PATCH 02/23] refs.h: clarify docstring for the
 ref_transaction_update()-related fns
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> In particular, make it clear that they make copies of the sha1
> arguments.

A couple weeks ago we had plans on getting rid of SHA1 in
"the near future" IIRC.  Would it make sense to not go down
the SHA1 road further and document this in a more abstract way?

    s/SHA1/object name/

essentially, but I guess one of Brians future series' may pick this
up as well.

I am just hesitant to introduce more sha1-ism at this point.

Thanks,
Stefan
