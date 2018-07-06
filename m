Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56EBC1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeGFUP0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:15:26 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33164 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeGFUPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:15:25 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so5030003ybb.0
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CoaDm7cey5ybvvmrekdboRy1H+hXW5JalwqZfoqLLQk=;
        b=GoK0wuwYh3eKrRVSQ6EWmE68oFgru19lva/TbOgdArVHBPefWfX5paf/IEZcGFigIE
         ahp+CbZeisb0VvKCA23jjHcIqM45wr+SE6z+nF+K3ZYseD3lY7E3dCtF0jqOZDYLmxGt
         YF3PtqSf3Sqc9vX6vU9p4G6eWMDHQYm7t1h3GqO06Dyki67MrMcNfrwWF05n3jZfPRGS
         bwG2ulmAmqsW2zsRuxbUAdva7D2UAI/58WMQiAiea3P8wzqLN50pX0uCBKA4HItBCPDK
         2wx0senUxos/RzaB2RfKzPZEc9QhX7sKLnsmRzGOU2K4E/s1i/n8HUeYLw9uuJh+6bmn
         sqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CoaDm7cey5ybvvmrekdboRy1H+hXW5JalwqZfoqLLQk=;
        b=s6sO/qtLauB8jEzENqHL/6GSItqqUVR9bhsn5715y8ZhyJWTiV4bAQ3T4jO6hONf7z
         OJoJj7eotRW7f/EjUf505ycKG7w3ABvUkO5EGK26tvpqe0ON7l7bUyOOTg3gZmWDbMJn
         ThdycYfLgvfnWTg3nlge4r3XFCV/ugcMi6Ex4W3NgVCfAEyrSxmS51LButB9KbixyKrO
         NywLq7qFLBsj2Lh6OvuG2mcBmtyHP2ujI08rbr2tXz4mkFlwM0pT9ThFJR6LC6fpvGZ0
         Yx0uc95bnb8zPBopdoc71ju4jD8hj90WIMFDGynQEcyG/WFR3Ya+G2zCkVySaWPUmL6P
         kWlQ==
X-Gm-Message-State: APt69E2HixdF0FIfxLJX7p1zBtVU7XIsiNjdT5RqXGSLuSDRC/LuS/u0
        7UgITQwHJRxE1SkHXi4ZNWs+XA==
X-Google-Smtp-Source: AAOMgpdw2YS3SUgpv0318QommKjMcWp0V0KJIyhn0ptRDcBeMh9vuQsUS6jhfCdII3JVwbIW9gr/5g==
X-Received: by 2002:a25:ce49:: with SMTP id x70-v6mr6336311ybe.18.1530908124591;
        Fri, 06 Jul 2018 13:15:24 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id b68-v6sm7108704ywh.68.2018.07.06.13.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 13:15:23 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:15:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
Message-ID: <20180706201522.GA657@syl.attlocal.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530654455.git.me@ttaylorr.com>
 <20180705142110.GA10192@sigill.intra.peff.net>
 <20180705143401.GA87330@syl.attlocal.net>
 <xmqqlgaokyy5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgaokyy5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 06, 2018 at 11:21:06AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I think that this might be clear enough on its own, especially since
> > this is the same as BSD grep on my machine. I think that part_s_ of a
> > line indicates that behavior, but perhaps not. On GNU grep, this is:
> >
> >   Print only the matched (non-empty) parts of a matching line, with each
> >   such part on a separate output line.
>
> Interesting.  I wonder what "git grep -o '^'" would do ;-)

That invocation prints nothing, but on BSD grep it prints quite a few
blank lines :-).

I'm hesitant on sending a patch per the hunk of your reply below because
of this. Should we mirror BSD grep's behavior exactly here? I suppose
that we could somehow, but it seems like we might be doing too much to
support what appears to me to be an odd use-case.

> > I'm happy to pick either and re-send this patch (2/2) again, if it
> > wouldn't be too much to juggle. Otherwise, I can re-roll to v4.
>
> Please do not re-send a different version of a patch with the same
> v$n value.  Either re-send, otherwise re-roll, will give us v4, not
> v3.
>
> In any case, I find that the GNU phrasing is the most clear among
> the ones I've seen in this thread so far.

OK. I'm happy to re-send that patch with the GNU phrasing depending on
what others think (and the above). I'll let this cook and collect some
thoughts over the weekend.


Thanks,
Taylor
