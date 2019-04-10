Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE6E20248
	for <e@80x24.org>; Wed, 10 Apr 2019 20:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDJUpp (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 16:45:45 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53608 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfDJUpo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 16:45:44 -0400
Received: by mail-wm1-f44.google.com with SMTP id q16so4042759wmj.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7L5S2nBqLcorBeHGmTf4oNs/b5Pd7wvxNhJTAQ6ZkCc=;
        b=teueE7onIpxcJsXMc6rps5IQIQY5YUBSJkXkSUTUJKpNkan5igz4Dnp8qbSvRnpc6g
         HsbpdBN2rABkDsU3ZAYkx5RUWZClWIjX5SZgun8UhUz/z6zU6JdP6hwcc7jmG9CMa7IV
         RnvzcIuUzpTf3OX3maorXXos1Axmq5QQhVTc9PJXCpZxuutYGXil/QE9ACfdG9OWt7s8
         Sh5k7LcFyaBCMMhiBauCEGXpg5eOdybqBt+H12LkgpMd0mu5+zmY75BLdrceJnfMsRkw
         l1ec1LYt34etFFhw8RCYBuVvRdJu5kDqt0DD68mtt35TsSbtl/eLCqnM08qC/c6upwKC
         CFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7L5S2nBqLcorBeHGmTf4oNs/b5Pd7wvxNhJTAQ6ZkCc=;
        b=BWNjFTRm7ooRSTc7aXxFHDBrZQnUHXr2t6849CCLt/+szgOjiKeSXTcdZ2HgMQRMM5
         XoRpwMPaNQLVLlX5JjmJi7ET27lLnKvzJfqY4BBpcJz2shYOZLgPFXj0cXuDFed755Ir
         SFW33MzNBI7GcBaDu/gRxxohI5xT4ap+YRogAH2JCX542CJo9w7B3SaRSv0mSb0P2Okw
         a8RptDOfBECWl4LswCFfFFWvaY+jxXNDrrEpy7CBbbk/LQFrEIEk6SmUvjAyC7vE5ba/
         g2v6z/P2olxj85NGuW2W0DmMbs738Mye23Lq8CG8tAot/Gx4l1vTC8U8zMpDVCgfzoRy
         E33Q==
X-Gm-Message-State: APjAAAVAVfAaZ80aIxNaTljotsGGglUAvV48HZr7D0IZHc75YGEH6wnw
        KKAx2epwQmV81EYJVvqJWqY=
X-Google-Smtp-Source: APXvYqwPtGQ7f2xX+am98hFRQGj1FSE4WdzKk55GLAc88iv/pqyLR9k5ytTYeS/tWBsI85zfxkJjXg==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr4039367wme.36.1554929142160;
        Wed, 10 Apr 2019 13:45:42 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id z18sm57644944wrr.90.2019.04.10.13.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 13:45:40 -0700 (PDT)
Date:   Wed, 10 Apr 2019 21:45:40 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
Message-ID: <20190410204540.GD32487@hank.intra.tgummerer.com>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
 <20190409191831.GC32487@hank.intra.tgummerer.com>
 <xmqqmuky36nj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmuky36nj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 04/10, Junio C Hamano wrote:
> >
> >> * tg/stash-in-c-show-default-to-p-fix (2019-03-21) 1 commit
> >>   (merged to 'next' on 2019-04-10 at 9489a31a36)
> >>  + stash: setup default diff output format if necessary
> >>  (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)
> >> 
> >>  A regression fix.
> >> 
> >>  Will merge to 'master'.
> >
> > ps/stash-in-c is still marked as "Will cook in 'next'", so I assume
> > since this is fixing a regression in that topic, "Will merge to
> > 'master'" is a mistake here?
> 
> Thanks.  I actually intend to unfreeze ps/stash-in-c and topics that
> fix it, now this topic is also ready to go.  So I'd rather mark them
> all for 'master', and give all of them exposure so that we can smoke
> out remaining issues, if any.

Ah cool, that definitely sounds good to me!  I was just wondering
because it looked like you had the intention of keeping the others in
next, so I thought I'd flag it, just in case there was an oversight.
