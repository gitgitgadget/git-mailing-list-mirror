Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B6D20248
	for <e@80x24.org>; Thu, 28 Mar 2019 03:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfC1DAE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 23:00:04 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:39922 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfC1DAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 23:00:04 -0400
Received: by mail-it1-f170.google.com with SMTP id 139so3695246ita.4
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 20:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+cL3pdHr6SAT2ETxqjQ5CMpDjhOrbwCY6Pv5sQv54Y=;
        b=YBmZKPvuc57NbfxRpo2XXvdQwd2tRYNg3HDuvGpLbj2ankoHgPWgwxR0QvAdrYtbbN
         KQYPlpnLga9CxUJuuu5s+5yCa58xdepM207vRwBNrpF5SslnhiROZi99rdDQ8QXSjj6R
         iSRQ5LLfuHwLTt1X9N3qMag9LRMKl/QQ4FgJgyYdpDGO/1oKsExb8PvOJ6g59Uqc1iWg
         ZXqZcCACVDLDWOlEc62kfQtJatAbXNblr+kkBll/YebTVCI9JGRX+prXNAr/W1idueYv
         iqms8+CwMhSZzLTvDbD5bVk6twJxVAz9ztoUF137KI+T3Kn082xhTuf29zkjlANaw/g7
         iZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+cL3pdHr6SAT2ETxqjQ5CMpDjhOrbwCY6Pv5sQv54Y=;
        b=Du64nlrD9sidT9ZTAR7eFAKaQCnD1xHzrxRB25qrXnkqgcv85RJfiRHhcW7e56XUNG
         C8vD6g6KaCpOLF4E6puvhJ/6RvwCDOX/Days7pGmyRWaJKK0HSksTuRfYzOWHUVK4ggS
         gE4wQdamUrvCV1l8kyysQTnURFpWmhxylgIssaAtsl7oUI/k3rbKToC8Zqrqs/CjQMJs
         ulEg1SRVPoZKS5Toj/hZ7bGSwv21mrmsfpNzIkJAiablCVqbRv8gBVViRA8dFlaa+cty
         HKlLFb1saORFHoLcj0KfEAp8XU9tv1/P1PpXDiReukz/ncX3EQJJI7zL73Wq/jyPDF6B
         yHow==
X-Gm-Message-State: APjAAAVoMtLYThRJI76TX5pEME6rl/8yScFoEE6slfbTClK3gz0wz2Op
        Broih1DFw7lJvker0tB1lB7PiagBZlfYdCRqVGD7A7Jx
X-Google-Smtp-Source: APXvYqztShiwqosDdlOlR0Tqt/TFc5/0muT8I4Tj1tdD60ncYfOU/1g0uz9GSlHgQksCx3sxP/LOGt/bO0cmJhHMrXI=
X-Received: by 2002:a24:9dca:: with SMTP id f193mr5769653itd.72.1553742003580;
 Wed, 27 Mar 2019 20:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-F8cmzOuhi6zeJJ13iwGh_ie-uTiJYUzBwssvH+kCY+yA@mail.gmail.com>
 <20190328014957.GA7887@sigill.intra.peff.net>
In-Reply-To: <20190328014957.GA7887@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 27 Mar 2019 19:59:52 -0700
Message-ID: <CAGyf7-EeeuaHKwn776i4YfFEX_rckKoszvn+K5mtD-aAafT=7w@mail.gmail.com>
Subject: Re: Puzzling Git backtrace
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 6:50 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Mar 27, 2019 at 05:49:27PM -0700, Bryan Turner wrote:
>
> > I'm trying to assist a Bitbucket Server customer who is seeing some
> > "git-upload-pack" processes "hang" on their server.
> >
> > While investigating, we had them connect gdb to their processes (which
> > are 2.10.0 built from source using a simple unzip-and-run-make
> > approach) and get the backtraces for them. The output that they're
> > seeing makes no sense to me, though, so I'm throwing this out to the
> > list just to see if anyone has any idea how the processes could end up
> > like this.
>
> upload-pack didn't become a builtin until v2.18, so...
>
> > When they attached to 32433 and printed its backtrace, though, things
> > go a little sideways:
> >
> > (gdb) attach 32433
> > Attaching to program: /usr/bin/git, process 32433
>
> The debugger needs to be using git-upload-pack as its executable, not
> "git".

Derp. Of course. Sorry, clearly it's been too long since I used C in anger!

Thanks for taking the time to point out what should have been obvious,
and for doing it so kindly!

Bryan
