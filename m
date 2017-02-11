Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F0F1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 18:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdBKSNq (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 13:13:46 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34420 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBKSNp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 13:13:45 -0500
Received: by mail-oi0-f67.google.com with SMTP id w144so4455263oiw.1
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sDLFCvoviMTNo4l+kQ7LiSpLzzlxES4ViQcxxDOR46Y=;
        b=S91IttKclB/3x7k3z+hhzHaU83r4TSEWa+eMVrHUrjUaWTP3ZS23xqIAlEujngegrJ
         FFJntJsLXVAN+JrrCz3FUwiQjv/Xxj34SdmboP8WsrOQFuBBrGWYBGkgzsDHcYktR3qC
         TLm5++TCU1JtMWEFqHduXHPFKVHnQm9cy7skIRIU+sddhhTl0c3+V3y/Pf8vEOkoN9pS
         q4HUd4E0f+J37s36hvLRuZ4hWYlVQFHSUVlF5nSyYput4PjOEnJtkFwTol70x6pnttgp
         +raMWDXyajHseWhgv8v6atI+lcuzbLVIYswAMaADqtjalBL49Cae8+/JOoGvaaGyWagi
         qydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sDLFCvoviMTNo4l+kQ7LiSpLzzlxES4ViQcxxDOR46Y=;
        b=kakP7G7UiNHkcTxR1dxDHvr0JpCaxwZctfAztSS41HW0EGWoVXHYUWCkZ2u25sUPHm
         8QfnfgUr7dx8AoKUqOuXLtGqxlFIamEdnCS2EnDv/I2xLG6WSjXyWwyJVC7Ztol9MuA6
         htg6Ka327sSOWZa9Zm/xEyaALZzkmgTTQyPJEYT+IVCR2/1rk45iqlbqi5acOpUzALmq
         tPw8WTNuhJdTaqLkKsv21gJ29Xg45WifBNxEiMuKxmQzf385MYBD/Wi7qcLHz/4TZUEz
         5oCCj+Kh2HG5NnqUaXO783CerPYZrH9urSE/s4/TYdBR4F53JD0DTRNYLV8oViCbLZfF
         fbGg==
X-Gm-Message-State: AMke39nfL2G71+Rf+b0cf6FvJ/rnc+jNkymOXMgDzW4y31l3SFFc+O2OHNUEp9mUSXBEs8Bn9crvEto/afleLw==
X-Received: by 10.202.242.8 with SMTP id q8mr8132626oih.129.1486836824772;
 Sat, 11 Feb 2017 10:13:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Sat, 11 Feb 2017 10:13:44 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2017 10:13:44 -0800
X-Google-Sender-Auth: H_JaOh5Mtz-jRhrl-DNmZ7lBNQw
Message-ID: <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 11, 2017 at 10:02 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've signed off on this, because I think it's an "obvious" improvement,
> but I'm putting the "RFC" in the subject line because this is clearly a
> subjective thing.

Side note: the one downside of showing the decorations at the end of
the line is that now they are obviously at the end of the line - and
thus likely to be more hidden by things like line truncation.

The default git settings (LESS=FRX) no longer truncate log output
lines, but if you use "-S" or "--chop-long-lines", you will obviously
be missing the end of long lines.

So moving the decorations to the end does obviously have a real UI
impact, apart from just being "prettier".

I just wanted to point that out. I still prefer decorations at ends of
lines (and yes, that's despite the fact that I actually personally use
the traditional git setting of "LESS=FRSX"), but it is perhaps
something that people should be aware of if this patch causes
discussion.

               Linus
