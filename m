Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6174120188
	for <e@80x24.org>; Mon,  8 May 2017 04:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbdEHEBs (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:01:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36014 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdEHEBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:01:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so8175355pfd.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3tYBVht9OQ7H0p3muLZu1CFdofKqnY2mtcogxHKk/o=;
        b=rOqfmrBYLZ/FmmhRtBoDJqGnRtVu+4DNJdCpk791B5jDfPPL3qCgwRFWgdGp0AiWPE
         cYvAD071wcobK9xGnfjTHflRTX1Wfc+BDYiqWqDL5sOrUFAldYb0b25d+Gw5IsaSGU+r
         HqcSl9QM+QPtWejpORefKfbhnoQM2St73CS686iR1E8q+BICneq/0IQi56piN+iy9gCJ
         qWC24hFJKjhHmrz91EfVCdw4BcsvQZje2fJtXPR1MqorFn2dA4AwWvhZgImGxw2BMwKq
         GDqguxNNdpE/oSkqvOG/vdJPzoq1zrdHBT8s8Uzv+sbbw+nBc2hSE20tkc/18nHCHNSF
         2Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3tYBVht9OQ7H0p3muLZu1CFdofKqnY2mtcogxHKk/o=;
        b=ibhqmt+ffCFv+J8PHQkwZ5SRdMDklevQlLfkhOKViQHiWVGXpxADpOF/a6vbd+0eQV
         OH7XcMT4jx9jYKEEWcKwSep2zXdCCC10QJA/OUHAP61dJsqFhsZBw70S8YbNxyuUvF+a
         OkLHkqsZ73rqH7ytFu8ba6CnNPJ00Vv/JUZHBF9Zx6EWX7qyCzrG2wT4qLXoM0DHSTUn
         jE/Eyk5Om6y/x774J4Y4u2FjYJRrVmm2qRWgO92trpi6YfP9w3thSKMGi3jLd+prk6Nj
         raQ9I75yBCgztqiR+ShMbwE3rZRizj9bOrwD1903F+K9C6zs5AN+xyrd6p8mOXm96C77
         Ye1g==
X-Gm-Message-State: AN3rC/4CrWDvhMeDGpxfOT+gbCz0TC2xp0hOG5pNqUKs9wcgfu5JzLeB
        HICtZ/bgBGpHbg==
X-Received: by 10.84.234.8 with SMTP id m8mr81008615plk.41.1494216107326;
        Sun, 07 May 2017 21:01:47 -0700 (PDT)
Received: from HP ([116.56.129.184])
        by smtp.gmail.com with ESMTPSA id q27sm2487384pfk.4.2017.05.07.21.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 May 2017 21:01:46 -0700 (PDT)
Date:   Mon, 8 May 2017 20:01:32 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
Message-ID: <20170508120129.GA3540@HP>
References: <20170507233512.GA9332@HP>
 <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
 <20170508111836.GB3014@HP>
 <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 12:41:03PM +0900, Junio C Hamano wrote:
> Yubin Ruan <ablacktshirt@gmail.com> writes:
> 
> > I understand this. I just suggest that git add some warning in case some users
> > are not aware of this, as it does when , on branch 'issue', changes to 'lala.txt'
> > are based on a commit different from where the checkout happened, i.e.
> >       
> >      on branch 'master'
> >          |
> >          |  <-- git checkout -b issue
> >           \
> >            \  <-- modification to git happened on a commit different from where
> >                   the checkout happened
> >  
> > in this situation, git would warn us something like this:
> >  
> >      error: Your local changes to the following files would be overwritten by checkout:
> >      	lala.txt
> >      Please, commit your changes or stash them before you can switch branches.
> >      Aborting
> 
> That does not have much to do with "are commits the same?".  If
> 'master' and 'issue' branches are pointing at different commit, as
> long as they record the same content at the path "lala.txt", you can
> check out between these branches freely, as we can do so without
> having to resort to merging the edit the user made to the working
> tree to the different contents of "lala.txt".
> 
> There already is an indication that you have local modification in
> the working tree when we check out another branch (you would have
> seen "M lala.txt" when you did a "checkout" of another branch while
> you have local changes to the path).  

That is convincing :)
 
> Because it is a quite commonly used feature that you can checkout
> another branch and carry local changes with you, making it error out
> like we do when the branches record different contents for the
> locally changed paths when we do not have to would be a bad change
> that hurts productivity of users who do use Git correctly, which
> would mean that we need to make it an opt-in feature. 

I agree.

> But to help "some users are not aware of this" situation, an opt-in
> "feature" would not help all that much.  The same number of lines in
> the documentation to tell end-users how to toggle on such a "safety"
> feature can be spent to teach them that their local changes in the
> working tree do *not* belong to any particular branch, and as soon
> as it is understood, the user would be OK.
> 
> So...
> 

---
Yubin
