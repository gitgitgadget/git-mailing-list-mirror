Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3593201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 20:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbdKIUQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 15:16:44 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:49282 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdKIUQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 15:16:43 -0500
Received: by mail-qk0-f178.google.com with SMTP id q83so9293450qke.6
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zGZbGV3dhC7BvaQnzldpXLZ5N+2yHcnlWLdpOPo/pi4=;
        b=AKLddMaj3N6g3HWUOj5/mwxcHkNQrPg00KlI5VFTL6uPOekJMhNZ4aihIrSUPTiOvB
         s7Vbjrcpmf7CToX0v09G7OiIjdqSRTiIZuI+QD4noliWzys7cglgQtniiq8TTVeKPQ66
         TNRlfq6JxdZ/KBaT4R0bt8vc0hf40e1zddXvAqZGFeE7/5dX+bmpBmFJpiFpvujbqFef
         NBh7/PKWVKDuFqkvvVRf6NVrjqtgNZG5N7cygG5EcLy6uDTfAQRM8TN49mUFDH/xsuOe
         COfbvJtBsNG8IahTujqnnqxgttV9V5GuglkvsFuEW45NU2pZsoj1kg5KribO8d1q5MGm
         gwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zGZbGV3dhC7BvaQnzldpXLZ5N+2yHcnlWLdpOPo/pi4=;
        b=WQjk5x2rhGzonXRImsbMFqu53BiAv/xr0ifxrmAWRpn7cpMOLeJAUcKIS2d71LRUdm
         qTWZEFQCIXtz+e6X5H9EeINoTzNEVYWd0fyCI5o6JlbSb/CcEhT87rePast57uKrhu2j
         sU+JowpZXQAaVlbvOf8+kU1DlOcsNJdHIj5bSlHWvyiadbstnT2NDF2AAK/4QlfB6x81
         WJieEz90BAFJi7a3quiQwINtq3vKeDtNXG0Ds/Fg9AwYfhTKgJ+6VDkXpCdsNK5BZ9w/
         4pwEL62+iPN6VCLhTkJJD2ch6uyKbAQBmJHa8wEKmh0s+ol6HPoLmUPTGhKQH5E6gAc1
         6cUQ==
X-Gm-Message-State: AJaThX7vXqncbCuG/E6odWvNZqOm1sNXEPMeTeD8oW3juUx/DaPzx/6T
        3aXGNMouBJ837bR78VGiDdSjbRF7bsFx5+aiVt3+AA==
X-Google-Smtp-Source: ABhQp+R35wNN7Wp2nw/NTzfq18LHyMFP7tJXdr60R0L6MOznYpJwCUIRpw5T14t6rsxk3x4F3iApXO3GFNekBE/CmyM=
X-Received: by 10.55.111.3 with SMTP id k3mr2710821qkc.332.1510258601982; Thu,
 09 Nov 2017 12:16:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 9 Nov 2017 12:16:41 -0800 (PST)
In-Reply-To: <CA+P7+xpTCHHNG1tAhysOFV5jFHpXdzRk5zfYNHUUVdYiGY55cA@mail.gmail.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
 <20171109001007.11894-1-sbeller@google.com> <CA+P7+xpTCHHNG1tAhysOFV5jFHpXdzRk5zfYNHUUVdYiGY55cA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Nov 2017 12:16:41 -0800
Message-ID: <CAGZ79kZAvMKQUjbqWZkhy39sE5e9k1DmkiA42ywiw2NgY1+Xig@mail.gmail.com>
Subject: Re: [RFD] Long term plan with submodule refs?
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 8, 2017 at 10:54 PM, Jacob Keller <jacob.keller@gmail.com> wrot=
e:
> On Wed, Nov 8, 2017 at 4:10 PM, Stefan Beller <sbeller@google.com> wrote:
>>> The relationship is indeed currently useful, but if the long term plan
>>> is to strongly discourage detached submodule HEAD, then I would think
>>> that these patches are in the wrong direction. (If the long term plan i=
s
>>> to end up supporting both detached and linked submodule HEAD, then thes=
e
>>> patches are fine, of course.) So I think that the plan referenced in
>>> Junio's email (that you linked above) still needs to be discussed.
>>
>
>> New type of symbolic refs
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> A symbolic ref can currently only point at a ref or another symbolic ref=
.
>> This proposal showcases different scenarios on how this could change in =
the
>> future.
>>
>> HEAD pointing at the superprojects index
>> ----------------------------------------
>> Introduce a new symbolic ref that points at the superprojects
>> index of the gitlink. The format is
>>
>>   "repo:" <superprojects gitdir> '\0' <gitlink-path> '\0'
>>
>> Just like existing symrefs, the content of the ref will be read and foll=
owed.
>> On reading "repo:", the sha1 will be obtained equivalent to:
>>
>>     git -C <superproject> ls-files -s <gitlink-path> | awk '{ print $2}'
>>
>> Ref write operations driven by the submodule, affecting symrefs
>>   e.g. git checkout <other branch> (in the submodule)
>>
>> In this scenario only the HEAD is optionally attached to the superprojec=
t,
>> so we can rewrite the HEAD to be anything else, such as a branch just fi=
ne.
>> Once the HEAD is not pointing at the superproject any more, we'll leave =
the
>> submodule alone in operations driven by the superproject.
>> To get back on the superproject branch, we=E2=80=99d need to invent new =
UX, such as
>>    git checkout --attach-superproject
>> as that is similar to --detach
>>
>
> Some of the idea trimmed for brevity, but I like this aspect the most.
> Currently, I work on several projects which have multiple
> repositories, which are essentially submodules.
>
> However, historically, we kept them separate. 99% of the time, you can
> use all 3 projects on "master" and everything works. But if you go
> back in time, there's no correlation to "what did the parent project
> want this "COMMON" folder to be at?

So an environment where "git submodule update --remote" is not that
harmful, but rather brings the joy of being up to date in each project?

> I started promoting using submodules for this, since it seemed quite natu=
ral.
>
> The core problem, is that several developers never quite understood or
> grasped how submodules worked. There's problems like "but what if I
> wanna work on master?" or people assume submodules need to be checked
> out at master instead of in a detached HEAD state.

So the documentation sucks?

It is intentional that from the superprojects perspective the gitlink
must be one
exact value, and rely on the submodule to get to and keep that state.

(I think we once discussed if setting the gitlink value to 00...00 or other=
wise
signal that we actually want "the most recent tip of the X branch" would be
a good idea, but I do not think it as it misses the point of versioning)

> So we often get people who don't run git submodule update and thus are
> confused about why their submodules are often out of date. (This can
> be solved by recursive options to commands to more often recurse into
> submodules and checkout and update them).
>
> We also often get people who accidentally commit the old version of
> the repository, or commit an update to the parent project pointing the
> submodule at some commit which isn't yet in the upstream of the common
> repository.

Would an upstream prereceive hook (maybe even builtin and accessible via
'receive.denyUnreachableSubmodules') help? (It would require submodules
to be defined with relative URLs in the .gitmodules file and then the recei=
ve
command can check for the gitlink value present in this other repository)

> The proposal here seems to match the intuition about how submodules
> should work, with the ability to "attach" or "detach" the submodule
> when working on the submodule directly.

Well I think the big picture discussion is how easy this attaching or
detaching is. Whether only the HEAD is attached or detached, or if we
invent a new refstore that is a complete new submodule thing, which
cannot be detached from the superproject at all.

> Ideally, I'd like for more ways to say "ignore what my submodule is
> checked out at, since I will have something else checked out, and
> don't intend to commit just yet."

This is in the superproject, when doing a git add . ?

> Basically, a workflow where it's easier to have each submodule checked
> out at master, and we can still keep track of historical relationship
> of what commit was the submodule at some time ago, but without causing
> some of these headaches.

So essentially a repo or otherwise parallel workflow just with the versioni=
ng
happening magically behind your back?

> I've often tried to use the "--skip-worktree" bit to have people set
> their repository to ignore the submodule. Unfortunately, this is
> pretty complex, and most of the time, developers never remember to do
> this again on a fresh clone.

That sounds interesting.

Thanks,
Stefan
