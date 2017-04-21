Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8861FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 09:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037406AbdDUJjQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 05:39:16 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36267 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037396AbdDUJis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 05:38:48 -0400
Received: by mail-oi0-f54.google.com with SMTP id s131so450008oia.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DOx1cfi6yZFp34A5OaNDx2mfjtKq+u6Vylatxn2ypGw=;
        b=aULaGTAsSMjZ4kNjzTx+93zOx4UCCPqI4S2o6bUatpwXfVAY4SNAT1y6gX/lhpA/nc
         E3xPMHCzVXvktwACQTQENC2En9WUsN4/6TfpLl/vMwZLwm4sceobjdjR8sHSGOvjMrVV
         AvH9A0tGC0odb85zSkZCJiujLgptrZ5HV6cudvTlFIDCP80Ne1BknrseIGLFtUXN0aQl
         PekJL18Szspju1E2gzT/UuA1MyxOTnA4RlOGe6V5jQ+hGEqkQNEnmDc0s5PhyFQNv3uA
         Vrv0u/xL/ajThfVI6iU+jIm83Tecb0GDlKD61czzaQBqL9dPHtnG8s21Ft4Xd/xtBmyI
         oCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DOx1cfi6yZFp34A5OaNDx2mfjtKq+u6Vylatxn2ypGw=;
        b=lvBA/n2sRbkDRqHm00AW9OMa9SUvShPx2zLkPHsz+l0t1RNof7prQlRHx7k678sgIa
         GOcjPP8vpHpW5oHy1uvs4Oqo6N9gC+GLmF3LwLqGPJO5Waj6LPeO5Dy/hfZAQGkazped
         TOKrB7OorwPB/KzngbwPax4gBEU7Kz25UrNoEcboKFHCVIjganVE3xzqMz3x32b8cTGB
         uq1n5XwtlitejO6HNHFpjVE3SBmokqsZoI7OZ4h0KFNB+bQrRa1zkZyC7Ehbt72lYlYJ
         KxXJr4XDFVOrfP16SwF7+L6uj7vOwE9mjPVNA58g51E3Chf6iTfuFUuRZhy2LE5eQzW4
         QSKA==
X-Gm-Message-State: AN3rC/4/YiZwE/Q70z5o1+FL/OG5YV7vHuVBIIzzXsH7EBZBz84Rk7Ag
        e646n9fuxHbevYonSFLT2z4f3izhtA==
X-Received: by 10.157.61.163 with SMTP id l32mr8193390otc.28.1492767527360;
 Fri, 21 Apr 2017 02:38:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 21 Apr 2017 02:38:16 -0700 (PDT)
In-Reply-To: <8b2ef70c-4064-f726-8752-5bb0a898ee7a@alum.mit.edu>
References: <20170412200037.18752-1-sbeller@google.com> <CAGZ79kYTqh=Qa+Pt1+MojrcYFr05HQgbPRcc=DvjCkUWsjP5Uw@mail.gmail.com>
 <xmqqy3uu7ee3.fsf@gitster.mtv.corp.google.com> <cb1dd8b6-3357-57ff-650d-c55a7eb38d34@alum.mit.edu>
 <8b2ef70c-4064-f726-8752-5bb0a898ee7a@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Apr 2017 16:38:16 +0700
Message-ID: <CACsJy8BJ2_omtR+LyE71JSSmHf9qVanbdgembqg_HJD6qNheNA@mail.gmail.com>
Subject: Re: [PATCH] refs.h: rename submodule arguments to submodule_path
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 1:42 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/21/2017 08:32 AM, Michael Haggerty wrote:
>> [...]
>> I've CCed Duy because I don't know whether he has more plans regarding
>> submodule references [...] get rid of the
>> `for_each_ref_submodule()` family of functions entirely.
>>
>> So perhaps the code that this patch touches won't be around long anyway.
>
> Oh yeah, he has done exactly that in his nd/prune-in-worktree patch
> series. (I knew I'd seen that somewhere...)
>
> So it seems that the argument renaming has mostly been overtaken by
> events, though even after Duy's patch series there are a few `const char
> *submodule` arguments that could be renamed.

Yeah. After that series, the only place that takes a submodule (path)
is get_submodule_ref_store() (other functions are just helpers).
Renaming it to submodule_path makes perfect sense. Johannes Sixt when
reviewing that series also noticed the "path" nature of this
"submodule" argument and suggested converting submodule[x] == '/' to
is_dir_sep(submodule[i]) for that reason.

At this point, I think Stefan even has the opportunity to
reference/look up a submodule ref store by something other than a path
 (like "struct submodule *", or by name)  if he wants to. But if you
do that, maybe rename the current function to
get_submodule_ref_store_by_path() before you add a new
get_submodule_ref_store_by_whatever().

About ".. because I don't know whether he (Duy) has more plans
regarding submodule references", I plan to convert "submodule[x] ==
'/'" to is_dir_sep(submodule[x]), but I think that's about it. I'm not
involved much in submodule to see the direction it's heading. As far
as refs code is concerned, a "struct ref_store *" is all it needs,
regardless of how you obtain it.
-- 
Duy
