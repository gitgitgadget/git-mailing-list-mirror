Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C7E20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 00:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933650AbdKGAoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 19:44:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933582AbdKGAoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 19:44:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E2A7A4C26;
        Mon,  6 Nov 2017 19:44:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S/3f2HZ473x9
        4p0tR9orBdGWr2M=; b=w3ygTlOAnNFRvJdEY87kEDXvIGq62GzocFbDWpT7BniD
        oRF7XJ8WpQV+2sB7mwvgvTwjWEatjMGkoMVDSVm+x8z3DXe+r7d90a8mzrhUka7H
        5GCVo8b2aGKf3OXu4hduljZsYMB7p//3Bf4GN7Y/hz5V/3C54l7ISOa7hixTrVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=F8Sb6n
        8hujI7tdB20qi022CR+JifioCNrPJQd+POdo8as/vok3fYhDOARHSAuvnaXOeoSR
        W9J5wbKGQE8W+HlkhNDfgHSvD/XElYzBHcNeOr3K6PF/WthFwgR5UDyvaGtQeMZb
        qg56a+y686L5mJSgXvFwUoHULfxcrAml4Q6Hk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1609BA4C25;
        Mon,  6 Nov 2017 19:44:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89185A4C24;
        Mon,  6 Nov 2017 19:44:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org
Subject: Re: future of the mediawiki extension?
References: <87vaix731f.fsf@curie.anarc.at>
        <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr>
        <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
        <874lqg83u9.fsf@curie.anarc.at>
Date:   Tue, 07 Nov 2017 09:44:03 +0900
In-Reply-To: <874lqg83u9.fsf@curie.anarc.at> ("Antoine =?utf-8?Q?Beaupr?=
 =?utf-8?Q?=C3=A9=22's?= message of
        "Mon, 30 Oct 2017 22:10:22 -0400")
Message-ID: <xmqq7ev2j4to.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1E4EA4A-C354-11E7-8BEA-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 <anarcat@debian.org> writes:

> On 2017-10-31 10:37:29, Junio C Hamano wrote:
>>> There's also a hybrid solution used by git-multimail: have a copy of =
the
>>> code in git.git, but do the development separately. I'm not sure it'd=
 be
>>> a good idea for Git-Mediawiki, but I'm mentionning it for completenes=
s.
>>
>> I think the plan was to make code drop from time to time at major
>> release points of git-multimail, but I do not think we've seen many
>> updates recently.
>
> I'd be okay with a hybrid as well. It would require minimal work on
> Git's side at this stage: things can just stay as is until there's a ne=
w
> "release" of the mediawiki extension and at that point you can decide i=
f
> you merge it all in or if you drop it in favor of the contrib.
>
> I think it's also fine to punt it completely out to the community.
>
> Either way, I may have time to do some of that work in the coming month=
,
> so let me know what you prefer, I guess you two have the last word
> here. The community, on Mediawiki's side, seem to mostly favor GitHub.

I guess I shouldn't leave this thread hanging.

As contrib/README says, the "owners" of an area in contrib/ has the
ultimate say and control over the area, and for contrib/mw-to-git,
the "owners" have always been Matthieu, at least to me.

As he made it clear earlier in this thread that (1) he sees you as a
steady hand that can help guide the tool forward as its new "owner",
and (2) he thinks Git-Mediawiki will be helped by being an
independent project hosted at GitHub, now you have the say ;-)

A few topics from you that are already on list may want to go
through to 'master' as any other topics, but from there on, I am
fine with the development of Git-Mediawiki primarily done as a
separate project, optionally giving contrib/mw-to-git/ occasional
update dumps.  You could even choose to remove contrib/mw-to-git/*
except for git-remote-mediawiki.txt that says that the tool's main
development effort happens at GitHub to redirect people, if you
think that would reduce potential confusion.

I am also OK to serve as a patch monkey and keep going; I won't be
picking up patches to contrib/mw-to-git/ unless you (and others)
review them, though.
