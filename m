Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7F91F428
	for <e@80x24.org>; Wed, 15 Aug 2018 05:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeHOIQJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:16:09 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:46943 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeHOIQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:16:08 -0400
Received: by mail-pf1-f174.google.com with SMTP id u24-v6so58066pfn.13
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z0Sh6mYXGPVC3RA1EA9nh24cgzqXWdmbXxbcEzQ0tZ4=;
        b=Jd/iX2ukboLCbzPVcVXN7m1LohSmo/RV+hd/U3pv2pzPHF8UpM55WyXa0RKv2+c+aq
         4zjcpRUAdsvrj1RLwouJ9WpKLxIbX5cmhgBNb+oVqbMtvtyb1F8/qUo6Y4ed+wl8Pkh2
         RKdGItUVjwU9JBhQs7EQ7fZCj8XbM1OvEl28EJLpep7y4lfG6P6KHB26t5L87vMxGcZO
         UD177mpU57/UMygBAmQ0TJbUyZ9IhziHYqPwTsLj7Tbyrael5sLsDuZI1/nEDIGoaYvf
         e13LvYOIpCC1NBnyH9f9DkNUyWGqirFY4L08aw7b6cWstFJdoXfkdB0fee+xc5Mp3djZ
         oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z0Sh6mYXGPVC3RA1EA9nh24cgzqXWdmbXxbcEzQ0tZ4=;
        b=Pk5hFcT0/Gcj9P7i4ej8xaKvHjbrhQk6j3yx2pmE3NpA5Bgxsu6vcdk36OCLZ7i3ik
         OlNLBr/22sGJxWQxwVYL13ACN0lqnHZUhwP+QE/Fx5mAGv9XLW9RPtMGuSWtFTlNuPxA
         4Px6b1Q6o9eYXPeT4j1aSJVeUnmZWvrni6vIVQhKm/K2dcD8CAsv4ZiLCWF016o/OWYq
         vtLWi6oDE043zLNwoL1TvOvEZ+SE89IAGfQylH75n4NBbcbMXORdqD44qTC+HXhCit3e
         yh+BO/WbZz6RYO32Xpqwt2DJ7K874yNP76nd6Xl6E26aWrpiopzUZhwH4LSuPYqZNyza
         OJzg==
X-Gm-Message-State: AOUpUlExxBMyS2l5DHRf9/xHfhnh/+G9ZF6TebJRHMIZpd6ocUEJkb7z
        OaN3ckbL76yVlhf1HtvbEi4=
X-Google-Smtp-Source: AA+uWPwD/isY8xBknQreebuNyyp2oBJ9c2vvnUF1ek+p33IUwSvVSOHEbBEyip7HQxqfumkfxmGzog==
X-Received: by 2002:a65:5288:: with SMTP id y8-v6mr110293pgp.284.1534310730134;
        Tue, 14 Aug 2018 22:25:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g184-v6sm43723918pgc.22.2018.08.14.22.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:25:29 -0700 (PDT)
Date:   Tue, 14 Aug 2018 22:25:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv3 4/6] urlmatch.h: fix include guard
Message-ID: <20180815052527.GF32543@aiede.svl.corp.google.com>
References: <20180811205024.11291-1-newren@gmail.com>
 <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171749.10481-5-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  urlmatch.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This has two benefits:

- avoids the definitions in this header from being evaluated twice

- many compilers recognize the #include guard idiom and also are able
  to avoid re-reading the text of the header twice, too

The header guard had been broken since day one.  Is there a tool that
can detect this class of problem?
