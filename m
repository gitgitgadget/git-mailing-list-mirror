Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67A21F404
	for <e@80x24.org>; Wed, 28 Mar 2018 12:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeC1MKz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 08:10:55 -0400
Received: from mail.javad.com ([54.86.164.124]:50820 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC1MKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 08:10:54 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8AE803E898;
        Wed, 28 Mar 2018 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522239053;
        bh=UXw95nw8GHcxSXrjN7TiaotiAfnVSOJ7t/hM8CWtHEY=; l=2975;
        h=Received:From:To:Subject;
        b=eaOTOtDOJLDO9+ePZA/DbSJZyQQBiZSkbo+cC2Znr2b7vlnS2q/x8IP2mawwwiqun
         5VpcFY2LDRmWgm13u4Y3+jkvssh8MrvKiB8zO67B2I0B1HHDqsVUvXf26chmaPnHdr
         mrce/APhO1WWoXX3Dz4zsmKwOpk6EZbHFHaugrsE=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f19ul-0003L9-IM; Wed, 28 Mar 2018 15:10:51 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
        <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
        <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
        <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87woxyf4lk.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <874ll0d9nt.fsf@javad.com>
        <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
Date:   Wed, 28 Mar 2018 15:10:51 +0300
In-Reply-To: <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
        (Jacob Keller's message of "Wed, 28 Mar 2018 00:20:31 -0700")
Message-ID: <87k1tw8kok.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Mar 27, 2018 at 10:57 PM, Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Hi Johannes,
>>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[...]

> I'm pretty sure the fact has already been accepted, as he did indeed
> implement and develop a strategy for rebasing the merges (Phillip's
> strategy). He hasn't chosen to re-write all the code such that it was
> "always" this method, but rather kept it as an incremental patch on top as
> it makes it easier to review the changes since we've already spent time
> looking at and reviewing the --recreate-merges patches.

That's perfectly OK with me, except that he apparently still can't
accept the fact that rebasing a non-merge is not fundamentally different
from rebasing a merge.

"Rebase non-merge" is just a special case of generic "rebase commit",
provided we do have generic method that is capable to rebase any commit,
and we do have it, Phillip's or not.

> Having watched from the sidelines, I've been unable to completely
> understand and parse the strategies completely, but I've also found
> Phillip's method to be easier to understand.

It doesn't matter at all for this particular discussion. Let's call the
method "rebase a commit", a black-box, that is capable to rebase any
commit. I don't care what implementation is inside. Rebasing a commit is
still rebasing a commit, and it should not be called "merge" in the todo
list.

> As someone who's read the discussion on the sidelines, it certainly
> does feel like there is some misunderstanding on both sides. Neither
> of you have been able to get the other to see what you clearly both
> believe strongly.

Calling "rebase" operation "merge" is wrong no matter what method is
used to rebase a commit. Isn't it obvious? It's currently called "pick"
in the todo and it seems natural to continue to use that name for
picking a commit, whatever number of parents it happens to have.

> Unfortunately I do not have any suggestion as to how to resolve the
> misunderstanding.

This sub-thread is not about method at all, so no resolution on that
matter is required here. This sub-thread is about todo format only.

> Sergey's method appears to me to be more complex, and I agree that the
> extra steps could cause more merge conflicts, at least in how it was
> originally conceptualized and implemented. It is possible that we are
> mis-understanding the terminology for U1 and U2? It sure seems like it
> introduces more changes for merge conflicts than the strategy proposed by
> Phillip. However, the latest editions also sound a lot closer to Phillip's
> strategy in general, so maybe I have mis-understood how it works and what
> is fundamentally different about the two strategies.

There is nothing fundamentally different between them and thus I don't
care in this discussion what exact method is being used.

-- Sergey
