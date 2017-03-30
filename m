Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8342520958
	for <e@80x24.org>; Thu, 30 Mar 2017 06:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbdC3GE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:04:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55604 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754808AbdC3GE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:04:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2BDE8CA05;
        Thu, 30 Mar 2017 02:04:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oM1A/zK44w0+Cpg4PDOChSCC9ds=; b=pxeO3V
        ZDr7Gq867aBq7ldL9m6rjHgfH20KRmZwK24YnZ7T0xzXXrxzZjpB51vhD9ZqUFB7
        DhHvMYTnrtouvvk19EaCBRcQF32CQlYHWql+FBHIugjeStTUGrbYKunc1QYHx/Oi
        mG3sV79z4Yx8BiUIRnWOUP+4EW7mOoYLSIQls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nTzu0z3UL84eXC/gmhKAkWqbCboULAP7
        T4O6zXTAkvp4fqiCUj6MXnYXeFf3uDK0frAsh20aXnypylORXxY1JHcTVdVOemkW
        yrbC/S06W4DXT6GQVzJGVSp9nYG89YgusIB1THrf5KXtIOygf/X/SAPc5P8BDWwR
        j+S+u6zcxmo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B6528CA04;
        Thu, 30 Mar 2017 02:04:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C1958CA03;
        Thu, 30 Mar 2017 02:04:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] change default for status.submoduleSummary to true
References: <20170330012025.22122-1-sbeller@google.com>
Date:   Wed, 29 Mar 2017 23:04:23 -0700
In-Reply-To: <20170330012025.22122-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 29 Mar 2017 18:20:25 -0700")
Message-ID: <xmqqmvc37120.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B94C8040-150E-11E7-B458-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A user complained about the workflow with submodules:
>> Re submodules pain, I've seen a lot of people get confused about
>> how and when to commit submodule changes. The main thing missing
>> in the related UIs is some way to summarize the subproject commit
>> diff in a human readable way. Maybe last log message would be better
>> than just sha?
>
> We could advise all the confused users to turn on
> status.submoduleSummary.  However there is no downside from turning
> it on by default apart from a slight change in behavior and bit
> longer output of git-status and the help in git-commit.

Is "there is no downside" substantiated or just hand-waving?
Any pros-and-cons analysis, e.g. performance implications, etc.?

