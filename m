Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E382C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435D1206F5
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aVSck1nU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgC3RJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:09:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60212 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgC3RJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 13:09:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C8C7ABAB3;
        Mon, 30 Mar 2020 13:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qw7p1jQFkNvC
        t1zT3T2JJXScagM=; b=aVSck1nUESrJytnVMZwOAPCoSphLWPuKsDaKzEEjID/8
        ctww2NMVmgYOXdylCk6UQnfpNYYvrQYUGahVG+rZQKJZ8dt3CPJagI6jiv7zZcQu
        MBcRQBzocj9ot0wpYgGuZ3jihXfMpi8z/gbQ4DibRmkUkCdfAWLwKmYwvk2M3fM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jRDWi/
        VK/S/rFxbZYz3ftvctqZaaR0x3RgO291Kos5IUs4J1z5fsGjikIuQ7YtZEKHjg2l
        8whwtDL6nmtVKygRp1vX3DiTsnoP+3QDpUv6dfdGWUs9ZHq1OVHLJ9SbR3EWKwAG
        ruPbky5LvDiY8K5711d87zIvbA4rr28VlC2pM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24997ABAB2;
        Mon, 30 Mar 2020 13:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C22BABAAE;
        Mon, 30 Mar 2020 13:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] doc: log takes multiple revision ranges
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
        <51E0F312-E132-4E8E-AFE6-570CB02B4590@gmail.com>
Date:   Mon, 30 Mar 2020 10:09:06 -0700
In-Reply-To: <51E0F312-E132-4E8E-AFE6-570CB02B4590@gmail.com> (Philippe
        Blain's message of "Mon, 30 Mar 2020 08:52:52 -0400")
Message-ID: <xmqqsghp93d9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AFEBA8C-72A9-11EA-8097-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> However, this is really clear in the 'git rev-list' documentation,=20
> which uses  '<commit>...' in the synopsis
> and clearly talks about the "set of commits" point of view:
>
>     You can think of this as a set operation. Commits given on the comm=
and line form=20
>     a set of commits that are reachable from any of them, and then comm=
its reachable=20
>     from any of the ones given with ^ in front are subtracted from that=
 set. The remaining=20
>     commits are what comes out in the command=E2=80=99s output. Various=
 other options and=20
>     paths parameters can be used to further limit the result.
>
> Do you think it would be appropriate that this explanation could someho=
w also appear=20
> in the 'git log' (and maybe also 'gitrevisions') documentation ?

Thanks for finding that paragraph. =20

I said in my previous message that I didn't think the synopsis and
short-help changes were bad, and I hoped that the other hunk of the
patch added reference to "git log" page that existed elsewhere to
help readers understand what the positive and negative options do.
A reference to the "set operation" is exactly the kind of addition I
meant I hoped to see.

By the way, I do not write "git log ab/topic-1 cd/topic-2 --not master",
but "git log ^master ab/topic-1 cd/topic-2 ef/topic-3" is something I'd
quite often write.

