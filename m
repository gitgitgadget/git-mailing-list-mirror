Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0E020756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbdATXv6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:51:58 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34473 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdATXv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 18:51:57 -0500
Received: by mail-pg0-f44.google.com with SMTP id 14so27228937pgg.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MCP//H4B6FW8Kr9UCRCJqPxFsS29dKzHDI7pTpqlykA=;
        b=lRzRmyF4i9Sgbx7RsWH26mZw4HyL33EtkMDrqRBqZBm+unwx8hXwY458jdp0LUazP/
         SD3LJn2QKpXsmdklCUXnsdTvCB2B8y3VTtHTFSPsJNRrIl/ATwrxkOMCP1lSm6cRZa7f
         a6kMsbYmfy7mTVHJ6PakPZl/JLt86/YcZY1O2D4PWGDhv9YUI2tnz4XTrrBARU7S/dzA
         tY8SANAxdChRBPvEePkwvMRePmcm9YpVzQlzesOw3T3mbKP9jpIek6XDqpk81ZKq5F/r
         SQrO/f7zOkFafK4i3HLBaMlF4YaBD5hALI/ZECkry0G7n3pXs0sugOGN1GMeKm3Odz8y
         82NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MCP//H4B6FW8Kr9UCRCJqPxFsS29dKzHDI7pTpqlykA=;
        b=cimt7PpJWUoQp0XxLP0iOjJr2yj2dl4xajGluvmBVdw7RgvTn9s4dZb/hlbZ7jp38B
         +5+/d3LYNDoUMmEtYuF7hBlbyk2NblZDjvD8PFbmBzpgaTr6/+id3XZoqgeTnu8lB5Mg
         SeLFH3JIw4ynm5cfm5y5Ceh1fWkEWla/ouVtrlslKcnKYwJSdOwzY4IESaznpjIQ8xuH
         JXk39F8Q72gELj+N6i9yDhG10yVdz0JSBF8za0UTvluY5vE11D0MJuF7ETVVKeL3HRon
         oPSe81VXlC+0XWLm7InaVIBXozVpFiO83kxGSZfvEPoOUoLYi8CjroslsT3Ia9mkQFpq
         cqwA==
X-Gm-Message-State: AIkVDXIGAv2stGdeIRGJkF+FmT9xAtZrdjOa6mqgnLKUO22wLUtSoqgjc9zFOLBDa97aWw9O
X-Received: by 10.99.234.21 with SMTP id c21mr20111512pgi.166.1484956295669;
        Fri, 20 Jan 2017 15:51:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:c902:1008:ef67:f67])
        by smtp.gmail.com with ESMTPSA id w16sm19427992pgc.15.2017.01.20.15.51.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 Jan 2017 15:51:34 -0800 (PST)
Date:   Fri, 20 Jan 2017 15:51:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
Message-ID: <20170120235133.GA146274@google.com>
References: <20170120171126.16269-1-stefanha@redhat.com>
 <20170120171126.16269-3-stefanha@redhat.com>
 <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/20, Junio C Hamano wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > If the tree contains a sub-directory then git-grep(1) output contains a
> > colon character instead of a path separator:
> >
> >   $ git grep malloc v2.9.3:t
> >   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
> >   $ git show v2.9.3:t:test-lib.sh
> >   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'
> >
> > This patch attempts to use the correct delimiter:
> >
> >   $ git grep malloc v2.9.3:t
> >   v2.9.3:t/test-lib.sh:	setup_malloc_check () {
> >   $ git show v2.9.3:t/test-lib.sh
> >   (success)
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  builtin/grep.c  | 4 +++-
> >  t/t7810-grep.sh | 5 +++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 90a4f3d..7a7aab9 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -494,7 +494,9 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
> >  
> >  			/* Add a delimiter if there isn't one already */
> >  			if (name[len - 1] != '/' && name[len - 1] != ':') {
> > -				strbuf_addch(&base, ':');
> > +				/* rev: or rev:path/ */
> > +				char delim = obj->type == OBJ_COMMIT ? ':' : '/';
> 
> Why check the equality with commit, rather than un-equality with
> tree?  Wouldn't you want to treat $commit:path and $tag:path the
> same way?

I assume Stefan just grabbed my naive suggestion hence why it checks
equality with a commit.  So that's my fault :)  Either of these may
not be enough though, since if you do 'git grep malloc v2.9.3^{tree}'
with this change the output prefix is 'v2.9.3^{tree}/' instead of the
correct prefix 'v2.9.3^{tree}:'

> 
> I also think the two patches should be squashed together, as it is
> only after this patch that the code does the "right thing" by
> changing the delimiter depending on obj->type.
> 
> > +				strbuf_addch(&base, delim);
> >  			}
> >  		}
> >  		init_tree_desc(&tree, data, size);
> > diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> > index e804a3f..8a58d5e 100755
> > --- a/t/t7810-grep.sh
> > +++ b/t/t7810-grep.sh
> > @@ -1445,6 +1445,11 @@ test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t/' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t' '
> > +	git grep vvv HEAD:t >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> 
> Perhaps you want an annotated tag object refs/tags/v1.0 that points
> at the commit at the HEAD, and then run the same grep on v1.0:t, in
> addition to the above test.
> 
> >  cat >expected <<EOF
> >  HEAD:t/a/v:vvv
> >  HEAD:t/v:vvv

-- 
Brandon Williams
