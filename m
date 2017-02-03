Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3291F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 08:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbdBCI75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 03:59:57 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:36634 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbdBCI74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 03:59:56 -0500
Received: by mail-ot0-f182.google.com with SMTP id 32so9838350oth.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S5QJ14Qsg6u7Xfp95rATVuKTut8/FqrN7lnB9sdOuuk=;
        b=GRwEmUhok4ex6UK5rwyqE98AhGFMGYK6V79HwYjo3mcBe31y4RRLREQGKbheX8vxro
         e6aafFODlHfimSh9trP2i062x5jbxWywMVPfvt5C+fDWe+oFbpiK+J7KF45xNQuoM9Yx
         8hYIjNq82piYI4lFLVrUS/GamWpu6wAdzF1PDf6RMhFqM9qYp+GVmMXIfl4ZHzhv/M23
         loZKVQ8ENgqy0tBTw6mri9GQIcClbDBd5x5q4h2iHt60ImLnsZJUUlCWt3yyX2JTkXnc
         a5rMYcn+ixLtgzxvcmcgv7PvTeL3KNzEtlPx09D94AdUvsV1xl+zlTOQGJLPmOjHcF+S
         pcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S5QJ14Qsg6u7Xfp95rATVuKTut8/FqrN7lnB9sdOuuk=;
        b=uNOUyW0TzgKBVqy7t+WbQrbiZ+yaEzFE85TI3O2krsHx01vAS66AD3icjLQP7iU3Zq
         giozpza0HPBVzXXQQgCh0+sqfRNDAV74a1NvBxkQTDRdWazk1fuAbDHZFkwAVnASSZ+f
         B9EwJDThJhMGD4T2Dflk3S4Ezt/lVDrIFVWtNlTkYFOOk+0PpMEMKkQUVzVJEtSyYcEh
         oY0ubjVbWDAZOVC3/oT/P4XAvew6DvHAOFItBwtl3lwHCgzTw69xrH3U0IVA8pfF93NG
         7Qd1bsfWCVqfDILsJAzj09zqooSIW76u/hd2qHvBuddEjJJcJPf3man0M+i9TFqQ4LZc
         clgw==
X-Gm-Message-State: AIkVDXL+hm3OjhuxtKJ7oOfo3Sx/FtpsK7/eaMFh+CpG05Qs/kJgvUxa8zNE8n429FmWce8PEq1IST+zBx23aA==
X-Received: by 10.157.46.226 with SMTP id w89mr6872915ota.225.1486112395828;
 Fri, 03 Feb 2017 00:59:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Fri, 3 Feb 2017 00:59:25 -0800 (PST)
In-Reply-To: <xmqqmve4s5r2.fsf@gitster.mtv.corp.google.com>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox>
 <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
 <alpine.DEB.2.20.1702021043110.3496@virtualbox> <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
 <alpine.DEB.2.20.1702021136210.3496@virtualbox> <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
 <alpine.DEB.2.20.1702021223320.3496@virtualbox> <alpine.DEB.2.20.1702021330040.3496@virtualbox>
 <xmqqmve4s5r2.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Feb 2017 15:59:25 +0700
Message-ID: <CACsJy8Cq8sY1hL75Xs_MMr9r_+jjr7p+58D+0GhT3mgSgiUEtg@mail.gmail.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 3:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Also, the more important reply was Peff's reply that suggested that the
>> proposed fix was incomplete, as it misses --unpack-unreachable:
>> https://public-inbox.org/git/20160601160143.GA9219@sigill.intra.peff.net/
>
> While I think that --unpack-unreachable thing is a symptom of the
> basic approach of patching things up at the wrong level, if you are
> hinting that fix to the issue that gc does not pay attention to
> various anchoring point in other worktrees is more important than
> adding new commands to "worktree", I fully agree with that.

Just to make it clear. It's not like I put new worktree commands on
higher priority. "worktree move/remove" was more or less ready for a
long time and the gc problem was blocked by ref-iterator series (which
entered master a few moths ago, but then I was busy with other things
and couldn't get right back to the gc issue).

You didn't answer Johannes's rhetoric question though: "It should be
possible to do that redesign work while having a small workaround in
place that unbreaks, say, me?"

I assume "the right way" is still updating refs subsystem so that we
can have a ref iterator to traverse all refs, or just one worktree,
etc. Should I keep looking for a middle ground (maybe better than the
linked series) to "unbreak Johannes"? I ignored all those comments
(about --unpack-reachable and bisect refs) because I saw no chance of
an updated series getting in git.git anyway.
-- 
Duy
