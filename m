Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1213FE65E
	for <git@vger.kernel.org>; Mon, 18 May 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106447; cv=none; b=iXGiEh25yKnOWOKIPi6CYeqoQ+05Vtkrpv7JfTwsP4UOlDcl829O2cGMgcFOkOjudN6Q5GQDZII+WmiwpUf6ibLCUk6M5E9ZOWJMlRZg2hyY448mw7x/XJd2vsXLd7TPgmO3lwBdKmvAiMxwRyg6ZamQVRRhjVs86a4sHKTBbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106447; c=relaxed/simple;
	bh=VI/JaXZ5aRapADxYqgTvPeUob/e1SlFXvTTH7SSzg3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prWDNkyTHacv4thLEOueZJ8yRE8kNogZb7yXOAyhzsk8BDHvlvNb5q3gSb06E72XCehLZzGmhIjFpTMak1IFjdzbKng/+gexswVySsdYSVGYbd+jCdrRgCfWygDnJohjzhODOS8lPJbKnlZAZsOWNhu4zxytVpH6sefQ9QteUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIvXCzXk; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIvXCzXk"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b59772d441so30479196d6.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106445; x=1779711245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZG8Sk619lKbDLw2qT7vU09Rowpt9dtnCORt5iyvoNs=;
        b=XIvXCzXkFYu40dx0PrwuqTjdP+8d2NcWJfpIvwiin2m/+r96xzmjIUYlqzuvHwLljm
         X3zGEkMy5DJEkd+YulIW6T1PBDDBtU2xivl+VUG0M5I0qAt5emI5kof1TyMvoHmyWCWQ
         urg5e5OE+aWPcWrPeS3OTd26aHK8j4m6oK2U3Mw4KiZc1dz7WxMfw5eCX2ThWKjQi4sB
         v0iKbvOQdjayq1c1auiwLINHTZTWiP1ja9JvJZz+JrP9jg60Zm7W6OpLa2Kpj5jsJL2H
         JOlgqzBeMxBGtbsksGtKMgwA2FiHQXye/gIijJtJo420wJ8XmyYx2NpbaM1kiHaSztwg
         EFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106445; x=1779711245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZG8Sk619lKbDLw2qT7vU09Rowpt9dtnCORt5iyvoNs=;
        b=WcYG0s2C11khboXKAc/HC+DVp8amc6nCnaS9Uf+9DlnRmFv9HkF4obX5uIAW8ixubZ
         Or2vmkq3+4LWK6i2Vr2ThSxNnpsWiJcoumdiMZHxzW3QJuD7K8S9kzepdmA7gCEyCvWU
         AKTKOWEtxQSxs4d7IQglRxjrzJ/cSaoD3LqnvcYWfEKYJkX2gD/koOOaCOcJyqomYAm6
         P78ks2orfMNvqzjvk/RuJ4HiXORFobcJxOuTyoeORgEIUInq3sfgQeBsfljpQCXlAUZs
         8gj211PYR8ay5ww+W+jI0n/H0dwvXnXiQlrDaAJFAaB5iGnntBrNvxlhyLw0DXhPC2/P
         ISHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9H0/azXR6tMwit1S5ayUglbz4TBZmiHna7imTeehw7Zda7+LBeiL1UBWHnWYIV8x95ztg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRRsRHfR3HGerzch8BEcYsID019xtyls2AbRhwD6ETOgXyGB+
	aLUNSlkreJHnDXbed5bryMmoIX1mg++VHMjs1Yfyyvejt1xDU3tw/eJB
X-Gm-Gg: Acq92OFiaRyuwzTRvEDiEEfLAVF1czuUISMDl0XZYZ2aFiWFaxHwGPslG5BrUhHZ8rg
	jCJ/nfWoaSM81ra+mXuWQTBC9Prl4Y0W/JLvYQRGZSsxefQDNSHs4n58rsGvFV+Yfey1ohydFYL
	PVlkgPbCFVtYtArLmRC7XwJKE7tG4YcQkigIdA5NAA7kIH9hvQGa+V9QnDsD8EkS7EO+bQyqFLB
	dDZ2bBhISVCTBeNXRimg+t/lkzqPG30nauy1YwE3iMavz/A5v6dh3Yua6J2I1stpMHnifDAmXR1
	fwvaaXppv5sDQiiz2onV9VNOt2pOT5gdpmTHrmDNVRQrdRD4n61G/xgoYPS7i7GRQttWU69QVUI
	jaXVjhkLXn7t6drFzwKZtD0fqWN83usarL0v11SFRFnszsmkVyJC+hOpwRNHkRBkR2uDX0y8oA+
	VbMshbw2jLl0mPrLNo1uueCkHhkm9AkYJsX/0jexhsTruwVrd2rVIfZpQ6eR534d8/fjhwYQ==
X-Received: by 2002:ad4:4183:0:b0:8ac:af21:5746 with SMTP id 6a1803df08f44-8ca0f706681mr163374376d6.42.1779106444572;
        Mon, 18 May 2026 05:14:04 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36190136sm53780276d6.24.2026.05.18.05.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:14:04 -0700 (PDT)
Message-ID: <9ff558a4-1be8-4a77-999a-b32c1812e4de@gmail.com>
Date: Mon, 18 May 2026 08:14:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git
 cherry`
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
 <a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com>
 <CABPp-BGpXgDfJeDEB91U-h092-8L6Q_MLrzSLFg9HotPDZ-m-g@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGpXgDfJeDEB91U-h092-8L6Q_MLrzSLFg9HotPDZ-m-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/13/2026 7:17 PM, Elijah Newren wrote:
> On Mon, Apr 27, 2026 at 6:17 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 4/17/2026 8:32 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>> +static void collect_diff_blob_oids(struct commit *commit,
>>> +                                struct diff_options *opts,
>>> +                                struct oidset *blobs)
>>
>> I think that this is generally a good idea, though I worry that
>> having this hidden in builtin/log.c may not be the right long-
>> term home.
>>
>> I expect that we'll find more and more examples where we want to
>> prefetch blobs in different operations, those that exist now and
>> those that may be created in the future. It would be preferred if
>> they could automatically take advantage of the logic already in
>> diff_queued_diff_prefetch() within diffcore_std() in diff.c.
>>
>> Ultimately, _this_ patch cares about a diff.
> 
> I read this patch a bit differently -- could you say more about what
> you have in mind?
> 
> The body of collect_diff_blob_oids() really is just diff_tree_oid() +
> diffcore_std() + process each pair, so at the per-commit level I am
> already leaning on the diff library.  One of the things this patch
> adds is accumulation across many commits: the containing loop (in
> prefetch_cherry_blobs) is over a commit range, not over a single diff.
> 
> Concretely, the motivating case was a patch touching a few files where
> upstream had tens of thousands of commits in <limit>..<head>, several
> hundred of which modified the same set of files.  A per-diff prefetch
> like diff.c uses would turn that into hundreds of small fetches of 1-3
> blobs each; what this series gives you is one fetch.  So the win
> really does live above the diff library, not inside it.

My initial thought was about finding what we can abstract into the
diff API for later reuse. Upon rereading, it's clear that this is
tied very closely with the --cherry feature and wouldn't make a lot
of sense in the API layer.

> There are two further wrinkles in cherry that are filters layered on
> top of the cross-commit accumulation, and they're cherry-specific in a
> way that I don't think belongs in the diff library:
> 
>    1. For most commits in <limit>..<head>, cherry doesn't care about
> the diff at all -- if the list of files modified doesn't exactly match
> the commit of interest, the commit is skipped before patch-id is even
> computed.  Prefetching for those would be wasted.
> 
>    2. We skip prefetching content for binary files (because patch-id
> uses oid_to_hex() for such files instead of the diff contents).
> 
>> Could we compute a
>> "diff prep" computation using the core diff library instead of
>> inventing a second queue of results for diffing?
> 
> To check this concretely I looked at each of the existing
> promisor_remote_get_direct() callsites for a similar producer.  The
> closest cousin of collect_diff_blob_oids() (the only part of this
> patch that looks like it might be close to the right shape to put in a
> core diff library) is diff.c's diff_queued_diff_prefetch() -- but it
> operates on the already-populated global diff_queued_diff and fetches
> immediately, rather than setting up the diff itself and returning an
> oidset for the caller to accumulate.  Reshaping it to match cherry's
> needs would either break its current caller in diffcore_std() or
> introduce a parallel function whose only consumer is cherry.  None of
> the other sites (path-walk in backfill, index walk in read-cache,
> three-way state in merge-ort, etc.) do anything resembling "diff two
> trees and harvest oids."
> 
> And even if we did factor a helper out, cherry's filter is
> patch-id-specific: commit_patch_id() substitutes oid_to_hex() for
> files marked binary by their userdiff driver, so we deliberately skip
> prefetching those.  That isn't a generic "diff prep" consideration --
> it only makes sense because the caller is patch-id.  We could express
> it as a predicate parameter, but with one caller that would feel to me
> like it's just pushing cherry's policy across an API boundary for no
> gain.

Thanks for the additional context. I agree with your assessment.

>> Patch 3 cares about a "scan prep" which cares about loading all
>> blobs for a given tree with respect to a pathspec. This is very
>> similar to what a checkout would do, though it ultimately uses
>> a form of diff to find out what change should be applied to the
>> working directory. Perhaps 'git archive' is a better matching
>> example.
> 
> Agreed that archive is the closer analog -- both grep and archive do a
> pathspec-filtered single-tree walk, whereas checkout's prefetch is
> tied to the index and optimizes to the subset of paths that are
> different since the previous version checked out.  Retrofitting that
> to grep would mean materializing an index for the target revision just
> to throw it away, which feels like more machinery to bridge the
> abstractions than the walk itself would take.

Makes sense.

>> By implementing things in a
>> common location, then we can have later integrations add to the
>> confidence in the feature through tests covering each user-facing
>> use.
> 
> Sounds great...but what common user-facing uses exist?
> 
> Looking at the existing 11 callsites of promisor_remote_get_direct()
> after this series [1], each has pretty specialized data needs --
> index-driven (read-cache), index-pack & pack-objects internals,
> path-walk batches (backfill), merge-ort's three-way logic,
> diffcore-rename's two independent rename-detection paths, plain old
> diffs, collection across a subset of commits (cherry),
> pathspec-filtered tree walk (grep), and
> on-demand-single-blob-at-a-time (odb.c) -- so I don't see a natural
> shared layer above the primitive itself (which is already
> promisor_remote_get_direct).
> 
> archive, if it had prefetch logic, would be the first match.  But it's
> not clear where the shared logic between grep and archive would live,
> if archive even had any prefetch logic to share.
> 
> So I'm inclined to leave both new producers local to their builtins
> for now, and factor a tree-walk helper when archive (or a third
> caller) actually wants one.  But I'm happy to be told I've missed the
> boat.

No, clearly I missed the boat. Thanks for giving me insight to your
deep understanding of this area. You executed on a good design based
on the right amount of specialization required for this need.

Thanks,
-Stolee


