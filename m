Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9931F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfHZSkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:40:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42981 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfHZSkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:40:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so14876129qkm.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZmdYTRYfiXaVudALPkxZswgKp+gKkYxjQBCMlMXKww=;
        b=lxACr8HgyrW5WQmxS1NUeLWkJuTA3V8xZ3acfvbOpzrg0cFQcKCoZ4tqsXDnE0yRqo
         uxAFDIOWROI5SW2uh4duzSWYmVaD5lsdvFpWbIdwbLV7ZyBfMLmrU7zOMiYoe+twlmVz
         i6nqr/VU1Y9X8pFLYL+XJGIPO7t5uMkee2nhlRpUMtivc3Bce5EjLTVEp8tLSq8XVmfS
         oCJXc9OFPQW2XD7Y/EeLa3n4RzT0xvGSmChfeKP8zD+3y1X3NPRsIL5keq9lbxKJW8/Q
         eKlrROJRlWkzGMxpOkqmL9ZFAUrm52ES9IGqdzGk8SrCasJbeJwCCyMgaD/Y7hjbkD/b
         97tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZmdYTRYfiXaVudALPkxZswgKp+gKkYxjQBCMlMXKww=;
        b=QmhTs0mVabksuibGzTFx16IfTf3PD5H9cbiyqw2PmfidzVN1NGHA4GPISynC34pT8w
         eBbc5kwoO4ZQVhLZM3kzOF23BOe5l9vViMFX9nTPpgx0nsrQqOwYcG1EqWZF56jxw540
         VxdLhhLRG7rYY0msrh8mmsRKg8/sl8Tmkrw0l+Ls67PHnuhbJw/fkEgE0KfKNLE5yaM/
         +QHmRcvxHgGMRnuGcpIQrpfO7a6zH4PJFJuia/A5Nh5p7Q8YDvIxJ2dFVRbicPyhHY2u
         nb4ciw0RwI++sFtHUXrnOhUtwZSVVdJ/rn0J0+JNcyXSwEbuE6PuL4X/i9SqqTM9iCOI
         xaRw==
X-Gm-Message-State: APjAAAXHNCwl5j8EcPa9a0RC5kdFDCSpNYX3j2JVPuQ9eFLPmpGgH3Na
        SlQi1KcBNzL67LGvMkkM9k1b/g==
X-Google-Smtp-Source: APXvYqy3LG73yYIKO4qSfR75fNvNqwYCEmUKTdmhs5W2UrluTWQ68VGn2Am/1Db2EEqPhIWOwHECug==
X-Received: by 2002:a37:6248:: with SMTP id w69mr17692540qkb.225.1566844823924;
        Mon, 26 Aug 2019 11:40:23 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:a56f:bf18:42be:60d4])
        by smtp.gmail.com with ESMTPSA id h1sm6887290qkh.101.2019.08.26.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 11:40:23 -0700 (PDT)
Date:   Mon, 26 Aug 2019 14:40:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrey Portnoy <aportnoy@ucsd.edu>,
        Taylor Blau <me@ttaylorr.com>,
        Andrey Portnoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] banned.h: fix vsprintf warning
Message-ID: <20190826184022.GA30349@syl.lan>
References: <pull.322.git.gitgitgadget@gmail.com>
 <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
 <20190826183317.GB23399@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826183317.GB23399@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 02:33:17PM -0400, Jeff King wrote:
> On Mon, Aug 26, 2019 at 09:24:10AM -0700, Junio C Hamano wrote:
>
> > "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Previously sprintf was the argument to the BANNED macro, where vsprintf is
> > > expected.
> >
> > Good eyes.  Thanks.
>
> There's an identical patch in:
>
>   https://public-inbox.org/git/cab687db8315dd4245e1703402a8c76218ee1115.1566762128.git.me@ttaylorr.com/

Thanks for mentioning. I did send mine in around a day ago now, but it
came in on a Sunday, so it makes sense that Andrey's message may have
appeared earlier in mailboxes when looking today.

I don't really mind about the credit, nor do I think there's much value
in crediting you or me with 'Racily-implemented-by'. My patch has a few
more details such as blame information (and how the typo was only made
in the explicit version, not the variadic form), so it may be worthwhile
to take that instead of this, but I don't mind either way.

> and both were inspired by:
>
>   https://news.ycombinator.com/item?id=20793298

Indeed. It was a little surprising to see 'banned.h' at the top of
Hacker News when I checked it this weekend :-).

> whose author has little info there, but I think is separate from either
> submitter.
>
> I don't know if we want to try to spread credit around via trailers.
> "Racily-implemented-by:" ? :)
>
> Anyway, the original bug is mine and the patch is obviously correct.
>
> -Peff

Yep.

Thanks,
Taylor
