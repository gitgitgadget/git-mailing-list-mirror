Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3751F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeK1JcY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:32:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33221 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeK1JcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:32:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id l3so1018390wme.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3BEUV7G3ZgtLlbnsKACB03kcK35VvI77+zQHbn88hHk=;
        b=UHUVZsLxdnwH30zeAp+28Ue8a51OppDKwBg35gUYnLZ2RM7mP5VvznxdRN4Tk7AmCe
         iExZm0JYv8NO/WDLx/CImRTprbLFYBml8Y4ESuzYjMa9jtF0oy5mxc40KY2/fOoEVagf
         +66jq9xeZvtdy/AwEv9wIMxMn52wCQvbAZcYwBR5Z5ITxTDSsAzY0ZJg9P+9+jkfF9Vl
         KsBigaI34sBSC4nEn86/X4qd3wGoi1u/T+3abb68O9zrZ85KrhsPFKEW9uELs1oIFYfK
         p4Cx/6KBe49yaNNHkVpY2WGF2XuOmVXuLmLX/HGwUsU120Hkp1Acl3P1LYqkXJ7GVLzB
         njjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3BEUV7G3ZgtLlbnsKACB03kcK35VvI77+zQHbn88hHk=;
        b=n9atZxVM7iSqJXfMgWVIMmWgqNvF7st/HD+lMF7PjBI7Tri4aJMDO5+oab/FGEZkam
         izLw2Blws1J5qUxy/mdhTOZibXgpAglv9CscxBRYUbsIpJHh6y2SghMD8KulEb374CPB
         DJXarG2WdvTbuJa/YLPZ8GXAezJBexJoZecfwRBBHjW4gWwIR5Y3B4dsSimhFuZKauVD
         aWRQ7RsTEEiI7G4NP8Xa5Xi5I4NDpnghoIRrkmCZHoZ5GblTq9sWM5w3evR3LgLVdjvp
         PruUuQfXBDpIFREDAyofswpykdUNS0KuAfcQ7s0VqIgcc1ChlbR2aDBD/tzm7xSanNGk
         w3UQ==
X-Gm-Message-State: AA+aEWYlzzlA7MS89cvGpWGlEvj6F9jRUi8k08wl9rLY9bSJvhMhHjeh
        IludB1sO6N3ZSU/vnyoNy+g=
X-Google-Smtp-Source: AFSGD/WlReVTtvefBXgomsm+odLQ+pCoLIorMfvIhA7jolVeISOjn41vZq2eCkO0uRd8GdgLOXqKxw==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr561315wma.109.1543357978296;
        Tue, 27 Nov 2018 14:32:58 -0800 (PST)
Received: from localhost ([31.127.45.106])
        by smtp.gmail.com with ESMTPSA id m6sm5286641wrv.24.2018.11.27.14.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 14:32:57 -0800 (PST)
Date:   Tue, 27 Nov 2018 22:32:56 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v11 03/22] strbuf.c: add `strbuf_insertf()` and
 `strbuf_vinsertf()`
Message-ID: <20181127223256.GM4883@hank.intra.tgummerer.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
 <e8d86fae660a79eabcf4764dfa9986282c097242.1542925164.git.ungureanupaulsebastian@gmail.com>
 <20181125214353.GI4883@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1811271428560.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811271428560.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/27, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 25 Nov 2018, Thomas Gummerer wrote:
> 
> > On 11/23, Paul-Sebastian Ungureanu wrote:
> > > Implement `strbuf_insertf()` and `strbuf_vinsertf()` to
> > > insert data using a printf format string.
> > > 
> > > Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> > > ---
> > >  strbuf.c | 36 ++++++++++++++++++++++++++++++++++++
> > >  strbuf.h |  9 +++++++++
> > >  2 files changed, 45 insertions(+)
> > > 
> > > diff --git a/strbuf.c b/strbuf.c
> > > index 82e90f1dfe..bfbbdadbf3 100644
> > > --- a/strbuf.c
> > > +++ b/strbuf.c
> > > @@ -249,6 +249,42 @@ void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
> > >  	strbuf_splice(sb, pos, 0, data, len);
> > >  }
> > >  
> > > +void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
> > > +{
> > > +	int len, len2;
> > > +	char save;
> > > +	va_list cp;
> > > +
> > > +	if (pos > sb->len)
> > > +		die("`pos' is too far after the end of the buffer");
> > 
> > I was going to ask about translation of this and other messages in
> > 'die()' calls, but I see other messages in strbuf.c are not marked for
> > translation either.  It may make sense to mark them all for
> > translation at some point in the future, but having them all
> > untranslated for now makes sense.
> > 
> > In the long run it may even be better to return an error here rather
> > than 'die()'ing, but again this is consistent with the rest of the
> > API, so this wouldn't be a good time to take that on.
> 
> I guess I was too overzealous in my copying. These conditions really
> indicate bugs in the caller... So I'd actually rather change that die() to
> BUG().
> 
> But then, the original code in strbuf_vaddf() calls die() and would have
> to be changed, too.

Right, making these 'BUG()' makes sense to me.  But at this stage of
the series it's probably better to just aim for consistency with the
surrounding code without starting to do more cleanups that were not
included in earlier iterations.  I think that's best left for patches
on top.

> > > +	va_copy(cp, ap);
> > > +	len = vsnprintf(sb->buf + sb->len, 0, fmt, cp);
> > 
> > Here we're just getting the length of what we're trying to format
> > (excluding the final NUL).  As the second argument is 0, we do not
> > modify the strbuf at this point...
> > 
> > > +	va_end(cp);
> > > +	if (len < 0)
> > > +		BUG("your vsnprintf is broken (returned %d)", len);
> > > +	if (!len)
> > > +		return; /* nothing to do */
> > > +	if (unsigned_add_overflows(sb->len, len))
> > > +		die("you want to use way too much memory");
> > > +	strbuf_grow(sb, len);
> > 
> > ... and then we grow the strbuf by the length we previously, which
> > excludes the NUL character, plus one extra character, so even if pos
> > == len we are sure to have enough space in the strbuf ...
> > 
> > > +	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
> > > +	/* vsnprintf() will append a NUL, overwriting one of our characters */
> > > +	save = sb->buf[pos + len];
> > > +	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
> > 
> > ... and we use vsnprintf to write the formatted string to the
> > beginning of the buffer.
> 
> It is not actually the beginning of the buffer, but possibly the middle of
> the buffer ;-)

Oops, you're right of course :) 

> > sb->alloc - sb->len can be larger than 'len', which is fine as vsnprintf
> > doesn't write anything after the NUL character.  And as 'strbuf_grow'
> > adds len + 1 bytes to the strbuf we'll always have enough space for
> > adding the formatted string ...
> > 
> > > +	sb->buf[pos + len] = save;
> > > +	if (len2 != len)
> > > +		BUG("your vsnprintf is broken (returns inconsistent lengths)");
> > > +	strbuf_setlen(sb, sb->len + len);
> > 
> > And finally we set the strbuf to the new length.  So all this is just
> > a very roundabout way to say that this function does the right thing
> > according to my reading (and tests).
> 
> :-)
> 
> It seems that Junio likes this way of reviewing, giving him confidence
> that the review was thorough.
>
> Thanks!
> Dscho
> 
> > > +}
> > > +
> > > +void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...)
> > > +{
> > > +	va_list ap;
> > > +	va_start(ap, fmt);
> > > +	strbuf_vinsertf(sb, pos, fmt, ap);
> > > +	va_end(ap);
> > > +}
> > > +
> > >  void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
> > >  {
> > >  	strbuf_splice(sb, pos, len, "", 0);
> > > diff --git a/strbuf.h b/strbuf.h
> > > index be02150df3..8f8fe01e68 100644
> > > --- a/strbuf.h
> > > +++ b/strbuf.h
> > > @@ -244,6 +244,15 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t n);
> > >   */
> > >  void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);
> > >  
> > > +/**
> > > + * Insert data to the given position of the buffer giving a printf format
> > > + * string. The contents will be shifted, not overwritten.
> > > + */
> > > +void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt,
> > > +		     va_list ap);
> > > +
> > > +void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
> > > +
> > >  /**
> > >   * Remove given amount of data from a given position of the buffer.
> > >   */
> > > -- 
> > > 2.19.1.878.g0482332a22
> > > 
> > 
