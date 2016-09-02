Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698811FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932982AbcIBT4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:56:08 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35932 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbcIBT4H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:56:07 -0400
Received: by mail-it0-f42.google.com with SMTP id i184so56867950itf.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eSbDWQgEJKXzPqX9HJP8OPEeo3N9Dx7LQ6vDaNGudAg=;
        b=NMhGsxCPysrDng1l7dcGtn/770uUwSAOXoFsTR5Tob7cOlI+cL4X+abIgJeaFzFOet
         kMUtHp1WCtTsWn8bt06SVXDYbXrgGVhycPF33X7h4LCuW47NFodHWFrMLVsCsJZ9nPXN
         MZy3KhVmh29cQra+y63YgdcM5Y/pcekRAfIa2cxF0lXLcNiwtaTK3gR1/WEru6J+d9NA
         /R4DiIcUhgk7y8+qNnashcblZ7oySn73f/EU6/5kh+CNLhkQvkP6UY7Zl3zD8jzD7Tj8
         PFUNqiJbPlcK9wkO2AjdFVgvST+MlCZqHRHoImLjzlqGrRh0rwVStT8R7psQ1cRs5nbS
         Vt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eSbDWQgEJKXzPqX9HJP8OPEeo3N9Dx7LQ6vDaNGudAg=;
        b=ebhdOM3VIcItZoysoidtHSBoEE4B+/Wx9rGAVQ+8gkpyahCrA+sSTp4ULiPvw6+TGK
         +6T20CiWvtzJ4PthLZav622KTLFdK4cI+GvxKISw8TllDHK17EMQPPf+bp6M6f3iHXgF
         9UobHVfLJyk06pN/AzmBUFjtDhzUoqFSTs0zdTjldFXNOdawwcehs/P8uDYv07gLz5vP
         3wp5mjmOw4sllFNbWeJS63k4jb3/OhyM8ZxCQrkFGgNuSi0tiX4DBJD1DYYSNJNkhxI0
         vc4P6yvOW3MZo8/9tYUY1BscyHVlT7Q01CVtylfx6/1gmwQpKqUrQf8UwSRqxIQun3Bt
         DM/Q==
X-Gm-Message-State: AE9vXwPQCm5eHHGRkc7XE+t44CCRL+RdIQUlgfCFpKc0g2sDx6lyNvEHGRzcuhwRFDJzNokUzuYQWR+4MdeSNjqN
X-Received: by 10.36.217.131 with SMTP id p125mr7314746itg.46.1472846166700;
 Fri, 02 Sep 2016 12:56:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 2 Sep 2016 12:56:06 -0700 (PDT)
In-Reply-To: <CAJo=hJssMohNq5zDU=wdb1gP4nW59m8pUmxP7eY4jnjr502z0w@mail.gmail.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
 <CAJo=hJssMohNq5zDU=wdb1gP4nW59m8pUmxP7eY4jnjr502z0w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Sep 2016 12:56:06 -0700
Message-ID: <CAGZ79kYWr09K2RXgSmmy4G=to65LbLfCi=GRkykhciq_vsyMZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 12:39 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Fri, Sep 2, 2016 at 10:15 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>> +               if (is_null_oid(&old_oid)) {
>> +                       if (strcmp(name, "capabilities^{}"))
>
> Its not the zero ID that is special, its the "capabilities^{}" name
> that is special when its the first entry in the stream. In the wire
> protocol a "x^{}" line is a modifier to a prior "x" line to add a
> peeled object to the prior line. But if we see "^{}" on the first line
> that is non-sense, there is no prior line to modify with this
> identifier.
>
> Further ^{} is used here because its invalid in a name. A server
> really cannot have a reference that ends with the sequence ^{}. And a
> server should not have a reference named "capabilities" without a
> "refs/" prefix on it.
>
> So the entire "capabilities^{}" on the first line is a bunch of
> contradictions that violate a number of things about the protocol,
> which is why clients should ignore it.
>
> I think the test should be about:
>
>   !*list && !strcmp(name, "capabilities^{}")
>
>> +                               warning("zero object ID received that is not accompanied by a "
>> +                                       "capability declaration, ignoring and continuing anyway");
>
> Annoyingly a zero object ID is sort of possible; with a probability of
> 1/2^160 or something. Its just a very very unlikely value. Slightly
> stronger to test against the known invalid name.

That ship has sailed long ago I would think?
There are tests for null sha1 in the refs code, e.g. for
deletion/creation of a branch
we consider the null sha1 as the counterpart.

So while it may be possible to have SHA1 producing a "0"x40, you
cannot e.g. push it?
