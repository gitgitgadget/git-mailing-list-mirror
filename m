Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC671FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbdBNWY5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:24:57 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:36479 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdBNWYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:24:54 -0500
Received: by mail-it0-f44.google.com with SMTP id c7so53597105itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L8GJs0VPNO+89J7ZiN+sKSngk/r8+gCFuOOw/cMWK4Y=;
        b=k2/TrCRnBlh5sebkil7jcBtRaCoOjDtXLZHtGTYcTq4zWel/Cy8XTOOxFAaat+yLi8
         mBzQBBR1dHIqVu62lxG2wEZmLBs/3+QhOLMLYF836bnmNKda8ejYWxjEZ4BNSbryADU/
         46gWmJnO0IiizYcZDwIbRJuFkoqo7G2RkI2ktjjgjyTAsV8fRom5nHlmwRfT13sm9HKm
         FixD1igQsjCw1mUq+TC+pkk5uyVucu57WIx2r5yzUN+TmOBBg/IxSfvK+BL01U6VxKSz
         YjPxZV9f3pMF8kQBIsdJHc9S0y08VTwxBe/ouQ/BSNcaCUQLC6OsFITW6HJrO2jrVSGl
         B1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L8GJs0VPNO+89J7ZiN+sKSngk/r8+gCFuOOw/cMWK4Y=;
        b=U7Tx6B82IjNTvc62DCQogaW3H4I1l7f2NaB+uGSMUAl4wT44cf3jJhgjGwbbFDFewd
         xbvr6Bzi9hoUfslk6J9A6ZbnvGnWDvqRxAUm/y0pKVarKbgBx9rNUQw4PS0JOfk8pBfV
         TxnXea/uxzEtzVZUXsvyd56PECrHVHx94hvFlkQ4t3O7jpkxvqFr30ZM5KZroDOHzOwt
         jrKRVT6xXr6OL0AkVXy9+ivEo6oC7e4QjDN0txxpwVzguZO0SHEYg9DZgLwZErKSGHAM
         y/t6IwfyZ2swfKtu3SXNeCfL7KtpIKk9DiX0Qnqtn1X0EcUHeG2VU8hSi+irbWQw/pWQ
         XqcQ==
X-Gm-Message-State: AMke39lWY7xD8zDAvmuQ3+UcVwtQ6/FB/+MK5BaZzT+W/IUAwmH3rtKC8hzwCPkmZ32p6HmAYgD96gdTgm+e8nfY
X-Received: by 10.36.4.2 with SMTP id 2mr5525606itb.116.1487111088675; Tue, 14
 Feb 2017 14:24:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 14 Feb 2017 14:24:48 -0800 (PST)
In-Reply-To: <xmqqmvdo76yw.fsf@gitster.mtv.corp.google.com>
References: <20170209020855.23486-1-sbeller@google.com> <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
 <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com> <CAGZ79kbjSLaUsJH_KuT6EiC+Kt-87+GjONt08hCytXULecMijA@mail.gmail.com>
 <xmqqmvdo76yw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Feb 2017 14:24:48 -0800
Message-ID: <CAGZ79kaeVrW3_kUWWxBMztOPuWY_V6XP2SUDyw8mmQ6peFZwdw@mail.gmail.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Feb 14, 2017 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> If we were to redesign the .gitmodules file, we might have it as
>>>>
>>>>     [submodule "path"]
>>>>         url = git://example.org
>>>>         branch = .
>>>>         ...
>>>>
>>>> and the "path -> name/UID" mapping would be inside $GIT_DIR.
>>>
>>> I am not sure how you are going to keep track of that mapping,
>>> though.  If .gitmodules file does not have a way to tell that what
>>> used to be at "path" in its v1.0 is now at "htap" (instead the above
>>> seems to assume there will just be an entry for [submodule "htap"]
>>> in the newer version, without anything that links the old one with
>>> the new one), how would the mapping inside $GIT_DIR know?
>>
>> It depends. Maybe git-mv could have rewritten the internal mapping
>> as well.
>
> And then after doing the "git mv" you have pushed the result, which
> I pulled.  Now, how will your "internal mapping" propagate to me?

The "name" inside your superprojects git dir may be different from mine,
after all the name only serves the purpose to not have duplicate
git repositories when renaming a submodule.

>
> I also do not think "this is similar to file renames" holds water.
> Moving the path a submodule bound to from one path to another is
> done as a whole, and it is not like the blob contents where we need
> to handle patch application that expresses a move as creation and
> deletion of similar contents at two different paths.  We can afford
> to be precise (after all, we are recording other information about
> submodules by having an extra .gitmodules file).
>
> In short, "name" is not a design mistake at all.  That needs to be
> excised from the "background story".

I am not saying it was a design mistake per se.

I claim that the exposure into .gitmodules combined with
the extreme similarity to its path is confusing. Maybe this
can be fixed by a different default name.
