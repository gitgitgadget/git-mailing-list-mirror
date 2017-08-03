Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBA01F991
	for <e@80x24.org>; Thu,  3 Aug 2017 17:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbdHCR27 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 13:28:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56537 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751131AbdHCR26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 13:28:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35CCCA4BD0;
        Thu,  3 Aug 2017 13:28:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x8ZD2yjIRghOZxsTyFUPn1fumE0=; b=sPPlU8
        vVfQisaqSLEwP1dFbbFI07d8W3Z21hlAhacwJI80pbckWFMdQ8c0YEYNVVPEZ2wB
        x44QaxrI2LxMICgJjSlQApe8gZeI/70ki9tdwCiI4Ufe5XXMJBNgFFSyqEigiER4
        fwkUg0fNWQZFQPkC9XD2XjwORphRaMOHQ+ipE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QGxVvNF+B+tmmdkAiVHjdmcRFL+ZUG3s
        ZNMyZHroQOG+BIOcceh4wCTaqI7PJTl2xOpcPb1yKChPGNnc06zDmOhkf8nvX1G9
        oAfzNSIUAQPYjQF+ZkR/E/v/EET26RSZTv+XDW+Ije1cS43SyOJFTGIGaoMPIVkw
        ne9kV/A1n2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CE6EA4BCF;
        Thu,  3 Aug 2017 13:28:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F4AFA4BCB;
        Thu,  3 Aug 2017 13:28:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alejandro Aguila <aguilasainz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning an specific commit from the hash
References: <CA+kp=uoHiP8t_40yZvT7r9ziB4uSxgcc=NRY0+XzQJDkuJpx4A@mail.gmail.com>
Date:   Thu, 03 Aug 2017 10:28:49 -0700
In-Reply-To: <CA+kp=uoHiP8t_40yZvT7r9ziB4uSxgcc=NRY0+XzQJDkuJpx4A@mail.gmail.com>
        (Alejandro Aguila's message of "Thu, 3 Aug 2017 11:27:05 -0500")
Message-ID: <xmqqtw1opnla.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36E9ED38-7871-11E7-B556-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alejandro Aguila <aguilasainz@gmail.com> writes:

> I've been working with Oscomo's project OpenBSC
> https://github.com/osmocom/openbsc and my old hardware won't work with
> the latest version, which is 0.15. So I asked for help to osmocom guys
> and there's someone who told me that his version is working with the
> same hardware I have, so have gave me the OpenBSC hash for it (
> 7f100c9712de5c684462e809bf31a58c0c326337 ).
>
> To be honest I don't use git more apart of cloning repos, so I would
> like to know how can I pull the files for that hash. And since OpenBSC
> has some dependencies that are in osmocom's github repo, I don't know
> if I can get the version that worked for the one committed in the
> hash.

When a user of a project that uses Git says "try this version"
without telling you on which branch that version appears, that
statement typically means that anybody who clones that project
would get the commit, i.e.

    $ git clone https://github.com/.../openbsc
    $ cd openbsc
    $ git checkout 7f100c9712de

This will give you a checkout without being on any named branch,
which would be sufficient for you to build; if you want further work
on top of that commit, you might want to do the last step more like
so:

    $ git checkout -b mybranch 7f100c9712de

If you are not developing at all, then starting at this URL

https://github.com/osmocom/openbsc/commit/7f100c9712de5c684462e809bf31a58c0c326337

and clicking around, you should be able to find this URL

https://github.com/osmocom/openbsc/archive/7f100c9712de5c684462e809bf31a58c0c326337.zip

which would presumably give you a Zip archive that contains the
files in that particular commit.


