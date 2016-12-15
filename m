Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176351FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 21:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbcLOV3v (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 16:29:51 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36480 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbcLOV3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 16:29:50 -0500
Received: by mail-it0-f68.google.com with SMTP id n68so363387itn.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TJ8m1RE77etYp+Ai7VwOeiOrP/HbymumFgKz/f4jYvM=;
        b=E+rl2Q+kxIo8QomXHTLx4fUAKlLJg/VE7a5GXWcsc6x9hYY9i1PG3wf3Mss6qF1hef
         7JgcJFUPeT98rrPC01Gfo/4NkJ7Ru1i0zuedqxot6xoWFBf3eLqSBdKRofD7XW1Oljft
         qWZYstsbS+IS4L1JGtPT4T6+MX0+urMZekDM9UHmcWGiBQ5nDvRhFZbosh41ujT90RAF
         nNaaw3Szluc3yIsbZW+4wLFog40V64NIFSGxBAYz78hhKqrDX1lNj/OxjYQ5fur89peB
         6+f6qdEKK7ZakaFYJtblG3YUgjf5w4y3LkjOkpBWs3GrbDIaxa64JzP3Cx+dxlSx+ahy
         M4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TJ8m1RE77etYp+Ai7VwOeiOrP/HbymumFgKz/f4jYvM=;
        b=S6JZWW+BvU5rdv21ew+LUJIU17r8jsnePaMHE3li8AgFb2EadgaCNiweH0Ce1mIN9r
         pexk+vyicHOnmIOnLNH94cFzSP9gUITqx86CRwCFFKgTRqRCtAgxrQCHcxuIyixJR2LC
         zw546f+z3zzOrdZopGLbhudeddapo3VcNLw1+Z9FkTvdR618cIbGAbuGk0/3UeI4frZu
         3nlY5L1NxRbY3rrCmSKFMg83D6ioVlIvUnXbXBZUE0ea6GnnjM0D7pv1VyGy6V2NPg15
         OuAvPX0s1vNVMoIUH16R++BjemhOOwkmEJMD3QFyhE+TRtw4vK0OevnrM1J2IUoCjQOy
         xB0w==
X-Gm-Message-State: AKaTC01q6YDOdKtakQxePc5sdgPZb8LBIBglEUS89wan2g5Hq/fcG5dpvaAdsThzHTIF8gRUWVXQVUarFzIDVA==
X-Received: by 10.36.148.84 with SMTP id j81mr385272ite.35.1481837389333; Thu,
 15 Dec 2016 13:29:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.65 with HTTP; Thu, 15 Dec 2016 13:29:47 -0800 (PST)
In-Reply-To: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2016 13:29:47 -0800
X-Google-Sender-Auth: eyVE255TB9PRieJrLioNw71boD4
Message-ID: <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
Subject: Re: Allow "git shortlog" to group by committer information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a ping on this patch..

On Tue, Oct 11, 2016 at 11:45 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> In some situations you may want to group the commits not by author,
> but by committer instead.
>
> For example, when I just wanted to look up what I'm still missing from
> linux-next in the current merge window [..]

It's another merge window later for the kernel, and I just re-applied
this patch to my git tree because I still want to know teh committer
information rather than the authorship information, and it still seems
to be the simplest way to do that.

Jeff had apparently done something similar as part of a bigger
patch-series, but I don't see that either. I really don't care very
much how this is done, but I do find this very useful, I do things
like

   git shortlog -cnse linus..next |
        head -20 |
        cut -f2 |
        sed 's/$/,/'

to generate a nice list of the top-20 committers that I haven't gotten
pull requests from yet.

Yes, I can just maintain this myself, and maybe nobody else needs it,
but it's pretty simple and straightforward, and there didn't seem to
be any real reason not to have the option..

                 Linus
