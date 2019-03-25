Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647CD20248
	for <e@80x24.org>; Mon, 25 Mar 2019 11:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfCYLNB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 07:13:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44153 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfCYLNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 07:13:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so5499717wrn.11
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NjkKAhIsU30ZyAkclHbFGX1eIMRC4ModRS1ftlJl2dg=;
        b=Uqn9waWnleb01yJp1rzoGm9+aoyK/JtWnWS4rvpMn9PtQT+QRP3tTT0/QjvSJRym6U
         TXhqF0WLnR0ys/WM6yecQgFgWqFauDPfeG9hR0OlAJ4gIVvd3DqfppU2NgBuNgiwnpSp
         PrYrkknrp1y4Rm7iEvops82QCaubHVbafzG4Jtsg3M+Bpn5VywMSr16pZ5YVJMyE+w9b
         wg2T9axV/oMaMZ4aAMOtgFeTjmzWwdlE6cZVpMoBNaBM/tmWMpAoUDO02HMc3StInx3p
         Hb0f23WWnx67LIEsAKSL6ZMorJHdH4qdg288j13RWXzx+JYGrI213bZQDvSwu/SfWFRb
         i/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NjkKAhIsU30ZyAkclHbFGX1eIMRC4ModRS1ftlJl2dg=;
        b=T6rq7s0RpbwPaJ6DYyY84lh7PbZSLY3F6ZaglxlccRzPYTqQ3OWktk4S0UvJ6ukthJ
         3KDYfLppD9CDSuniFhTkyvSC8Ga25667eCrYOz+fgo+5g8yWCYEzck0AH3s98/jznGcJ
         ivwcb1nPyKP5dDzrFhNumtcsGCrkYpjZifEC1Zl6wG1XMeEThjDAJilTm0PVxzlCxe5q
         deZul6FvuMKExLSyh1IQXGuQjdWP2r8AS/1a2wCV8maxU31dO4GV9ZORqecSK98w/gSj
         voogntfvSPZYRAzX5RBTD3c5rjujQJT4LvUaYKK+MxqNzGxEOwFAN4rX7bxuqAMnIuLC
         SiFg==
X-Gm-Message-State: APjAAAWcqYkzvaoFVeHcYszdhAnzP0h9lEIAmbgwZSt5bUhiuzTGyFqu
        GVmJ6OFq9NiS1wstQK+jL6g=
X-Google-Smtp-Source: APXvYqynnQ9eWJbu2n8qwbxbcZ1SZrN7GaugWNakeDlO2XHMun/B9/SoNFRXnUcCJmjQMUFVD6QOJQ==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr14776624wrv.282.1553512379396;
        Mon, 25 Mar 2019 04:12:59 -0700 (PDT)
Received: from szeder.dev (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id m6sm21146217wrr.53.2019.03.25.04.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:12:58 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:12:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/5] progress: break too long progress bar lines
Message-ID: <20190325111255.GK22459@szeder.dev>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-6-szeder.dev@gmail.com>
 <CACsJy8AYC24tbDhq6LJ5FgZEcSsOYTuw-G88eXdKzbT6iP3NNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AYC24tbDhq6LJ5FgZEcSsOYTuw-G88eXdKzbT6iP3NNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 06:02:13PM +0700, Duy Nguyen wrote:
> > @@ -225,6 +241,8 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
> >         progress->throughput = NULL;
> >         progress->start_ns = getnanotime();
> >         strbuf_init(&progress->counters_sb, 0);
> > +       progress->title_len = strlen(title);
> 
> I think you need utf8_strwidth() so that the "cols < title_len"
> comparison above works for multibyte encoding too.

Oh, indeed.  I remember seeing the Chinese translation and wondering
about it, but then completely forgot by the time I got around to it.

> > +       progress->split = 0;
> >         set_progress_signal();
> >         return progress;
> >  }
> > --
> > 2.21.0.539.g07239c3a71.dirty
> >
> 
> 
> -- 
> Duy
