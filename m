Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C991FE4E
	for <e@80x24.org>; Mon, 27 Jun 2016 21:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbcF0VU1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 17:20:27 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35285 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcF0VU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 17:20:26 -0400
Received: by mail-it0-f49.google.com with SMTP id g127so75329581ith.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 14:20:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UIzFbM32BBJScctCMhH5kd9bojHDgrJuO9xKmxvYOm0=;
        b=mOKPFsvsAd7IpmMq8CJGhHpPFzbNbbNL7I7K3E1+VKHEEqJlieW7D+z210sEqKIQlf
         u8UTbhXEONjnO91lEN+qFx3zX0pYKpsIO+9om/5i5IjzPtfA8nlWKcgSfQLYFrwPfaFK
         o51N2Qjmwr4YdtR+d1djKrYlIqwFLesuQVou9o7KhrqLaAAA09XBMVmDqQB59FhL/wyB
         KlAB2gZax2VyZqVp5aTgdPyCSWHiO7s69oR3ThtkbTgtGcjlmrw2jqEsEZF8GmRXdS79
         dq9x1XKtodzL4N4c0LSmetwkTbRUggC8ULM76EAa3yIqXWAw6aXxZy8AmuxaHb/4u/dt
         GSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UIzFbM32BBJScctCMhH5kd9bojHDgrJuO9xKmxvYOm0=;
        b=WZwDm07Sm7Rt8eNMzrxjiZ1Mn7rRQZ5b/Vzzvxt1cO21pTgfGzdtjm4QKEncugOVZc
         dHDNgsl9BmlqsCTirXEeP282V25tT4b0M7oO4cr7TiyAOFj+qt/WVVe6DW5b4acUhrAv
         Mg2TVg6UEQvM17YJ1UA5Wxul/4+gGLnyWx90ZRiZnHIHFj8nhEdfpYzvEWA233eyzyDY
         mg5TmFZoRtgpLCLW1y6OIFreyan3798OuE0DXBA4YdGK5KNpXf4o/vfCu1ln0pcXMDED
         ga3vQZ4IAPUIDFnru+oZUzg/RENBdcxF4rE7CBNryZwnKOTlKnL4TM6vrDLiFYmdxEYX
         zSUw==
X-Gm-Message-State: ALyK8tIUl5FPzAL81FU1H2VeQLTyNl69FHtI6629bFn5y/P8li2qBQEd+zTpa2VKzPZVgKRQgSWzZXjG5WYaiddv
X-Received: by 10.36.91.80 with SMTP id g77mr6538390itb.46.1467062425426; Mon,
 27 Jun 2016 14:20:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Mon, 27 Jun 2016 14:20:24 -0700 (PDT)
In-Reply-To: <CAOG-3GJ5arRRixEAjMt00jp3A+ZQQ3bGXa+ZUQrpffJyAOP_4w@mail.gmail.com>
References: <CAOG-3GJdH5q9fdj+7zdEv-UUZMTAnunZu1PRJYjFNV360r6+sQ@mail.gmail.com>
 <CAGZ79kYKBxL4xLyySALBv_-gqkss9_iCk-qSc4T7u7fKDMOFWw@mail.gmail.com> <CAOG-3GJ5arRRixEAjMt00jp3A+ZQQ3bGXa+ZUQrpffJyAOP_4w@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 27 Jun 2016 14:20:24 -0700
Message-ID: <CAGZ79kbdb39NAF4wC35aH6kY7QGTjqkg=Q1RWmOzcO_d9-ZMHA@mail.gmail.com>
Subject: Re: Git mv -- submodule -- recursive
To:	Bart Bogaerts <bartbogaerts@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 1:07 PM, Bart Bogaerts <bartbogaerts@gmail.com> wrote:
> Hi,
>
> I tested this on git version 2.9 and it still fails (exactly the same
> behaviour as on the stackoverflow post; also the workarounded I posted
> there still works).

I see. the commit I referenced was solving a slightly different problem, than
what we do here. That commit only fixed the issue for submodules in a nested
directory.

The important detail what is different in this case is having another
nested submodule.

If you only had

- git-repo a
-- subdirectory 2015
--- git-submodule b
-- git-submodule c

(quoted from SO)

then `git mv c 2015/` is expected to work as well as
`mkdir d && git mv 2015 d/` with submodule b being nested in 2015.

but as you have a submodule inside of c, moving c is buggy.

Stefan
