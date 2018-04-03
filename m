Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1901F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754907AbeDCIQl (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:16:41 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34158 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754891AbeDCIQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:16:39 -0400
Received: by mail-qt0-f179.google.com with SMTP id l18so18293891qtj.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=j6ZW1uZsi50PjTEOHHnxtuWDGTFXVfHSFO1mI/sDE+Q=;
        b=C6zSjY231+0MckzhGPNk/x4fVqmYzx1sT8b1dklJHjduPM05IYxHskOewzGgOIcDgJ
         qpOZxth6LYDXisCgCyAtpe88R95s8c8pZYk8QczN1xTjw57FgxkN5jDW5S3wOmkLsL/2
         2B7TTBGqkxkQOZmEI+1LcGvsJqKdTSeVy7yhFvEo6hK1y3g97zjil++33m+YALNxlo+L
         s6qwpB9LbF3DsxkV3ts0w+alNiV73gBKE9TNViTkPtnDxPzH36lKc0qZFRrFpOfrCFCv
         T7CGpUaEZ9HjrQ7o6JrFc5C49/+SWjJScvp6IM9FTX/m5i8KvXOldV/Sy7UL1pZFgiH5
         rnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=j6ZW1uZsi50PjTEOHHnxtuWDGTFXVfHSFO1mI/sDE+Q=;
        b=UgwjZagPxCe+KC1272bf1ywbJrRXFOgC7yaTiNvW9Ly+Ao20Zg42kfOogR8I5hyGwP
         24f3ZdcZsf3iPOCa+bPnsQLByBjUlurls7TvjLwutD1T+7IE2uhx0ux2KElYyhmavAfj
         b50l5Y3nBUC7PrS4qBHMIBGbNRclXGuSNFEtVSFABahBVKiGUha5zEBY5TROyQrgQG+D
         E3j/HCWnkn4csUtW5J6yhs3S2ac+4jmoKlCkraewQghK+4jMHedWexAAe4dXqlHQvPZ/
         Y1H7CUl6cM3bKiYR4Rji9A9Z90VUfRiThq2mHnAviaNdpcVl6DmXUnTrTIvAnGzjy5jc
         N1ig==
X-Gm-Message-State: ALQs6tBJsf0+mc91arSqvEg7xNrSzqYB/9XP9pXuPzJcIIO9/VPTyspd
        0ZUXEdu2Mm0WUkYNYVNYJJIqDY5cNk6fAxEHOME=
X-Google-Smtp-Source: AIpwx49jX6/JpbjyYnNLJoQn+Z3w6csMqeu4nLMQrMDBY2CW0RwMt1BZ/B6Jl1zK9Le2TPEnU9v6EBKiKStEeXkGSKM=
X-Received: by 10.200.69.131 with SMTP id l3mr19338667qtn.50.1522743399197;
 Tue, 03 Apr 2018 01:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 3 Apr 2018 01:16:38 -0700 (PDT)
In-Reply-To: <cdec466c-ecc9-b1d7-c637-04e63552c759@frm2.tum.de>
References: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
 <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com> <cdec466c-ecc9-b1d7-c637-04e63552c759@frm2.tum.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Apr 2018 04:16:38 -0400
X-Google-Sender-Auth: vk0NwI5PeO_qNM8hWf76Vx1fdZE
Message-ID: <CAPig+cSsTPKoLfcxrgD4+NhXa5AeWynxumo8Zed_PH-q3U163w@mail.gmail.com>
Subject: Re: Test t2028 failes
To:     =?UTF-8?B?SmVucyBLcsO8Z2Vy?= <Jens.Krueger@frm2.tum.de>
Cc:     Eric Sunshine <sunshine@sunshineco.us>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 4:01 AM, Jens Kr=C3=BCger <Jens.Krueger@frm2.tum.de>=
 wrote:
> The actual2 file does not exists, if I call the ./t2028-worktree-move.sh
> with the '-v -i' options, only without any option or with '-v' option.

The content of the various files looks correct, and absence of
"actual2" implies that one of the grep's failed, which is very odd
considering that "out" has the expected content.

Using the "out" file you attached, can you show the output of these command=
s?

    grep "^worktree.*/destination" out
    echo $?
    grep "^worktree.*/source" out
    echo $?

I'd expect the first $? to report 0 and the second 1 in a working installat=
ion.

Also, are you using an unusual 'grep'? What does "command -v grep" report?
