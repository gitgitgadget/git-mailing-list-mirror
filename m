Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D4B1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeCXUb0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:31:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39560 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeCXUbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:31:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id f125so8983006wme.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u4clfmIcLSKtPhD6c66UAmoliIcI1R123K6rM5YnMpU=;
        b=Neer34SRPgHcKkmpiTkGMl5EoQa7l734Rqm3Oh5jyF+0cH+BJly5n+VHogfynwFf15
         pV0NCkTjo4yDxaMZgikD4N0ddGJQ/X1Ekcr5zeuB5/UOYfX+WD+VIVLvhhUEbbe8NDor
         ZtKVxf0XNZODaNPfVQC/qc5WRzs7G9ImwmlRu4x+iJnIBdDRvZ4e8JsL/gqb5YGVKjN3
         d6ZJliHrN8dOEHfFQ3rGUnvdr4Ym9fCPVdydXn/bQw+yxWXv8Ks+RAeKNcclGASWeFbf
         2lwTdYeGHgSa+85rBRDsr5walXO8rKYAHEdwMmqPd1ZivNNUdwk+yOWd2/2d5A1PgMA4
         q0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4clfmIcLSKtPhD6c66UAmoliIcI1R123K6rM5YnMpU=;
        b=h8vw0Q/0B8DWHVaXBAAS8KoI3o/B/UPM+kzO5lxn4ZWgwDlA0hzA2MajA4j7FFiYYx
         LOiA9YUazthMXbpAxvEfwpFakfiVRXArxwJjNyl9kgWLzcVwJkLqZzgA1v7NpXqISX4L
         RiXow8KtJ2C0kWH1VWxh+4GyVLIEqKy7rfoCBnRwQ68NGZ8+PHgAEH+Di/UNq4J0GPcs
         pAyIP8WEzCllcNr6JmMmoAWZjGSmdwOiASuPz0TcDSmIsEqBTeGOOjGOHfKNkxEhVAMg
         ifm6ClpLhQqZzJjfnWtBdBYnQe0pNQH5mrzRhEm8UY2ss+qqUW1oUTjt7HIhc+HbpC02
         oumw==
X-Gm-Message-State: AElRT7Hf1L/va1fkpCOfIs5whU5oMiR0aNhqr/9P6H7cuytx+2DG5gV2
        S9dSNdqqwf6r8Sv4AmwGoYK9E7PP
X-Google-Smtp-Source: AG47ELv5Rg7Vl3vAMNpWXzL56BiEs0dzlJ5AVl5BwATMJcT5wNPkAOEOqW2ifHgxz3zglhVS9uKN0w==
X-Received: by 10.28.184.8 with SMTP id i8mr12775291wmf.52.1521923483986;
        Sat, 24 Mar 2018 13:31:23 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o88sm12322447wrb.44.2018.03.24.13.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 13:31:22 -0700 (PDT)
Date:   Sat, 24 Mar 2018 20:34:45 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] worktree: improve message when creating a new
 worktree
Message-ID: <20180324203445.GI2224@hank>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
 <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-2-t.gummerer@gmail.com>
 <CAPig+cT8i9L9kbhx=b0sG4_QYNdoEDPW-1xypM9xzBqPmqR__Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT8i9L9kbhx=b0sG4_QYNdoEDPW-1xypM9xzBqPmqR__Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Eric Sunshine wrote:
> On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > [...]
> > Fix these inconsistencies, and no longer show the identifier by making
> > the 'git reset --hard' call quiet, and printing the message directly
> > from the builtin command instead.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -303,8 +303,6 @@ static int add_worktree(const char *path, const char *refname,
> >         strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
> >         write_file(sb.buf, "../..");
> >
> > -       fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
> 
> A minor regression with this change is that error messages from
> git-update-ref or git-symbolic-ref -- which could be emitted after
> this point but before the new "worktree HEAD is now at..." message --
> are now somewhat orphaned. I'm not sure that it matters, though.

If those commands fail, we would now not print the "worktree HEAD is
now at..." message, but go directly to "done", and clean up the
working tree.

So while we no longer emit the "Preparing worktree" header, the user
should still be aware that they are creating a new worktree, and that
the error happened while creating a new worktree.  From a (admittedly
very quick) look the error messages would all make sense in this
context, without an additional message.

Printing the "worktree HEAD is now at ..." message before that
wouldn't make much sense, as we may not even have a new working tree
at the end.  We could add the message back, but that would also put us
back at three lines of output.  I think I prefer the more concise
version here in the normal case, and I think we can live with the
slight regression.  But if others have a strong preference for the
current way I'm happy to add that message back.

> >         argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
> >         argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
> >         cp.git_cmd = 1;
> > @@ -320,10 +318,19 @@ static int add_worktree(const char *path, const char *refname,
> > +       fprintf(stderr, _("worktree HEAD is now at %s"),
> > +               find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> 
> I wonder if this should say "new worktree HEAD is now at..." to
> clearly indicate that it is talking about HEAD in the _new_ worktree,
> not HEAD in the current worktree.

Yeah I aggree that's nicer.  Will change.

> > +       strbuf_reset(&sb);
> > +       pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> > +       if (sb.len > 0)
> > +               fprintf(stderr, " %s", sb.buf);
> > +       fputc('\n', stderr);
