Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F95520195
	for <e@80x24.org>; Wed, 13 Jul 2016 01:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbcGMBxa (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 21:53:30 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34783 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcGMBx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 21:53:29 -0400
Received: by mail-yw0-f174.google.com with SMTP id i12so30343281ywa.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 18:53:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KwtMPD8vHOP4tG1d8ezKaO7IOyTBRE4Aj0W6sCrF44E=;
        b=xfLBpFoQkH10HU/gLlAc9C3McYFP2IVYOg9BPjg2DnTWfwZtIloX/Egz4m9JCSdgG1
         Tz5mWwMX5tuwu+W4xGDHv32S18QMjsm+3byNoUHl9yuloHiVFXHKFlD7k+wRM6kH+Kcu
         xHTf/cOpTnO2i+gq54CjBkrCrrNgyTZ+YwE+qhi3k5fio+grlwJPC4JXC4HsTq9g4zFg
         1k57jTifEpeCT9cv0mz0PTmrGmqhSv6tlFShq4WH5eDftXY/rKxmYUKECh9LmgjTK4kK
         PMVOZKnmFoMkHrfdotaqczPnDgoNGIob2QgvUCdBc9Dusnbc5JrXm0u4FWI2zYI7IyzO
         jZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KwtMPD8vHOP4tG1d8ezKaO7IOyTBRE4Aj0W6sCrF44E=;
        b=Y5yN9ZnIDluATKU90t6xxJrQ/WyP+ukLMJNbgLrgo7e4GriAGz2Xrq1gyMferw1ARR
         73u/GphVmQNsCcjjk24wboRw970sWCO/AYvAEDjyxrPafIe6/VBjjCLAT3wN400u2qdy
         xNU3s24FT8y2UmN/JF+jIvNfFOyR2lr8I3MAetGSh4dyYbWKqKSmGTSRc1TcJ2zNM3op
         u7+d5N/Rn28nWY/Ra2T8vsdixekmN/y+BErSn837qvHdsb5lynRQbv2z2wpDkURrECiS
         KWhOBr14VnJALiYV8obBJnXaB9UiEhwTPdXuYMJV6tx8SW96+Pje6fOUEt1C+Q4N8Wcq
         cIXw==
X-Gm-Message-State: ALyK8tI3dPl/2wQxwYpKTyWzkEJp+01mcR+RoFvRjOsry9LoKAiwoMs5yGdcHFTWnNoKD7pdaIAZ+M05ok+dhw==
X-Received: by 10.37.111.69 with SMTP id k66mr3931157ybc.47.1468374806948;
 Tue, 12 Jul 2016 18:53:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Tue, 12 Jul 2016 18:53:07 -0700 (PDT)
In-Reply-To: <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 12 Jul 2016 18:53:07 -0700
X-Google-Sender-Auth: vx4lfl4cufINH7yV-VCDrM6Umqg
Message-ID: <CAPc5daXx=C82whkmoxkO7JSdG5gd=W=M4L0xsvQb12U2TKLJqQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.9.1
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 11:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Let's do 2.9.2 together, as this is not limited to GfW.
>
> Taking Peff's suggestions into account, perhaps like the attached?

If I can get positive comments soon enough, I can do 2.9.2 early
tomorrow my time.
Or a reasonable counter-proposal (including "without Peff's
suggestion, because...")
would work well, too, for that.

Thanks.
