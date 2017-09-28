Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79EEB202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 17:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdI1RqT (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 13:46:19 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:51716 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdI1RqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 13:46:18 -0400
Received: by mail-pg0-f51.google.com with SMTP id k193so1328217pgc.8
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GBNSCam7uqARpl1XAJvvjjY4xup1tnmFYdgVtDaDiU=;
        b=CjnNVuhEJU0fCGFYEP16XsUPv+oejvCFMZNsHGwo6u5LFTcC9eglw6TcWXb/CBQpR3
         lGZH66dtzdIxBJ/8wJs0omqKMvbgPEjMhPf38vhU1JnRCvZMzmQJTfLtc/OZi4wKwKlL
         5I68X10QLTOlsaw76ArVg0IkXHEO8+KLDuPM+9Y9IiWSDxNVBCpLuGuZjt238nA4oq+B
         z08MUPDetq6sdv6/Msktk5joI+Tk60qxLNWexJvvzLDSmVD4frrQfLgCSmf+d00T31BO
         pjZXK5ZxeuNANXYaEVsHbnZRz2/e1vwQpYbnSNIfbkLxdM/1/UZZfyeIBpRNfb24d1pU
         lboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GBNSCam7uqARpl1XAJvvjjY4xup1tnmFYdgVtDaDiU=;
        b=NKevDwz7hx2kZCE6I4KX63x+FlDSISAmiMCIAbzGVCOdkWDeJE/c7/dgxnjZjSI0hs
         +wlkxJF19SWbrGitLcElFsYC6Dh03YKSv9IEFVCPS+TybJY+QrbmiTB6/RvIYJVqZQJu
         GBd/DjqpabKxbMHS68g5j8NxIo9gaPkKDEhEpj0aA7h+k7h5jpAxT2XkvjSTGitQRj/p
         cmmqs2trWOifg/GWcmO+Se4x++iHSidoWwkoq2idxTH5N2/tw7r0AYJMa0EXAPpTRf6C
         xPu7IIZIhr/5z/sr3UzSbZGQLaIkofZMOJeljAo+dL15zKVleD+gPt6tPYOh/c0Y3hBf
         rtlQ==
X-Gm-Message-State: AHPjjUgsf1wOAoMe7PlHAeU0wS0e7cJ7q288aMig6lsMNjJqm0FEu+jP
        Q/ocskFaMcwhAfV4TmWwSsHAAiWiLZw=
X-Google-Smtp-Source: AOwi7QCKOc09MsRNsUbPyay2jk1QTrG7ca5GO8FL++/NbfBWKzQywmg7Fvg7S7stva+omdI5Ew1Auw==
X-Received: by 10.98.80.85 with SMTP id e82mr5116234pfb.265.1506620777903;
        Thu, 28 Sep 2017 10:46:17 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:6d10:3370:77a8:b2d0])
        by smtp.gmail.com with ESMTPSA id f69sm4059845pff.4.2017.09.28.10.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 10:46:17 -0700 (PDT)
Date:   Thu, 28 Sep 2017 10:46:16 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-Id: <20170928104616.be61b394b50dc5193be275be@google.com>
In-Reply-To: <20170928004137.GD68699@google.com>
References: <20170927221910.164552-1-jonathantanmy@google.com>
        <20170928004137.GD68699@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2017 17:41:37 -0700
Brandon Williams <bmwill@google.com> wrote:

> On 09/27, Jonathan Tan wrote:
> > This is similar to using the hashmap in hashmap.c, but with an
> > easier-to-use API. In particular, custom entry comparisons no longer
> > need to be written, and lookups can be done without constructing a
> > temporary entry structure.
> > 
> > oidset has been updated to use oidmap.
> 
> After a quick glance at the code, I think it looks good.  I do have one
> suggestion though.  This map is structured much like our internal
> hashmap where if you want to include any data you have to implement your
> own struct with the internal 'entry' struct as the first member in your
> custom struct.  I personal dislike this method, despite the potential
> memory savings, because it makes the data structure much more difficult
> to use.
> 
> If all i wanted was a map from 'OID -> const char *' then I would need
> to write all the boilerplate code to make a struct which contains the
> map 'entry' struct + the 'const char *' entry.
>
> You are also making the
> caller responsible for allocating the individual entries instead of
> letting the data structure take care of that internally.

In the case where your extra data ("const char *" in your example) fits
in a pointer, yes it's true that the "util" design eliminates the need
to define and allocate a struct. But if you need to store more than
that, you will still have that need.

> To me it seems like a much simpler API for a map would be to just allow
> callers to store a 'void *' as the value.

I agree that the API would be simpler.

My main motivation with this design is indeed to save memory, and not
inconvenience the user too much (in the case where you're storing things
larger than one pointer, you just need to remember to put the special
struct at the beginning of your struct), but if memory is not so
important, I agree that we can switch to the "util" design.
