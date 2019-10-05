Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D621F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 23:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJEXgk (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 19:36:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50836 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEXgk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 19:36:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C4AE196F2;
        Sat,  5 Oct 2019 19:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rf1S8cgPJ4UTL+CUzfQM6yWNuMg=; b=T/BsqM
        BlCA3pxNx/dKj9HXBDQ+1CJQdopot8+/koOP2TPINURgdWQOmNOI5kc8wFaa8C/l
        /9pRQw76zD/rX+EXYcJdw76n0upc3RmEZHYYc19A/kexioJNpyuwlB5B4Qvfug21
        gGjtYqbVFtU5oc/ocFfn8ZfAHOAGU0aYMegTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=weyquUpOX//HP2O9l6lLW+3Tw4oVFrQ2
        QoArEzozv9TEksqsnU/qg3OZPK1OcWHGoPNJd13BSZvR9O2o1d6MUyiagW0gfSoa
        f1aszQn1IvXxr8D2PiFNertpVIIJXhMVVDkzq1UT/Uhgpwq2Wdd9+3Q9BDJQ/uUW
        toohZPsVSC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63FA5196F1;
        Sat,  5 Oct 2019 19:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB3DF196EF;
        Sat,  5 Oct 2019 19:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
        <972f4674-ed00-7113-24eb-f59f1b751690@gmail.com>
Date:   Sun, 06 Oct 2019 08:36:36 +0900
In-Reply-To: <972f4674-ed00-7113-24eb-f59f1b751690@gmail.com> (Phillip Wood's
        message of "Fri, 4 Oct 2019 10:44:47 +0100")
Message-ID: <xmqqzhie69yz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F98E1ABC-E7C8-11E9-AA96-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * ra/rebase-i-more-options (2019-09-09) 6 commits
>> ...
>>   Is this ready for 'next'.
>
> Nearly, but not quite I think cf [1]. Also I'm still not convinced
> that having different behaviors for --ignore-whitespace depending on
> the backend is going to be helpful but maybe they are close enough not
> to matter too much in practice [2].
>
> [1]
> https://public-inbox.org/git/20190806173638.17510-1-rohit.ashiwal265@gmail.com/T/#m965ce1f09d1d1b8010c04db0eabd4b19ce99fe82

OK, so I'll leave a note that this needs to consider existing
GIT_COMMITTER_DATE environment variable, etc, with a reference to
<5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>.

A URL to public-inbox.org is good, but that is because those who do
not use public-inbox.org (or after the site goes out of service) can
still identify exactly which message you are referring to if you use
the https://public-inbox.org/git/$message_id_without_brackets
format.  

Unlike that form, the format you used only identifies the thread
starter, and without public-inbox.org in service, a reader cannot
tell which message in the thread you are referring to, even if the
reader had full mailing list archive.

IOW, I would have appreciated if the above reference were done like
so:

 https://public-inbox.org/git/5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com/

Thanks.
