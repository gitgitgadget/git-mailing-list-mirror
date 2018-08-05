Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AE11F597
	for <e@80x24.org>; Sun,  5 Aug 2018 22:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHFAw7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 20:52:59 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39556 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHFAw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 20:52:58 -0400
Received: by mail-pf1-f174.google.com with SMTP id j8-v6so5882915pff.6
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JCPCtZMR5m0kj4olGHRGR4HzZO0JOsS0eltapmDtyiU=;
        b=eVq6a9dVbOSyqpxAMrzgFNjOB1x/4XoHjJ6+3OIU31LALKH2LFMM/z+Ity7iqTX1Pm
         3ptKyBFpMuymQfdyWbBU1o3BZJ7iXGH6e+LwiYoAsqBCiYsdfEfyhYk1AZWFjJZ139aa
         f97miDj+EcVOThmpzkjGCm+lJG/7mkysP4N896gBjijZNlQl0TYCPcABDTsCU0R794lS
         66miB4xVuopDAIz3IJwzCKA41RuMGQWKuEI9n12JyP357aHQlb07FHrpQYCrNgjvPBVT
         i743se9/y+vLFJcFuf1KUJ6CyYXR4Gyyd2562rwSVbl9ZjVz+5Gk6At5mJt2/K/xXvJo
         iYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JCPCtZMR5m0kj4olGHRGR4HzZO0JOsS0eltapmDtyiU=;
        b=SC/Z6izPIiGq1GFYakLBU2/v+FLqdiHOSxtAz6E1UlIhabBu8sDfoNwuTo2KfGlhXR
         6WAtux8uSuLHBeL92b240MPIflUG9wd3sYHKPw2oGqMZlgNLsEd5/d8YKbaJYzoBp6mR
         ivB2TOGy6zxGV5W+19V71qCXn7kNeKLl35C/IOgPVJ7dP7/VH/1r2CgyCvRrAIL+2QUu
         6TrIeAMIa/2TXxYX200z//AimVn33aqTCpcqcubwr9S3vcN524FEMV6kxPsPsVen8KKh
         LMwfW8UY5curVRYOeGpP2lTBypGw7dzkeRom8aszxF97szJ6S9T5z4fCH8TPJi1/Ej72
         78tg==
X-Gm-Message-State: AOUpUlFBYLU38oo4nOkhwD2zHQ3eqrknngbbuQHkaoCcM+JKf8JF/HX0
        3SIOCVOQmYbfptw7tYZ9Q6Y=
X-Google-Smtp-Source: AAOMgpe0KP/mEcbQlbPdU/Jb4d63z4U5KEfJrMRc4T1AiUYg1htEN7u9sAYXTcqyDJL2v9Qe79oodw==
X-Received: by 2002:a62:d401:: with SMTP id a1-v6mr8475164pfh.51.1533509205913;
        Sun, 05 Aug 2018 15:46:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g15-v6sm16977167pfg.98.2018.08.05.15.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 15:46:45 -0700 (PDT)
Date:   Sun, 5 Aug 2018 15:45:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Karen Arutyunov <karen@codesynthesis.com>, git@vger.kernel.org
Subject: Re: git worktree add prints to stdout
Message-ID: <20180805224536.GA208811@aiede.svl.corp.google.com>
References: <631ae70d-9b5f-613d-5b6f-5064d548a894@codesynthesis.com>
 <20180805145254.GF2734@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805145254.GF2734@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Gummerer wrote:

> git 2.18.0 should print both of those lines to stdout.  This was done
> to match where 'git reset --hard' prints the 'HEAD is now at...'
> message. See also the thread at [1] where we did make that decision.
>
> [1]: https://public-inbox.org/git/CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com/

Thanks for the pointer!  And especially:

[...]
> I think eventually it would be nice to write all those messages to
> 'stderr', as I think they do make more sense there.  I said I may do
> that at some point in [2], but never got around to it yet.  If you
> want to take a stab at it, feel free :)
>
> [2]: https://public-inbox.org/git/xmqq604rzytx.fsf@gitster-ct.c.googlers.com/

Thanks for this pointer, which captures my feelings pretty well.

Jonathan
