Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461EE202BB
	for <e@80x24.org>; Sun, 31 Mar 2019 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfCaSte (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 14:49:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfCaSte (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 14:49:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so8983941wre.7
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gym2CQ125m3GTR6F+gg36wfDVcXG1k4PWr6xni2FpiE=;
        b=nUYj8oXe2/RaYAIKH5VLfLXHsNfAVL1bnEnZljYFHzAsbyOvfY6QVSZUkNSIqcc3S4
         v6tXt+E3LWgeIfEX7xzdl3wZlcnvxQ8KqWKZcW2tBkKZ8WHS0KiMLoS3O0e2SJnzVEyc
         Iz5zYpF/qFlODtv1HTEbazvLQ6tI/36P+70IVay+8G2X2R2datFjU8atVfabbCY6v7RZ
         GUFKQXgH734asgs1WXLSPu1UuHIiYI3Z3YfTfEDc2/rX0jX13tx2lnjk1dvPZ4RI2C3x
         FOxYWsCA+bpwBhlxdNbZ1SOQGmXgSwd2tbEX8cMD7qGmBf3ABdkcubDfkIDHJDLjjw5c
         yVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gym2CQ125m3GTR6F+gg36wfDVcXG1k4PWr6xni2FpiE=;
        b=SpQznzffYvRmjvsl44XA9seTcJP23WMYOlMmOMTiNmTZ61C+PdbC5MQ3YKoM3VqHLs
         DNsUj9q3qOVMns/+Ue+EJjbLLpDgeHATk9KotpQbRfqYB2LwsHh8CpH3yN35bNKrF1Cb
         8yoT5HWnGYLXj7TeDEskmwOvlSD2VLnxBvFcfLZTUkOI1p7ZoKDAHpL/TPeHtBJcXusj
         SCzrTqBwmWJ/rgVxUnhj1bXGY/2aSwy3zRTkqWWY0GHAX8c4xdBT/bNnaiCWIx1rNJJ9
         a1lQoaAcyGT7PD3Pl3RcWKwZBRYS4cyNrzKqaesQQZ+abO/cYz/6KesKIrF9BGBYHAB/
         xHng==
X-Gm-Message-State: APjAAAVR9/ekwx4FK3xnn3g5HcP5gVcpK7LyNuCiNP121n1GNCXXqOdW
        gWVgQzZcr7+PAfbXhbuV2K4=
X-Google-Smtp-Source: APXvYqwaw3dHeSDEXgtbpf+DRtC7hjcg84XiL/vcWi4QUPemiE/M5rFhKwv9Nhvd9bmlwqBe3qE3yg==
X-Received: by 2002:a5d:424b:: with SMTP id s11mr5322925wrr.158.1554058172432;
        Sun, 31 Mar 2019 11:49:32 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id v16sm16138810wro.48.2019.03.31.11.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:49:31 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:49:30 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
Message-ID: <20190331184930.GV32487@hank.intra.tgummerer.com>
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
 <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
 <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com>
 <CAMknYENqM1Q_2v+0_DJtw41M85otpYzbVbbKPyh2NVZ++u=fpg@mail.gmail.com>
 <CAMknYEPN2rPsX8CcJVosi-S1W8bLTmMMvgS8E-SwyR74gevtcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYEPN2rPsX8CcJVosi-S1W8bLTmMMvgS8E-SwyR74gevtcA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/31, Kapil Jain wrote:
> On Fri, Mar 29, 2019 at 7:23 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
> >
> > On Thu, Mar 28, 2019 at 11:14 PM Olga Telezhnaya
> > <olyatelezhnaya@gmail.com> wrote:
> > >
> > > Unfortunately, I can't consult you properly about structure of
> > > pretty.c. I guess that would be your first task of the internship to
> > > dive into it and think how to improve it. By the way, you could try to
> > > make more detailed documentation and that could be one of your first
> > > contributions. It will help you to understand the system better, and
> > > other contributors will be happy to read it.
> >
> 
> i traced the cmd_log() to understand the point at which pretty.c could
> be used, i only got to userformat_find_requirements().
> 
> struct userformat_want {
>     unsigned notes:1;
>     unsigned source:1;
> };
> 
> what are notes and source flags used for ?

If you look at what userformat_find_requirements() does, calls
strbuf_expand(), which in turn calls userformat_want_item(), which
fills the 'userformat_want' struct based on the strbuf that has been
passed.

Now if we look at the caller of userformat_find_requirements(), which
is cmd_log_init_finish(), you can see where 'w.notes' and 'w.source'
is used. 

Just this parsing is probably not something that the ref-filter API
can help too much with.

I unfortunately don't have much experience with the pretty, or the
ref-filter API.  But rather than going into the details of the code
already, I'd suggest first looking at what you actually want to
replace (see for example the PRETTY FORMATS section in 'man git-log',
what which verbs you can use in the ref-filter (see 'man
git-for-each-ref') to achieve the same thing.

Then you can see how one format is implemented in 'pretty.c', and see
how a similar thing using the ref-filter is implemented in
'ref-filter.c'.

E.g. the "%(objectname:short) %(contents:subject)" (this is missing
coloring, but just to get you the idea) is similar to
'--pretty=oneline'.  Now you can try to find how 'oneline' is
implemented in 'pretty.c', and you could translate that to use the
'ref-filter' API.
