Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7976C1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 15:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeDCPVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 11:21:40 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:42728 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeDCPVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 11:21:39 -0400
Received: by mail-ot0-f175.google.com with SMTP id h55-v6so18278755ote.9
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gx2tfE2nj1Qo2xM5pLLWHBexRI/WvBF0ndJ1qaw/S/Q=;
        b=ntoEMqcMTcnholR+iO/HPQQpn0fzZAGLekm0/bPNa/GyTpKDoUDYaoy4m/nyMCQac3
         JGv4yG76yikAvkQ9P5H/C8fzmoWU9Wdm+C11ddr99n2XMP50QRKkWqvQ0AfeLgiWXnCD
         WoTk8tCkh+bzah2qCOsHWyOw3/pbGU7O9al77uhs5YG0ypKO1UJDr+u0A8nPzaArgJww
         4vjfs9T+Hrgect3tcxI5ns19iwAStBKWaTIWYhlhIHxBR9vPEQD2k9Kyw/2toK7CsmBq
         3cyuXXoBd+TkN959JaXnIFEzF50a1TpVZ8nwrAw9+W7/iFJpJRdUpwJZWLtq2sLC85T0
         jqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gx2tfE2nj1Qo2xM5pLLWHBexRI/WvBF0ndJ1qaw/S/Q=;
        b=UBCTPcnUhFW6jhVNLvyDyqSNb2ioFMhUHIqGPxdkWLdnPUURLERW+6+biK4x3MOg74
         5wl8m9xj8UQ+ZFpJqfIV53DxPuRTxiMKD5XiLvTa5XyfggtPCHdkBndn51T7HpWRYlo3
         jZ+0cP0HuWwAxu5F4odjPIH/SJN8dYlNtaeIIBK9g/rgUcuWdDfV83TP/i+AbdbK7wmo
         YhdDhtHDysWhsvX9Din6elHXZmutVcAU8BFgMKHSla+P8KdPAQ+AKkI7v2h8z4mxCwjX
         ook4mfRiO0lmZ07ruAqf3xg1N03ZLqs5Ugf2ZEteK/1D4Y1etlRBM9qMwgMBeeqVV93p
         yKRw==
X-Gm-Message-State: ALQs6tDwSbinmph9VGCrQNVWeqOxB9v069bQHSv6etD2kZdnZgxsjSxK
        /wDsyzljuhI2KXXHiFeSFRqa75+LCNP2NtfTQ2U=
X-Google-Smtp-Source: AIpwx49aJS4n8zXWc9VISzsp+woljCk1RgkXZgxYfLmUxuq4AJbL7ygD7tjJJsQ25NisA9/N4k+c8Shye14z0iHxyWg=
X-Received: by 2002:a9d:e84:: with SMTP id 4-v6mr8780676otj.14.1522768899390;
 Tue, 03 Apr 2018 08:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 3 Apr 2018 08:21:08 -0700 (PDT)
In-Reply-To: <20180403092541.43920-1-sunshine@sunshineco.com>
References: <20180403092541.43920-1-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 3 Apr 2018 17:21:08 +0200
Message-ID: <CACsJy8DszXXK2htRupg8FhdcSgYweCv4FPAA_ZG23YKGz7AG=Q@mail.gmail.com>
Subject: Re: [PATCH] t2028: tighten grep expression to make "move worktree"
 test more robust
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?SmVucyBLcsO8Z2Vy?= <Jens.Krueger@frm2.tum.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 11:25 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> Following a rename of worktree "source" to "destination", the "move
> worktree" test uses grep to verify that the output of "git worktree list
> --porcelain" does not contain "source" (and does contain "destination").
> Unfortunately, the grep expression is too loose and can match
> unexpectedly. For example, if component of the test trash directory path
> matches "source" (e.g. "/home/me/sources/git/t/trash*"), then the test
> will be fooled into thinking that "source" still exists. Tighten the
> expression to avoid such accidental matches.
>
> While at it, drop an unused variable ("toplevel") from the test and
> tighten a similarly too-loose expression in a related test.
>
> Reported-by: Jens Kr=C3=BCger <Jens.Krueger@frm2.tum.de>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> t2028 in 2.17.0 can be fooled into failing depending upon the path of
> the test's trash directory. The problem is with the test being too
> loose, not with Git itself. Problem report and diagnosis here[1].
>
> [1]: https://public-inbox.org/git/26a00c2b-c588-68d5-7085-22310c20e6df@fr=
m2.tum.de/T/#m994cdb29f141656b0ab48dd0d152432c7e86fc20

Thanks both. It was great to scroll to the latest mails and saw that I
didn't have to do anything else :)
--=20
Duy
