Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7C620986
	for <e@80x24.org>; Wed, 19 Oct 2016 19:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942152AbcJSTpx (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 15:45:53 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35134 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbcJSTpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 15:45:52 -0400
Received: by mail-qk0-f172.google.com with SMTP id z190so55592266qkc.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ug1BbGfEwXw0jdeUWwyZqrwiP4bQ2EJ3uAcKl/a6DwU=;
        b=IjIMOpc1+bdL/bhevAJ56Pd99ACWQy0eBPqYanqmWUs7c8Whub3d75rWqUkfJNWIPb
         S8BiWhoODqVxSyqw70EUUQ+7zlWhQwhEeUQfYHTKpaDWwmsrDdtEZJAqhpiYU5tb2tI2
         1ZuwGC3EeCwrwqjc5T4baKn96+v3XuNk07g6JLTJRgWcFmQPjf9AkQNcHzMHfLPri+Hq
         yk2ptnM1MeI9UOXOsEeV4mW3B8Ju8uluVX2RmhAzI+sfsvO45lbxL25uQXN4XqsETWho
         Z2FOIraWPD9/IQpAjpsywpqoVe9O96isejsDl48umOryXXHf+bdFU2nLHYiHTne4ZE7c
         I63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ug1BbGfEwXw0jdeUWwyZqrwiP4bQ2EJ3uAcKl/a6DwU=;
        b=WXfwCNm8YAmH1LzQ1+lK5bjVus58BEk1AFEUuwILu189CplYqmTbyX2gKoyjO+VmdN
         xh2zzwoJEtVeYdja71ouJf1fhMJMVjfn1GzTuivWfgqLPRZjhO2q3UPvOJZl1GLpF+3y
         vlcNIXeAnkmaRe9bVNG35sRMIpyOcLVg8/AjcaEbbU9KPg+BhECW5la02IVuwPru1EDY
         6z8GfMynfFaCVcumGrW1pEBT4UGV27j6qZpp8GWOfXkvRKAKcxFyg5+0dY3OTGFKN1t7
         a6K0HyK0ks92LJjRNeossMyK9zr9FOZB0kN1JHeFGX+M5+ifQaiP30v1d+BmDOnZYgnf
         73xQ==
X-Gm-Message-State: ABUngvecGFrUKq+iHlcAVlkiyXNCZzjvJ9am/coS0ZW0nUSBTSBTTUZYagHkArfhQwLp8QhDzQQJ8RXyP4EUKbU+
X-Received: by 10.55.56.11 with SMTP id f11mr7502019qka.255.1476906351145;
 Wed, 19 Oct 2016 12:45:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 19 Oct 2016 12:45:50 -0700 (PDT)
In-Reply-To: <CAHd499D_fehBHsNdH9PLQj+H_WAJqbbMhDwv_nCT3fZcX60ENA@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
 <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
 <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com>
 <CAGZ79kYKdHHcfRxCOJwNuqnOGMjBBeMy3Av5U7_ssuOp-to61w@mail.gmail.com> <CAHd499D_fehBHsNdH9PLQj+H_WAJqbbMhDwv_nCT3fZcX60ENA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Oct 2016 12:45:50 -0700
Message-ID: <CAGZ79kZWaShG9iG565bD3aVYFcb53+opbpnJH-v3G6hrQL2tzA@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 12:19 PM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> On Wed, Oct 19, 2016 at 11:23 AM, Stefan Beller <sbeller@google.com> wrote:
>> You could try this patch series:
>> https://github.com/jlehmann/git-submod-enhancements/tree/git-checkout-recurse-submodules
>> (rebased to a newer version; no functional changes:)
>> https://github.com/stefanbeller/git/tree/submodule-co
>> (I'll rebase that later to origin/master)
>>
>>>
>>> Do you have any info on how I can prevent that error? Ideally I want
>>> the integration to go smoothly and transparently, not just for the
>>> person doing the actual transition (me) but for everyone else that
>>> gets those changes from upstream. They should not even notice that it
>>> happened (i.e. no failed commands, awkward behavior, or manual steps).
>>
>> It depends on how long you want to postpone the transition, but I plan to
>> upstream the series referenced above in the near future,
>> which would enable your situation to Just Work (tm). ;)
>
> At first glance, what you've linked to essentially looks like
> automated `git submodule update` for every `git checkout`. Am I
> misunderstanding?

Essentially yes, except with stricter rules than the actual submodule update
IIRC.

>
> If I'm correct, this is not the same as what I'm talking about. The
> problem appears to be more internal: When a submodule is removed, the
> physical files that were there are not removed by Git.

That is also done by that series: submodules ought to be treated as files:
If you checkout a new version where a file is deleted, the checkout command
will actually remove the file for you (and e.g. solve any
directory/file conflicts
that may happen in the transition.)

> It leaves them
> there in the working copy as untracked files.

That is the current behavior as checkout tries hard to ignore submodules.

> The next step Git takes
> (again, just from outside observation) is to add those very same files
> to the working copy, since they were added to a commit. However, at
> this point Git fails because it's trying to create (write) files to
> the working copy when an exact file of that name already exists there.
> Git will not overwrite untracked files, so at this point it fails.
>
> What needs to happen, somehow, is Git sees that the files were
> actually part of a submodule (which was removed) and remove the
> physical files as well, assuming that they were not modified in the
> submodule itself. This will ensure that the next step (creating the
> files) will succeed since the files no longer block it.

Yep.
