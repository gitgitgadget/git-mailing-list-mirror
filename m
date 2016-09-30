Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5521F4F8
	for <e@80x24.org>; Fri, 30 Sep 2016 10:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbcI3K5f (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 06:57:35 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51924 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751099AbcI3K5e (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Sep 2016 06:57:34 -0400
Received: from x590e26a0.dyn.telefonica.de ([89.14.38.160] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bpvVP-0004KZ-RE; Fri, 30 Sep 2016 12:57:29 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] pretty: allow formatting DATE_SHORT
Date:   Fri, 30 Sep 2016 12:56:39 +0200
Message-Id: <20160930105639.15589-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.516.gccda3a9
In-Reply-To: <CA+P7+xoxTpqn=jkuHYp5pKCCWfKLP5OKCTBYkcTVw_RhEw0KVw@mail.gmail.com>
References: <CA+P7+xoxTpqn=jkuHYp5pKCCWfKLP5OKCTBYkcTVw_RhEw0KVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1475233049.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Sep 29, 2016 at 1:33 AM, Jeff King <peff@peff.net> wrote:
> > There's no way to do this short of "%ad" and --date=short,
> > but that limits you to having a single date format in the
> > output.
> >
> > This would possibly be better done with something more like
> > "%ad(short)".
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  pretty.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/pretty.c b/pretty.c
> > index 493edb0..c532c17 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -727,6 +727,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
> >         case 'I':       /* date, ISO 8601 strict */
> >                 strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
> >                 return placeholder_len;
> > +       case 's':
> > +               strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
> > +               return placeholder_len;
> >         }
> >
> >  skip:
> > --
> > 2.10.0.566.g5365f87
> >
> 
> Nice. I use date=short in some of my aliases and switching to this is
> nicer. I assume this turns into "%(as)"?
> 
> What about documenting this in  pretty-formats.txt?

Here you go :)

  http://public-inbox.org/git/1444235305-8718-1-git-send-email-szeder@ira.uka.de/

