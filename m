Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A6A4203EA
	for <e@80x24.org>; Tue, 20 Dec 2016 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbcLTVvF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 16:51:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60414 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751214AbcLTVvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 16:51:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B579359CB6;
        Tue, 20 Dec 2016 16:50:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GiIZ09UkFNhk/3WY1a/iAw66VGg=; b=XzW52z
        ZVLzZTkSr+ov4He4aRQRQSD9MxuxjwnkPc72eVQUl6gMSl7HJxx86kapPqkoxygG
        hUlEsQJ2QKin4v7+WjjqWwm4ItaUXEWbMWY5qvenQ4981iHtUU7xJOYfidigqddg
        2YBh/3gs/G9YR3XRORuOxaJAXT6WJi8uwCImY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O0AYhIDGQet5T1qtPbcx2LyE6aNlYMDH
        AKwZ6GbUEfewLMLTDTS2xXXT5JCcVeHWGRKiE4BVayf0t1yJf6bMpERuJ6JI6acM
        GokU6z3V7L6c9SgY76YGjXjezocSb5rHqkaJsTtpOH99wMcZV/LfChplPOt3CssK
        /xcakZqKRkU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB29459CB5;
        Tue, 20 Dec 2016 16:50:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2830B59CB4;
        Tue, 20 Dec 2016 16:50:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, johan@herland.net
Subject: Re: [PATCH] fast-import: properly fanout notes when tree is imported
References: <xmqqbmw6jp59.fsf@gitster.mtv.corp.google.com>
        <20161220210448.32213-1-mh@glandium.org>
Date:   Tue, 20 Dec 2016 13:50:32 -0800
In-Reply-To: <20161220210448.32213-1-mh@glandium.org> (Mike Hommey's message
        of "Wed, 21 Dec 2016 06:04:48 +0900")
Message-ID: <xmqq7f6ujmmv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 559DC760-C6FE-11E6-8A5C-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> In typical uses of fast-import, trees are inherited from a parent
> commit. In that case, the tree_entry for the branch looks like:
> ...
> This change makes do_change_note_fanount call load_tree() whenever the
> tree_entry it is given has no tree loaded, making all cases handled
> equally.

Thanks.
