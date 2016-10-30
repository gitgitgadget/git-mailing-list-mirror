Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20982022A
	for <e@80x24.org>; Sun, 30 Oct 2016 03:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbcJ3DJ5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 23:09:57 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37780 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754899AbcJ3DJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 23:09:56 -0400
Received: by mail-it0-f54.google.com with SMTP id u205so45987063itc.0
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JCOsiIszr4b4omcY51cz453Tvv6BnjkH8NKQtXhsrkQ=;
        b=wKM7j05N+V7lHDeDqmjKSibCl/h57/7d0UzidY+m9+zHpnpFrahVAwCLly7RpIUoBG
         D9EagD5EFmEP243g1EA/34tnjV7oeepyt/kP+jCDUNnmho9Fr7WLuzecKGgcHtZ2yyk4
         NNI0ea7RdA2vw5+R3mtiM9JQoLRnwaTVGjpscJbKFuUiVbCh0ghFIS6RuKQauunT1h86
         Mj0YY+jRRkvz3AaNfFU+F9OFbjflr9jG6zQBoXBOdom3m6pA1D0SsuBhi2a5s5F26gX6
         KbKYrZG7rIOunZGiYvKajKAbj+CW+oXK5hL6FzZBYsbbyVBcTtdB2h1difJ2X4/A3gLW
         rmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JCOsiIszr4b4omcY51cz453Tvv6BnjkH8NKQtXhsrkQ=;
        b=Gkd5l7D3R49y6IYHSGcbXzB5SnbkKRKSmJfanuq35LTyaeXdhPEUtwgRJ7XZRWw2R1
         BdxkVX/5T6G7njQuggJV/t8l8n/hSdKjE5NYdGHG99rFjZbc5KHgrKCL/MMpenlUhV9I
         VIA6kqAW4bo7jnVx+fDOtZqXE2Z+G0w4YQvGNcnU4nNKbsRsqHXXfUUFZf194IEltDf9
         Ie68FHkl3rGxJZgpbUu9W5UI7USi2JKCReBP88d8i0acGnFgFwvwPUJKJcDqo+78OiIG
         FpJloqVK2ZLLnbaHMRGIS4rij+yqjVLq/X4BciMH4iddAG2RiE/Hr2bqqQOimF6tkLUr
         uRDg==
X-Gm-Message-State: ABUngvcyeQrqAjtKV+IG+pO/m/7AHxw0EvyPOAChWp+R7cvnvqKKeN80+bVkW/XFGBaPwavgmoTuLWd3kLMYwQ==
X-Received: by 10.107.44.17 with SMTP id s17mr16312841ios.212.1477796995772;
 Sat, 29 Oct 2016 20:09:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Sat, 29 Oct 2016 20:09:25 -0700 (PDT)
In-Reply-To: <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net> <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
 <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 30 Oct 2016 10:09:25 +0700
Message-ID: <CACsJy8AMDW2w=xnAYDLTEN5MVxj+5JuiFnXGD1JFbD=RgLDcfA@mail.gmail.com>
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Aaron Pelly <aaron@pelly.co>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 4:04 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 27, 2016 at 12:48:34PM -0700, Jacob Keller wrote:
>
>> > I think the normal behavior in such "foo.d" directory is to just sort
>> > the contents lexically and read them in order, as if they were all
>> > concatenated together, and with no recursion. I.e., behave "as if" the
>> > user had run "cat $dir/*".
>>
>> Yea, this is the normal behavior, and the user is expected to order
>> their files lexically such as "00-name", "50-name" and so on. Pretty
>> traditional for a lot of newer configurations.
>
> One thing I will say about this approach is that you can implement it
> without any changes in git by doing:
>
>   path=.git/info/exclude
>   cat $path.d/* >$path
>
> and I have seen several config mechanisms basically do that (e.g.,
> Debian packaging for a program that doesn't have its own ".d" mechanism,
> but needs to grab config provided by several separate packages).

My first thought at this .git/info/exclude.d was "oh no I have to
teach untracked cache about new dependencies, or at least disable it
until it can deal with exclude.d", but this "cat" approach simplifies
things and should keep untracked cache unchanged.

There may be complication with negative patterns though. The user may
want to limit the effect of negative patterns within individual
exclude files in exclude.d so a negative pattern in exclude.d/a won't
influence anything in exclude.d/b (easier to reason, safer to compose
different exclude sets). The plain "cat" would lose file boundary info
that we need. I'm not sure. But I'll dig more into it when patches
show up.
-- 
Duy
