Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5782C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706B220780
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrMTy4M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgFWWwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:52:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62263 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbgFWWwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:52:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5030E786EA;
        Tue, 23 Jun 2020 18:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JqkU+50cp/gGbi8LpoA+pLZJdcU=; b=vrMTy4
        M3ssRt/EW9LBRZV4LQ6xwoRoamat3AkS46qI9yGHyLTVo/wLS5zdfCp+0Z1/o9gF
        VB8LLiS5dQ6yDnTu9ZjCseRdasYerTpkzb76/dFR3gKxElqhk4egg43WOUT0mc0m
        9NyBd+s6TYCdaQoPTawZIcNwArEoSWZAIzCCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UDlg3PYKIx3+c6xSNKHGuTo3CqgSpHYJ
        2mamgFgg5kraXiYDugrzPSTugrcMeTDEJtLNnok32zZdS1qN+QkHIMdGApQG8siL
        ds1n3dbpV5I5I8nP8ro8ujmkUbxbei3Ror1LQWijjm/sWnZnWQTrLjPSZAECd2tz
        rnGrtFJQ3F4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4694C786E9;
        Tue, 23 Jun 2020 18:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C02C9786E8;
        Tue, 23 Jun 2020 18:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Doc: reference 'seen' instead of 'pu' in meta docs
References: <e250f1bb100aca94c914f1b2d38a3849c2566aea.1592909867.git.liu.denton@gmail.com>
        <nycvar.QRO.7.76.6.2006231708300.54@tvgsbejvaqbjf.bet>
        <20200623152207.GA2027104@generichostname>
Date:   Tue, 23 Jun 2020 15:51:57 -0700
In-Reply-To: <20200623152207.GA2027104@generichostname> (Denton Liu's message
        of "Tue, 23 Jun 2020 11:22:07 -0400")
Message-ID: <xmqqbll9bdki.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2464874A-B5A4-11EA-9F9C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Dscho,
>
> On Tue, Jun 23, 2020 at 05:09:12PM +0200, Johannes Schindelin wrote:
>> Hi Denton,
>> 
>> On Tue, 23 Jun 2020, Denton Liu wrote:
>> 
>> > As of 2020-06-22, the name of git.git's integration branch has been
>> > renamed from 'pu' to 'seen'.[0] Update git.git-specific documentation to
>> > refer to the new branch name. In particular, update documents that refer
>> > to the workflow and also "how to contribute"-type docs.
>> >
>> > There still remains other uses of 'pu' in the docs. In these cases, it
>> > is generally used as an example and there isn't much value in updating
>> > these examples since they aren't git.git specific.
>> >
>> > [0]: https://lore.kernel.org/git/xmqqimfid2l1.fsf@gitster.c.googlers.com/
>> 
>> Whoops, I only saw this now. In the meantime I submitted what I hope is a
>> more complete version of this patch.
>
>  No worries. I was on the fence about changing any non-meta
>  documentation but, after reading your justification for the patches, it
>  makes sense to me. Let's supersede my version with yours. 
>
>  -Denton

The differences are quite small and there are only three differences
to the paths touched by this patch vs Dscho's.  Two of them are
"(patches seen by ...)" that explains what `seen` is, which is a
good reason to keep Dscho's version.

The change to Documentation/SubmittingPatches in your version quotes
`seen` better that matches how `git pull --rebase` nearby is quoted,
which Dscho may want to mimick in his version, though.

Thanks, both.
