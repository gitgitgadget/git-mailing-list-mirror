Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0825B1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037501AbdDUJxf (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 05:53:35 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33324 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037475AbdDUJxd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 05:53:33 -0400
Received: by mail-oi0-f46.google.com with SMTP id y11so55354268oie.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ohTVbUZYOpqREuXUkrAqVU3zlc3cPXr65iZVG7aaDFQ=;
        b=BaR6SiNH/DCxsPayeSIIZmRPlPJ0KSycLYhWW++6p4RlpvItEr5WBgz+yfn8Fr+8KG
         V0l0LAfhxdXgKRaQGdVKbpzPK1pOQf+zBYgALt31kTN2zmrs9W733MStVKCWS8XH4kvI
         ThvQDsjWLz8Ja9QITSq4FH0+JH2Wcj+rCsE9RBuX4wZ5py9tEpj5KcuO4WYsnmOU0PJV
         64pTy8otHWC9jkFNhZOvK5FtlDbY+LyNqeJTW/6WTbcgGxqJdOEoyosGk0PddaWuxF9u
         T+Z3VkFQhaG4vykCVZjVRjWyci/hElfL/2KyUAObRtIYCaMcoWl8WHoTkuFzBqx4gXcP
         2+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ohTVbUZYOpqREuXUkrAqVU3zlc3cPXr65iZVG7aaDFQ=;
        b=FCHMDfzCKCoWuYJGikvQ6bkyiBPg/LOTM9esgV4bJb2a4b1PR/kN5wNTzXSjvvjuoz
         Qe+XPsGc3ybcVYxrE3t8LUiM75YG3yL1M/FKKdkZ+XNMeM1EPVVhwRXK3+sBwm53UUj3
         COnfgJNX/L8tFKTWDSz6NovvIeTYA3a3SY18FuJdE5D5c7Lnw94g3z5kHZdErUt9gAQ5
         nUS5vxBQnPWTiNxIwQR1rhp7N15iLASusGCQQnrM5mrZOU/nPLoY7wCA0ZRP8AImVisI
         fNRRUMf037mEwhhCgfovNDPp3uYuTmNnUW7YuhFYcAQmzbciUcLimcA4e4II8LY9NHQr
         6uqA==
X-Gm-Message-State: AN3rC/4PCuo1lkH+t9dG4QfzaZB4sGpd5j0twi7625vXDlHXTrtq0eSZ
        ZDACPp8da0kWJIWPsR9Oz1nntsk0Xg==
X-Received: by 10.157.61.163 with SMTP id l32mr8224405otc.28.1492768412814;
 Fri, 21 Apr 2017 02:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 21 Apr 2017 02:53:02 -0700 (PDT)
In-Reply-To: <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank> <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Apr 2017 16:53:02 +0700
Message-ID: <CACsJy8DotVErJjbUBmt9bxu90CSKEsqAT_nYTNXwstEk3YhN2g@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 2:10 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> On 04/20, Christian Couder wrote:
>>>
>>> Could you try with the following patch:
>>>
>>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>>
>> Yeah, I tried with and without that patch with the same result.
>> Unless I'm screwing something up when testing I don't think this fixes
>> the issue unfortunately.
>
> Ok, I will take a look soon.
>
> By the way I think that GIT_TEST_SPLIT_INDEX has become redundant now
> that there is core.splitIndex.
> So perhaps in the long run it will be best to deprecate
> GIT_TEST_SPLIT_INDEX and eventually remove it.

I think you can't, at least the way I understand this variable. It's a
_test_ variable to force exercise split index code path a whole lot
more, by running the entire test suite with split index always
enabled, instead of just a couple in  t????-split-index.sh. We can't
achieve the same with core.splitIndex because that's more about user
control and you can't just set core.splitIndex for the entire test
suite (can we?).

I would understand if the failed tests are about core.splitIndex (they
both try to control how split index is created), but failed tests look
totally unrelated. We may have discovered some bug (or that git_path
one Jeff mentioned).
-- 
Duy
