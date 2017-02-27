Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520A91F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdB0SkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:40:09 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34445 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdB0SkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:40:07 -0500
Received: by mail-pg0-f42.google.com with SMTP id p5so23745246pga.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BiYshO5ar09MbRQwq2Z1hmBQRC/T1rr79RKEumn/g2Q=;
        b=Yvzl4nyHM8w5afsyuUzO+FbAwA1nULJDKBlS0t/45y3VHVqtDXACDFzWcqypOjMIfP
         IRQp0WFOxb5Ayw5STo7lA9ROCQRtv12g3/6u53h+Ltbv4l6zjfjRRAckZ1YcwkxoWJJH
         etnyg4yy2E2oyTAyPZjhEip4QMWHEV2nzUCmyDyAbHHZyIYvLtYw6l3A4CNYCQNOxu+h
         yg6LIU26JiiRuq81jAR07qAeem3dmKdr1ryepCj4eGNzpzwZ8wryVFwxTFxrzvr++GWf
         Yp64rLeuSAJa/bCVPV+7XNLckg7HXXrQi8vx1/rcVhJe5Cpapz5x+Un+gFAYsfUtCyIw
         JB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BiYshO5ar09MbRQwq2Z1hmBQRC/T1rr79RKEumn/g2Q=;
        b=Sprnj8hkV4KgD3Uws0F6LH7pRvMGPc0ms8DSk1tIZWMrV+R7Esxr8vuk/GJhg6Opg7
         hMpWPFX2M6ftQWrcU1CnaWVBKDTud8Hl9TL8sKQllqvoJs0vT00qkFx7zkxriJVr6hCb
         ByOxCXg3kJjb8Fb+h4wJjWXMqnLw/k5vUPG1JH4setQaYxYlRDh2uVLZYncfcHHOdoMJ
         mnKGGn7LfZ9evXPvsBuGdsNSG2568WO9loPhGrtXUUH/cqi219m5/FKtQgbhBmtpfskN
         tGRwPSgKYG5r459JEZBx++UiRONJyn7CjqgJCNXDcE2pvySQdN7h+bv8T4J2bEXXu/Vf
         YAog==
X-Gm-Message-State: AMke39kX+dp4T9sF/MVlW/Oj1LbF1NCueOBF1cCM4R+Y93kW+yfQy+BQ+ou+yowk8maPNuRY
X-Received: by 10.84.168.4 with SMTP id e4mr26450751plb.138.1488220696949;
        Mon, 27 Feb 2017 10:38:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:5d0b:b83e:e4b4:f20d])
        by smtp.gmail.com with ESMTPSA id m6sm31945674pfg.126.2017.02.27.10.38.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:38:15 -0800 (PST)
Date:   Mon, 27 Feb 2017 10:38:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] submodule--helper clone: check for configured
 submodules using helper
Message-ID: <20170227183815.GE153455@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170223234728.164111-11-bmwill@google.com>
 <CAGZ79kYmmeVOYSPTvAbGpRQn1YL9yjPOkT5xCoSDmtNzQ1t2fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYmmeVOYSPTvAbGpRQn1YL9yjPOkT5xCoSDmtNzQ1t2fw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Stefan Beller wrote:
> On Thu, Feb 23, 2017 at 3:47 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > @@ -795,14 +794,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> >         }
> >
> >         /*
> > -        * Looking up the url in .git/config.
> > +        * Check if the submodule has been initialized.
> >          * We must not fall back to .gitmodules as we only want
> >          * to process configured submodules.
> 
> This sentence "we must not ..." is also no longer accurate,
> as we do exactly that when using sub->url instead of just url
> below.

You're right, I'll fix that.

-- 
Brandon Williams
