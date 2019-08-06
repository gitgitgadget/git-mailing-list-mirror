Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3091F731
	for <e@80x24.org>; Tue,  6 Aug 2019 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfHFSPE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 14:15:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34686 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFSPE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 14:15:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so9483916wmd.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jb5Sb/sWob5GBCsrohXTg+yO001LTK7GcmKJVEx6V6Y=;
        b=s9969cX2gHpBj+kcufXfn/SzIOcbMFSDUZ4uGgyyZ5iqtdDsndf0i1RGDm2lgcjypM
         +Rc/rbPaffP5getC1uR+2emZqF5fnf6fOMiNm0jVil/cC6jNVFOYAgMyrabq0Aboakvh
         QDy5oIktt2gIiwH51BUUog6S3Ii9jn/k6FiFqHxZ764Tb75YQiubStovBVxczNm+BMrF
         QhrjUJN3twuTFhUEWtcw1DVF42Uv/iB+7r6GJVfybHu3LSPZghOvvE7xhPM7wKmz+fMY
         E+PtwC//Zrtyf92w1fHo+eyXWDOTO2+r4WMp/8L0MZ7o6pjb0LL1hjtdV2orx+ZvZE9M
         olog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jb5Sb/sWob5GBCsrohXTg+yO001LTK7GcmKJVEx6V6Y=;
        b=aGbapf1VEy5W+TH9QPvgXkmNcwEgk9Lktd6CF1vq2B9UVr5RPDnegOoP6+Nk5pCThX
         ehzxmUAuwwSaw0w1tMAoIqzCBMT3Rg0kpM7X5l2gjNOLBdGPrzyIFoDK7u8QjtCdaEoe
         ELLM7aWGulfLpZlFO6pNCFyQkCTnDmqpokCnhbzA+7qCrMm6Em29zgRKGZ/X7g0syBCU
         +5GCfMVHnGDAVyFD1QEV20hDD7qhh7Cej6JL8Y1EtfYFgyfmHN7NGJUO1QrXKwli0Pg0
         j7YdS3sYBEBGo/NgToh2+doB9OKQpR24iduAK5l9udZvOao60Vmy6QZHXMDMwskPwB86
         5czA==
X-Gm-Message-State: APjAAAUzlQHX+mlYsnITces/tfmlVsxuLREMAm4pdDNRaIuqn2kBV2AX
        bctFI5Y5Oc9e1//aP1Iem+A=
X-Google-Smtp-Source: APXvYqw69p8Qx6WONtoX35dil2GIlW0zWq324OmA0q24CHaJ2FVkddXR/BDAxMopQROkh3ngeZnfuQ==
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr6228669wml.64.1565115302205;
        Tue, 06 Aug 2019 11:15:02 -0700 (PDT)
Received: from szeder.dev (x4dbe4c2a.dyn.telefonica.de. [77.190.76.42])
        by smtp.gmail.com with ESMTPSA id t140sm18217401wmt.0.2019.08.06.11.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 11:15:01 -0700 (PDT)
Date:   Tue, 6 Aug 2019 20:14:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190806181459.GG20404@szeder.dev>
References: <20190806143829.GA515@sigill.intra.peff.net>
 <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
 <000f01d54c75$1a8fe460$4fafad20$@nexbridge.com>
 <20190806173817.GB4961@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806173817.GB4961@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 01:38:17PM -0400, Jeff King wrote:
> Nothing about "--" is changed by my series; it will still stop option
> interpretation in rev-list and in other commands. But as before,
> rev-list (and other Git commands that use the revision.c parser) use it
> to separate revisions and pathspecs.  That's unlike how most other
> programs use "--", but that ship sailed for Git in 2005.

I'd like to draw attention to the oddball 'git filter-branch' command,
which uses '--' as a separator between 'filter-branch' and 'rev-list'
options.  Will it still work with this new option?  I think it will,
but not sure.

