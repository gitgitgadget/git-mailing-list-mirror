Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E515211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 01:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeLFBA1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 20:00:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33230 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFBA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 20:00:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so10890698pfb.0
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 17:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vS1jhlIYk+NgIrDwlwyt8fr8yKg/akxV/bQqqwq5qTU=;
        b=oaNymQS/ZnQC5JqDY3bxwny/+jqMAP4AHDpF6EvX2YevuXHTRYD1S40s009fmq9naK
         pkwIlvdBLRtuL7yh9TeuXt8eLyrOh5y+Ub8SiMDVrlkM/XwS9oFcrbHluAPaxRzhInkJ
         RFbNnwbibC98ImnCR3dPJ+/jNwfQVLdrYTqJx4C/Rugrcsa9gkjX8wMHcQng+najk53R
         JdbwK+fg8GemT5mWF3IrjZJ1L0QfZtlhLDJYGQ/r4gXIOMVxck1YIdA9fqVvIt3eSqmF
         mI790SVFPYvZNiM8N5bgmL47P2LTBFiPmD3LaJTUEGKFEriQVY3WseIO4+0abgOMMdgi
         43LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vS1jhlIYk+NgIrDwlwyt8fr8yKg/akxV/bQqqwq5qTU=;
        b=fPDH1Orm1/uhsjlPpaJHYCwfxXdHgWPDwwH7nXTCTYBFGHKVRBu565CBBB6jZeTqMw
         +ilO9+t2y4sUb3dTIwb6v8NHGUHpIy5EjRZcntFzo8fnE08N1qmZAXXsfxkPl7AVUkwn
         3bVCM0fLBaJPM67atnLL9uqbClFrcubFhMsH47Al0sBHlKgg6M8wtq2C/3rfaK69D2eg
         cAiZAKa5oxDRCCQIAGp5UeBoFK8rY1I0yJkUuwYyTyiiaJeC5KXhLdwsgwbQlRiTeaId
         ZFcaGbtk8t2a+SEq229fPf/gBaHWOtO8t2mnJn93/XXKR23HjP2L1Xyso7iSBYwvhwA0
         AuJw==
X-Gm-Message-State: AA+aEWaw4vpducY77Pe/PiZQoah53cS69QhkOAGhrz3sBUuLqhDgqA3H
        Rc8+w1uM0jczAMHkdedNvzSAVg==
X-Google-Smtp-Source: AFSGD/V1UHqq2VcRra1MbkZQkeYEDuyr+quaderwl0ejEnKukCsEt1GSPRC/N23SsjmJB2NeALer1A==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr22244946pgb.66.1544058025366;
        Wed, 05 Dec 2018 17:00:25 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id v9sm34046298pfg.144.2018.12.05.17.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 17:00:24 -0800 (PST)
Date:   Wed, 5 Dec 2018 17:00:18 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 1/2] commit-graph, fuzz: Add fuzzer for commit-graph
Message-ID: <20181206010018.GE9703@google.com>
Mail-Followup-To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com
References: <cover.1544048946.git.steadmon@google.com>
 <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
 <874lbrzj2d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lbrzj2d.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.05 23:48, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 05 2018, Josh Steadmon wrote:
> 
> > Breaks load_commit_graph_one() into a new function,
> > parse_commit_graph(). The latter function operates on arbitrary buffers,
> > which makes it suitable as a fuzzing target.
> >
> > Adds fuzz-commit-graph.c, which provides a fuzzing entry point
> > compatible with libFuzzer (and possibly other fuzzing engines).
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  .gitignore          |  1 +
> >  Makefile            |  1 +
> >  commit-graph.c      | 63 +++++++++++++++++++++++++++++++++------------
> >  fuzz-commit-graph.c | 18 +++++++++++++
> >  4 files changed, 66 insertions(+), 17 deletions(-)
> >  create mode 100644 fuzz-commit-graph.c
> >
> > diff --git a/.gitignore b/.gitignore
> > index 0d77ea5894..8bcf153ed9 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -1,3 +1,4 @@
> > +/fuzz-commit-graph
> >  /fuzz_corpora
> >  /fuzz-pack-headers
> >  /fuzz-pack-idx
> > diff --git a/Makefile b/Makefile
> > index 1a44c811aa..6b72f37c29 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -684,6 +684,7 @@ SCRIPTS = $(SCRIPT_SH_INS) \
> >
> >  ETAGS_TARGET = TAGS
> >
> > +FUZZ_OBJS += fuzz-commit-graph.o
> >  FUZZ_OBJS += fuzz-pack-headers.o
> >  FUZZ_OBJS += fuzz-pack-idx.o
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 40c855f185..0755359b1a 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -46,6 +46,10 @@
> >  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
> >  			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
> >
> > +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> > +					size_t graph_size);
> > +
> > +
> >  char *get_commit_graph_filename(const char *obj_dir)
> >  {
> >  	return xstrfmt("%s/info/commit-graph", obj_dir);
> > @@ -84,16 +88,10 @@ static int commit_graph_compatible(struct repository *r)
> >  struct commit_graph *load_commit_graph_one(const char *graph_file)
> >  {
> >  	void *graph_map;
> > -	const unsigned char *data, *chunk_lookup;
> >  	size_t graph_size;
> >  	struct stat st;
> > -	uint32_t i;
> > -	struct commit_graph *graph;
> > +	struct commit_graph *ret;
> >  	int fd = git_open(graph_file);
> > -	uint64_t last_chunk_offset;
> > -	uint32_t last_chunk_id;
> > -	uint32_t graph_signature;
> > -	unsigned char graph_version, hash_version;
> >
> >  	if (fd < 0)
> >  		return NULL;
> > @@ -108,27 +106,61 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
> >  		die(_("graph file %s is too small"), graph_file);
> >  	}
> >  	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
> > +	ret = parse_commit_graph(graph_map, fd, graph_size);
> > +
> > +	if (ret == NULL) {
> 
> Code in git usually uses just !ret.

Will fix in V2, thanks.


> > +		munmap(graph_map, graph_size);
> > +		close(fd);
> > +		exit(1);
> 
> Ouch, exit(1) from load_commit_graph_one()? Can't we return NULL here
> instead? Nasty to exit from a library routine, but then I see later...
> 
> > @@ -201,11 +235,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
> >  	}
> >
> >  	return graph;
> > -
> > -cleanup_fail:
> > -	munmap(graph_map, graph_size);
> > -	close(fd);
> > -	exit(1);
> >  }
> 
> ... ah, I see this is where you got the exit(1) from. So it was there
> already.
> 
> >  static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
> > diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> > new file mode 100644
> > index 0000000000..420851d0d2
> > --- /dev/null
> > +++ b/fuzz-commit-graph.c
> > @@ -0,0 +1,18 @@
> > +#include "object-store.h"
> > +#include "commit-graph.h"
> > +
> > +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> > +					size_t graph_size);
> > +
> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> > +
> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> > +{
> > +	struct commit_graph *g;
> > +
> > +	g = parse_commit_graph((void *) data, -1, size);
> > +	if (g)
> > +		free(g);
> > +
> > +	return 0;
> > +}
> 
> I hadn't looked at this before, but see your 5e47215080 ("fuzz: add
> basic fuzz testing target.", 2018-10-12) for some prior art.
> 
> There's instructions there for a very long "make" invocation. Would be
> nice if this were friendlier and we could just do "make test-fuzz" or
> something...

Yeah, the problem is that there are too many combinations of fuzzing
engine, sanitizer, and compiler to make any reasonable default here.
Even if you just stick with libFuzzer, address sanitizer, and clang, the
flags change radically depending on which version of clang you're using.
