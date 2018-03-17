Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995291F404
	for <e@80x24.org>; Sat, 17 Mar 2018 19:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeCQTIZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 15:08:25 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34984 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbeCQTIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 15:08:24 -0400
Received: by mail-wr0-f175.google.com with SMTP id n12so14750588wra.2
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/z2ArvjLUYI5K441wMnZXPnWuqaol51Ylrvjou/aZsg=;
        b=U3rgChSgwuKp1AWwkEU3++F9sBclX6Q7p6H9MKWjNHUU5KAGHkbVaKjWFEqV6ULAgI
         AFXDr4NkTlHlhalNTVc46/4kbI0ATiKqGv2K+jvP4YYEkk3iCPHKSy5Ert2W1MnpIy20
         m8RBF87id1IpX7g8v0y45KWihQiPnc06U/b9c1EXAGvrB2dnAi0OX11iT5RRR9TdbOwT
         hYfhqiP9TJVK9KsDzFIwWx++DwxecIJtkIEM3NzfFtbU7Z0+bTIlcQlT09c6Jh/R49Yb
         ERs5QEw1qP5kLsTxGXJGW556x7upkXpAencl3PbgNrO7grexbpJAjiX6N0FcHdTosuUj
         r0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/z2ArvjLUYI5K441wMnZXPnWuqaol51Ylrvjou/aZsg=;
        b=a6Xle9zrApZmiWlFkHq4Ddh6gqGrqaCgolKUNDciGhGQVKGXsAeCbdgouloFcOo3O5
         9FguCzYrNAsuuPou3btn33ClbQPLZXwJUXVliFEvol2hQ11WPS7GZ8F2ByKOlFsy2R24
         Y6F4PZmwX2UdGPqoUmr9X1M08lihSR6H16CgvnocO4yNpiK92IeB9qeMKX+TYHnHWUFz
         STI0/KwNjVgHXpC79wwCnpGbcCrFx3BoJ9W8CC0gxCYvGSxYGTQL61YT9ioyG0lq+yqc
         D2QnJ8CkkbwW6ZJoMNy/7+zbvn1Epuas88AMoWYTJu6zxoApT2oh2AzGYOG+RgddNcf6
         4LPQ==
X-Gm-Message-State: AElRT7FTgjbd07ZN53mTJXou5tMaFmUHC4xsQXxrZbgPqYFCr3Hmpoxh
        ZJuHpkScAZ2P32I869Zd74E=
X-Google-Smtp-Source: AG47ELvWncKfIckZ9HE6W7pnDO2fqiCIH9NUT2BAFFRIQPJmcb+n9kXAXkFjDeJIMjJmfxa6kPoGXQ==
X-Received: by 10.223.183.75 with SMTP id n11mr4872584wre.22.1521313703440;
        Sat, 17 Mar 2018 12:08:23 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x82sm8921167wmg.7.2018.03.17.12.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 12:08:22 -0700 (PDT)
Date:   Sat, 17 Mar 2018 19:11:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eddy =?utf-8?B?UGV0cmnImW9y?= <eddy.petrisor@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
Message-ID: <20180317191138.GE2224@hank>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
 <20180306202149.GA160269@aiede.svl.corp.google.com>
 <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
 <20180316213323.GC2224@hank>
 <CAPig+cR5ncp9eMZ8krgy19A6g1Uqjx9dXTkus4r1QimD5Uwk0A@mail.gmail.com>
 <CAK0XTWcNySGgwgFgCPDnZ+m=2hfEgswHbJKYeu+LQfuQ9_=shQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK0XTWcNySGgwgFgCPDnZ+m=2hfEgswHbJKYeu+LQfuQ9_=shQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Eddy Petrișor wrote:
> vin., 16 mar. 2018, 23:44 Eric Sunshine <sunshine@sunshineco.com> a scris:
> 
> > On Fri, Mar 16, 2018 at 5:33 PM, Thomas Gummerer <t.gummerer@gmail.com>
> > wrote:
> > > a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> > > @@ -260,8 +260,8 @@ that starts with `-----BEGIN PGP SIGNED
> > MESSAGE-----`.  That is
> > >  Send your patch with "To:" set to the mailing list, with "cc:" listing
> > > -people who are involved in the area you are touching (the output from
> > > -`git blame $path` and `git shortlog --no-merges $path` would help to
> > > +people who are involved in the area you are touching (the `git
> > > +contacts` command in `contrib/contacts/` can help to
> > >  identify them), to solicit comments and reviews.
> >
> > It may be a disservice to remove mention of git-blame and git-shortlog
> > since git-contacts may not be suitable for everyone. Instead, perhaps
> > advertise git-contacts as a potentially simpler alternative to the
> > already-mentioned git-blamd & git-shortlog?

Not sure how much of a disservice it would be.  I think of
SubmittingPatches as mostly a document for new git contributors, for
who I think we should make it as easy as possible to start
contributing.  Interpreting the output of 'git blame' and 'git
shortlog' feels like an extra hurdle for new contributors, especially
if someone is not familiar with the mailing list workflow.  I do
remember wondering exactly how I should interpret this when I sent my
first patches.

> As a "victim" of the current documentation, I would advise to have the
> order reversed. For a new contributor, judging if git blame and shortlog
> are "more suitable" than git contracts  or git related is definitely over
> the reasonable knowledge expectation. Why is that more suitable than this?
> How is suitability determined?
> 
> A new person needs a straight forward way to focus on submitting the patch
> in the right form. With experience adding more people in cc will come
> naturally and those contacts might be aware of the contributor, too.

This is also my experience, as I am getting involved with longer with
the project I get more of an intuition who is involved where, and
'blame' and 'shortlog' start helping me confirm that and come up with
a reasonable list of contacts (although I'm still not always sure
whether I got the correct people or not).

But I don't know if people that are getting involved for longer read
this document much anymore.  So I feel like having the commands
mentioned here comes at the expense of new contributors, so I'm not
sure it's worth it.

> > Also, would it make sense to mention Felipe's git-related[1] which is
> > the original (and now more configurable) script from which
> > git-contacts functionality was derived?

The reason I chose 'git contacts' over git-related is mainly that it
comes available with git.  Mentioning both again makes things harder
on new contributors who already have enough to think about when
submitting the patch.

I guess in the end it comes down to who we think the target of the
document is.  To me it was always people new to the project, which is
why I think the single command there makes sense.

> > [1]: https://github.com/felipec/git-related
> >
