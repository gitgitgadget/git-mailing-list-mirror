Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F81320954
	for <e@80x24.org>; Mon,  4 Dec 2017 20:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdLDUQ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 15:16:56 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38364 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdLDUQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 15:16:55 -0500
Received: by mail-wm0-f51.google.com with SMTP id 64so16499526wme.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 12:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yAMWoWS/vxritsUcMkUinme2zwB4YqlaDzl3DCEoMPk=;
        b=Q91PLESYKl+48k6joxz1CuApoS+id4QnWqpiwoyLys2Oafemtan6wAbrsTX3VqEtb7
         ngZTMuM9WxPEE8I+4okZoV6YmshFVCW0peqkFIkJ2t+eV8a0Qtua+vGsN1czsI+0M/y8
         vVBn7DsVW4AL/Rmk6kro7dIn4EGgPRchW2xJwSBFoOj/dEsyDViNSnmjX1rO9N7JZt4b
         InzFACpt+JIcG8b3oKs65GAXo+7rMpx71HpRcx9qIgGt3ZJt3e4tk36kVLvl29mp/MCU
         FRdSLNT4T4rwIRV90t9EgzAxaftJgNjVTtreoZM/09xBIED6lkKVmAdf2IW6cb8XtCMp
         xI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yAMWoWS/vxritsUcMkUinme2zwB4YqlaDzl3DCEoMPk=;
        b=fBp+/AIxsjbeaV25lZBmBqLPp8nOvI8vmYLueYrLBrjEIZmhEZi79cDlGovjRmGk5/
         O2RVZGn3tlGPWo8Fg1t+y3Xk8qn2CDxybypQJXE7LB2NKIDGdB0tVJHwYld9kfApelAY
         /grbAXkR1WLW+fYBrqMIjcS0v1RDyT0cF5GfXw1Q0zMYI/DSGkl4fLUvNoqtMtSVgkcF
         J+4WwU/Rv+nyEHp0kPWMRJIak4Hoz7hggWC4LQI/9vcpUgAB/8a9Al9flEpD+PQSHfhE
         49E3+Gii/gWd7iQnEXlwfKBB2KVCXa6GQLDnVjtFnhHO8k2yYRKKMKTz3y1BlZRuYhi1
         CaOw==
X-Gm-Message-State: AJaThX5u8g8kArxhyWmWnAJTShk8ArCSSeNUl9jFjuknp3/j8RECjxuf
        RREfHWF1MksPdb1cemKIzyj2w8oWKs4ntqtrXao=
X-Google-Smtp-Source: AGs4zMa1EEyvXnFDbKJpRGDGUjZyoU5r3tBSGWS9Cqcot+ziVDsmjgGKrDqmDsa6s64A27mMv+gOLOPNPP2ySiegqSc=
X-Received: by 10.80.208.195 with SMTP id g3mr31938875edf.246.1512418613926;
 Mon, 04 Dec 2017 12:16:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Mon, 4 Dec 2017 12:16:33 -0800 (PST)
In-Reply-To: <CAGZ79kYbhTyHRMRvZaq3SC7MpxdruXsr+4nKGo-4RojjymwYVA@mail.gmail.com>
References: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com>
 <CA+P7+xorpJGrn=5zTrAPVDwHLkU5vCphOrebkH_d+MxV1k1oRg@mail.gmail.com>
 <CABPp-BFdJr8AL3hJSSLiqwPJMt6LZcLOEcTtxz1vohEuw==wKg@mail.gmail.com>
 <CA+P7+xonU838dOAzsUY4KmweYyM-NLFQeKVYD9jYM7i5EuWXcw@mail.gmail.com> <CAGZ79kYbhTyHRMRvZaq3SC7MpxdruXsr+4nKGo-4RojjymwYVA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 4 Dec 2017 12:16:33 -0800
Message-ID: <CA+P7+xrTZZn0r8JBG+=tjEN__jVsLZrNxbA9B_m0PNu2+c0hGg@mail.gmail.com>
Subject: Re: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive:
 Fix logic ordering issue)
To:     Stefan Beller <sbeller@google.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 11:33 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Nov 25, 2017 at 9:59 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Sat, Nov 25, 2017 at 2:37 PM, Elijah Newren <newren@gmail.com> wrote:
>>> On Wed, Nov 15, 2017 at 9:13 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>> On Tue, Nov 14, 2017 at 10:13 AM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>>>> But this line of though might be distracting from your original point,
>>>>> which was that we have so much to keep in mind when doing tree
>>>>> operations (flags, D/F conflicts, now submodules too). I wonder how
>>>>> a sensible refactoring would look like to detangle all these aspects,
>>>>> but still keeping Git fast and not overengineered.
>>>>
>>>> I think given how complex a lot of these code paths are, that an
>>>> attempt to refactor it a bit to detangle some of the mess would be
>>>> well worth the time. I'd suspect it might make handling the more
>>>> complex task of actually resolving conflicts to be easier, so the
>>>> effort to clean up the code here should be worth it.
>>>
>>> I think changing from a 4-way merge to a 3-way merge would make things
>>> much better, as Junio outlined here:
>>>
>>> https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/
>>>
>>> I don't know of any way to detangle the other aspects, yet.
>
> Jonathan Nieder and me tried some pair programming some time ago[1]
> plumbing the repository object through most of the low level internals, which
> would help in detangling submodule merges as then these merges could
> be done in-core, just as Junio laid out.
>
> [1] https://github.com/stefanbeller/git/tree/object-store-jrn-rebased
>

This sounds promising to me.

Thanks,
Jake

>> I agree, that is absolutely a (big) step in the right direction.
>
>
> I agree as well; A better (abstracted) merge backend would be huge for
> the future of Git.
>
> Thanks,
> Stefan
