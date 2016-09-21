Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11651F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936498AbcIUQpS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:45:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934522AbcIUQpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:45:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B61B23E254;
        Wed, 21 Sep 2016 12:42:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bbjBINsA1wzYfhccTGjuZazmxGA=; b=pk4LHG
        Xjsvx3/R/UvRFbB7so3EETpjw/J6vA13Q84KaRwHQa/XLg5IX3+e2AzaBLqPiOrH
        /Ecj45myAGAUhdABKUxpgf+yjA8qTnjAqA+ea5yamZAjXvelY1947KGBABqMU6qI
        8vuO+csGncLWj289cmJNxEVuLUV38UXj2WXX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U8Ybfkm+pMncO3uEzMV2UZXkv4u+ztSH
        xdOMHk4sIVNML6z6+MIeYAfJhvQGQQMm3mxf4ZGFaY9eV77XYUFc6BdExzWKRj+Z
        w8gG2k897YGSadD5B5eSFgeYVJyxhPdxsHtkDG6vIQ4xtf4XaI2Bc/a5pWNYC5Nz
        xeO/DmStxpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADCA13E253;
        Wed, 21 Sep 2016 12:42:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 146783E24F;
        Wed, 21 Sep 2016 12:42:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: ask homebrew for the its path instead of hardcoding it
References: <20160921084518.13091-1-larsxschneider@gmail.com>
        <83e3049c-34ea-4440-7b4d-061cb98ba2dd@atlas-elektronik.com>
        <14C21417-491B-4C8E-90FE-47154EEDD9FE@gmail.com>
Date:   Wed, 21 Sep 2016 09:42:56 -0700
In-Reply-To: <14C21417-491B-4C8E-90FE-47154EEDD9FE@gmail.com> (Lars
        Schneider's message of "Wed, 21 Sep 2016 15:28:51 +0200")
Message-ID: <xmqqzin19pbj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73C2791E-801A-11E6-A66B-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 21 Sep 2016, at 11:31, stefan.naewe@atlas-elektronik.com wrote:
>> 
>> In the Subject: s/the //
>> 
>> Am 21.09.2016 um 10:45 schrieb larsxschneider@gmail.com:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> The TravisCI macOS build is broken because homebrew (a macOS depedency
>> 
>> s/depedency/dependency/
>
> Thanks for spotting both errors!
>
> @Junio: Should I make a v2?

No.  osx before_install stuff was in there since the very beginning,
i.e. 522354d7 ("Add Travis CI support", 2015-11-27), so I guess this
needs to go to maint-2.7 and upwards, but I guess we should discourage
people to stay on an older maintenance track forever, so let's do
this only for 'maint' and upwards.
