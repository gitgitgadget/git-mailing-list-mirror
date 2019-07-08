Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548F21F461
	for <e@80x24.org>; Mon,  8 Jul 2019 11:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfGHLo2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 07:44:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfGHLo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 07:44:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id u18so16731300wru.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uaO1HuCavRZ8bVIgvtudj9QTnjPad2xo1przUKtrJ2k=;
        b=cykL8exbxKidsDiSx3AP1jf7nKSxArtOa96bdmILIYBt5gTe0I1iI7/kcIsqErQxv2
         Tc5oDfSsKAqr5vdoM1e/SL4/zJkBeUv3khagGIG5tJtVU7Vy5US9vLb9UvQJBrHepX6s
         A9+6/Cg3bleoJFQgeL43N6fzsQU8yXSFAYgA75qdzD4rdGkaxw8zdzPrx09fcWFEWnPS
         1vvIv1TL0JYAMXq2GZS1oWxi8xaKdI99MaPLcumAshQrfaP/xAfMcIezwD+iAJQTrJ4L
         J7tHU94DF95GDhGdyOEF/Thz85kUWu8kst8r1AFv6HzluVts/Ah8iOgMwQtaZgjE9UhT
         24Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uaO1HuCavRZ8bVIgvtudj9QTnjPad2xo1przUKtrJ2k=;
        b=PZ+JuJP6m8Gi0y6dN2XgMxxJsjOLGlGta/QPGlbFAw0bUDyeoXjOELaiZE421finXY
         se+FeDgGUa9MVedzUcTNQrxx+gHG5BhMg3yOMIvazgcYdbCfPYdAo3borM9eAg8SxTDl
         sQ9CVA8bDVgztSTL9TVBDPNCuhO2Q71CyvE8RPotaI8q4pZRLJO3ETnsmVDRlMnlpCpu
         Kh4mt2Sm4d/OMX7zEYS4xTqMn96ZSP5bUxJPCs7sspaAJ7RlQ8YvekXFRbBeNx4xfOm6
         V0HgtffbHeVzKq3/0XFDotxuExBv9exU9mkegxtgJmNd4/ncZe+pLw88Ov8Q9wLX/hOC
         UYdQ==
X-Gm-Message-State: APjAAAVwMHDbYCps1X875idxCNqHYY8edkUJ/r34M4uW0vm4YnLioKdP
        Tw5bdxa9tp0lLOw548pozmU=
X-Google-Smtp-Source: APXvYqzruS+F/EGLMYtsB93lqd7Hm0av4O3o0QZkoh5t66qOt+9PxiVBt1S4dlAC15IF7g0H85e+yQ==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr6828336wrx.175.1562586264470;
        Mon, 08 Jul 2019 04:44:24 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id l11sm16182917wrw.97.2019.07.08.04.44.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 04:44:23 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:44:22 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 12/14] range-diff: add section header instead of diff
 header
Message-ID: <20190708114422.GC16825@hank.intra.tgummerer.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190705170630.27500-13-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1907052114480.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907052114480.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05, Johannes Schindelin wrote:
> >  range-diff.c           | 35 ++++++++++++----
> >  t/t3206-range-diff.sh  | 91 +++++++++++++++++++++++++++++++++++++++---
> >  t/t3206/history.export | 84 ++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 193 insertions(+), 17 deletions(-)
> >
> > diff --git a/range-diff.c b/range-diff.c
> > index b31fbab026..cc01f7f573 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -10,6 +10,7 @@
> >  #include "commit.h"
> >  #include "pretty.h"
> >  #include "userdiff.h"
> > +#include "apply.h"
> >
> >  struct patch_util {
> >  	/* For the search for an exact match */
> > @@ -95,12 +96,36 @@ static int read_patches(const char *range, struct string_list *list)
> >  		}
> >
> >  		if (starts_with(line, "diff --git")) {
> > +			struct patch patch;
> 
> If you append ` = { 0 }` (or ` = { NULL }`, depending on the first field
> of that struct, you don't need that `memset()` later.

Thanks!

> > +			struct strbuf root = STRBUF_INIT;
> > +			int linenr = 0;
> > +
> >  			in_header = 0;
> >  			strbuf_addch(&buf, '\n');
> >  			if (!util->diff_offset)
> >  				util->diff_offset = buf.len;
> > -			strbuf_addch(&buf, ' ');
> > -			strbuf_addstr(&buf, line);
> > +			memset(&patch, 0, sizeof(patch));
> > +			line[len - 1] = '\n';
> 
> I guess `parse_git_header()` cannot handle lines ending in a NUL?

Yeah, it doesn't deal well with them.  We might be able to change
that, but I haven't looked into that tbh.

> > +			len = parse_git_header(&root, &linenr, 1, line,
> > +					       len, size, &patch);
> > +			if (len < 0)
> > +				die(_("could not parse git header"));
> 
> Maybe include the line's contents, like ` '%.*s'", (int)len, line`?

Will do.

> > @@ -117,17 +142,13 @@ static int read_patches(const char *range, struct string_list *list)
> >  			if (!(p = strstr(p, "@@")))
> >  				die(_("invalid hunk header in inner diff"));
> >  			strbuf_addstr(&buf, p);
> > -		} else if (!line[0] || starts_with(line, "index "))
> > +		} else if (!line[0])
> >  			/*
> >  			 * A completely blank (not ' \n', which is context)
> >  			 * line is not valid in a diff.  We skip it
> >  			 * silently, because this neatly handles the blank
> >  			 * separator line between commits in git-log
> >  			 * output.
> > -			 *
> > -			 * We also want to ignore the diff's `index` lines
> > -			 * because they contain exact blob hashes in which
> > -			 * we are not interested.
> 
> Oh, are we interested in them again?

Not really, but we no longer need to ignore them explicitly here.  The
'index' lines are just another part of the diff header, which we parse
using 'parse_git_diff_header()' now, and then replace completely.

Previously we singled that line from the git diff headers out, because
they would result in a particularly noisy range diff, as the blob
hashes would change in a lot of cases, but are not really
interesting.  We could have ignored things such as the "similarity
index" as well, as for example a 1% change in the similarity wouldn't
matter that much, but I assume we just didn't because that's much less
likely to change between different versions of a patch series.

> >  			 */
> >  			continue;
> >  		else if (line[0] == '>') {
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 9f89af7178..c277756057 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -181,6 +181,85 @@ test_expect_success 'changed commit with sm config' '
> >  	test_cmp expected actual
> >  '
> >
> > +test_expect_success 'renamed file' '
> > +	git range-diff --no-color --submodule=log topic...renamed-file >actual &&
> > +	sed s/Z/\ /g >expected <<-EOF &&
> > +	1:  4de457d = 1:  f258d75 s/5/A/
> > +	2:  fccce22 ! 2:  017b62d s/4/A/
> > +	    @@
> > +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> > +	    Z
> > +	    -    s/4/A/
> > +	    +    s/4/A/ + rename file
> > +	    Z
> > +	    - ## file ##
> > +	    + ## file => renamed-file ##
> 
> I guess there is no good way to suppress the `- ## file ##` line in this
> case? It is a bit distracting...

No, I can't think of a good way.  I'm also not sure it would be right
to remove it.  In this case it means that in the previous version this
was only called 'file', while in the new version it was renamend in
this patch to 'renamed-file', so it does give some useful information.

Not sure how else we could represent that.  If we just had a 
'## file => renamed-file ##' section header, I'd expect that 'file'
has been renamed to 'renamed-file' in both versions.

> > @@ -216,9 +295,9 @@ test_expect_success 'dual-coloring' '
> >  	:     <RESET>
> >  	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
> >  	:    <REVERSE><GREEN>+<RESET>
> > -	:      diff --git a/file b/file<RESET>
> > -	:      --- a/file<RESET>
> > -	:      +++ b/file<RESET>
> > +	:      ## file ##<RESET>
> > +	:    <CYAN> @@<RESET>
> > +	:      1<RESET>
> 
> I am a bit confused where these last two lines come from all of a
> sudden... They were not there before, and I do not see any code change in
> this patch that would be responsible for them, either...
> 
> Could you help me understand?

Sure.  The actual change (in the range-diff) here is that "Also a
silly comment here!" was added to the commit message.  The diff header
is context lines after that.

We now replace the diff header with the new "section header", which is
only a single line, so we get a couple of additional lines of the
context of the subsequent inner diff.  


> >  	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
> >  	:    <REVERSE><CYAN>@@<RESET>
> >  	:      9<RESET>
> > diff --git a/t/t3206/history.export b/t/t3206/history.export
> > index b8ffff0940..7bb3814962 100644
> > --- a/t/t3206/history.export
> > +++ b/t/t3206/history.export
> > @@ -22,8 +22,8 @@ data 51
> >  19
> >  20
> >
> > -reset refs/heads/removed
> > -commit refs/heads/removed
> > +reset refs/heads/renamed-file
> > +commit refs/heads/renamed-file
> 
> Hmm. Is the `removed` ref no longer required by the 'removed a commit'
> test case?

It is, and it still exists.  I'm not entirely familar with the format
for fast-export/fast-import scripts.  What I did was just fast-import
the existing script, create the new refs that were required for the
tests and then fast-export'ed it again.

So not sure exactly why this changed, but the 'removed' ref still
exists :)

> >  mark :2
> >  author Thomas Rast <trast@inf.ethz.ch> 1374424921 +0200
> >  committer Thomas Rast <trast@inf.ethz.ch> 1374484724 +0200
> > @@ -599,6 +599,82 @@ s/12/B/
> >  from :46
> >  M 100644 :28 file
> >
> > -reset refs/heads/removed
> > -from :47
> > +commit refs/heads/added-removed
> > +mark :48
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574151 +0100
> 
> Neat ;-)
> 
> > +data 7
> > +s/5/A/
> > +from :2
> > +M 100644 :3 file
> > +
> > +blob
> > +mark :49
> > +data 0
> > +
> > +commit refs/heads/added-removed
> > +mark :50
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
> > +data 18
> > +s/4/A/ + new-file
> > +from :48
> > +M 100644 :5 file
> > +M 100644 :49 new-file
> > +
> > +commit refs/heads/added-removed
> > +mark :51
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
> > +data 22
> > +s/11/B/ + remove file
> > +from :50
> > +M 100644 :7 file
> > +D new-file
> > +
> > +commit refs/heads/added-removed
> > +mark :52
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574177 +0100
> > +data 8
> > +s/12/B/
> > +from :51
> > +M 100644 :9 file
> > +
> > +commit refs/heads/renamed-file
> > +mark :53
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574309 +0100
> > +data 7
> > +s/5/A/
> > +from :2
> > +M 100644 :3 file
> > +
> > +commit refs/heads/renamed-file
> > +mark :54
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574312 +0100
> > +data 21
> > +s/4/A/ + rename file
> > +from :53
> > +D file
> > +M 100644 :5 renamed-file
> > +
> > +commit refs/heads/renamed-file
> > +mark :55
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574319 +0100
> > +data 8
> > +s/11/B/
> > +from :54
> > +M 100644 :7 renamed-file
> > +
> > +commit refs/heads/renamed-file
> > +mark :56
> > +author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
> > +committer Thomas Gummerer <t.gummerer@gmail.com> 1556574319 +0100
> > +data 8
> > +s/12/B/
> > +from :55
> > +M 100644 :9 renamed-file
> 
> I have to admit that I allowed myself not to study this script too
> closely, trusting that the range-diff explains better what commit history
> it creates than the fast-import script.
> 
> Thanks,
> Dscho
> 
> >
> > --
> > 2.22.0.510.g264f2c817a
> >
> >
