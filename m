Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6411FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 23:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbcKVX2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 18:28:19 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33250 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbcKVX2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 18:28:18 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so12386182pgd.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LL1mLHViAC4TJJxIIcam+2e0sbIBEzi2kv7Pb1XzBKE=;
        b=c6m4QbuxQ1M1XlGh3Lun+WSzpiYf5yXWQFJFfRd0p1V7nFONUuZhlQVbwI+JTQcJeQ
         MijTv6lI4TYO6Oy7PAjLSh69LvNknZCcX5iOO45qAk5oJJzdwUJEp+wxWIc4OYEiQpLc
         zUBGsQdki+NSjJCBJBy2zAItnN8yl1ojNSHdhm/0W+cuD5jRV+eIBkSyeqD+Ab9o51Lk
         zgVvdPyqSdRFY+RCFj9nRxfBEXPZPla3X3pGTXz5dKXg8aSIKiYNUFas3fm/Vd1Ty0X/
         KfhxTNQNMdg8yKdhw8Ksh6tUR9fXf5tbnmjnHX7vHH2BhT9xuEpnhWYXb4ej6ECATRu7
         IKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LL1mLHViAC4TJJxIIcam+2e0sbIBEzi2kv7Pb1XzBKE=;
        b=OTW97lnqB0iBz8OrpBcmUYtYLWBcDfDw0r+f0Tx4IiDIa5p4AGH2z9KhxxbvWP9+EZ
         0Uv2MZ2tqdh9wjDfdlweHBdlB41G3wA0behauRLV66ItR+8hK/wwlnkzJZEnDSYncxsE
         92VhHyjktc4jE/bvcMrfN3Bfiw5jQP7CrYV4MsbKMfdyc5KrfOw1DgHhJDsNB6hD8Kng
         hCSNUjwMTRCYf+90cfgQft9dp2yzkQR+EYDf1tNkloJilQ4JJJqMRfBDD7WdFPTaJ5ER
         XCFm7TjkFvjwzBUCPGfWUP2kDp/oWQ7XaJb61zxFsBCx3A8Jm/xcIF765dVnA8QKZu/1
         U3PQ==
X-Gm-Message-State: AKaTC006lvSIhNSosGNoS+/mxGNRnYUqBRVOgy7F2GlXSqdETMDFGwV3dz2HXf3ygXKoHXAh
X-Received: by 10.84.209.227 with SMTP id y90mr336123plh.111.1479857297764;
        Tue, 22 Nov 2016 15:28:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a049:6e3d:16a5:8086])
        by smtp.gmail.com with ESMTPSA id l3sm29623014pgc.41.2016.11.22.15.28.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 15:28:16 -0800 (PST)
Date:   Tue, 22 Nov 2016 15:28:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161122232815.GD65825@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1479840397-68264-6-git-send-email-bmwill@google.com>
 <xmqqshqjnmtc.fsf@gitster.mtv.corp.google.com>
 <20161122232105.GC65825@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161122232105.GC65825@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, Brandon Williams wrote:
> On 11/22, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > diff --git a/tree-walk.c b/tree-walk.c
> > > index 828f435..ff77605 100644
> > > --- a/tree-walk.c
> > > +++ b/tree-walk.c
> > > @@ -1004,6 +1004,19 @@ static enum interesting do_match(const struct name_entry *entry,
> > >  				 */
> > >  				if (ps->recursive && S_ISDIR(entry->mode))
> > >  					return entry_interesting;
> > > +
> > > +				/*
> > > +				 * When matching against submodules with
> > > +				 * wildcard characters, ensure that the entry
> > > +				 * at least matches up to the first wild
> > > +				 * character.  More accurate matching can then
> > > +				 * be performed in the submodule itself.
> > > +				 */
> > > +				if (ps->recursive && S_ISGITLINK(entry->mode) &&
> > > +				    !ps_strncmp(item, match + baselen,
> > > +						entry->path,
> > > +						item->nowildcard_len - baselen))
> > > +					return entry_interesting;
> > >  			}
> > 
> > This one (and the other hunk) feels more correct than the previous
> > round.  One thing to keep in mind however is that ps->recursive is
> > about "do we show a tree as a tree aka 040000, or do we descend into
> > it to show its contents?", not about "do we recurse into submodules?",
> > AFAICT.
> > 
> > So this change may have an impact on "git ls-tree -r" with pathspec;
> > I offhand do not know if that impact is undesirable or not.  A test
> > or two may be in order to illustrate what happens?  With a submodule
> > at "sub/module", running "git ls-tree -r HEAD -- sub/module/*" or
> > something like that, perhaps?
> 
> Maybe unrelated, but it looks like wildcard characters are overridden in
> ls-tree.c per '170260ae'.  As such wildmatching just doesn't work with
> ls-tree.  so `git ls-tree -r HEAD -- "*"` results in no hits.

Wrong commit.  Its this one (f0096c06bcdeb7aa6ae8a749ddc9d6d4a2c381d1)
that disabled wildmatching since it is 'plumbing'

-- 
Brandon Williams
