Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6DE1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbeDKUJy (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:09:54 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:43976 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbeDKUJu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:09:50 -0400
Received: by mail-wr0-f180.google.com with SMTP id y7so2927568wrh.10
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DtJhSQjEd62J9P0g8YIMUr5F+v+NDY2C050Pj/uCEYU=;
        b=Obqk0FT+AQNwHUIB470C/jASCZLysczb8yCyBhnJi+hq/RFkwqugw6/uQZmLx+/HNZ
         fR34g0cmR0JbS48D0J/VFDF9Fnh1TGJ/3xKE+OQ+m/IafcdTPPudJ5uLQi2WJg+sp7Cj
         S4fMOtWZ2lNhKMJzdZxF7LZupEMoK5DEbT4CxM0iDd6YjwBQuW0WMJ1p74MAddX2Rpwo
         8EJeiVfMqzhVAbPmti21n3jMxUEio+lU9J2dsQYW1D6xDW2vISQHmb4tUQ177KAuvM7u
         QqMkFwtbkeWKQtv2M8ZceE3wCpoesY6YiQt4SCeshv5yLuwS4DF3zyb/q+W8K1dGgrLh
         NTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DtJhSQjEd62J9P0g8YIMUr5F+v+NDY2C050Pj/uCEYU=;
        b=stFl8VJOGHHP6VFuP5wrS8LQfJBN+yE/mIhDRTBdHZBZQb17k3Hhn72oFASe9jmZBv
         Cz17t0jg7uKdyLlbeS7eyGU8dMR9gIknfXpp8gK6ptZRv/CjeAct7s3JKZDXJdNWLXcu
         xyzWt26761T2AlvLS1h/Whnzlv0vYB8c+nH14PyE5OCs559jS8/51EcupxycIUp4GGMa
         NrL4pA8mzWmaX0FEcLFz8dpYQliI4z1Dy4nnX/+BtsDds90/LzQzPBtpZJ8uyoqAdMkS
         XKJQ+LtDISxjaxTDQmZGCLR7thGg9Oskmidk5DHlShlNaKowhfTx7JBEZOVdqDqdMSBs
         iTXA==
X-Gm-Message-State: ALQs6tDO6ASJXVStQip8vlGJngJreOQ/dxdaMbNLxAtahlf+PKs+YuLj
        0rEW6R1cX0PHHQoZ0zoOcRQ=
X-Google-Smtp-Source: AIpwx4/gj+cdMVnRvwxStOGCeKrTQSe+J0FdO9AHocOAiM9UJ8qPgk+y83ElKePr4uWtFS1u/oS74g==
X-Received: by 10.223.160.195 with SMTP id n3mr4632553wrn.92.1523477389138;
        Wed, 11 Apr 2018 13:09:49 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id h197sm2838414wmd.3.2018.04.11.13.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 13:09:48 -0700 (PDT)
Date:   Wed, 11 Apr 2018 21:09:55 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180411200955.GO2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
 <20180409193007.GL2629@hank>
 <CAPig+cRXsir3siZ5eArk6k1mF9kaDfFe1mL+T9faR6dxSUez7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRXsir3siZ5eArk6k1mF9kaDfFe1mL+T9faR6dxSUez7w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09, Eric Sunshine wrote:
> On Mon, Apr 9, 2018 at 3:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 04/08, Eric Sunshine wrote:
> >> As with Junio, I'm fine with this hidden option (for now), however, I
> >> think you can take this a step further. Rather than having a (hidden)
> >> git-reset option which suppresses "HEAD is now at...", instead have a
> >> (hidden) option which augments the message. For example,
> >> --new-head-desc="New worktree" would make it output "New worktree HEAD
> >> is now at...". Changes to builtin/reset.c to support this would hardly
> >> be larger than the changes you already made.
> >
> > Something else I just noticed that may make this a worse solution is
> > that this breaks the sentence in two pieces for translators.  I guess
> > we could somehow get the "New worktree" part of the option translated,
> > but that still means that if some language would require to move parts
> > of the sentence around that would be less than ideal for translation.
> 
> Good point.
> 
> One solution would be to have the new hidden option replace the string
> entirely: --new-head-msg="New worktree HEAD is now at %s", which would
> allow translators to deal with the entire sentence. Even clearer would
> be to drop "now", as in "New worktree HEAD is at %s". (Default in
> reset.c would still be "HEAD is now at %s", of course.)
> 
> Another solution would be not to augment the "HEAD is now at..."
> message at all. I realize that that augmentation was one of the
> original motivations for this patch series, but with the upcoming
> restoration of the "Preparing worktree" message:

My original motivation of the series was to just make the new dwim
work :)  Because that's adding some magic, the secondary motivation
became improving the UI, to help users see which dwim was used.  I
felt like this was going to be one of those improvements, especially
after we get rid of the "Preparing ..." line.

I do however like your suggestion of the "Preparing worktree (_branch
disposition_)", as that doesn't add more lines to the output, while
still giving a good indication of what exactly is happening.  At that
point just showing "HEAD is now at ..." is fine by me, and doesn't
require adding the hidden flag to 'git reset'.  So I'm happy just
dropping the change in the message here, which will simplify things.

Thanks for the suggestion!

>     Preparing worktree (_branch disposition_)
>     HEAD is now at ...
> 
> it seems clear enough (at least to me) from the context introduced by
> the "Preparing..." message that "HEAD is now at..." refers to HEAD in
> the worktree. (But that's just my opinion.)
> 
> > Would factoring out what we have in 'print_new_head_line()' into some
> > common code, maybe in 'pretty.c', and still doing the printing from
> > here be a reasonable tradeoff?
> 
> Isn't that getting uglier again? Not only would you have to publish
> that function, but you'd still need the hidden git-reset
> --show-new-head-line option.
> 
> Also, you'd end up calling that function from within low-level worker
> worktree.c:add_worktree(), thus making it take on UI duties, which
> would be nice to avoid if possible. (Unfortunately, the alternate idea
> of having worktree.c:add() handle this UI task doesn't quite work
> since add_worktree() doesn't return sufficient information for add()
> to know whether or not it should print "HEAD is now at..."; however,
> add_worktree() could be augmented to return more information.)
> 
> So, I don't presently have a good answer. I'm partial to the idea of
> not augmenting "HEAD is now at...", partly because context makes it
> relatively clear that it applies to the new worktree and partly
> because it's simpler (less implementation work for you) to leave it as
> is. If that choice isn't desirable, then next best would be for
> --new-head-msg= to replace the entire "HEAD is now at..." string
> rather than augmenting it.
