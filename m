Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A933203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 14:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735AbcG0Otj (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 10:49:39 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33022 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbcG0Otg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 10:49:36 -0400
Received: by mail-io0-f180.google.com with SMTP id 38so72366618iol.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 07:49:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Qs+QXUJ8MquzbyrWTSx4015doPy594GnEbTOn+IWVA=;
        b=Kxaob00zDwku0NLYGJW0GIZfFp9zGAUw3mGC3Bfys+DTKevLRoyPmlrs6IInMx/M/b
         28jEWvT0tHci2hDZsRprHqo6c2T9rBJ2mUnIyhDjkT3BYy9xksvCz44ykhAsRuud/B3H
         wd/9lXzrxzjp4PFSy2Zf9g8EFmAE5POETCUHF5kL3Y/RBEyT1EEUnkuZPwQg/owsf2Qa
         gUxQUD/sw4x5ueqgmAu6XwX9/KpDnZnShAF5mk+vXn2Fll/J5IkZUx/2ZyVR/XrgbgDm
         ZaqtTgqrwbH1NbJtnRk6oOAuScGUQKLIaojR7Z9K1bpRabwevzRCGtS81tP6SMReSjxs
         7J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Qs+QXUJ8MquzbyrWTSx4015doPy594GnEbTOn+IWVA=;
        b=S1RBMGezdpgkgjfabmybN6+oumLxH4bGMyq19m0Eqc7+D+JveBBxMtfqZ5OhWEwJ+y
         jEJy3vBBRnRSgWEtCArqNOyH8gIC+fINMJgRgSsfR3koANzXvXUJprb76EaP228gfO9s
         w19xIbU7som2rFmLyS0D+/iOyJmSU0G02LDA/rqYZSsYebu0Ab5sbGRauAjo7NRENxUI
         OzCbpXH1aTGPJ39aUOwjhFgVBbHcEe/zl2ug+1m7uBWCXDBnSwAif6reR/Mhz5UUDdHx
         pjdKUHC8wPpnYLsmEoPLC4up0Wu7k24iMPVqcp2NZwpmT3ZLYxIi5of/vA41EHBOvOMb
         Olnw==
X-Gm-Message-State: AEkoouuI4O0Aa7XwjJWEO3AjA/T9wh1e43qTep74APiWHYVQVCvHiCtwJP+srnrUx6jfdN05ANrQo7F087G0fg==
X-Received: by 10.107.8.140 with SMTP id h12mr34203734ioi.95.1469630974869;
 Wed, 27 Jul 2016 07:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 07:49:05 -0700 (PDT)
In-Reply-To: <20160727041058.GA9015@wheezy.local>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <20160727041058.GA9015@wheezy.local>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 16:49:05 +0200
Message-ID: <CACsJy8D+pyKXeci8xs+XBmVRat0QjnT94iqPuSz1r8Zbv780jw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Max Kirillov <max@max630.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 6:10 AM, Max Kirillov <max@max630.net> wrote:
> Hi.
>
> On Wed, Jul 20, 2016 at 07:24:18PM +0200, Nguyễn Thái Ngọc Duy wrote:
>> + - `remote.*` added by submodules may be per working directory as
>> +   well, unless you are sure remotes from all possible submodules in
>> +   history are consistent.
> ...
>> @@ -1114,7 +1114,7 @@ cmd_sync()
>>                               sanitize_submodule_env
>>                               cd "$sm_path"
>>                               remote=$(get_default_remote)
>> -                             git config remote."$remote".url "$sub_origin_url"
>> +                             git config --worktree remote."$remote".url "$sub_origin_url"
>>
>>                               if test -n "$recursive"
>>                               then
>
> I don't think remote.* should be per-worktree.
>
> * note that it is sumodule repository, not superproject.

Ah.. silly me, I thought all these were about supermodule. Yes it
makes more sense then to share remote.* (just like it's set up after
clone).

>   It does not even have to have multiple worktrees.

But we can turn a submodule into multiple worktrees after "submodule
init" and I don't think sharing remote.* is a problem even in that
case.

> * it is quite bad to have it different in worktree, because
>   git fetch then results in different ref updates depending
>   on where it was called. So whatever issue it was intended
>   to solve, it hardly made things better.
> * I'm not sure I know all use cases of "submodule sync",
>   but as far as I understand, it should be called when the
>   submodule repository stays the "same" (however user
>   defines the "same"), but older url does not work for some
>   reason. Then I think it is correct to change the remote
>   url for all worktrees.
-- 
Duy
