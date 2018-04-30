Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE04215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeD3We0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:34:26 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:37419 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeD3WeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:34:25 -0400
Received: by mail-yw0-f171.google.com with SMTP id u83-v6so3092705ywc.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BfYiZd5ooZKxE2TNLCxTdWmhXHLrAIJTZjKa7BSLnc=;
        b=n+R9TJnd8xLa1qiKoFQQWxS86O+7QxqcoSFDjSbucQgFx1hWlU+RAuKc+ZtSj931St
         RPz4uj6TyvhQZedt7Ecc8bV+UAzNYgoiFvUk0txErZo1sIENgSe+bbQ7q647WAMEqBGC
         u76xZ5Lgtx9PM9cwR83wyXpVS7n+wtaqCE3+bVGikp+WSAg6PRYay7wNJaCw69FnleiZ
         jd3Vf8FpBpqk9LitvsTHZ48zSIwvJe/ePdfeObkd89zpdMjg23jT9PtuJQ7Vu7fC6hWv
         unO12n+XT4a/zyx6zh4AK6WbLip2CGD0XD6rBH7vcRRGujtjOodqu6nlYpGP6CNVyaZf
         Lf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BfYiZd5ooZKxE2TNLCxTdWmhXHLrAIJTZjKa7BSLnc=;
        b=JOyoXm/mRNEMZ5cPz1hJfrWDbpDaJyF74R3mI4n5Azi8491ZVDOLoQGx/xv179BjgE
         myjMVLKn6+AB4ckCmiBjBsXJgAHEYZ0YrUnDEZztVZk2pLVkYK3m/QNRfpeaGSBWG4qz
         9S+SdXisKsU/JRomiLwcWPURJmvtH5Kb8MQSR9PsfOR0EArK/pig5zg8EIep73KrBpiq
         m6ZgfzfioTJZrbPRRMx1BB1cnACjQhRbkzKpGqUNWLn3mjfoLUaoEtLroW1WrmOAQ67F
         y1rRdlCUHMQssHXl6D3jGDvb+gSHmzOQC1+2M7lhhGZaqyQu2a/6sGBXr/ze9PcJgLBj
         yCzg==
X-Gm-Message-State: ALQs6tCtmay0H5z6Doo34MU7rnPXtG5fwG3uCQzyiSzfhw6iuYmKFfkC
        pA0F+CIeR4vzJAlMC3MJdSRoqmgKjVgGtlG3do9cHA==
X-Google-Smtp-Source: AB8JxZqddHTK9JSBBdfowbW8R6im4kbCZTp2DBOa71NHCD8MBzgNqPpQS7HCN2uqj+9/sFkVQl6a905uWMNCHvVEBgU=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr7328718ywf.238.1525127664472;
 Mon, 30 Apr 2018 15:34:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 15:34:23
 -0700 (PDT)
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 15:34:23 -0700
Message-ID: <CAGZ79kY=-LAvA3i8QvS3Q1VniE2M-=vFxuXX3=zmPx9vXUaRgQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] get_short_oid UI improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 3:07 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I started out just wanting to do 04/09 so I'd get prettier output, but
> then noticed that ^{tag}, ^{commit}< ^{blob} and ^{tree} didn't behave
> as expected with the disambiguation output, and that core.disambiguate
> had never been documented.
>

This whole series, including the comment in which you wonder
if the code is overly smart, is

Reviewed-by: Stefan Beller <sbeller@google.com>
