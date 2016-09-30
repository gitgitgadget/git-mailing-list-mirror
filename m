Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8610207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbcI3WFR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:05:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34612 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbcI3WFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:05:16 -0400
Received: by mail-yb0-f196.google.com with SMTP id z8so1712222ybh.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zi+BlSfYMQ5tnb+LG2KO7l1Mx4rB4EFtjrEc2eKqleg=;
        b=XvmN2jseI7UpY0OP+EWGjc4+GWnLsv1/hkNXi1agHbCItiDoNnr84/UMYlBUhUjPOT
         k5lqsfcM+oRvC+aofRFTmQOwZOQU0ug8XgoCKNWPKhAqlEmJhX9CdvUIuKMLwmyZqVPb
         69/zA3gzDjbA3eTAPGYiOeuxqQrbMh1MJk3yRY4fCNaJmcYeAZIstHZAYvPpRWsFOhJ6
         vBPBgaB6SMeiKvZp3LZNJ6vDeu8CCzvI391rtw2SwOEXKNLDgzUrBPudT+I0vG4KQONW
         geFZBOraV1c9SO8iVZXJI5u/HZINB2IcpKEu1s12oqtcYVBizmdkrZRU7/mm/Km6W6Sr
         AS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zi+BlSfYMQ5tnb+LG2KO7l1Mx4rB4EFtjrEc2eKqleg=;
        b=IyewF+45sHmcagCQmjRnXMi/SkbPJQuxlyh8OrZ5EXuLW0F/iaaz+balAaP5jv6AOe
         E4FXvaLGXhpiJDtKL5rfXUwmqRRrbM8b9oBeDkar/REhINuw+rkCmX9SB6KsHK4BZdoF
         9uDJKGl9tdzPBL0pe6mzzfNJYbX+Vt2o0xv1ac+ntzz9gC+uEeUNQ30Qbrf1Sfkii5D2
         B5kVdhnlrUlCM7lccsSY8mF1x70syPLnXs3603NMjtTJE5TglvX26BK0272yAUGLNvTz
         eYBToVU0zzGpbDsbP3xOfi/Xkw1ZGndl4+b1OUHuo4Mzhj/cXyLpp+RMJhjYveo/ea0K
         SLmA==
X-Gm-Message-State: AA6/9RmStuvFDOCPy6vok1NCtnZK68q51S2sO0XKxeldYilJPG2nCdpQ7bbaDl52QZ8FxHj68vG1haysmIQ+4g==
X-Received: by 10.37.163.104 with SMTP id d95mr6663860ybi.132.1475273115372;
 Fri, 30 Sep 2016 15:05:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 30 Sep 2016 15:04:54 -0700 (PDT)
In-Reply-To: <20160930105639.15589-1-szeder@ira.uka.de>
References: <CA+P7+xoxTpqn=jkuHYp5pKCCWfKLP5OKCTBYkcTVw_RhEw0KVw@mail.gmail.com>
 <20160930105639.15589-1-szeder@ira.uka.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 30 Sep 2016 15:04:54 -0700
Message-ID: <CA+P7+xpWi_qgRTVmLf-bJq1mn7dW0Hf6544wHsOgFniDQyHo2Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] pretty: allow formatting DATE_SHORT
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Cc:     Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 3:56 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> wrot=
e:
>> On Thu, Sep 29, 2016 at 1:33 AM, Jeff King <peff@peff.net> wrote:
>> > There's no way to do this short of "%ad" and --date=3Dshort,
>> > but that limits you to having a single date format in the
>> > output.
>> >
>> > This would possibly be better done with something more like
>> > "%ad(short)".
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> >  pretty.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/pretty.c b/pretty.c
>> > index 493edb0..c532c17 100644
>> > --- a/pretty.c
>> > +++ b/pretty.c
>> > @@ -727,6 +727,9 @@ static size_t format_person_part(struct strbuf *sb=
, char part,
>> >         case 'I':       /* date, ISO 8601 strict */
>> >                 strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO860=
1_STRICT)));
>> >                 return placeholder_len;
>> > +       case 's':
>> > +               strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)=
));
>> > +               return placeholder_len;
>> >         }
>> >
>> >  skip:
>> > --
>> > 2.10.0.566.g5365f87
>> >
>>
>> Nice. I use date=3Dshort in some of my aliases and switching to this is
>> nicer. I assume this turns into "%(as)"?
>>
>> What about documenting this in  pretty-formats.txt?
>
> Here you go :)
>
>   http://public-inbox.org/git/1444235305-8718-1-git-send-email-szeder@ira=
.uka.de/
>

Nice, thanks!

Regards,
Jake
