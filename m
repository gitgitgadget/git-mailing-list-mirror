Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B89D1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 15:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfARPGv (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 10:06:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33218 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfARPGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 10:06:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so10755421lfc.0
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRe2bDyHTofB8+P6VO+q/biyLR87UJ5Cxu3B8MvlDrg=;
        b=PPH6vt/RFdNbT02iBXxR5iugbJPKfMimwkYmx674k0hXwJxRccE/pTi4DuL5q0nMyH
         jEctdPPBe8oqN573RmkERmgPzmppLmuuu7P3nhAPV3hyXz/iiStgfJNLXD7RDJtDNYFn
         0idTosn6VYYawgiI5dKFbC0613cZxOVphgJu9vZ2SH7c3DaJx2u6YgpZmM+4llM8w/FK
         x5kYyN/UUsRjcDZFonZlG/16NSbMQLkY7lYgVO+YU0VXxVLcjLyu5CZlaRacSdm4kt1C
         N8OMz1J8j9/iLUC4dtxxB7jVKPfIFAv3l5CCwP7EdPCq7jU2Q0n6bNpNhVF68aSBsHIB
         i7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRe2bDyHTofB8+P6VO+q/biyLR87UJ5Cxu3B8MvlDrg=;
        b=L9LPtxs4ngRMhyEJbt3y9eaBfvb0kwybyxZ+aa7xSdbonEJnAe3hP6F2hFcBhqJ0Cw
         FQUejREk76bojuUqfKpQ8oBSF3Pi0Wlwj8Di8abECt1gzh2c7GP5+TActszILBuIwOZi
         Egk8fZKT/dbvYD/1bB1cdr7h9s29A0q4JHor0xy/A+t0REQJGQQIdEyctM8PeijvBDYv
         w5RL+oBcwWswkMRyhfgmkK2f3kUanSWfRqqjXq+ojTWhzNHtyKlJx/2Jt4cp7dwp9N2x
         0aE2Dd7ANqOaebuTUOepwKDcwsBVA2Dsk0c9eCJnCidz+XXKfspA9rnhTj8S28R6im4r
         e+og==
X-Gm-Message-State: AJcUukf1hteICx7ogJ70ovjruaGuAnmme3PXCe7Mddh5rI0LY3Qf8cp5
        J83LF23OqY7YSa/mH4ABsUojh+X/T+PX/6smFLY=
X-Google-Smtp-Source: ALg8bN6oB+drXa8nH2Lmaf5sXzX1kcYTXWuK7mR1pJsP5qpLyAypYScxbKPWb3lK+C2meHGeRWEjYPvQCxvo/fmagIM=
X-Received: by 2002:a19:4ace:: with SMTP id x197mr12561127lfa.39.1547824008798;
 Fri, 18 Jan 2019 07:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20190118010918.43705-1-brandon1024.br@gmail.com> <CAN0heSrE3mOnjyrzw76Gp6wBuq62wgM6jBV1u+vn3b6ySm0EDQ@mail.gmail.com>
In-Reply-To: <CAN0heSrE3mOnjyrzw76Gp6wBuq62wgM6jBV1u+vn3b6ySm0EDQ@mail.gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Fri, 18 Jan 2019 11:06:36 -0400
Message-ID: <CAETBDP7BcENA3Cjbj6y_5L3WGHx1wmMwkagx_CuRr5gAz9wYVA@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: add missing --gpg-sign flag
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Thanks again for your comments and patience, I appreciate it :-)

> > -               if (skip_prefix(arg, "-S", &sign_commit))
> > +               if(!strcmp(arg, "--gpg-sign")) {
> > +                   skip_prefix(arg, "--gpg-sign", &sign_commit);
>
> I personally find this a bit convoluted, compared to just assigning "".
> Maybe there are reasons for doing it this way that I don't see?

You're right, it is a bit convoluted. The reason I opted to do it this way is
because I wanted to reuse part of "arg" by simply advancing the pointer,
but this is silly and wastes cycles, and after thinking about it a bit more
I realized how silly it was.

> All of the commands above are suffixed with "&&" which means that the
> shell only keeps executing as long as the commands succeed. If any of
> those 20-30 commands fails, the shell will jump out of the &&-chain and
> land ... at this line you're adding. If that one succeeds, the test will
> be reported as succeeding. So please add a "&&" to the "10" line.

Woops, I can't believe I missed that.

> All of that said ... if I add the missing "&&" and run your test on the
> *old* implementation, it still succeeds. The reason is that I grepped
> for the "best" place to put this, and directed you to a part of the test
> suite where it might be a bit too easy to copy existing code and end
> up with something non-ideal. Sorry about that. :-(
>
> What happens is that git commit-tree reports "fatal: Not a valid object
> name --gpg-sign", then we go on to happily execute `git tag
> eleventh-signed` where we've just substituted the empty string produced
> by git commit-tree. The verifications will succeed, because there's
> already a signature there... (BTW, the verifications happen further
> down, so you'll want to add "eleventh-signed" to the list of tags
> there.)

No need to apologize, I jumped the gun. I'm going to look into putting
together a more robust test for this change.

Brandon
