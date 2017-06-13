Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D661FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbdFMRQM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:16:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34256 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMRQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:16:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id s66so2810384pfs.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lw4Zaf4GHfyTsxIy10A5V5KMxCbwusZChA9WZmYtPYw=;
        b=SR1EeUYDtVLgFDu8cwTgjLHxB7jo+F51bOJkrrF7vFrTOaqMbADM3JccXLrOvz4tCB
         +je5PspqEJqFkaOinH/07UiR2jdxyThEOayhLHQnXElbHjiBmnZ+PT/FdQXA0k2BQ+8T
         1tXwbLBOxZ8uaiVAZO1Zgr6llUpTPj4U28nwhM2llx7UPHz1onVTdXgJQWfJwS8KjLy1
         tHzyyDiAjEOWpUF3q2/HjuVHBC50TCuPUeRKGoh8vwdzMUS5k+kpe+NQAhQRWPSnHsIc
         fi/mI8ZxPHReQNpnbw+Cmd+0wukI2/Lm+i4U1vbxT31uWB9oZRx2prrVoydxbmEg3NHU
         Hymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lw4Zaf4GHfyTsxIy10A5V5KMxCbwusZChA9WZmYtPYw=;
        b=US1qqxoJT9BxgrZzWd+DG/PmMJC1c5XAhEFHbG3lE3bOdqZ0nPzVvddBa0I0+/Rppw
         YqE5T4XBZxVV/mBPQc6g0Y1GgaL+nXpH1YGMVTVG1VYX6/3Rc+RukfGQmH6V0yM/umeP
         daN4YggC/t773BekL9YWG0lBbq+2Rjy0M0gqsiw8V8c9fRbLdmdJh82hW2K0QP5CgJd1
         JYIVN0lYEztzuTarJoSZG7d6p7lYrG/h4tJ5iqrdB/u+JshxwOUinN9TaayYOjNKOYlg
         Qk+xa8cvKAqrNCQcERWJwU9Oj0tnbN+BsUDXGn/xSS//1q0EcHM5gMq5vyDIWNj/MP5v
         Rnpw==
X-Gm-Message-State: AKS2vOzcMuqQEQIn5Iw85dF/5qL0THvige7gsKHfjDWam752yf0Mz+xz
        wEJ1SZkgBAZFI/5m
X-Received: by 10.98.98.6 with SMTP id w6mr592057pfb.67.1497374170778;
        Tue, 13 Jun 2017 10:16:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd0d:448e:29f9:5e86])
        by smtp.gmail.com with ESMTPSA id f71sm26227444pfd.98.2017.06.13.10.16.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:16:09 -0700 (PDT)
Date:   Tue, 13 Jun 2017 10:16:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] add: warn when adding an embedded repository
Message-ID: <20170613171608.GN154599@google.com>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
 <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
 <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Stefan Beller wrote:
> On Tue, Jun 13, 2017 at 2:24 AM, Jeff King <peff@peff.net> wrote:
> 
> > There is a config knob that can disable the (long) hint. But
> > I intentionally omitted a config knob to disable the warning
> > entirely. Whether the warning is sensible or not is
> > generally about context, not about the user's preferences.
> > If there's a tool or workflow that adds gitlinks without
> > matching .gitmodules, it should probably be taught about the
> > new command-line option, rather than blanket-disabling the
> > warning.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > The check for "is this a gitlink" is done by looking for a
> > trailing "/" in the added path. This feels kind of hacky,
> > but actually seems to work well in practice.
> 
> This whole "slash at the end" thing comes from extensive use
> of shell completion adding the slash at the end of a directory
> IMHO. (cf. PATHSPEC_STRIP_SUBMODULE_SLASH_* is
> the same underlying hack.)

I got rid of PATHSPEC_STRIP_SUBMODULE_SLASH_* recently, just an fyi.

-- 
Brandon Williams
