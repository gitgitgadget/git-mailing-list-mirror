Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210B420401
	for <e@80x24.org>; Mon, 19 Jun 2017 00:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbdFSARI (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 20:17:08 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34755 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdFSARH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 20:17:07 -0400
Received: by mail-pf0-f182.google.com with SMTP id s66so46096924pfs.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnZR0Efpw1ZzCi3KqxMLuX2qYg89EAzJOYeBc6EC8BU=;
        b=ZdfOlpWvu1jAbL6PK3wjTfnnbn1G2/gBuqhZNMbCDQ3iOUCgEu43UVRBqBCBoZa/0C
         Btk94TuYmqMz1QCh4F24b51cHEk/C3KrF1SudEClQcpV/eaOlCvh7VX9J2lgbdI7Puq6
         R97PyJ2FcomZxBKrEqhuT2aDepfepHIj9Xt4RJ0VWQmnHzSzBtKYpn//fCTEnDeQNRdC
         W7eW/7ssgNhDvDZ0RhjHbYlgyAlvqaM4XVeCzVwONl5sYRTRi1eGZeavuMq5iOPSoYLd
         o72dcDnAHQwZJp/TKUex7q/Wg+UuKN62oIgGa8X+tf8/NaquyujoNVtyy0nHEXWMpx56
         lpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnZR0Efpw1ZzCi3KqxMLuX2qYg89EAzJOYeBc6EC8BU=;
        b=nHF99GhoBM1gMXtxP0SqojxRbYGeZtW49C3smRhrlKCdg4TuXJSeH0OjFrpsWsA06W
         8M6qK68Wczu5k6qjrGReZ+O3EzQUGb6frKgPlx7Nzdxmy9QuisIDOeZHaGH6xtKFOvra
         5Usd7I3UrkKebH1kJfyIFdLPNRIc+uVlQ9L6dadWagL97gg15W9s5rYMkpCrwkIj409f
         zGFgfroxQyWGn/bC6qlYvRfwO8zHiNJS4416qTjKC/oseBlbhQTCmQxWgKgW7Eb7/Mc4
         T4Tm0fWdsf3/1sMeI2jqhomA3t7i4ydGsDidcXiawucgiZcwN5aggoqxI4YBDtF4OqoH
         EVHA==
X-Gm-Message-State: AKS2vOy98F8OpwWNuw5gtKPtm35J096sOd3gR5hdj9mS8ZKs6aimlnrC
        Bf4hSl7ym9u4ow==
X-Received: by 10.84.128.107 with SMTP id 98mr22038847pla.285.1497831427018;
        Sun, 18 Jun 2017 17:17:07 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id 62sm17733483pfr.90.2017.06.18.17.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Jun 2017 17:17:06 -0700 (PDT)
Date:   Sun, 18 Jun 2017 17:17:01 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>
Subject: Re: [PATCH] mergetools/meld: improve backwards-compatibiilty when
 using "--output"
Message-ID: <20170619001701.gvyjdrohsv7scshc@gmail.com>
References: <20170617102454.2040-1-davvid@gmail.com>
 <CAJZjrdX=8DbRTsdJ+bH5BABJG0m=y2QpT8C4kFviUsxVqVLVLg@mail.gmail.com>
 <20170618074603.epf3vhsi4pevg6jn@gmail.com>
 <CAJZjrdVU7h6RCd7K2hwFbZfo-6ifiKeh3dYdz7bdNzaPzCRXCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdVU7h6RCd7K2hwFbZfo-6ifiKeh3dYdz7bdNzaPzCRXCg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 05:11:48AM -0400, Samuel Lijin wrote:
> On Sun, Jun 18, 2017 at 3:46 AM, David Aguilar <davvid@gmail.com> wrote:
> > On Sat, Jun 17, 2017 at 10:11:36AM -0400, Samuel Lijin wrote:
> >> On Sat, Jun 17, 2017 at 6:24 AM, David Aguilar <davvid@gmail.com> wrote:
> >> > Meld 3.16.0 requires a "=" in the --output argument, as it uses
> >> > a simple hand-rolled command-line parser.
> >> >
> >> > Newer versions of Meld (3.16.4, and possibly earlier) use
> >> > optpaarse, which accepts either "--output <file>" or
> >> > "--output=<file>".
> >
> > Junio, there's an optpaarse -> optparse typo in the commit message
> > here in case you want to fix that up.
> >
> >>
> >> Do older versions also support both?
> >
> > No.  When the "--output" option was first added (3.16.0, or possibly
> > earlier) it used the simpler parser that does not undertand the
> > "--output <filename>" form.
> >
> > Much older versions didn't support "--output" at all, so we don't have
> > to worry about them since we already use the "--output" flag
> > selectively based on whether or not it's supported.
> 
> It sounds like this patch would break versions of Meld that use the
> hand-rolled parser, then.

I don't think so.

The whole point of this patch is to make it compatible with the
hand-rolled parser.

Before the patch:

	--output <filename>

After the patch:

	--output=<filename>


The form with "=" (the latter one) is the one that's maximally
compatible.

Please re-read the commit message and patch to verify that this is
indeed true.
-- 
David
