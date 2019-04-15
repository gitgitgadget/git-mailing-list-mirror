Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896AD20248
	for <e@80x24.org>; Mon, 15 Apr 2019 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfDOTUy (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 15:20:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34138 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfDOTJo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so23396127wrq.1
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HsVoUw7pXiCWJaYunFIbmYVnbCeKp4TjOjCZl3LNwho=;
        b=IIm4StzmjuTGTHCnMJqju7z7DzTd7avV1iPZa4HTuEd9sC2vPozZQV2HnmYp2KYDwl
         dxABtOMFw62+Oa0BTvnyUBYXYwP1RMvYmdNB69j05ywLHHD/TNNFwA6H7r4BrMCtdoLT
         Er3zI8O9eXK3lhukWyd2nxUqKyH26DGx7VDKsEHW5T/q6KPpyRngXNuHaZ19uk6fqviI
         s4YZaQRAoBv2ghMQt7Bshg6TY83GnlnDr0WZnApxGEmLNk8INfXFnaKa+SdMsUYcbF0O
         EjA/pEKOLSe6ehkfKZalGLlqyr22drFe9EVh7RxTReWE4ZHXRcid/pJbBYGx5qNhVnO7
         PAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HsVoUw7pXiCWJaYunFIbmYVnbCeKp4TjOjCZl3LNwho=;
        b=P4SMd5BHjBJ0qeES4bElIj90jnICnvUArqh5QmZyVSImH2xY+ljUb480mteeoLAH+c
         w+SSzQq8qLwrtLd5hlEIqRnAGsPKDyDOqgBPZyeKKglozwel5lNoZjWRGu1eQqp/6PkE
         G42P9Ari9iw2bOQJPJO0thmHNbyAS6OmHOecI8c/3BhsGYMvpKuWP8zZC+CtPzVJhWox
         m0YLGmU/o2CKpMTdPqJf4AS6As9sNkuAGvs55DiJcHXyTYJJ15szxTB9NBRaCPSAJONR
         r0iw/WmEeGRf+pNI/5LfgEfX1RG3lxOVlsi0Zk5bIGkp6S021aC59akzT1U1114v+f7P
         hkuA==
X-Gm-Message-State: APjAAAWwN6jATLgjeEVD/V781TUVpYjzNjFeABs96hfl5SVTRfL4W0NO
        6jhue3E6exajiQG60z3PLdQ=
X-Google-Smtp-Source: APXvYqw96VkUThqEXa4kzYvHdEk+bNd+omQM+j3zm+C37xmweQ3cDECEDtq8ePh75LdF179w7F/FtQ==
X-Received: by 2002:a5d:684e:: with SMTP id o14mr52326459wrw.138.1555355382010;
        Mon, 15 Apr 2019 12:09:42 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id s10sm23241393wmh.0.2019.04.15.12.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 12:09:40 -0700 (PDT)
Date:   Mon, 15 Apr 2019 20:09:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/4] range-diff: add section header instead of diff
 header
Message-ID: <20190415190939.GD1704@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <20190414210933.20875-4-t.gummerer@gmail.com>
 <CAPig+cTJyYLGAfHM_PrZd9DDaZBcVUetcWFcANGCYPvaMh2qxA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904151457310.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904151457310.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Johannes Schindelin wrote:
> Hi Eric,
> 
> On Sun, 14 Apr 2019, Eric Sunshine wrote:
> 
> > On Sun, Apr 14, 2019 at 5:10 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > [...]
> > > Introduce a new range diff hunk header, that's enclosed by "##",
> > > similar to how line numbers in diff hunks are enclosed by "@@", and
> > > give human readable information of what exactly happened to the file,
> > > including the file name.
> > > [...]
> > > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > > ---
> > > diff --git a/range-diff.c b/range-diff.c
> > > @@ -90,8 +91,37 @@ static int read_patches(const char *range, struct string_list *list)
> > > +               } else if (starts_with(line.buf, "--- ")) {
> > > +                       if (!strcmp(line.buf, "--- /dev/null"))
> > > +                               strbuf_remove(&line, 0, 4);
> > > +                       else
> > > +                               strbuf_remove(&line, 0, 6);
> > > +                       strbuf_rtrim(&line);
> > > +                       strbuf_reset(&filename_a);
> > > +                       strbuf_addbuf(&filename_a, &line);
> > > +               } else if (starts_with(line.buf, "+++ ")) {
> >
> > At this point, we know that line.buf starts with "+++"...
> >
> > > +                       strbuf_addstr(&buf, " ## ");
> > > +                       if (!strcmp(line.buf, "--- /dev/null"))
> >
> > so, it seems unlikely that it's ever going to match "--- /dev/null".

Ouch yup, this is some bad copy pasta, thanks for catching!

> > > +                               strbuf_remove(&line, 0, 4);
> > > +                       if (!strcmp(filename_a.buf, "/dev/null")) {
> > > +                               strbuf_addstr(&buf, "new file ");
> > > +                               strbuf_addbuf(&buf, &line);
> > > +                       } else if (!strcmp(line.buf, "/dev/null")) {
> > > +                               strbuf_addstr(&buf, "removed file ");
> > > +                               strbuf_addbuf(&buf, &line);
> > > +                       } else if (strbuf_cmp(&filename_a, &line)) {
> > > +                               strbuf_addstr(&buf, "renamed file ");
> > > +                               strbuf_addbuf(&buf, &filename_a);
> > > +                               strbuf_addstr(&buf, " -> ");
> > > +                               strbuf_addbuf(&buf, &line);
> > > +                       } else {
> > > +                               strbuf_addstr(&buf, "modified file ");
> > > +                               strbuf_addbuf(&buf, &line);
> > > +                       }
> >
> > All of these disposition strings end with "file", which seems
> > redundant. Short and sweet "new", "removed", "renamed", "modified"
> > provide just as much useful information.
> >
> > Also, should these strings be localizable?
> 
> I'd rather not.

Dunno, why do you think they should not be localizable?  I'm tend to
agree with Eric that they could be made localizable, after all this
output is not supposed to be machine readable either way.  I don't
have a strong opinion here though.

> > Alternately, rather than using prose to describe the disposition,
> > perhaps do so symbolically (thus universally), say with "+", "-", "->",
> > "*" (or ""), respectively?
> 
> Or maybe streamline the common case (modified) by *not* saying anything,
> then? I.e.
> 
> 	@@ Documentation/Makefile
> 
> for a modified file,
> 
> 	@@ builtin/psuh.c (new)
> 
> for a new file,
> 
> 	@@ git-add--interactive.perl (deleted)
> 
> for a removed one, and
> 
> 	@@ builtin/serve.c -> t/helper/test-serve-v2.c
> 
> for a renamed one.

This looks like a good suggestion to me, thanks!

> That should also give us a bit of wiggle room to append the function name
> part of the inner hunk header, if any.
> 
> Ciao,
> Dscho
