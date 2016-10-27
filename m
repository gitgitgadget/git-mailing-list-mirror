Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C85C2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 05:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbcJ0Fq2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 01:46:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751252AbcJ0Fq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 01:46:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14C6242308;
        Thu, 27 Oct 2016 01:46:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ra5oH1y0yEwZgJDlM3q0ib26C6E=; b=rU2fft
        2CXeO0S2g02wS2SnI40PZ0eFOlAdAkCbYooyj81DordF8Gy8FjfX655Ef66GN8ng
        K2OoWUSq4kIjxTRvHSPmVTk4ILoRDm4HY8PBRnmXtHc5mOrvkP7CjNYc6uoXsDBX
        FJvDRJJ/WN5PTE6OdYTHhNx4OT/FLR8yFNBwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jprNy8vri/MmJUP5tzIu143IUhvhXc5r
        BAoLt5o9+rnZMNTv0gC6w/4EYN8sWMZB+s/aF3FAMwjdL39pqKRB5OCZ4LEcnGKP
        j504cUHLlbSB09CgZd4fuRZtSEGj7uMJ95UaBn6JfOb4yc0tgC+vQS+li6x+c4UL
        Z6ZbU6Uh3v0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CFA842307;
        Thu, 27 Oct 2016 01:46:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7756742306;
        Thu, 27 Oct 2016 01:46:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Williams <pwil3058@bigpond.net.au>
Cc:     Stefan Beller <sbeller@google.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and rebase
References: <1477523244.2764.114.camel@mattmccutchen.net>
        <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
        <xmqqk2cuach3.fsf@gitster.mtv.corp.google.com>
        <f07745f8-d0ff-c41f-fd44-0812757fbd43@bigpond.net.au>
Date:   Wed, 26 Oct 2016 22:46:23 -0700
In-Reply-To: <f07745f8-d0ff-c41f-fd44-0812757fbd43@bigpond.net.au> (Peter
        Williams's message of "Thu, 27 Oct 2016 14:23:20 +1000")
Message-ID: <xmqqtwby8hu8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2D0C304-9C08-11E6-AD81-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes:

> However, for git commands such as diff/status whose job is to display
> information it would be nice if they had a --recursive option to
> override the default submodule diff/status and show details of the
> changes in the submodules.  Sometimes you want to see the big picture
> in detail.

I won't disagree. My comment was only on this part from the original:

>> - We have to make separate commits and manage corresponding topic
>> branches for the superproject and subprojects.

and on this point, we seem to be in agreement.

