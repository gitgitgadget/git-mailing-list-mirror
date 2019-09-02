Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCB01F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfIBRPn (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:15:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55355 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfIBRPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:15:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so11362204wmg.5
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mWRjyou9XC3G1zM5nN3G10qZ+NjygGZ1fsO57IiLxGs=;
        b=UDFv9961CkJY2QAdOZF1JGC0wZ+dbCZlxI1ea7sTgUJ0WCaAiwn2kyuvC0Dsx6uUCq
         uSlyxrRDI6NintEkANtbBnI0t3jpLTGXo7cAkumMDopdQDyhy7xQAGzf7zccwRWwo8sF
         anNo3JdV+wSvuGuABuDoDlMXYqsYzTnMWFE/IytXyWhU4CaD2NBOuHnYWtalDALPO3Vo
         z/f/fC7jQvadd+deGRvFBWNHUcXCxZyLehJ3oF1LwMA+tgcQyoysEUWCvcIf5+BF3I4Y
         4+NciEKf1qgnkRsNUCYx2JAvsui8i2LIf1V+uCUWLB+djNAzA0CxDc1XElILn33R/i/q
         U13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mWRjyou9XC3G1zM5nN3G10qZ+NjygGZ1fsO57IiLxGs=;
        b=Jx9vSvBt7ABj7MDXH1nlL+tQAgZxBOvtnEHG3XMaIP5Evh1DLOE3VpXBymG44K7JV9
         0xGGf1MRCeB4le6WTkBntmYQC+BMP4T+t+rdFijJwQXjGppNRWTA+WQ0deFLkzERyDT7
         lktmAOuf4IdGc0P9xYBJHc3sMqQal4sGU5RNAw3sahC2FB6m4SaVzSN3nNfUzSz2qGew
         RIKO8afSoitdyo98+z4TQ5Rd2/qFs5MNQETEpbm04AhtuLwYLBrwJGZV9JBdxjuFwWWy
         m/1UQ7oIaWoJ5O1+wjtM0RH2OTzW9UqXsLCJ4GCdfPlmhc1XbBnXnGA01toq/hSPqDca
         K4AA==
X-Gm-Message-State: APjAAAXDI5RWeP4NSmWgPjajBGoTe5etG0foFB1qCGTI/SXsQEbRjQLq
        2ATx7rAf/THHgGz1OPihscY=
X-Google-Smtp-Source: APXvYqwBYTNkJK2XQcMOReWd+eJI1Sbj0xJGW6GSQnFOtIlULLh6MHqACrTU6HaohWpX4ubLAY8XBQ==
X-Received: by 2002:a1c:4082:: with SMTP id n124mr22610249wma.154.1567444540724;
        Mon, 02 Sep 2019 10:15:40 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id h12sm11486237wrt.16.2019.09.02.10.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 10:15:39 -0700 (PDT)
Date:   Mon, 2 Sep 2019 18:15:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] factor out refresh_and_write_cache function
Message-ID: <20190902171539.GB77876@cat>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
 <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190829182748.43802-2-t.gummerer@gmail.com>
 <CAN0heSqZOG6NMJE4=RReKzG3eD_w1mh8EcYaAQWN6WBY3WuZ1Q@mail.gmail.com>
 <xmqq8srazipr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8srazipr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30, Junio C Hamano wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
> 
> > There's a difference in behavior that I'm not sure about: We used
> > to ignore the return value of `refresh_cache()`, i.e. we didn't care
> > whether it had any errors. I have no idea whether that's safe to do --
> > especially as we go on to write the index. So I don't know whether this
> > patch fixes a bug by introducing the early return. Or if it *introduces*
> > a bug by bailing too aggressively. Do you know more?
> 
> One common reason why refresh_cache() fails is because the index is
> unmerged (i.e. has one or more higher-stage entries).  After an
> attempt to refresh, this would not wrote out the index in such a
> case, which might even be more correct thing to do than the original
> in the original context of "git am" implementation.  The next thing
> that happens after the caller calls this function is to ask
> repo_index_has_changes(), and we'd say "the index is dirty" whether
> the index is written back or not from such a state.

Looking at the other callsites, we seem to do something similar
everywhere, and usually fail if the index has unmerged entries.  So
the refreshed index would only not be written out in the case where
there's unmerged entries, and we fail later, which I think is okay.

> > The above makes me think that once this new function is in good shape,
> > the commit introducing it could sell it as "this is hard to get right --
> > let's implement it correctly once and for all". ;-)
> 
> Yes, that is a more severe issue.

With this do you mean what you quoted above, or that the lockfile is
not rolled back?  I agree that the lockfile not being rolled back if
'refresh_cache()' fails is indeed the bigger issue, and I'll fix that
in v3.  I can also add something like the above to the commit message,
just wanted to make sure I'm not missing something subtle in what you
quoted above.
