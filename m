Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BAD2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbdGKTFO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:05:14 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33935 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755549AbdGKTFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:05:13 -0400
Received: by mail-pf0-f177.google.com with SMTP id q85so619245pfq.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TjERDxTPzWm/Bjl/fwgwoKKdVkBAdVREiSe1SB9lf7A=;
        b=h8/G6BY5mA1BBUsVPLfVdE6OTgB5eh1r1yQaZQvqf+NZdaooUGF6nC/mY0BSHJQPI9
         +rAfplw95Lj4Vre2BXLsBAmwWSGetQTbINmmqkPtZyQjg+PhupgtOr+PUXW0pniVbAX7
         A/ZRLhGQXgUlvKd4MXgeFK5qnTINVuNo9pvYs4Zkxeq5OFPNYkoPcqFpmghhYTUuWseB
         e4dZUBq+AbRAE+KZTGJjfs2ASjnYhstSQp2XARuka/ncu3VxcjN+K4RnDG1v4WS+6FOL
         FpEv7dU8/dg/fqBwEiV2jqMqUgcrnYAb5p+Rj42nwtoNPgKhwemtrBVHbrGIIoeuhim2
         uuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TjERDxTPzWm/Bjl/fwgwoKKdVkBAdVREiSe1SB9lf7A=;
        b=X5nasn5JKTFM3EuE1F+1vIQwLdi4GrgnvMOrXjnT7xwEzXjox1lII4LPr6SV+zrSGq
         6eY9Ql3C1qEjaJ6sRklCxBW7zI3o8QtaKl7Wqea7QAf7WjAKmA0VAOfhlZf8GwbYHamR
         gU6JwMF+8Q0E3TVHkPDAp/10QOpTVDRzANrsF25pabE78woKg9Xoz0TjH0OAYCab+Ec2
         /1nvIqOKGedU3/k1x2RxcN19ZDWmlqPg9eSnXuxGolZ5jSYblkn6+EY7jnUJXFj6Ml/9
         9uX8bIxCvu0ULqqAN2+B4qacE9g8QDe86bIX5Z4oCU0V97Bc/HC5kLPOmQhotdtHbL0f
         Bd4Q==
X-Gm-Message-State: AIVw113ZgmxuHSDP7u4GgnD3HndOsOBCLSgpwBx/VlajLfhblJOAQWKu
        UspMV9YWqpsrJpRw6AMQTkLJfhBixi8pi4TVhA==
X-Received: by 10.84.215.197 with SMTP id g5mr1397166plj.297.1499799902501;
 Tue, 11 Jul 2017 12:05:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 11 Jul 2017 12:05:01 -0700 (PDT)
In-Reply-To: <20170711175342.mllx7efdsqlzv5lo@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se> <20170711175342.mllx7efdsqlzv5lo@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 12:05:01 -0700
Message-ID: <CAGZ79kbQsRQaHjRccs-0jkYkfhBwU-gX-M3A9sP4hqTtqqpFYw@mail.gmail.com>
Subject: Re: git config --help not functional on bad config
To:     Jeff King <peff@peff.net>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 10:53 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 11, 2017 at 03:49:21PM +0100, Peter Krefting wrote:
>
>> That's fine. However, when trying to look for help, it is not that useful:
>>
>>   $ git config --help
>>   error: malformed value for branch.autosetuprebase
>>   fatal: bad config variable 'branch.autosetuprebase' in file '.git/config' at line 24
>>
>> Perhaps it should allow "--help" to go through even if the configuration is
>> bad?
>
> Yes, I agree the current behavior is poor. What's happening under the
> hood is that "--help" for any command runs "git help config", which in
> turn looks at the config to pick up things like help.format.
>
> But it also loads git_default_config(), which I suspect isn't actually
> useful. It goes all the way back to 70087cdbd (git-help: add
> "help.format" config variable., 2007-12-15), and it looks like it was
> probably added just to match other config callbacks.
>
> So I think we could probably just do this:
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 334a8494a..c42dfc9e9 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -273,7 +273,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
>         if (starts_with(var, "man."))
>                 return add_man_viewer_info(var, value);
>
> -       return git_default_config(var, value, cb);
> +       return 0;

Instead of ignoring any default config, we could do

    git_default_config(var, value, cb);
    /* ignore broken config, we may be the help call for config */
    return 0;

I looked through git_default_config which seems to only die
with useful error messages for compression related settings,
but these we may want to convert to errors instead of dies,
when going this way.

Thanks,
Stefan
