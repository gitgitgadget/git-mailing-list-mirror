Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3191207E6
	for <e@80x24.org>; Thu, 15 Sep 2016 17:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbcIORs5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 13:48:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50741 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752622AbcIORs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 13:48:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E6253B222;
        Thu, 15 Sep 2016 13:48:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0V9vgLlZsfhkAjwBAnpY4xBWCvA=; b=NBMBpx
        rdgd1Mzh2sffinU3Tz4J2hPRPWa8C7wLCg4m4L0fvOvPkALcRC9JDqaF1yHTMy1j
        iowgu5EWp0knrIAGBlMEEHP+COit70BHPwrPPudQoeWtAvnEjgJmePTL68+9Hz2G
        GgI5mimIL/bIAPq5vyj0vHwug9txjlRvbJWUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s6JRAJtdlfgW01UeXWgL9s3cHUq9xppd
        +cvSFB4y4VQ9bWK4DD4gRRkeShO1gQx9BCYiO4FojVC0fJ11chYEBWxBIxmHw4Zy
        mggg2kiRso/P7+hk8fBKQwhM4+ua1K1daTmEyJ0IlgmaGMd8ZUAp5J8urHxC9WLY
        kkr7QiBt7qM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9469F3B221;
        Thu, 15 Sep 2016 13:48:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31CED3B220;
        Thu, 15 Sep 2016 13:48:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aviv Eyal <avivey@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git add --intent-to-add silently creates empty commits
References: <CAGHT48L2s_nf-oSGPKrOB7uo5UAkCScNh+Ju5xH1dE5DFVnHwA@mail.gmail.com>
Date:   Thu, 15 Sep 2016 10:48:47 -0700
In-Reply-To: <CAGHT48L2s_nf-oSGPKrOB7uo5UAkCScNh+Ju5xH1dE5DFVnHwA@mail.gmail.com>
        (Aviv Eyal's message of "Wed, 14 Sep 2016 22:01:05 -0700")
Message-ID: <xmqq1t0loxz4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8549D18-7B6C-11E6-8E46-90D812518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aviv Eyal <avivey@gmail.com> writes:

> Using `git add -N` allows creating of empty commits:
>
> git init test && cd test
> echo text > file
> git add --intent-to-add file
> git commit -m 'Empty commit'
> echo $?                                    # prints 0
> ...
> I'd expect `git commit` to error out instead of producing an empty commit.
>
> I've seen this with git 2.8.1 and 2.10.0.129.g35f6318

I think I've seen this reported some time ago.

https://public-inbox.org/git/%3CCACsJy8A8-RgpYxYsJBaLrMia7D3DfQPr4cxASNsaLyCnmgm3ZQ@mail.gmail.com%3E/

I do not offhand recall what happend to the topic after that.
