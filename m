Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD6720229
	for <e@80x24.org>; Thu, 20 Oct 2016 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbcJTSC0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:02:26 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34625 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbcJTSCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:02:25 -0400
Received: by mail-qk0-f196.google.com with SMTP id n189so5172936qke.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Qvj1UvZ2Vzzbpl6FzFpvZNrdxXlaMqIGiG8FkvhYZU=;
        b=RbA+cIl+EWplDR8pLyB7YgDpJtn/NBeZ9whqog+EOH3utgH2wKXizctdDuWAIJRU4X
         X+P3g/IWmeSrkgaKfGDqHBi9cLf85agJAFtV2Kk+uQXpAS3HixtJ/PfrKXKc8iMltk3n
         p0H5fujlPZ7K/C91jB5U+xgJIfWiV1QZAZ3c8SqLx0/x5wAHkmfJVoJBo/mLG48SBc8N
         Jr0xrfaVLMNp6v4B3dwWsfodES2DmYrQdjzqfpEwvaIvEOV4xm/u86osXnOgKDIvYluq
         1WOqyU/Jrz1IOT0XmxMF3b2MAHLXRdaoaVy3me2BQLnK269BhEdLrZDVc6r9jNjcpch3
         fLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Qvj1UvZ2Vzzbpl6FzFpvZNrdxXlaMqIGiG8FkvhYZU=;
        b=fN+N+8znpYuuUAx9U3Ag0GXAE5Z+46lb/+JsEzoX2KAY5oi9e08heq96Z8csMKjYmi
         9SBIZIaaMHLIM0jSBwYPXYbzBbxtldFi9rJQn/PkhKitJKAIc4UWhY+NA8kB2ssegQp0
         J5ky5QE4yQqSC9Z500tYNPB7AUD3GOEcX0dQJ5qMSJj1ditQQOd3gHHP07iyBfKhGDSJ
         cPaG4N44OY2F3sj1c/68JBYpK0mVW8aqXQcV+CVpSA1ofXVQWMu4ZVg/jKmC6gBZxK7k
         Zg1r6UWq1XjK1BJM9N6NsquOLgtFMA66KhtaN4316ktVlXnXbedqW7wcKlDqcHDk1AsJ
         MqmA==
X-Gm-Message-State: ABUngveYpL6hsaGl1N68Jpg0siOCx4ppEEUq/8hhHISQo4GjSzSD2Tmz4Hmwf8Cnlg7A4A==
X-Received: by 10.194.127.161 with SMTP id nh1mr1070375wjb.61.1476986544440;
        Thu, 20 Oct 2016 11:02:24 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id wh3sm80700896wjb.49.2016.10.20.11.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Oct 2016 11:02:23 -0700 (PDT)
Message-ID: <1476986542.28685.3.camel@kaarsemaker.net>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header
 mode
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net" <peff@peff.net>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>
Date:   Thu, 20 Oct 2016 20:02:22 +0200
In-Reply-To: <xmqq8ttkj740.fsf@gitster.mtv.corp.google.com>
References: <1476908699.26043.9.camel@kaarsemaker.net>
         <20161019210448.aupphybw5qar6mqe@hurricane>
         <CA+P7+xogHOCbPV+rx7yrur85m=HX5ms9kGQYvTpQ7n2i7Hzuvw@mail.gmail.com>
         <xmqq8ttkj740.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-10-19 at 15:39 -0700, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > Hi,
> > 
> > On Wed, Oct 19, 2016 at 2:04 PM, Dennis Kaarsemaker
> > <dennis@kaarsemaker.net> wrote:
> > > Commit 660e113 (graph: add support for --line-prefix on all graph-aware
> > > output) changed the way commits were shown. Unfortunately this dropped
> > > the NUL between commits in --header mode. Restore the NUL and add a test
> > > for this feature.
> > > 
> > 
> > 
> > Oops! Thanks for the bug fix.
> > 
> > > Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> > > ---
> > >  builtin/rev-list.c       | 4 ++++
> > >  t/t6000-rev-list-misc.sh | 7 +++++++
> > >  2 files changed, 11 insertions(+)
> > > 
> > > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > > index 8479f6e..cfa6a7d 100644
> > > --- a/builtin/rev-list.c
> > > +++ b/builtin/rev-list.c
> > > @@ -157,6 +157,10 @@ static void show_commit(struct commit *commit, void *data)
> > >                         if (revs->commit_format == CMIT_FMT_ONELINE)
> > >                                 putchar('\n');
> > >                 }
> > > +               if (revs->commit_format == CMIT_FMT_RAW) {
> > > +                       putchar(info->hdr_termination);
> > > +               }
> > > +
> > 
> > 
> > This seems right to me. My one concern is that we make sure we restore
> > it for every case (in case it needs to be there for other formats?)
> > I'm not entirely sure about whether other non-raw modes need this or
> > not?
> 
> 
> Right.  The original didn't do anything special for CMIT_FMT_RAW,
> and 660e113 did not remove anything special for CMIT_FMT_RAW, so it
> isn't immediately obvious why this patch is sufficient.  
> 
> Dennis, care to elaborate?

The original logic was (best seen with git show -w 660e113):

if(showing graphs) {
     do pretty things
}
else {
     just print the buffer and the header terminator
}

660e113 changed that to

do pretty things

Given that the 'do pretty things part' works for other uses of git rev-
list, it made sense that the \0 should only be added back in
CMIT_FMT_RAW mode. Changing the first putchar('\n') as Jacob proposes
(that mail arrived while I'm typing this) might work too, I haven't
tested it.

D.
