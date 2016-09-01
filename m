Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD591F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbcIAVVR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:21:17 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35802 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933465AbcIAVVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:21:05 -0400
Received: by mail-it0-f51.google.com with SMTP id e124so4207274ith.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+iawVDhcS8AxaCFvWGASW+Q8giK1sBI181M/GHjj74=;
        b=Njuuibu5B0H95U/rGV2SAtZKxeES35Gl/ow23ZrnwciG3qyjSh5bBw6u9JuTWRJT3e
         b5jGwQLWgO5zpcgHNbTcDlgZTVS/2q/L8u8ITRrmkZnd8W8PaOxE/bsezWRJ8Q+PfsT3
         8NWlvvcLBTbSf2Hy+Fiuol9JAvnU0cpH/z2UjvG94ncV8Dv1cWcdtUmIOZJ+UJBlSUkU
         H70YHdJGMVIaYgknHjnKqqJ7Xa+WngE4OLqRv4gaDAAsKZ6bWdzZ3AbY4344vra172U1
         X65UPDmDXjjYvHi7WGWaBNFI4vjHpw/RtNDZo/B1rodKJ5UB6u/YlOQ1fNIbe0uHClUk
         Ah3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+iawVDhcS8AxaCFvWGASW+Q8giK1sBI181M/GHjj74=;
        b=GzkM88auGYw1DINCHDMHj0acq7vdoX9l+3sXXms4FGsmrvyOXPBaNMJHLgDz+MIMh+
         BdheHBj5X8m1OfHndkXe8Dl/MtlHK7wEQ3Rhd6Ek6/akW4HUoOkhJwgzkRUx5QDPYdM1
         0PPKzwFK8wYjhE7M0vthuqKUEoZ+W2US9/M2ugTmOFYmwZ6S4iOGaxBRnAu+pf82wXwe
         l3zH7lciBcM+UlRNht+Pf7mnTzgrdaz74BY4Rpp+jZdPJH9KXT3+gXwi/MOtAll0UbmK
         A22ylF3Vm3kREutfoh3gcVJM9XGtgQPUDqsn9e0Z1u/tb38rSUElnz9he1aUS2/h1JH+
         SgFw==
X-Gm-Message-State: AE9vXwO8IZdpKplbSKe3GSrvrS8Pi2Z0JFVqQcTUkL5yKpdeM8Od6l9oMkjwBUShPfDA+aw/LbDeeMB+J6JisAet
X-Received: by 10.36.93.201 with SMTP id w192mr16859929ita.52.1472755050884;
 Thu, 01 Sep 2016 11:37:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 1 Sep 2016 11:37:30 -0700 (PDT)
In-Reply-To: <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
 <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com> <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Sep 2016 11:37:30 -0700
Message-ID: <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Uma Srinivasan <usrinivasan@twitter.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The final version needs to be accompanied with tests to show the
> effect of this change for callers.  A test would set up a top-level
> and submodule, deliberately break submodule/.git/ repository and
> show what breaks and how without this change.

Tests are really good at providing this context as well, or to communicate
the actual underlying problem, which is not quite clear to me.
That is why I refrained from jumping into the discussion as I think the
first few emails were dropped from the mailing list and I am missing context.

>
> So it is a bit more involved than just a single liner patch with one
> paragraph log message.  I may be able to find or make some time
> after I tag the 2.10 final this weekend to do so myself.

Thanks,
Stefan
