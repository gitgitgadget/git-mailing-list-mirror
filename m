Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25E720248
	for <e@80x24.org>; Thu, 18 Apr 2019 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbfDRScZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 14:32:25 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42798 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390330AbfDRSA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:27 -0400
Received: by mail-ot1-f48.google.com with SMTP id 103so2419900otd.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qv2HaH67MYpHlvxhVlmKg+rHM7jMoqDf9qcIy03+knI=;
        b=ZBn8YrRTuJklAmPSm2lVo1xRjwbaJlYy0m4t+uD3AP3YiCiGRPq0R3ZANNTpySXOup
         /hoYgEtDYX/fOXQquy7Y8HeyIEEivKihcP0FvZJDLEoUHi0pB6cSkENsJ8RjOqOqdyZw
         Hx09Gz816GXvdaQhGkJqtpCXrs9NWfbBlIMz7yUBBAHkv+s3BZoxdVpSlcie1dhbcUvt
         nMladgGx9P7RsLkG3DPDP+4S2fO/HqyzL/J4tO0UFxPLg/fr6NOEhJLAEJ823osbMZWS
         elfgONznBGmjmdRCf9BCQjMYbEf8uf5B9zEyxqkO3B4LjfFDrPT6VzhuNMfahUQqyrx4
         /GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qv2HaH67MYpHlvxhVlmKg+rHM7jMoqDf9qcIy03+knI=;
        b=W9P/7F7hvus6QGi2YxZkl/raFyRtA0XgNUOSRxyUdQ04yNzPinMjcgPX8/+Z++HB6A
         FFYVDF44jqwH0/WoauvDymSuZGDVp6fi9zbt4Ocllgfghj4L6s7ISjkzz8hH3+NGVXS/
         F/tnQMxcOhBAc0RQGvwJY9d/LIrQF34gZVZJbSWwsA9faPI/b/iGNa7ngSqfF0NLeBz9
         ADBn7raDgeuPYtJlA1j/E1YONWRo+Qe33Cue3U1AubrjeASFqgha2fndsUhtnGYesvhu
         5RfQal373Gh5xddo9avFEZc6UOOB7vMEF8ZTHksJQ4DKoUcVmoJgJkE8ME52gScSmdWm
         UqNQ==
X-Gm-Message-State: APjAAAW9HlYxO4jFm8CqTtyI/GmJr7D/0LvgTNkMh0q41IN65U07e9II
        vtpjHUocXkpF7KDmPc9dfeMfFBoeGoCNqibgr0A=
X-Google-Smtp-Source: APXvYqzKTNFqVHfknqjB894MTck70vcPvJYohIo3C/UcASfww+ZeIcH4zocZ+axbKosO/pLF7Syk87ynblXolPqM1XA=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr40397673otb.20.1555610425967;
 Thu, 18 Apr 2019 11:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
 <878sw8bbby.fsf@evledraar.gmail.com> <xmqqtvewgj4c.fsf@gitster-ct.c.googlers.com>
 <86o953z0b9.fsf@gmail.com>
In-Reply-To: <86o953z0b9.fsf@gmail.com>
From:   =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
Date:   Thu, 18 Apr 2019 19:58:23 +0200
Message-ID: <CAGV3M55di4Nc_x25RoT0=dREkeCVc5_LpNabEjVDF+mSHK+0nQ@mail.gmail.com>
Subject: Re: Feature request: Allow to update commit ID in messages when rebasing
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 7:32 PM Jakub Narebski <jnareb@gmail.com> wrote:
> Well, what about limiting changes and rewriting only to the commits
> being rewritten by [interactive] rebase?  I mean that we would rewrite
> "revert 01a9fe8" only if:
>
> a.) the commit with this message is undergoing rewrite
> b.) the commit 01a9fe8 is undergoing rewrite in the same command
>
> We could use the infrastructure from git-filter-branch for this.
>
> It is serious limitation, but that might be good enough for Giuseppe
> Crin=C3=B2 use case.

In which case you need to change the ID of "revert 01a9fe8" _even if_
01a9fe8 is not involved in the rebase? Wouldn't be a solution to my
use-case an already complete solution?
