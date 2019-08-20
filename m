Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380071F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfHTSVg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:21:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62374 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfHTSVg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:21:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 048A817416E;
        Tue, 20 Aug 2019 14:21:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wfptArXW5diXUuvYuTUT3ZyMBqY=; b=KgF7k6
        Q3oUueE3AcmGU2XD8zfAH9L1C3Bsd1gXbot0KGSRdbR4XOZ4+3rkha2KqwLf6M/U
        xz0Rp/SYSBaTpdQVnKFZgiAf2VZju/gnKhDjl2tYLAg9uPD9v0b3zTapPpoTo0tS
        ZfcxdmqO/NGJklf/2OzZ7mvj/y0+odcMY4Ppg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uUi15CpCKw+sMd1h88GzjRMxGfZySf++
        eGbXy4Gjvviha2yTEplY968TUkGtlOrOfQ2drv6myjMBOQYkgX9rdaSpb0wrtbBN
        qn2EJsfsozO0a5G84pdehPlr3F3B9uJORaH+iDRE814n5kqh6mX4c+OHiS/CONoI
        WTGQjcjz1HY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFBA117416D;
        Tue, 20 Aug 2019 14:21:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D3BC17416C;
        Tue, 20 Aug 2019 14:21:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [problem with name-rev]
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
        <87pnkzkivn.fsf_-_@mat.ucm.es>
Date:   Tue, 20 Aug 2019 11:21:32 -0700
In-Reply-To: <87pnkzkivn.fsf_-_@mat.ucm.es> (Uwe Brauer's message of "Tue, 20
        Aug 2019 16:32:12 +0200")
Message-ID: <xmqqh86bvgsz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56A96E5C-C377-11E9-85B8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Brauer <oub@mat.ucm.es> writes:

> Gives
> *   changeset: ae68dbe:master
> |\  user:      Uwe Brauer
> | | date:      Tue Aug 20 16:25:53 2019 +0200
> | | summary:   1.2.1/1.1
> | |
> | * changeset: c00bb5d:master^2
> | | user:      Uwe Brauer
> | | date:      Tue Aug 20 16:25:53 2019 +0200
> | | summary:   1.2.1
> | |
> | * changeset: 54c9230:master^2~1
> | | user:      Uwe Brauer
> | | date:      Tue Aug 20 16:25:53 2019 +0200
> | | summary:   1.2
> | |
> * | changeset: da0712f:master~1
> |/  user:      Uwe Brauer
> |   date:      Tue Aug 20 16:25:53 2019 +0200
> |   summary:   1.1
> |
> * changeset: 8eb999d:master~2
>   user:      Uwe Brauer
>   date:      Tue Aug 20 16:25:53 2019 +0200
>   summary:   1
>
> That looks odd.
>
> Any comments?

When you make a merge like the ae68dbe, merging a topic with two
commits 54c9230 and c00bb5d into the then-current tip of the master
branch da0712f, _all_ direct parents are recorded in the resulting
merge commit, so the first parent of it is denoted as ae68dbe~1
(which is da0712f) and the second parent of it ae68dbe^2 (which is
c00bb5d).

There is no linear ordering between these two commits, so c00bb5d
will *never* be named as master~<some-number>.  As a commit on a
side branch, its description from the tip of 'master' will always
involve some ^2 (the second parent of some merge commit) somewhere
in its name-rev result.

If you are saying that the $commit^$nth_parent notation "looks odd",
then you are shooting the messenger with your title.  The problem is
not with name-rev; the problem is with the way the world works.

