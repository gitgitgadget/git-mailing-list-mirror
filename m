Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49B21FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbdBGTO4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:14:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35112 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755243AbdBGTOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:14:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so12846301pge.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 11:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Spbmej9u6FssjNJn5X38lLh3jqgrKZ+/ux/1YBhADAY=;
        b=ESj7twLUDfHOLRUgYD54ONAEeso84yR9JsK9hKolRRaiv7jvl+aeCCpw7voCkMkCRZ
         qsdwi92O2ZSqSYmhqUc2VI9ukVW5GX91SIH+umo2ZkYauXqQyHnO6dRi07nouQISl+Gp
         TzgM2uBp1bGqLbMKWLjgo1amktWbtjtz9LJd8xBRBQvwpvmrcXlrxC56yr45IZ5ExABD
         hcGGfBFVVraAl3Y+1LEnPgb6mD8Q86pL8FzSpDZxu2GYqAq//E545WIdUGO2puzFnG/2
         DXQLID8jxAGMJrEy3IV4h/0OXmJy4mj57eox5p7RVLhZQy/qY0JtEDRy8dYJorp5wjsj
         we+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Spbmej9u6FssjNJn5X38lLh3jqgrKZ+/ux/1YBhADAY=;
        b=lDV2qjyiGjDIpyxfnHpbuJC0cmAwsnXUD0JgQmExwUcJnkrntY3u/GOsQ/KJX8KD+e
         l743VufRcomXszagLD58ECzYcDvMoDJVz6MujzSMuxlI9CrHi6ERJumDbJokVQGG6+uL
         QXZ8RcGxYxh38qDCgm9Nk+YRYS6Z5hQEE6qT6rxISjhx4vLjthVRjOYDOdRrLUQaPhZf
         h6Bb5pU8nByukaAvBpelmc+ftsPQsZpsG9v0JoNXngDuYma+XKuC4l30NR6israV3btB
         BheCt8RaiksyGBEPKTAmYqzDFDmRhzsYSRFkc+5KdNHLFRhFAkRawM+bjn/2PwLQRpJZ
         NxvQ==
X-Gm-Message-State: AIkVDXKMGQ6HXmkAk8+K3OqyUEZLKQb1OQtohdVHHS9QZqee4HoQudhYLnyiHJULi2qtEQ==
X-Received: by 10.99.177.79 with SMTP id g15mr22250668pgp.185.1486494893688;
        Tue, 07 Feb 2017 11:14:53 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id z74sm13407166pfd.70.2017.02.07.11.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 11:14:52 -0800 (PST)
Date:   Tue, 7 Feb 2017 19:14:50 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com, Matthieu.Moy@imag.fr,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous
 branch"
Message-ID: <20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain>
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
 <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
 <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 03:09:47PM -0800, Junio C Hamano wrote:
> The focus of GSoC being mentoring those who are new to the open
> source development, and hopefully retain them in the community after
> GSoC is over, we do expect microprojects to be suitable for those
> who are new to the codebase.

Okay, understood! Since I have spent time here anyway, I guess I will
continue on this instead of going over to a new micro project.

> 
> > (c) -> Else look for "r1^-"
> > ...
> > Case (c) is a bit confusing. This could be something like "-^-", and
> > something like "^-" could mean "Not commits on previous branch" or it
> > could mean "All commits on this branch except for the parent of HEAD"
> 
> Do you mean:
> 
>     "git rev-parse ^-" does not mean "git rev-parse HEAD^-", but we
>     probably would want to, and if that is what is going to happen,
>     "^-" should mean "HEAD^-", and cannot be used for "^@{-1}"?
> 
> It's friend "^!" does not mean "HEAD^!", and "^@" does not mean
> "HEAD^@", either (the latter is somewhat borked, though, and "^@"
> translates to "^HEAD" because confusingly "@" stands for "HEAD"
> sometimes).  

Yes, I meant that whether we should use ^- as ^@{-1} or HEAD^-.

Oh! So, that's why running `git log ^@` leads to an empty set!
> 
> So my gut feeling is that it is probably OK to make "^-" mean
> "^@{-1}"; it may be prudent to at least initially keep "^-" an error
> like it currently is already, though.

I agree with your gut feeling, and would like to _not_ exclude only
this case. This way, across the code and implementation, there
wouldn't be any particular cases which would have to be excluded.

> > So, this patch reduces to the following 2 tasks:
> > 
> > 1. Teach setup_revisions that something starting with "-" can be
> > an
> > argument as well
> > 2. Teach get_sha1_basic that "-" means the tip of the previous
> > branch
> > perhaps by replacing it with "@{-1}" just before the reflog
> > parsing is
> > done

Making a change in sha1_name.c will touch a lot of commands
(setup_revisions is called from everywhere in the codebase), so, I am
still trying to figure out how to do this such that the rest of the
codepath remains unchanged.

I hope that you do not mind this side-effect, but rather, you intended
for this to happen, right? More commands will start supporting this
shorthand, suddenly.  (such as format-patch, whatchanged, diff to name
a very few).

Best Regards,

Siddharth.
