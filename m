Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0ED21F428
	for <e@80x24.org>; Fri,  5 Jan 2018 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeAEXtG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 18:49:06 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:41876 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeAEXtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 18:49:05 -0500
Received: by mail-pf0-f180.google.com with SMTP id j28so2804814pfk.8
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5TFvyC93FgJ8U/JtUhB9JTd4ac7EHfAqb1T2IpecRE=;
        b=r77yN/aIggsVvxdsrNuq2uQ3rsgkv17G5lhCiyzJDWYFvQFyFhBPELJV7OzLedW1uG
         ETyGGMc2GQdExdCxqlFcoMpAibU7GtvUWmmc/CSwj/bKFHLQ+QEqq13+L3YJS6OidVOd
         71KfhU91SfBpsWytuCf4hEqZdMAld/+vU4JLybKiF7XFYA7K7fI2RRHor5uZXdWnO41D
         UiY5GB4Fd9BcX8Cqc/Dr6COZwdKvItwCjheXoW45kGAglZ+pQueUshgMZ49LSd9FairY
         gyIS+1WEjv4+7/A0UEDDMmhI9r6rOa/cLLRoB3uxvZ71jPSTFm7pkPh0FH897vwcxEVJ
         wBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5TFvyC93FgJ8U/JtUhB9JTd4ac7EHfAqb1T2IpecRE=;
        b=lojDYp6cO4rwoLpL6/RHzC7pMAstuNDDB1NncYRnFSu5Y9ji3bmKBoucCBz1OYT3Ot
         lUUW5MIZYqwKHMUj/MGliwaJVLYRQzGoqhEtgS9W9Y2OrOqe+LxEDkGTjqe57hCGcyYA
         zGNpOaphzs3jM91HYImTuw1Rm4r8/GLEhfX/C/ddMOgPsw9WAHX8nrHEPWebYhuQHF/N
         RtoZg4CRbr64jaUccS9QbkwvbrA25iZpFjQFGsjB81zza9JQ9XXcU08Zix+vywMi19h3
         KMp196HYH7uM3UZlxusJ9ZQl5P3Lf1ev7X6M1ulZFy9yfCyxLuvWdynDmJ8UVBM+OZbC
         wYAA==
X-Gm-Message-State: AKGB3mIicAAkzjxcFMvRGUo523mf6ytP4udkRL0lXRKFhpHhi6HbkGPG
        MU8xOBdPj9Tztwr+CTlYyl6Vzg==
X-Google-Smtp-Source: ACJfBotHfRaPTOGFlRbZODYI6ebYHWDvKRNPILoBakTLkDYtWME3fz1v0ySj0JBI1qKm95kYvof5yg==
X-Received: by 10.98.6.130 with SMTP id 124mr4358518pfg.8.1515196144434;
        Fri, 05 Jan 2018 15:49:04 -0800 (PST)
Received: from google.com ([2620:0:100e:422:b962:214:60b3:c1cf])
        by smtp.gmail.com with ESMTPSA id 84sm16140344pfp.180.2018.01.05.15.49.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Jan 2018 15:49:03 -0800 (PST)
Date:   Fri, 5 Jan 2018 15:49:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/26] ls-refs: introduce ls-refs server command
Message-ID: <20180105234902.GB172942@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-13-bmwill@google.com>
 <CAGZ79kaQMBaA+gxqjY0xBNZiy2PdafoXjB+kowM9pj9heLwRPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaQMBaA+gxqjY0xBNZiy2PdafoXjB+kowM9pj9heLwRPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Stefan Beller wrote:
> On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> > Introduce the ls-refs server command.  In protocol v2, the ls-refs
> > command is used to request the ref advertisement from the server.  Since
> > it is a command which can be requested (as opposed to mandatory in v1),
> > a client can sent a number of parameters in its request to limit the ref
> > advertisement based on provided ref-patterns.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Documentation/technical/protocol-v2.txt | 26 +++++++++
> >  Makefile                                |  1 +
> >  ls-refs.c                               | 97 +++++++++++++++++++++++++++++++++
> >  ls-refs.h                               |  9 +++
> 
> Maybe consider putting any served command into a sub directory?
> 
> For example the code in builtin/ has laxer rules w.r.t. die()ing
> as it is a user facing command, whereas some devs want to see
> code at the root of the repo to not die() at all as the eventual goal
> is to have a library there.
> All this code is on the remote side, which also has different traits than
> the code at the root of the git.git repo; non-localisation comes to mind,
> but there might be other aspects as well (security?).

Well if we were to do this then we should move upload-pack and
receive-pack into this same "server code" directory.

> 
> 
> >  serve.c                                 |  2 +
> >  5 files changed, 135 insertions(+)
> >  create mode 100644 ls-refs.c
> >  create mode 100644 ls-refs.h
> >
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index b87ba3816..5f4d0e719 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -89,3 +89,29 @@ terminate the connection.
> >  Commands are the core actions that a client wants to perform (fetch, push,
> >  etc).  Each command will be provided with a list capabilities and
> >  arguments as requested by a client.
> > +
> > + Ls-refs
> 
> So is it ls-refs or Ls-refs or is any capitalization valid?

"ls-refs"  I'll make sure to change this.
> 
> > +---------
> > +
> > +Ls-refs is the command used to request a reference advertisement in v2.
> > +Unlike the current reference advertisement, ls-refs takes in parameters
> > +which can be used to limit the refs sent from the server.
> > +
> > +Ls-ref takes in the following parameters wraped in packet-lines:
> > +
> > +  symrefs: In addition to the object pointed by it, show the underlying
> > +          ref pointed by it when showing a symbolic ref.
> > +  peel: Show peeled tags.
> > +  ref-pattern <pattern>: When specified, only references matching the
> > +                        given patterns are displayed.
> 
> What kind of pattern matching is allowed here?
> strictly prefix only, or globbing, regexes?
> Is there a given grammar to follow? Maybe a link to the git
> glossary is or somewhere else might be fine.
> 
> Seeing that we do wildmatch() down there (as opposed to regexes),
> I wonder if it provides an entry for a denial of service attack, by crafting
> a pattern that is very expensive for the server to compute but cheap to
> ask for from a client. (c.f. 94da9193a6 (grep: add support for PCRE v2,
> 2017-06-01, but that is regexes!)
> 
> > +The output of ls-refs is as follows:
> > +
> > +    output = *ref
> > +            flush-pkt
> > +    ref = PKT-LINE((tip | peeled) LF)
> > +    tip = obj-id SP refname (SP symref-target)
> > +    peeled = obj-id SP refname "^{}"
> > +
> > +    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
> > +    shallow = PKT-LINE("shallow" SP obj-id LF)
> > diff --git a/Makefile b/Makefile
> > index 5f3b5fe8b..152a73bec 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -820,6 +820,7 @@ LIB_OBJS += list-objects-filter-options.o
> >  LIB_OBJS += ll-merge.o
> >  LIB_OBJS += lockfile.o
> >  LIB_OBJS += log-tree.o
> > +LIB_OBJS += ls-refs.o
> >  LIB_OBJS += mailinfo.o
> >  LIB_OBJS += mailmap.o
> >  LIB_OBJS += match-trees.o
> > diff --git a/ls-refs.c b/ls-refs.c
> > new file mode 100644
> > index 000000000..ac4904a40
> > --- /dev/null
> > +++ b/ls-refs.c
> > @@ -0,0 +1,97 @@
> > +#include "cache.h"
> > +#include "repository.h"
> > +#include "refs.h"
> > +#include "remote.h"
> > +#include "argv-array.h"
> > +#include "ls-refs.h"
> > +#include "pkt-line.h"
> > +
> > +struct ls_refs_data {
> > +       unsigned peel;
> > +       unsigned symrefs;
> > +       struct argv_array patterns;
> > +};
> > +
> > +/*
> > + * Check if one of the patterns matches the tail part of the ref.
> > + * If no patterns were provided, all refs match.
> > + */
> > +static int ref_match(const struct argv_array *patterns, const char *refname)
> > +{
> > +       char *pathbuf;
> > +       int i;
> > +
> > +       if (!patterns->argc)
> > +               return 1; /* no restriction */
> > +
> > +       pathbuf = xstrfmt("/%s", refname);
> > +       for (i = 0; i < patterns->argc; i++) {
> > +               if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
> > +                       free(pathbuf);
> > +                       return 1;
> > +               }
> > +       }
> > +       free(pathbuf);
> > +       return 0;
> > +}
> > +
> > +static int send_ref(const char *refname, const struct object_id *oid,
> > +                   int flag, void *cb_data)
> > +{
> > +       struct ls_refs_data *data = cb_data;
> > +       const char *refname_nons = strip_namespace(refname);
> > +       struct strbuf refline = STRBUF_INIT;
> > +
> > +       if (!ref_match(&data->patterns, refname))
> > +               return 0;
> > +
> > +       strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> > +       if (data->symrefs && flag & REF_ISSYMREF) {
> > +               struct object_id unused;
> > +               const char *symref_target = resolve_ref_unsafe(refname, 0,
> > +                                                              &unused,
> > +                                                              &flag);
> > +
> > +               if (!symref_target)
> > +                       die("'%s' is a symref but it is not?", refname);
> > +
> > +               strbuf_addf(&refline, " %s", symref_target);
> > +       }
> > +
> > +       strbuf_addch(&refline, '\n');
> > +
> > +       packet_write(1, refline.buf, refline.len);
> > +       if (data->peel) {
> > +               struct object_id peeled;
> > +               if (!peel_ref(refname, &peeled))
> > +                       packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled),
> > +                                        refname_nons);
> > +       }
> > +
> > +       strbuf_release(&refline);
> > +       return 0;
> > +}
> > +
> > +int ls_refs(struct repository *r, struct argv_array *keys, struct argv_array *args)
> > +{
> > +       int i;
> > +       struct ls_refs_data data = { 0, 0, ARGV_ARRAY_INIT };
> > +
> > +       for (i = 0; i < args->argc; i++) {
> > +               const char *arg = args->argv[i];
> > +               const char *out;
> > +
> > +               if (!strcmp("peel", arg))
> > +                       data.peel = 1;
> > +               else if (!strcmp("symrefs", arg))
> > +                       data.symrefs = 1;
> > +               else if (skip_prefix(arg, "ref-pattern ", &out))
> > +                       argv_array_pushf(&data.patterns, "*/%s", out);
> > +       }
> > +
> > +       head_ref_namespaced(send_ref, &data);
> > +       for_each_namespaced_ref(send_ref, &data);
> > +       packet_flush(1);
> > +       argv_array_clear(&data.patterns);
> > +       return 0;
> > +}
> > diff --git a/ls-refs.h b/ls-refs.h
> > new file mode 100644
> > index 000000000..9e4c57bfe
> > --- /dev/null
> > +++ b/ls-refs.h
> > @@ -0,0 +1,9 @@
> > +#ifndef LS_REFS_H
> > +#define LS_REFS_H
> > +
> > +struct repository;
> > +struct argv_array;
> > +extern int ls_refs(struct repository *r, struct argv_array *keys,
> > +                  struct argv_array *args);
> > +
> > +#endif /* LS_REFS_H */
> > diff --git a/serve.c b/serve.c
> > index da8127775..88d548410 100644
> > --- a/serve.c
> > +++ b/serve.c
> > @@ -4,6 +4,7 @@
> >  #include "pkt-line.h"
> >  #include "version.h"
> >  #include "argv-array.h"
> > +#include "ls-refs.h"
> >  #include "serve.h"
> >
> >  static int always_advertise(struct repository *r,
> > @@ -44,6 +45,7 @@ struct protocol_capability {
> >  static struct protocol_capability capabilities[] = {
> >         { "agent", agent_advertise, NULL },
> >         { "stateless-rpc", always_advertise, NULL },
> > +       { "ls-refs", always_advertise, ls_refs },
> >  };
> >
> >  static void advertise_capabilities(void)
> > --
> > 2.15.1.620.gb9897f4670-goog
> >

-- 
Brandon Williams
