Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA041F576
	for <e@80x24.org>; Sun,  4 Feb 2018 09:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbeBDJ5v (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 04:57:51 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35737 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBDJ5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 04:57:50 -0500
Received: by mail-qk0-f172.google.com with SMTP id 69so16081010qkz.2
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PBXFu0+2HPe6/3ty8s4lG0WAIFV0FGMSTgV4/edo7aQ=;
        b=B3fEAABQI0FHVIS6yInCArulLw5pohzBJ4zpO9WjgxPIYq01YhjrxRp11KxWOBy5DW
         VT8n0Pj1OA1UakKkJL5XbkyCPaxcWHpt/to4lQLoqq2SptnD0F6z8+VpcjsHE4KMy6Zr
         69PRg1WMDwX3Tu8hpYKB4KCjRtHWjEirvKBdwz1xmHE1xoKKEZyzVqd+Cr4pKjQ1uu0q
         tAoA6iMUhyIKdCvH7yFCQR6w2OUeNb6OEG4dMUCZyWtubBx1l55GDyT8aNIp3oyAZBCZ
         sWjEAio7sXwVLvEMYB+S8LuS0imxlutY2hbQS2nX9nUJzktIJHDDiWMkihC0+s3jtmXU
         41Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PBXFu0+2HPe6/3ty8s4lG0WAIFV0FGMSTgV4/edo7aQ=;
        b=DW4wobCbavEtKFOlDq2wEdE1hcDEsRNdSlKM4H8HKoY85RH3Wv4ftgn/BcTRTLn6Fj
         kRmJ56ym62hQqk4UaqxhzVjJF+eu6+yXcpA9r4KkGVB+iz9RLIqE52yrpNfJ/PVix9AD
         4SPBGlV7qzjp4cIp6zTERBdNffxypoHPwoY9cB2F/OdLaWK4fBxuiw46FF667Yw6vYeD
         dnuLl5lWYIJvxp974JG6ZJMhI1xrR2s1tkQya0TDSx5bGY86TVjR5+upG1Cp/kAJR8/c
         ZO/rC7jpmK4efORUsM3L1B5izTeMomEcvOCTz49fTsiWNrOaM7EsVr/yTwfbgmo1EbzX
         tumw==
X-Gm-Message-State: APf1xPCimtPyW8bCyCPRpI1uOBsOp4gSO+lN/+BRIRyamg1NvTFXOWgH
        Z7udynqaVYdmyApjL4CNDbuyl3SQsV4d7aMArvs=
X-Google-Smtp-Source: AH8x226gyV9I46h0Nagkvc3mJ9nXPkgTeTTJog4bP999+j12Swop+9CIRqWzBB0coPBA2dFZxjAfdtUCCHX/qKmPJu4=
X-Received: by 10.55.16.137 with SMTP id 9mr8203937qkq.189.1517738269309; Sun,
 04 Feb 2018 01:57:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 4 Feb 2018 01:57:48 -0800 (PST)
In-Reply-To: <CACsJy8BKpniRxzDa8tOzEu=UVB0kMgv-n0tqZgp0Jreruqq-mg@mail.gmail.com>
References: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de> <CACsJy8BKpniRxzDa8tOzEu=UVB0kMgv-n0tqZgp0Jreruqq-mg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Feb 2018 04:57:48 -0500
X-Google-Sender-Auth: DF826CWgaMv2wPl2f0ZVmtHmXcM
Message-ID: <CAPig+cQXT1ov4MjzSzqiLBzr4wN1XcP7aSxMP+_dhtWtYwhDAA@mail.gmail.com>
Subject: Re: contrib/completion/git-completion.bash: declare -g is not portable
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 4, 2018 at 4:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Feb 4, 2018 at 12:20 AM, Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
>> After running t9902-completion.sh on Mac OS I got a failure
>> in this style:
>
> Sorry I was new with this bash thingy. Jeff already answered this (and
> I will fix it in the re-roll) but just for my own information, what
> bash version is shipped with Mac OS?

The MacOS bash is very old; note the copyright date:

    % /bin/bash --version
    GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin16)
    Copyright (C) 2007 Free Software Foundation, Inc.

A recent bash installed manually (not from Apple):

    % /usr/local/bin/bash --version
    GNU bash, version 4.4.18(1)-release (x86_64-apple-darwin16.7.0)
    Copyright (C) 2016 Free Software Foundation, Inc.
