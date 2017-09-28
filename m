Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D7820A26
	for <e@80x24.org>; Thu, 28 Sep 2017 00:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdI1All (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 20:41:41 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:49767 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdI1Alk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 20:41:40 -0400
Received: by mail-pg0-f52.google.com with SMTP id m30so8686314pgn.6
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 17:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hd+Cqw1YgSCFYhL1ArOydluKxhihEjw72ciSfA2WTHk=;
        b=I42bv+/ln4Xqx9b9Wt+gN3Nx0pHCEclhZYfpzZCXhlSVHUuusIV4jDlVQPdqm57ak8
         K321rABL0lV9m9YFRrKVxVKYtVSOdr6R4Z/3EdSknJQrtd25LSKn0xuLEXWznWMCu6p8
         ce6ct/d2abvrxcm9/e3u3ypbC+gfg8YeU2FBGe4LCAsjDXmP8k8kN3dFo+/1USbnnx1p
         FaYEsL9xIRAVVCFTe6pPGYorR8q9w+K9oDIha3yi/7AjKe6u8pCvyIyb5A0JGCF6g4Qq
         I/sbOA54B2uxeS4w8wG3IiO5JAlNuW8+N6L605FVSmnnBvcpFmJjdT9pzNndHDpYedSY
         SiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hd+Cqw1YgSCFYhL1ArOydluKxhihEjw72ciSfA2WTHk=;
        b=UOLwTa57FLrYRyvlZD/d1IUttrFl4585EzXq7LgqylrK/ur6lsMMLl17aOuf0T49sE
         DTUacEIRfQUrlhDwc9JuxZzvqi8HfplmlnSJ3Z93k/za5qUADk18hRmfQ22xyoNx1YUx
         Y1VXoppUQ5f+ueTUbv38l6N7NEkKMWEwLwjapD7dLx2apL672xc34piN6Fqif1JEfSVg
         R8zozsiEeYDZfV8PcbNWygFuEbrO3OsWAC8nNh1aBt9AH7R00NPw8AgnoWwRnaoQr7or
         Cco2cgR23u7t9WxhvqkdKqsgu2iLTh+U1+OOF89pXZjHgLF5LMKl9rTj0BpUpzrkRGtf
         sJ3w==
X-Gm-Message-State: AHPjjUjsKaP4NWpJqdiuGx6onkOiBCrdjsCbvS+KWHYkxuVc6zfTX1cQ
        9+asAUPijprsr6CLkjmRdmaB0Q==
X-Google-Smtp-Source: AOwi7QAoniSe8CH1GMr1U58o9m+IsYfugpd6/QRKALbeSXOQ2DtbI9aEEJ7RNWXpLaORQ8jS4YGrFA==
X-Received: by 10.98.14.213 with SMTP id 82mr2786774pfo.320.1506559300075;
        Wed, 27 Sep 2017 17:41:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:880:967f:fa0a:fc13])
        by smtp.gmail.com with ESMTPSA id n83sm220080pfi.163.2017.09.27.17.41.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 17:41:39 -0700 (PDT)
Date:   Wed, 27 Sep 2017 17:41:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-ID: <20170928004137.GD68699@google.com>
References: <20170927221910.164552-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927221910.164552-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Jonathan Tan wrote:
> This is similar to using the hashmap in hashmap.c, but with an
> easier-to-use API. In particular, custom entry comparisons no longer
> need to be written, and lookups can be done without constructing a
> temporary entry structure.
> 
> oidset has been updated to use oidmap.

After a quick glance at the code, I think it looks good.  I do have one
suggestion though.  This map is structured much like our internal
hashmap where if you want to include any data you have to implement your
own struct with the internal 'entry' struct as the first member in your
custom struct.  I personal dislike this method, despite the potential
memory savings, because it makes the data structure much more difficult
to use.

If all i wanted was a map from 'OID -> const char *' then I would need
to write all the boilerplate code to make a struct which contains the
map 'entry' struct + the 'const char *' entry.  You are also making the
caller responsible for allocating the individual entries instead of
letting the data structure take care of that internally.

To me it seems like a much simpler API for a map would be to just allow
callers to store a 'void *' as the value.

-- 
Brandon Williams
