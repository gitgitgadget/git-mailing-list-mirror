Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB5D201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 02:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbdKNCHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 21:07:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52934 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdKNCHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 21:07:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCB84AC02A;
        Mon, 13 Nov 2017 21:07:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mLfsUHhTZ7f1v4ejxNCngr046Vg=; b=r0Xl1e
        hjted4w6KR29vzIX+JcLjMDP5t2bFlkoOBkVAdmYGDixkwUl92O0w0eUA1UF8LY2
        Yevca9MtJcGcuhGmzDMLoTLXU4sPrImWfywRN8vzIgv8aQcI2cuH6vh/kw4q3MCC
        NUWfrizZiXX347OyNGbONireANlCRCrbLdTJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x8v/SaITe7KJRURwnhhErL90cITcl8y1
        9VvtRseUSJyrgT7VRCZrE69A9Krgqp/n18EBaq3JBYF5Dkwgl7wC+r6q4ghFSNRS
        jRyH3WR6wHdq8eNOfQ/79y4vlbVI8Geq+gaLI9mDlGgc25nobKSgjWddqSPKxna7
        v2a76n9lse4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4A02AC025;
        Mon, 13 Nov 2017 21:07:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B2E7AC022;
        Mon, 13 Nov 2017 21:07:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joey Hess <id@joeyh.name>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] link_alt_odb_entries: make empty input a noop
References: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
        <20171108075336.is4awgyw53dohf7y@sigill.intra.peff.net>
        <xmqqd14pef5q.fsf@gitster.mtv.corp.google.com>
        <20171112102739.6xtnnsmtabhnhrm5@sigill.intra.peff.net>
        <20171113171119.fjhufmbbuidr35ud@kitenet.net>
Date:   Tue, 14 Nov 2017 11:07:38 +0900
In-Reply-To: <20171113171119.fjhufmbbuidr35ud@kitenet.net> (Joey Hess's
        message of "Mon, 13 Nov 2017 13:11:19 -0400")
Message-ID: <xmqqined7gut.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97BB1EA6-C8E0-11E7-8411-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> Jeff King wrote:
>> This should make Joey's immediate pain go away, though only by papering
>> it over. I tend to agree that we shouldn't be looking at $PWD at all
>> here.
>
> I've confirmed that Jeff's patch fixes the case I was having trouble with.

Thanks, both.
