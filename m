Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A35720248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCLSUh (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:20:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfCLSUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:20:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t18so3811000wrx.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PH+yy3DezjtuZQy8XKQ/8HUz0JxK5PPF9UBtdH3fQPU=;
        b=TVbzhUoCh4n8LcHBkrsqAHtxJRCUyvSH4nSGGSymU+zwnFvW8dkrG09j7ibC87Ltw+
         D/phnYWLd9Pxcz0lSUyayNqnKZcm6pRmeZVehQuMyuiJgwdb4qM+lf4LGkKEHoBQHpQ/
         pLcQtOT7AxbiPE5AbC1qB3S5o+PtPMTni2BrRv1FyhvA7VnmHdZ9Zfmp+KVrNcDJa4jO
         IwGJw+H8J6TXCtLcv53bAO2P2CBvknDJBaR/E/hKqxfKKQC9iTZw94TDqrYJAiQU+Rh+
         e96PwGVSann8IqkW6yK4+rsSUlc2lFiVej3Ox7XwxRAVyUQWtPOSSo1fsTrmCCaBIhyL
         Z7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PH+yy3DezjtuZQy8XKQ/8HUz0JxK5PPF9UBtdH3fQPU=;
        b=j45YGLJ7IBfSlddzSFdaorcjEHkI1rfjbxw60rJ9ks44Ah9ZJ9NloEBNOEvIpYRI5u
         tVs721h/V+gSCUNYZFarofRIJWPZMmMGDwd/0S7wt2Ja67mWx2usB39XMSfcAlksg5Wv
         +BIya+wOM9nWsvB1m2t/344g+DfoPoryXItLXlTe56O3KsTTo1SKs0o5ywrKn5OJz7rd
         f4CmcGCMwUs6DcTA+vRd3vH8SvAc/IReKhm78OXQXHRgbLuggPPCo4xPd+pSd/K6KYag
         nH9ii1VeSXZGj7NDVlJsXVJGRfRmIqJdx2ymlP1HAfX8UpnbMtrUExtmmwoSTkQ04FVR
         piSw==
X-Gm-Message-State: APjAAAXrQQmQQkLabXY6lnN8vVQ1x0eWU93hdWR5M+xDF0RD0EycqA1q
        /1caiUqLF500XT+JxSGeOBAlC1ma
X-Google-Smtp-Source: APXvYqxtYgN0B6BA19PF9iv2fLo1BCU749bDpNmPItb42MnjHMl7NbV4qgj64lTj9HWahzmnVFjjUw==
X-Received: by 2002:adf:f60d:: with SMTP id t13mr24560977wrp.225.1552414835383;
        Tue, 12 Mar 2019 11:20:35 -0700 (PDT)
Received: from szeder.dev (x4db53905.dyn.telefonica.de. [77.181.57.5])
        by smtp.gmail.com with ESMTPSA id a74sm5436966wma.22.2019.03.12.11.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 11:20:34 -0700 (PDT)
Date:   Tue, 12 Mar 2019 19:20:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
Message-ID: <20190312182031.GE28939@szeder.dev>
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
 <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com>
 <alpine.LFD.2.21.1903121411500.17683@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1903121411500.17683@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 02:14:37PM -0400, Robert P. J. Day wrote:
> On Tue, 12 Mar 2019, Bryan Turner wrote:
> 
> > On Tue, Mar 12, 2019 at 10:23 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >
> > >   never noticed this before ... when i do a regular "git commit" and
> > > enter my "vi" edit session and change my mind, i can bail with ":q!",
> > > regardless of what i've set up as a commit message, and i'll see:
> > >
> > >   Aborting commit due to empty commit message.
> > >
> > > however, i was just playing with "git revert" and, after i ran:
> > >
> > >   $ git revert <commit SHA>
> > >
> > >   again, simulating that i changed my mind, i just typed ":q!", but
> > > the revert went ahead, anyway. i tried again, this time completely
> > > deleting all the lines from the commit msg (as the template
> > > suggested), but the revert *still* completed after typing ":q!".
> > >
> > >   it was only after deleting all the lines and using ":wq" that the
> > > revert was cancelled:
> > >
> > >   Aborting commit due to empty commit message.
> > >
> > > that seems ... inconsistent. am i misunderstanding something?
> 
> ... snip ...
> 
> > When you use git revert, though, it writes a valid, usable message
> > to the file ("Revert <subject>\n\nThis reverts commit <sha>"). When
> > you :q!, that's still in the file. Since the file isn't empty, the
> > commit moves ahead.
> 
>   again, this is also not true. as i think i mentioned in my earlier
> note, if you get dropped into the revert edit session, even if you
> delete all the usable commit message lines, if you type ":q!",

If you type ':q!', then all your edits are thrown away, leaving
'.git/COMMIT_EDITMSG' intact.

> the
> revert commit still succeeds and, in fact, with all of the
> revert-supplied usable lines that you just finished removing.
> 
> rday
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                   http://crashcourse.ca/dokuwiki
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
