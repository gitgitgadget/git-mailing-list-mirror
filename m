Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C05F1F462
	for <e@80x24.org>; Thu, 23 May 2019 22:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbfEWWUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 18:20:36 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34195 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbfEWWUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 18:20:36 -0400
Received: by mail-wr1-f49.google.com with SMTP id f8so7921093wrt.1
        for <git@vger.kernel.org>; Thu, 23 May 2019 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sWIe4Zm5cTMp7FSQFVeCpz9ortnn98AFdsM9JY7vXLI=;
        b=Pu4qMOQ57utoKhtOV4rEQmQA4X8VVXJMHP/aHZuQTHgFS8fw4xM5O3BVVgP6kYTduG
         AiMAND2+zM2qR1NpwPCGjxDlEhKVGf1S4fEfqCYe3iWgCB6aBOcf7jnnQAinXpkyoY7C
         Gl2+KiBFZhEmU+UsdvGI1S4CL7d0vU0XH4Hbq9RO6REGF52GYOJzUUGa2T/QSUeNszJG
         ICzqLl5U1IPQGZa7mtX9ZTJj4bqtN4K7Ze4DVnqrHkfbGEFCnLKs9H4bpKBzK3X9c9xX
         rLjLV5B2Re2LIULq7Ac7NNPd8L2TNcekbRlfC7zJpygjOw4QKcZJUOswdd0y+kwb4ymk
         95Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sWIe4Zm5cTMp7FSQFVeCpz9ortnn98AFdsM9JY7vXLI=;
        b=cys9g8jccHwWW8hkJz9Q2zFl/oSCmsyHMbUzOpsd0vItUEMiUne0GFZQf3Yktp6WHM
         4bniLYFewC6aJeo9Ge+hAdS9D2ArFViPliGPS1VETSG/n9nMftW9JgJANonSoVjXdYz3
         al5DJxXGyBfX9dBbN0vVRUDSR2uLAkmqBqrUH6nxzXtHPp+93srYX6CwrSzXg1k81otg
         K4yghSxHXU2rkMr869cE9X5i4Wxi2VTI9YlJGjrI3wrqgcTkbzfQRz65uP5QoI8c+lq4
         HtZEOEbs/yP6G0T2KpkV2nEqCNepFqB/PefiETnAStMBwrhZCieRBx/8XY9QT0jnfJE6
         PUMw==
X-Gm-Message-State: APjAAAWiPc/Ovuf9h5V4l/DELbgj4wHwnuT8UStqnOdZx9LsmUK4Hg+E
        +xE15IAgtMD1IctKuxf8TatKYBji
X-Google-Smtp-Source: APXvYqy48uduV00EPxGIiqRPrZSI2bYEtYNUFZDlWZrjfsOX2OwGHX5DZxhPSqt4x/hLkOo+bq8Kew==
X-Received: by 2002:adf:e902:: with SMTP id f2mr60223390wrm.301.1558650034502;
        Thu, 23 May 2019 15:20:34 -0700 (PDT)
Received: from szeder.dev (x4db56830.dyn.telefonica.de. [77.181.104.48])
        by smtp.gmail.com with ESMTPSA id v188sm940793wmf.9.2019.05.23.15.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 15:20:33 -0700 (PDT)
Date:   Fri, 24 May 2019 00:20:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
Message-ID: <20190523222031.GC951@szeder.dev>
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
 <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
 <86blztq8ap.fsf@gmail.com>
 <87tvdkg7ld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvdkg7ld.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 11:54:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, May 23 2019, Jakub Narebski wrote:
> 
> > Derrick Stolee <stolee@gmail.com> writes:
> >> On 5/22/2019 2:49 PM, Karl Ostmo wrote:
> >
> >>> After producing the file ".git/objects/info/commit-graph" with the
> >>> command "git commit-graph write", is there a way to answer queries
> >>> like "git merge-base --is-ancestor" without having a .git directory?
> >>> E.g. is there a library that will operate on the "commit-graph" file
> >>> all by itself?
> >>
> >> You could certainly build such a tool, assuming your merge-base parameters are
> >> full-length commit ids. If you try to start at ref names, you'll need the .git
> >> directory.
> >>
> >> I would not expect such a tool to ever exist in the Git codebase. Instead, you
> >> would need a new project, say "graph-analyzer --graph=<path> --is-ancestor <id1> <id2>"
> >
> > It would be nice if such tool could convert commit-graph into other
> > commonly used augmented graph storage formats, like GEXF (Graph Exchange
> > XML Format), GraphML, GML (Graph Modelling Language), Pajek format or
> > Graphviz .dot format.
> 
> Wouldn't that make more sense as a hypothetical output format for "log
> --graph" rather than something you'd want to emit from the commit-graph?
> Presumably you'd want to export in such a format to see the shape of the
> repo, and since the commit graph doesn't include any commits outside of
> packs you'd miss any loose commits.

No, the commit-graph includes loose commits as well.

