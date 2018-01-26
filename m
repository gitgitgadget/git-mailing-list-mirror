Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941B31FAE2
	for <e@80x24.org>; Fri, 26 Jan 2018 11:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeAZLWx (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 06:22:53 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43646 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeAZLWw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 06:22:52 -0500
Received: by mail-ot0-f195.google.com with SMTP id p36so136205otd.10
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 03:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f6hwYZyIKZ7cZb4NHacW+sBnRuZJS+nOerKWtDrex5E=;
        b=SY/clVeE6UDjmSSvShSl1XDQFnbMvOtmxHMgG5EmbcdrjmgBxAFWZHggvJv6TRAQx1
         KI2eq55T1/go54rEUq5aVBjAqRUY7mXVyfD1EA5D61Se4uBlAMeZm7RlKhsvtdONTUr8
         O1GRa8KxymnNuFO07/pUVnfF5B5UNwUoF8FSs1OU9xs4sCZWYaC0KlSVgzEPlHps4jdr
         6hX5C1uhBTvhSjSAILm4ROribw1PTLTqDyx4ESeycp3La5u7sKm8589mLgGwPiXmonXY
         B8WNtwjrO4eeDWgXvtEf8gg4XpWLxajjUFnbYWUU6xh/k7GachTxIy613IdHLxqufTNG
         JAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f6hwYZyIKZ7cZb4NHacW+sBnRuZJS+nOerKWtDrex5E=;
        b=ZwbWILJYqXKhFVSfO4d9DzwaLmHLTn9r5oSUVdOQlbGlBKKv6apMfNw6KSGiOqLk0c
         BUHzBE2wVGZ7fJi319LLPWocEDx6smLIrJHjyadngX694RUhY6fsIWKyrM/IxUmsmXwf
         FsMWyDDV252U3AAAZCiDsTBzp5T3rzqzFs+PgiyL6QVqac4CmbDxwm3zKkupmtKLKpF9
         dgTdH6DWRFUKpYwu5IlZr7q+8NIf+nTma9tpV6so/aqT8fg6rQsjjWXmLg2Ut7nYJJxw
         KFU19Ge79oT9/krKUMLI08jj29o1mk7wwLfPjsHxKNpQhV/Tqj0xrm5I1UGnvTOCnrQq
         dHeg==
X-Gm-Message-State: AKwxytdPawFnl1fATGMSTgZrv/VzdoW9eSkdrfG4L9eYq+Mn8aqS3uMV
        ZMxaKIkW99pZV7HD0Z87K7nydz2TF3V+fzfdmq8=
X-Google-Smtp-Source: AH8x2253z5BF5Ph/jmX1IldySmmTV4X4LqFhN1srxfdlP900SRHUkvaxwI7v+1pF3oSDqCGQ6icxtezwIaGhQ/YEFo8=
X-Received: by 10.157.14.65 with SMTP id n1mr14319121otd.337.1516965772069;
 Fri, 26 Jan 2018 03:22:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Fri, 26 Jan 2018 03:22:21 -0800 (PST)
In-Reply-To: <4d7eb4c8-8d48-7c8d-259a-ba6b2f64def0@talktalk.net>
References: <20180126095520.919-1-pclouds@gmail.com> <20180126095520.919-3-pclouds@gmail.com>
 <4d7eb4c8-8d48-7c8d-259a-ba6b2f64def0@talktalk.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Jan 2018 18:22:21 +0700
Message-ID: <CACsJy8BsJjuxD8hhZ9P2KgTxraRvCJgYt83onBaD_gXA0ZP9DA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: add --show-patch
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 6:12 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
>> index 06a4723d4d..5c513a9736 100644
>> --- a/git-rebase--merge.sh
>> +++ b/git-rebase--merge.sh
>> @@ -137,6 +137,10 @@ skip)
>>       finish_rb_merge
>>       return
>>       ;;
>> +show-patch)
>> +     cmt="$(cat "$state_dir/current")"
>> +     exec git format-patch --subject-prefix= --stdout "${cmt}^!"
>> +     ;;
>>  esac
>
> Here and in the git-rebase--interactive you have access to the SHA of
> the failed pick so you could run git log --patch and git colored output

Yes. My first revision I actually did "git diff" here. The only
problem is inconsistency because we can't color "git am --show-patch"
the same way, the patch source is in text format, not in the repo. But
if people are ok with that I sure would switch to "git show".

> and it would use the pager in the same way as 'git am --show-patch' does

format-patch does set up pager. If it does not I would be very
annoyed. I added this for convenience after all.
-- 
Duy
