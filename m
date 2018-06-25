Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A41C1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964947AbeFYSrd (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:47:33 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41741 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964860AbeFYSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:47:32 -0400
Received: by mail-ot0-f196.google.com with SMTP id d19-v6so16198662oti.8
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bi6KU1uj/yozYancWmTcOe2GgAmmRABLVpHS/Fc2MjE=;
        b=DzV6nACU9A+B42WF+/sSFgDcGcWwlVXD0GrSpfr/SkqOHL4bKkdim7Npr4S13Z3rnN
         VOXCvgklAGLD3YP6HvpFYVeuuuSAGTeKie5zbJ5TZIE6K3Nb8EHQhwm0ioX9GMEqWmX5
         JaYlOLveFLGzLDtHl/lbO1UyttetcM2BPnauRQuAqsr2V1uYSNevDnr55NEedK3QKjY1
         Gpw/NSNMloFPz8K6zeBmYNQh7aWcaCHuygdRDmQCKEsbtz5dyoIf1oQ78A6rVyQwIzRZ
         JJN6pXtBK9RoMiYSAWyM2i64EUJvpoxcA16UNFw4+kDEru9uqcadE2453eed7LtadD9a
         CgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bi6KU1uj/yozYancWmTcOe2GgAmmRABLVpHS/Fc2MjE=;
        b=njrdjcb4XMhTAdNP6Pqmw6MNAzqbVChhM7zqShzWgKfMzPBbkunfzIV9w+HO6hTL0n
         b4kr4koupyydSLiLdy8fHpj1e2bUrML3uOf62nAOOfARQltd1yhwCYUnaoem9BT9lFm+
         fXzpE+y/dsmMvYQGC6iEAI36idpwZRrpF1Q2zO7m3bsmHiwi4TzM3BZ3dIWJv3NAEUOS
         vi28lUhUvi0Y525mjzxNdAJO83qleHW9il2LmBtCep3ypFPPWQRvUeQ6FvTrOwBssZU3
         CBfHKzhoNCH3q8ibO3EQ+RxGGJEiinewBUt577GaTq4PtUvzaWxoorJIIeL29k2/Nsdy
         TP0w==
X-Gm-Message-State: APt69E2HxIHTXgVOiEW4VGWnemVgOtgbIydueKzsSamU+4JgvMBO+0Bl
        MjeGLzRQWB36H8yUy5sUfM6fPmeF0Co=
X-Google-Smtp-Source: ADUXVKLm+RavkOBIkme/D7dr6TljQG7pP69uJy/VOP8XNKwE7pCPm1oiMFeEMVeR3/BGxIKh1oyekQ==
X-Received: by 2002:a9d:64c3:: with SMTP id n3-v6mr8623400otl.210.1529952451400;
        Mon, 25 Jun 2018 11:47:31 -0700 (PDT)
Received: from localhost (c-73-203-137-4.hsd1.tn.comcast.net. [73.203.137.4])
        by smtp.gmail.com with ESMTPSA id o55-v6sm10072313otb.51.2018.06.25.11.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 11:47:30 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:47:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180625184729.GA12140@syl.local>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
 <20180625184350.GA26688@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625184350.GA26688@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 02:43:50PM -0400, Jeff King wrote:
> On Fri, Jun 22, 2018 at 10:49:26AM -0500, Taylor Blau wrote:
> > Since the last time, only a couple of things have changed at Peff's
> > suggestions in [1]. The changes are summarized here, and an inter-diff
> > is available below:
> >
> >   - Change "%zu" to PRIuMAX (and an appropriate cast into uintmax_t). I
> >     plan to send a follow-up patch to convert this back to "%zu" to see
> >     how people feel about it, but I wanted to keep that out of the
> >     present series in order to not hold things up.
> >
> >   - Don't short-circuit AND when given --column, since an earlier NOT
> >     higher in the tree may cause an AND to be converted into an OR via
> >     de Morgan's Law, in which case the problem is reduced to the OR case
> >     (and should not have been short-circuited in the first place).
> >
> >   - Add a test in t7810 to cover this behavior (i.e., '--not \( -e x
> >     --and -e y \)').
>
> Jinxes aside, this interdiff looks good to me.

Thanks; I hope that I haven't jinxed anything :-).

I'm going to avoid sending the PRIuMAX -> "%zu" patch, since dscho
points out that it's not available on Windows [1].

Thanks,
Taylor

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1806222344280.11870@tvgsbejvaqbjf.bet/
