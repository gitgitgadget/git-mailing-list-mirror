Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2401F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbcHPP6d (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:58:33 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35639 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbcHPP6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:58:32 -0400
Received: by mail-yw0-f169.google.com with SMTP id j12so45703169ywb.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 08:58:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=25Kt9KyzOpMcVr6MQrKv1j6tpQL1VMwP40QEE8cob/U=;
        b=VLY+MjwEkE83JTeKMjjwTr93ynoU9VesD/K1X+NmdIvynh4iKkIcmgXFi9SEdfOarm
         axmq3jKGUd5xAHFOZQ8hF8nv/RrtiVS/nJgFts8v4mkQRT8h13r5UYYtgMkzM7f5f0EU
         8QMVkRDI9UUmj++P5ciIKDDS0a0y0gDuzDtBV0EUKSCxfmBaUb2Cvbc1N1yi/oWkGyMC
         UzNfLcAtV3ye+ZuyE2cAe5TGQbHUQzP3f3OkZzG8efc5rl9wfVjVZ8w64OBKMXgjMQ7g
         8ZRMIGsIHsRF2X8AqELxrZavY4+XwC64njFn3miGXqOnd6rApSEnotzGGBDCMH5MarOS
         lN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=25Kt9KyzOpMcVr6MQrKv1j6tpQL1VMwP40QEE8cob/U=;
        b=UtNPBMSYH6cZpEK+bNszP1fdECq4g06wgTSPClfBdas1dE8M8oJL91CoMboKsqFGep
         sk94DTmYlXqg8tfdjUCHpLdwrKwftJl06SDlE3ipkhvBkwEvxeeV6WncyxqQckF6/f7x
         CALrjb6dPt4qmpMPEoYcK0OuOKqNjX+53fPUCNTeQV/sigymK2LucxD1rBoLH9BllVPW
         EWNZvIwLFA7RzchxLdzTo6q68yUV164neofBYLEllCSQeiI8BZatxM5uoipCCIuy1yuD
         WRy16oFk41HMBKQcD9qlu9uFwYN7AGYDXr7CgpqosF4/tOZcL1EQvLpL/aJjZEnHlBWq
         fo4g==
X-Gm-Message-State: AEkooutK9Ai623I8ZtO2nzoJjbrBzP6zQJHj2b4uAlPF0b7cGA82mc2WjAcDyPpZdhthexjXLltmZUnm9TjxUw==
X-Received: by 10.13.249.135 with SMTP id j129mr27120075ywf.267.1471363111956;
 Tue, 16 Aug 2016 08:58:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 16 Aug 2016 08:58:11 -0700 (PDT)
In-Reply-To: <CAC+L6n0j0=6haBprM2ip75=orEi_5oBedHV1iPBTgi-N8Y6=4A@mail.gmail.com>
References: <CAC+L6n0j0=6haBprM2ip75=orEi_5oBedHV1iPBTgi-N8Y6=4A@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 08:58:11 -0700
Message-ID: <CA+P7+xpe2FeBjO0AEHTyuZPEOpCUmt=vUcs5RFYhE9KTZWLNhw@mail.gmail.com>
Subject: Re: Credential helpers processing order
To:	Dmitry Neverov <dmitry.neverov@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 8:13 AM, Dmitry Neverov
<dmitry.neverov@gmail.com> wrote:
> Hi,
>
> I wonder why credential helpers are called in the order: system,
> global, local, command-line and not in the reverse order? This make it
> impossible to provide a custom helper and disable default ones via
> command-line parameter. My use-case is to clone a repository in a
> non-interactive environment where a system-level GUI helper is
> configured: clone hangs since system-level helper called first and
> there is no input from the user. Also if a system-level helper sets
> quit=true, then lower-level helpers won't be called at all. Is it by
> design?
>

If I understand correctly, the credential helpers aren't supposed to
require input so it is assumed they can be tried in sequence if one
fails? It might make sense to reverse the order though...

Thanks,
Jake

> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
