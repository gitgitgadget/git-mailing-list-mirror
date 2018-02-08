Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35ED21F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHVnQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:43:16 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38572 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHVnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:43:15 -0500
Received: by mail-yw0-f193.google.com with SMTP id m84so3714156ywd.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xJNCKLW+nIte1EFYH1oc1Dupm5iihifMY0aWcGLOs/k=;
        b=ME3RNw+t2iiXHOM/kT/hm/Dbe1R3gGpvr/DIWTgKcz8w6TNPhCM1i08+5G2ZdOqBeY
         ncLpxOnU05ZSR8dcDLBWy6z0trYvEdS5SLbUyVxYQuP3sQnOTooX33SoaPziOkrLsDVZ
         zF37deGahaPGnYdq949l/tlGDssi6DFn9xHpZfz/8Wa9Vp3rucbHNZqkhR9dlniBJSHz
         YPNQlUgXaLjCXQKh0AWVm29fY3GHFyrhkOx8G4q6XsC+yDlipcuQ3yqXxKRl3BAli5M9
         QmHYqbJKiFf0pGOa42Tzt1wP4/57uejSvlVC7nQ+ySMXVBsroSv62QXz+XGwK6fe88iO
         eUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xJNCKLW+nIte1EFYH1oc1Dupm5iihifMY0aWcGLOs/k=;
        b=sJGTa5MF1NfVH7gRN6XmOrOyg0katZnf1lbtKyvuEmA3heWAv0ZeX8K6KbNDgfm0Jg
         f4RUqX+FiYlOpElBvpDx49A/HrNv8zqJoSkwLw+CCpSpsk0LhsYsigrnNLmqddMmNXFW
         CsM3iQt7CZsBrzDByPuGrZe3PMhQfKN7AyJSqxwW3yjngdb/XmWXLsUQt3FWFoqN8ZA4
         pDzBryOqOB4ff4q3VC1FSNt5zRXK5tEyyKfASP47mlqs8kIBaebYkd6QWU4DcQJFhIPf
         9bnn40DG2pgJ461qJi1HnZOhZryRLcx3rXXrvFNPnBbtYa1nW0UacUwVzUV62VvW/NHb
         6/vQ==
X-Gm-Message-State: APf1xPCxWQ+o8vHLFOkSHP5ZIayJP65f3CC4RWWBN3lbCNesrp85YDOJ
        V8VEwkJnqSeaf68UHR9py51dXb8yu4oq8K3gF/3AeAtW
X-Google-Smtp-Source: AH8x226gdNkhJb2aMcKjxka8S5xXuOTNKwVtlCGsIYnvaOFov76e6smHGO4WFWc3I4Im+FFOcnfcKTG2Pae2P49JI2k=
X-Received: by 10.37.59.204 with SMTP id i195mr367730yba.420.1518126194354;
 Thu, 08 Feb 2018 13:43:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 8 Feb 2018 13:43:13 -0800 (PST)
In-Reply-To: <20180208213806.GA6381@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com> <20180208204309.GA4541@sigill.intra.peff.net>
 <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com> <20180208213806.GA6381@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Feb 2018 13:43:13 -0800
Message-ID: <CAGZ79kYjHMYO19bJUQNWXyiwOp3HwiiAYuOHO9O7VnxUzzC1Tg@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: mention "static" and "extern"
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 1:38 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 08, 2018 at 01:04:08PM -0800, Stefan Beller wrote:
>
>> You may sense a pattern here: I currently have the very firm understanding
>> we use the extern keyword in our codebase.
>>
>> And I can also attest that this was not always the case, as back in the
>> day I remember writing patches without the extern keyword only to be told:
>> (A) be similar to the function in the next lines
>> (B) the standard is to use extern
>> and I was convinced it was a bad decision to prefix declarations with
>> the extern keyword, but followed along as I don't want to have style
>> in the way of writing features.
>
> It definitely was the case that people used to suggest "extern". I think
> this was a Linus-ism from the early days, and I have been hating it for
> almost 12 years now. ;)
>
>>   $ cat Documentation/CodingGuidelines |grep extern
>>   $ # oh no it's empty!
>>
>> Care to add a section to our coding guidelines?
>
> Here's a patch.
>
> -- >8 --
> Subject: [PATCH] CodingGuidelines: mention "static" and "extern"
>
> It perhaps goes without saying that file-local stuff should
> be marked static, but it does not hurt to remind people.
>
> Less obvious is that we are settling on "do not include
> extern in function declarations". It is already the default
> unless the function was previously declared static (but if
> you are following a static declaration with an unmarked one,
> you should think about why you are declaring the thing
> twice). And so it just becomes an extra noise-word in our
> header files.
>
> We used to give the opposite advice, so there are quite a
> few "extern" markers in early Git code. But this at least
> makes a concrete suggestion that we can follow going
> forward.
>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Stefan Beller <sbeller@google.com>

... and now I can resend that patch, after fixing it to
follow our style. :)

> ---
>  Documentation/CodingGuidelines | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c4cb5ff0d4..48aa4edfbd 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -386,6 +386,11 @@ For C programs:
>   - Use Git's gettext wrappers to make the user interface
>     translatable. See "Marking strings for translation" in po/README.
>
> + - Variables and functions local to a given source file should be marked
> +   with "static". Variables that are visible to other source files
> +   must be declared with "extern" in header files. However, function
> +   declarations should not use "extern", as that is already the default.
> +
>  For Perl programs:
>
>   - Most of the C guidelines above apply.
> --
> 2.16.1.365.g89f5777adf
>
