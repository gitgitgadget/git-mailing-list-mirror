Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6711C1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfIRRtQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 13:49:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56262 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfIRRtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 13:49:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 321871A1BF;
        Wed, 18 Sep 2019 13:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v6JEPGCJGlj3imrMp09HSyPRN3M=; b=n29/G9
        Aa9B+tqJdKNJnXX9wSVmssVITM2zD7urN4MYNlW83BiiETak+y72hm+aTjv5jPM/
        BPjaz6s2lTSJX6Si1kpjXOhu+7CzNyGhWXRhMVu7l4xPrQxR4xx+lWKeja7YKEpo
        AgCOI+Eegp6+kjaWeFAX/hxA9Sfb5GrtjPjmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GzULlAabaenPQynMzKVx42DLoRIXhxeV
        dv8UND93rF7vazfjhv5UV5QRY3gXXK02a0QrjeqImw5ftejoK4fHd9DG0sH0T3dO
        ca5y6slk28WtUfeUq+SLnMQBYsXUUFAZdyxwfoumRe+VK0gxVQE6rE1+HA5YWROK
        OeAATAnx/A4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AF311A1BE;
        Wed, 18 Sep 2019 13:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FB4D1A1BD;
        Wed, 18 Sep 2019 13:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
        <20190918092721.GA76617@archbookpro.localdomain>
        <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
Date:   Wed, 18 Sep 2019 10:49:12 -0700
In-Reply-To: <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com> (Pratyush
        Yadav's message of "Wed, 18 Sep 2019 20:44:04 +0530")
Message-ID: <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A06F44C2-DA3C-11E9-B01C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Assuming I have git.git cloned in ../git (relative to git-gui.git), I 
> ran:
>
>   git pull -Xsubtree=git-gui ../git $branches
>
> instead of:
>
>   git merge $branches
>
> because git-gui's tree doesn't have those commits and branches yet, so 
> we can't merge straight away. This seems to have worked, but I thought 
> I'd mention it in case it would cause some subtle problems.

I am not sure what your $branches above are referring to, but if you
run "git log" in the resulting git-gui repository and see any of the
commits that are about git and not git-gui, then it is not a subtle
but a grave problem.  The reason why git-gui and gitk are separate
projects is because they do not want to contaminate their history
with stuff that are not related to them (e.g. changes to "git
fast-export").

Taking one of the commits Denton found as an example:

>> 	js/misc-git-gui-stuff: 76756d67061076c046973bff2089ad49f5dc2eb6

(by the way, this can also be found by running

	git log --first-parent --min-parents=2 master -- git-gui

in git itself; 02a5f25d956be187bc0 merged it in as its second
parent.  The second parents of these merges you would find are
candidates---you may already have some, and you may need to merge
others to your tree; there may be some that are direct updates to
git-gui/ part of my tree (which shouldn't have been done but
mistakes happen).

You should be able to merge this (and all other git-gui topics
already in my tree Denton pointed out) to your 'master'.  If you
then make a trial merge of the result back into my tree with "git
merge -Xsubtree=git-gui", it should result in "already up to date",
i.e. a noop merge.

Thanks.
