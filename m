Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4FB20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbdBQOyY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:54:24 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:36803 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934066AbdBQOyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:54:21 -0500
Received: by mail-ot0-f182.google.com with SMTP id 32so32791767oth.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mnV9u1v3x+1GooHz2u840CqO9zsl+56hDuDPFZR2ds0=;
        b=g6C+CX+a+XP8x/7VaeE3q6IAFUMnxG+8I5VrP6CMN2vVjzHzwAPLJaV2ydohZ8wVue
         NYV5xXMBnTkpoShrqtjacMOCclPkylBzLSdTfXojgq79yH/Vi+KEI/im9ZRW20RWUVLx
         YQsz3pZGd480n1zc99iarxhjv6aHP1uxJRG4dgtij5qcQAGceas9aabkJ/rzAfy4mCQy
         7xt+R/oKcfmX6KTXFNzC99rktK03WIKOO+wgaIjSSJFnsi+ZA6N0gaAGpBIOBSEi0zV/
         MaUNI61MaPB8E3UXIcDjN+pB4+VzXJpbg6FztuM0ucuNdzgtrPPT/TP0WjqYEI1/Mvz8
         qHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mnV9u1v3x+1GooHz2u840CqO9zsl+56hDuDPFZR2ds0=;
        b=QufcD6sT2VyZ0rELqwqFs611EGxurm7l1rcNMV7iRM2hbW94i8Ev9INNbwtsD692ut
         V8Z4/VsajLGHbkJxCH4QRnpw4PNM8XeprTN4ia6KqaVl/rh54I3Kc88kJ3baiiUp/IAq
         PtlGM8wXItWUGwfxF9Ek6imfHaMHfaEbDEgVl8B2po4oaJd7KjPfH88TAZ53J7g3MYBi
         wys+wiLKW5jtkkW6D0Qer8kAT0ocTTgswDxYxhfSvP5MGZTjsuZD+M4aMopJpMsm6/LN
         zwxwrpLKoxOsybRGj1Y8kHCdB68sgbmwgrJNxbf+hcgQh09Pc4Bywdc2rbW0KhPliaV7
         6Irg==
X-Gm-Message-State: AMke39m1xHzK3N9EexBY3sLrKgWxRiKXVCDQNEakJ0wlJP66dkWmlkeZUpuiensBCs8Tj4zWBeA3slAdCoU3dw==
X-Received: by 10.157.27.11 with SMTP id l11mr3963252otl.199.1487343261029;
 Fri, 17 Feb 2017 06:54:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 17 Feb 2017 06:53:50 -0800 (PST)
In-Reply-To: <2C8817BDA27E034F8E9A669458E375EF11886C5A@APSWP0428.ms.ds.uhc.com>
References: <2C8817BDA27E034F8E9A669458E375EF11886C5A@APSWP0428.ms.ds.uhc.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Feb 2017 21:53:50 +0700
Message-ID: <CACsJy8CTL1GUreqNVBYyu2EqqdiUxj-dOOE9=Rr0ivK6-7yKjw@mail.gmail.com>
Subject: Re: new git-diff switch to eliminate leading "+" and "-" characters
To:     "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 6:01 AM, Vanderhoof, Tzadik
<tzadik.vanderhoof@optum360.com> wrote:
> The output of git-diff includes lines beginning with "+" and "-" to indic=
ate added and deleted lines.  A somewhat common task (at least for me) is t=
o want to copy output from a "diff" (usually the deleted lines) and paste i=
t back into my code.
>
> This is quite inconvenient because of the leading "+" and "-" characters.=
  I know there are shell and IDE / editor workarounds but it would be nice =
if there was a switch to git-diff to make it leave out those characters, es=
pecially since "--color" kind of makes those leading characters obsolete.

Color wouldn't show you new/old empty lines though (unless you use
different background color, but I doubt that looks readable).

> Would it make sense to develop such a switch or has there been work on th=
at already?

I face this "problem" every day, but most editors nowadays have
block-based editing that would allow you to remove a column of "+/-"
easily. At least it has not bothered me to think of improving it.
--=20
Duy
