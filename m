Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B2B1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 00:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeJTIM2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 04:12:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35339 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbeJTIM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 04:12:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id 14so30829863oth.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGuDUO9nIUxDCFhYTVrkx2RWeWBUgf7k0FN16TGGCr8=;
        b=eIVbj2MzSKPzvvKBlSKjpfh+A2B58ABPLuxXzItZn4oJe+wuelhOUt6ZQMFXSry2kn
         p62iF3yez+XPHnlyunoc/5xahey63VnBPmQn82h8c8eLmqujPrj52Bx4mqFGFraOi0q9
         dUIbL61uUC+196ZAXOCeaUeE6FBhaPMjzh5WOMErzeZc0lLemvP6QtmqRQAQGxQw04yb
         qvIlaeBQQ8q9hSvsjQVu8JzD3NLfQ4XXaPs9MdOj/SeExgKAzW+pAmyZpahFtzVVoEp7
         1QTP6U/UJ0PmnugNSzQcyWwAILQcDnW7Wwp3oPKixE/nNlpOW/7Zz0+GCJRRUqwbqTRf
         964Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGuDUO9nIUxDCFhYTVrkx2RWeWBUgf7k0FN16TGGCr8=;
        b=iTRYIkBAdRdhds+i1vSXHYTYddtB8g9+d++LRlBqoMLQRYTsufELJ0QEbHLNPpnRFw
         4JRtJEgIthyeFVCqkS2+TiPe0iVUQT0WzKWMauGmS4UPPPrFsfTCGnmnaM96Y0yF6HGF
         zOhhRrTm7ui/eqqQE65+Jt0EjsWzjdSn1aswpiPKsoxEvo7BKqtAcK6RXZdsp/l8caME
         V+mv9AxCzqmC5YMEmskudA8cTcTB4dvE430JDFBcI97vXUnLWD/leJYZZPj+q3JV4QV1
         d02HIwX+qWgNG+yEw9c5gDwaguos8n7buJcGyCkUFbBtrHGRshZEr1KCji+lTkuOfman
         oGoA==
X-Gm-Message-State: ABuFfog/oJYkZZAm1T3OKjB2vMCgpUDlwk4msRxh5Uo4hVcg4/u8UkRW
        UV29lBzjA5mPvDKwKUMV8IuqYzclHFOJv3vylxNP
X-Google-Smtp-Source: ACcGV62P0nuj692y7nZeuCSyBK1R5MILzJRSZKn7PIHXrzv+vuoylt4H14iS/PjGLEOL0YPmZvQznW6eoXdGXJ0OPCU=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr13866576otj.349.1539993848125;
 Fri, 19 Oct 2018 17:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539298957.git.matvore@google.com> <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
 <xmqq4ldo861m.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ldo861m.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 19 Oct 2018 17:03:56 -0700
Message-ID: <CAMfpvh+CDc_jToDmZaAypqwXvrhJMO-_4sUWRcjXwwz6OHhAHA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Documentation/git-rev-list: s/<commit>/<object>/
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 4:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > -List commits that are reachable by following the `parent` links from the
> > -given commit(s), but exclude commits that are reachable from the one(s)
> > -given with a '{caret}' in front of them.  The output is given in reverse
> > -chronological order by default.
> > +List objects that are reachable by following references from the given
> > +object(s), but exclude objects that are reachable from the one(s) given
> > +with a '{caret}' in front of them.
> >
> > +By default, only commit objects are shown, and the commits are shown in
> > +reverse chronological order. The '--object' flag causes non-commit objects
> > +to also be shown.
> >
> > +You can think of this as a set operation.  Objects given on the command
> > +line form a set of objects that are reachable from any of them, and then
> > +objects reachable from any of the ones given with '{caret}' in front are
> > +subtracted from that set.  The remaining objects are what come out in the
> >  command's output.  Various other options and paths parameters can be used
> >  to further limit the result.
>
> I am not sure if this is a good rewrite.  It gives a false
> impression as if you'd not see anything if I did this:
>
>         git rev-list --objects ^master md/filter-trees:t/valgrind
>
Oh that's interesting. So my mental model conflicts with the command's
behavior. It actually is surprising behavior because:

# this shows all files that were modified in the HEAD commit
git rev-list --objects ^HEAD~1^{tree} HEAD:

# but this shows *all* files at HEAD
git rev-list --objects ^HEAD~1 HEAD:

Which means that ^commit and ^non-commit are treated inherently
differently. Maybe I should fix this bug before clarifying this
documentation...

> It is more like "this is a set operation across commits.  We also
> show objects that are reachable from the commits in the resulting
> set and are not reachable from the commits in the set that were
> excluded when --objects option is given".
>
That would be correct though it wouldn't tell that you can use
"--objects ^foo-tree bar-tree." Without fixing the above bug, I could
add to your wording something to the effect of "You can also use trees
to include and exclude sets of objects rather than commits." Which
implies that mixing "--objects ^commit tree" on the command line is
undefined.
