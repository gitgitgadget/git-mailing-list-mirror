Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19354202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 14:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbdCOONs (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 10:13:48 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36647 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdCOOM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 10:12:57 -0400
Received: by mail-vk0-f47.google.com with SMTP id t8so9062430vke.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=If6GrwKTVcfI4KdiiTSHYp/UeOxTLNuHC0zA/4I3Wwc=;
        b=bnHPGOk/VRPq8mgcau/VbDRlbaZZve2onturCwPS+732cj+oj6QHNxBCTU8NiGRmdb
         /6n6TmvpgV6AcV4RNAaJ6xTFmD2uzFrk3/fkK3sysJsWvYVYZsGTLOA9ejnX5pLDZZgf
         bp2t6aiugdSGwUejuPT9UnoMLH3V7o6Xbsxw5VA4luCOMB1nEHRF+Ff6fgMVqCQ3PQiF
         aUZhlpsBg8K8ijcsIEYIX7E7mj6kRTHt7QHMLnXHKj5uRWFRG/FH4gGrzZpMvvxCNn1I
         vQUMGmY+I6Y7/HRn1GSNmF5UDXRqEpPyRVEjujTxYWAtnU7OtHXLN1/wp0JLADgBb3AQ
         reuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=If6GrwKTVcfI4KdiiTSHYp/UeOxTLNuHC0zA/4I3Wwc=;
        b=dsGtYTZmAfeF/QHgim5otarGV9agA1aLekn5Lpec0mvB3tZi+dQAfvgVErze4OhyZS
         DI66hVY1EeXjleGYbVDx5mynliZYkKWp6FhIFdNZSGgOHp4B6A9q9ojfpxOt60OWYjcd
         0QgWgytXPeJUDPYLcXvk50n7EGk94leS2Fj9BguqRSkwqABaW3e3AGgDgMLHScvpizLv
         oQtTO+1BzHSXCZsCphGuMUU0lYzWZsV5yLW3NN6LKUTaYKRX8ahHD1MWM5yWO7vdVcbM
         6cn2WKJdOVor8Q9g9xmBRhqxIAw2e7YZ0lL5ZyUsdRwphC3KS92wEEwfN4g+j3obA+hK
         SdUA==
X-Gm-Message-State: AFeK/H06PBuX1I9beLctRnvhRtJ8VOBcxlkf7VJWjsUfsSETYhYISM5uaimbN7xFNveAvTOXlIJ5fLkXkK10Sw==
X-Received: by 10.31.110.138 with SMTP id j132mr1007564vkc.103.1489587176206;
 Wed, 15 Mar 2017 07:12:56 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.82.136 with HTTP; Wed, 15 Mar 2017 07:12:55 -0700 (PDT)
In-Reply-To: <xmqqy3wm1bkm.fsf@junio-linux.mtv.corp.google.com>
References: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
 <xmqqy3wm1bkm.fsf@junio-linux.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 15 Mar 2017 09:12:55 -0500
X-Google-Sender-Auth: bcmeGWq2fL-mJUybZ_YDz9RKo6s
Message-ID: <CAHd499Bf-Y5uuZKPO5dOaJqYJ7ZGhG0nX7nQmw7+KO8tZr8eMQ@mail.gmail.com>
Subject: Re: Finding a tag that introduced a submodule change
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> Sometimes I run into a situation where I need to find out which
>> release of the product a submodule change was introduced in. This is
>> nontrivial, since there are no tags in the submodule itself.
>
> Does your superproject rewind the commit in the submodule project as
> it goes forward?  That is, is this property guaranteed to hold by
> your project's discipline:
>
>         Given any two commits C1 and C2 in the superproject, and the
>         commit in the submodule bound to C1's and C2's tree (call
>         them S1 and S2, respectively), if C1 is an ancestor of C2,
>         then S1 is the same as S2 or an ancestor of S2.
>
> If so, I think you can do a bisection of the history in the
> superproject.  Pick an old commit in the superproject that binds an
> old commit from the submodule that does not have the change and call
> it "good".  Similarly pick a new one in the superproject that binds
> a newer commit from the submodule that does have the change, and
> call it "bad".  Then do
>
>         $ git bisect start $bad $good -- $path_to_submodule
>
> which would suggest you to test commits that change what commit is
> bound at the submodule's path.
>
> When testing each of these commits, you would see if the commit
> bound at the submodule's path has the change or not.
>
>         $ current=$(git rev-parse HEAD:$path_to_submodule)
>
> would give you the object name of that commit, and then
>
>         $ git -C $path_to_submodule merge-base --is-ancestor $change $current
>
> would tell you if the $change you are interested in is already
> contained in that $current commit.  Then you say "git bisect good"
> if $current is too old to contain the $change, and "git bisect bad"
> if $current is sufficiently new and contains the $change, to
> continue.
>
> If your superproject rewinds the commit in the submodule as it goes
> forward, e.g. an older commit in the superproject used submodule
> commit from day X, but somebody who made yesterday's commit in the
> superproject realized that that submodule commit was broken and used
> an older commit in the submodule from day (X-1), then you cannot
> bisect.  In such a case, I think you would essentially need to check
> all superproject commits that changed the commit bound at the
> submodule's path.
>
>         $ git rev-list $bad..$good -- $path_to_submodule
>
> would give a list of such commits, and you would do the "merge-base"
> check for all them to see which ones have and do not have the
> $change (replace "HEAD" with the commit you are testing in the
> computation that gives you $current).


Hi Junio, my apologies for the very late response.

I really like your idea, however unfortunately often times people on
my team accidentally rewind the submodule. However your latter
suggestion about just doing merge-base on each change would be a
worthy solution to try. Thank you very much, I will certainly give
this a try!!
