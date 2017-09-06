Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A8A20286
	for <e@80x24.org>; Wed,  6 Sep 2017 23:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdIFXnw (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 19:43:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59296 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750800AbdIFXnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 19:43:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1FDB9BCE4;
        Wed,  6 Sep 2017 19:43:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urtOBJNhSuBzwKk+4LcZEUvojbE=; b=HXjVxV
        QuD8yaanPLTCmXIgT9wawWcXoGuxI3W9p7PlU8q+zLE12UnqSLM1UjO+jNskllzB
        IDgYhUl+34ZAzvH6HJicKR/3bscBFJqmdAPP/mwqWChvC3URUpfL/0JJboR5fPcy
        75mhWTREap0va5CvWxOjvoaS0VkLMC+/XZmVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cTAwl3QbEeYQaSPm4Dc+dwgDHZe5n5p6
        kLpGxBN8S2Mnh8DKDTeNY+ReoWdeBsqqU7m0guWFDzZeZiT/ejzmor3Eu0g/t/6N
        ch87qi6HQtubWGT9mWnqj1XTtuQXmPeiJ+O47KOFBrsUFeyT4VHMrzFVgB/Qbosi
        M1yxCbHVVqI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A97ED9BCE3;
        Wed,  6 Sep 2017 19:43:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11C7B9BCE2;
        Wed,  6 Sep 2017 19:43:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv2] builtin/merge: honor commit-msg hook for merges
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170905232953.22330-1-sbeller@google.com>
        <xmqq4lsga8s7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kauB+AznEOwmNBQLbuz-szD3kYBHAJDmy0OWWEbxny9xQ@mail.gmail.com>
Date:   Thu, 07 Sep 2017 08:43:44 +0900
In-Reply-To: <CAGZ79kauB+AznEOwmNBQLbuz-szD3kYBHAJDmy0OWWEbxny9xQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 6 Sep 2017 15:11:23 -0700")
Message-ID: <xmqqr2vj2y1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 394FA822-935D-11E7-91EC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I also thought that we were hunting calls of cmd_foo() from outside
>> the git.c command dispatcher as grave errors and want to clean up
>> the codebase to get rid of them.
>
> ... but I did not account for this fact. (I was not aware of these being
> called grave errors, but assumed this is a good state. And why change
> a good state?)

https://public-inbox.org/git/20170830053108.g2xsn43rwulnwn3p@sigill.intra.peff.net/

gives a good explanation why it is not a good state.
