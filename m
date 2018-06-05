Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037BA1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeFEUqY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:46:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53564 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeFEUqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:46:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so7416213wmc.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yhyv4rR2NNdSwscKCR3CtI1z39m6MUYlEoXJcnURv+I=;
        b=M83qCdsFcaeIKEtMIzlNFfbU4nvTSAuM+W2/a6kKdTP3YbykVxPZCMF9ful7p+4ctR
         vN8+/sDPkXKcrFcQmofoo/ncx0TgzbiqCersIHR9EEEA+/3VORRHINqBfn7V1zdXCWkt
         JP41BiavcpSNjTnqvd3avtG6S44Gmc/o5bEQuaR8jCt5BLwL2q+yXqgv2/eTmfzsEPNU
         onXiBGu1DIf51QF/qlVWU00Rlj1wxoxrzlWZsDU9eyTrp7IKpmyihPXRZYvEx/ykPNc/
         fR9jtg8MLKjtYd7IZO4X4oS9AtTtMu4ngXA/t5s8fC7X5XugD1F1B9w7BfnH14q6Ngm1
         WjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yhyv4rR2NNdSwscKCR3CtI1z39m6MUYlEoXJcnURv+I=;
        b=ShdROKN4NoxOG9Je9h1b2CYkaLb0E5W3TZ0gQRMLZkAKnqDvyLq9zorlYPAJL664Oy
         rLyZqFkiIuY7AFzf0CkGCjnuSt1jM+/qKuaVcvM88Cf/oMKTmTD0YeLPejT1cA+048kQ
         moJreR7cz92dO5+RUnL3KWHOSTm3OjRmaU0hUd5piJiEPEv09cogW9GoTBAcLqY4B9MB
         /qzVvbM+Vl/viNkBgtsCRpFrxytAwmV7YkY44tfVjIVA3pqo9woomUOdN2gGG15uT/px
         gTZq8pInFvRnp4cWqPM5CqyubXUYbGmzBVgDkdfvsQ9FlpM3FD2hsIY5cWrBYXVePHKt
         esmg==
X-Gm-Message-State: APt69E3UpIk7Mcz/1ZJsWmD/wLz1P1xEp6zHwf8iffpxiTEdxqsGDr8c
        qyrHumP9mwwt23UgoAPr310=
X-Google-Smtp-Source: ADUXVKLW5gGhWivLT6uRre4hZMQL/+Dwq2IzhrJ3ZSRy5sOIiBBQuJd/8foVgFXD5/mVdPTKrBfPMg==
X-Received: by 2002:a1c:9b04:: with SMTP id d4-v6mr430349wme.8.1528231581068;
        Tue, 05 Jun 2018 13:46:21 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id r75-v6sm3737837wmg.31.2018.06.05.13.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:46:20 -0700 (PDT)
Date:   Tue, 5 Jun 2018 21:46:07 +0100
From:   Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marius Giurgi <marius.giurgi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH 1/2] docs: reflect supported fetch options of git pull
Message-ID: <20180605204607.GA4679@rigel>
References: <20180604215023.20525-1-rafa.almas@gmail.com>
 <CACsJy8DVi0rqjw0dCdxppb=e+jH5yNcX9XcRXDnvLXS8x0QsJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DVi0rqjw0dCdxppb=e+jH5yNcX9XcRXDnvLXS8x0QsJA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 05, 2018 at 06:05:56PM +0200, Duy Nguyen wrote:
> A better option may be making git-pull accept those options as well. I
> see no reason git-pull should support options that git-fetch does (at
> least most of them).

I sent this as a RFC, mostly to discuss what is the correct path to
follow. Updating the documentation was trivial and would still be useful
if nothing came out from this.

> It's basically a couple of OPT_PASSTRHU though so not very hard to do.

My impression was that in the past git was very permissive on adding new
options but nowadays it tries exercise more restraint. But not sure how
relevant this is anyways, as pull already supports the majority of the
options from both `fetch` and `merge`.

> PS. Anybody up to making parse-options accept multiple struct option
> arrays? This way we can have much better option passthru without
> specifying them again and again.

If the path is adding just couple of OPT_PASSTRHU, I could do it. But
I'll wait and see if someone picks your parse-options suggestion.

Thanks for the review.

--
Rafael Ascensão
