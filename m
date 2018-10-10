Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6461F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 18:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJKCBv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:01:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34586 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKCBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:01:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so5888466eds.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SC/2mhJWRsMmg+vrPoNGyylm1z6ZpOw9EE/tggo4ZtY=;
        b=RDwVIcTHK5R8L/8OAxsbISmlU7Ysq/iOeVGPv3aWm9oFj++TDDfDdh91mtUY2F9PqB
         46JT59AH85kcHi3nSZHXPvHAn0odFPQ5GTiJqkRrKfjICnYlKIT6tpt95rESOmpj7SeA
         cJhZ+0qHBC55/dYAQdkot/9b9xrE8QzuhyAlh+Lgo9X8JlyqKe/zRufTvWuqYLPR84DH
         MNR5mOLzXQcxIBxo/NVP6wxeYMSUPqfZEm3I0MrJoruwwYwY7PIDADRrAUJ7p0AsVQMk
         YbTDkingdLFRnAfLk9WnjqSwqzBI6CTCm6RmtfRAyoiyOBVrRAe8K3Va6lceBx3TSAcN
         EwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SC/2mhJWRsMmg+vrPoNGyylm1z6ZpOw9EE/tggo4ZtY=;
        b=SqMlBbR3+9zZpGZH5q0gAMLt7KjlXX9nLOrvcpdrQvPYfpox6Zett6ugS914QIYXKj
         w938S0zigT85qvlF8O/PnEn16rR0vrlHuFBvd5d1Y1+f0O4E3KcJ/kIDOvXkSB11zHDd
         0PGHSXXuMNt3gG1/4QpCXcVrUC+cYmUPHzaLxupuJDTkaGffWtKyIIoYuzD4tB2o1nkc
         CKDfk4VJGlEYUoliGFjtoglPWeGcCsBl/k0Y28/AuoqiUWyU8hvc9Sr+PMnptSjRTVtx
         Tj2UaQGQYlhKJDHdeieH2OJ74U3pg65OAuLJ0tXL9Ztw3f3ME/ZPbPYqeXXUTCtBqF6G
         JpAQ==
X-Gm-Message-State: ABuFfojzN5lTFhnYJfCnwPogq9YBcF4x1WUdy/zjRYnlDa3pYNxuoaBT
        V0fimXPJOr01ILYJBOkd7yo=
X-Google-Smtp-Source: ACcGV62ooBrBCJN25UfEDhmrdW2JkqHKmhjZQOomgXKNIF9GPQLUI7/5NDgqo4bnnRslddKrYA5HPA==
X-Received: by 2002:a17:906:7c96:: with SMTP id w22-v6mr34992650ejo.36.1539196705436;
        Wed, 10 Oct 2018 11:38:25 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id t10-v6sm2146165eda.2.2018.10.10.11.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:38:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com> <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com> <20181009234502.oxzfwirjcew2sxrm@dcvr> <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com> <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com> <878t36f3ed.fsf@evledraar.gmail.com> <CACPiFCKMF2di=waQ5reRtjUFEjuE6DkxxLcN-YnF-SqgE_m=_Q@mail.gmail.com> <875zyaf2f1.fsf@evledraar.gmail.com> <20181010165152.GA180779@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010165152.GA180779@aiede.svl.corp.google.com>
Date:   Wed, 10 Oct 2018 20:38:23 +0200
Message-ID: <87va69ejfk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Jonathan Nieder wrote:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> I'm just saying it's hard in this case to remove one piece without the
>> whole Jenga tower collapsing, and it's probably a good idea in some of
>> these cases to pester the user about what he wants, but probably not via
>> gc --auto emitting the same warning every time, e.g. in one of these
>> threads I suggested maybe "git status" should emit this.
>
> I have to say, I don't have a lot of sympathy for this.
>
> I've been running with the patches I sent before for a while now, and
> the behavior that they create is great.  I think we can make further
> refinements on top.  To put it another way, I haven't actually
> experienced any bad knock-on effects, and I think other feature
> requests can be addressed separately.
>
> I do have sympathy for some wishes for changes to "git gc --auto"
> behavior (I think it should be synchronous regardless of config and
> the asynchrony should move to being requested explicitly through a
> command line option by the callers within Git) but I don't understand
> why this holds up a change that IMHO is wholly positive for users.
>
> To put it another way, I am getting the feeling that the objections to
> that series were theoretical, while the practical benefits of the
> patch are pretty immediate and real.  I'm happy to help anyone who
> wants to polish it but time has shown no one is working on that, so...

[I wrote this before seeing Jeff's reply, but just to bo clear...]

Yes, like Jeff says I'm not referring to your gitster/jn/gc-auto with
this "Jenga tower" comment.

Re that patch: I've said what I think about tools printing error
messages saying "I can't do stuff" while not returning a non-zero exit
code, so I won't repeat that here. But whatever anyone thinks of that
it's ultimately a rather trivial detail, and doesn't have any knock-on
effects on the rest of git-gc behavior.

I'm talking about the "gc: do not warn about too many loose objects"
patch and similar approaches. FWIW what I'm describing in
<878t36f3ed.fsf@evledraar.gmail.com> isn't some theoretical concern. In
some large repositories at work that experience a lot of branch churn
and have fetch.prune / fetch.pruneTags turned on active checkouts very
quickly get to the default 6700 limit.

I've currently found that gc.pruneExpire=4.days.ago is close to a sweet
spot of avoiding that issue for now, while not e.g. gc-ing a loose
object someone committed on Friday before the same time on Monday, but
before I tweaked that, but with the default of 2.weeks we'd much more
regularly see the problem described in [1].

But as noted in the various GC threads linked from this one that sort of
solution within the confines of the current implementation and
configuration promises we've made, which lead to all sorts of stupidity.

1. https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/
