Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BCF1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbcHWVqE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:46:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751032AbcHWVqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:46:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D0F37F2D;
        Tue, 23 Aug 2016 16:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RgyiUsSxj6p+tJKu1DvxCrhhLe4=; b=jXkPTs
        /hSjDYJb3VmYFNu3Xa2tBjkjMrHUE1xlnVGGcwTsqDL66tlDoNKNtye3+f1yuhKn
        L4dKS8ZeuRE5YeA+RiIax5qeVcRgkz5jwRSn50gtKIWwbgpiymDVZPfZqv6U3NBx
        cJcw4kIWgFidoyc8e4/Er90Jpdkdkju1JP9yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DiUF5gJsY4n6d4a/w1kh8fMfwMLlbnS8
        qxx9mmClgIB2ucKSKhd3hZRMuCUCSBwgOXt7PVOjmv/4VhlHj4vcqPm8l2IiG83d
        VGBVb2DECCT4wcMtey0yqCssj+pr/hSYR9vcLPyhlYttdEaSrLgfJbMTvJcQ/iOu
        zYzeBrucBhs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C69337F2C;
        Tue, 23 Aug 2016 16:28:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECE4937F2B;
        Tue, 23 Aug 2016 16:28:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <01020156a48144f8-c0e127c1-8cd9-4295-ac16-449a54315cac-000000@eu-west-1.amazonses.com>
        <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Date:   Tue, 23 Aug 2016 13:28:51 -0700
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqmvk3ut4s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35B79DEA-6970-11E6-837D-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> `--next-all` is meant to be used as a subcommand to support multiple
> "operation mode" though the current implementation does not contain any
> other subcommand along side with `--next-all` but further commits will
> include some more subcommands.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---

A series this size really needs a cover letter that describes what
changes were made relative to the previous round to help reviewers.

I also noticed something curious.  All of your messages are dated

    Date: Tue, 23 Aug 2016 11:53:53 +0000

and I think that is the same as all the previous series, but how are
you sending your patches?  The reason why I ask is because this does
not allow readers to tell their mail reader to sort messages by the
sender's timestamp in order to see the messages in order (as a
matter of fact, git-send-email knows that readers are helped by this
feature, and backdates the first message of 10 patch series by 10
seconds, stamps the second message as later than the first by one
second, etc. to help them).


