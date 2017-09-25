Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774BF2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 01:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932177AbdIYBIV (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 21:08:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932090AbdIYBIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 21:08:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F6B5B0731;
        Sun, 24 Sep 2017 21:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mjskuImMPojg+h4lpUaB4Rr3NuY=; b=rDQa5x
        eVMGJ9Dc8ZCpV2KU7d6gND85z3Hz69SCNQ5msewK3sDGOA9ePIz0Kg2cj0GhKIWH
        AEvefnFLP3/ijRIlAdOEpOM+q8kBaRrI2wDg1B5f34D1YCOLT0cIBnWYNfn/8hx3
        oBe6F++pb/TlzNO8Y460g4x8Czm5zGc1v5628=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TceJ8h47JGPu2IO45q3Fb3AQr3wi1FSs
        0lTe4M1WYztIcl+gZh4SQjBf8FEctcHIjZk6Ga75lejkTD4pyUmiW9nkrI3rBd8S
        +EClbeBT9VtiZhcUID9igRVmnA9hH9mhlh2cY6u9pBXEdXELXuphmevVjQxLI78r
        NnYRJMZMNxo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2583EB0730;
        Sun, 24 Sep 2017 21:08:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F283B072F;
        Sun, 24 Sep 2017 21:08:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: merge -s theirs  is not in effect (does the same as -s ours)
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
Date:   Mon, 25 Sep 2017 10:08:18 +0900
In-Reply-To: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Sun, 24 Sep 2017 20:02:13 -0400")
Message-ID: <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04CBE310-A18E-11E7-A14C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> My interest was to get remote branch "merge" the changes in the
> branch taking the branch's version (primarily alternative symlinks
> for git-annex'ed content) over the version in master (previous
> merge of a similar branch).  Unfortunately -s theirs seems to do
> actually -s ours

What does

    ls $(git --exec-path) | grep git-merge

say?  

The official Git never shipped "git-merge-theirs" as far as I know,
and it should not exist (neither should "git merge -s theirs"; you
can use "git reset --hard theirs" instead).



