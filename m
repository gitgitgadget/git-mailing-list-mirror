Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593C11F453
	for <e@80x24.org>; Fri, 26 Apr 2019 02:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfDZC2j (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 22:28:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58416 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZC2i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 22:28:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA61F41B61;
        Thu, 25 Apr 2019 22:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T+ZvzMUtbKYI
        wpHUNZfHrVpc5ec=; b=rO6Ma3zid8m45xrqAfXiilf1/RFBdMKZmw2KOFICSZEh
        HCAaY7KoPWCiDDJ69f3V40UwTdGdm7n6FzoPboMW81KKO947NEVSBmamw8FxBqrI
        z3SkRiWDWcHxLlk0jozs4YdWN1Ij0t/pafoPsEdXipQqMcjbiRoEQ242FEQZNQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SfYf5q
        p145ubEQN3sbMrejWmpPG1F7asa4ayunCMi15rVSvBlHBN2R25IcXzcT2+5LGnnf
        MpQYOHwoXnsp1Mtit0qCMxrrtlA9xNvRYZ26GLGRg09teLNs4Hk+vSjb1bEooBXS
        i31e69w4IoC8uQcWeeqTsBn1ZJSjv+bYBcWX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B258C41B60;
        Thu, 25 Apr 2019 22:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E638A41B5E;
        Thu, 25 Apr 2019 22:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
        <87a7gdspo4.fsf@evledraar.gmail.com>
Date:   Fri, 26 Apr 2019 11:28:31 +0900
In-Reply-To: <87a7gdspo4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 26 Apr 2019 00:09:15 +0200")
Message-ID: <xmqqef5pwldc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD24B632-67CA-11E9-9CCE-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Apr 24 2019, Derrick Stolee via GitGitGadget wrote:
>
>> NOTE: this series was rebased onto ab/commit-graph-fixes, as the confl=
icts
>> were significant and subtle.
>
> Sorry, hopefully it helped more than it harmed :)
>
> A few unrelated things:

Thanks always for your careful review and thoughtful comments, by
the way.

> Now as noted in my series we now on 'master' downgrade that to a warnin=
g
> (along with the rest of the errors):
>
>     $ ~/g/git/git --exec-path=3D$PWD status
>     error: commit-graph version 2 does not match version 1
>     On branch master
>     [...]
>
> ...and this series sets the default version for all new graphs to v2.

The phrasing seems odd.  It is unclear, even to me who is vaguely
familiar with the word "commit-graph" and is aware of the fact that
the file format is being updated, what

    "commit-graph version 2 does not match version 1"=20

wants to say.  Do I have version #2 on disk and the running binary
only understands version #1?  Or do I have version #1 on disk and
the binary expected version #2?  How would I get out of this
situation?  Is it sufficient to do "rm -f .git/info/commit-graph*"
and is it safe?

> I think this is *way* too aggressive of an upgrade path. If these
> patches go into v2.22.0 then git clients on all older versions that gro=
k
> the commit graph (IIRC v2.18 and above) will have their git completely
> broken if they're in a mixed-git-version environment.
>
> Is it really so important to move to v2 right away that we need to risk
> those breakages? I think even with my ab/commit-graph-fixes it's still
> too annoying (I was mostly trying to fix other stuff...). If only we
> could detect "we should make a new graph now" ....

True.
