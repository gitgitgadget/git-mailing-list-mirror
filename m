Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A977E1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbdCJTxo (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:53:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755485AbdCJTxn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:53:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AB66674C7;
        Fri, 10 Mar 2017 14:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BhQLRVzjJE2si0Ox1/OIc9M4mVQ=; b=YzfhB0
        5dfdM4pd/saa4su1s0vTSkJs5pMWC1uRYXp6Ju4tefjx9NXGScFUS8Eo/JvkaRWu
        FMRiYGiQXgGTYs2fRdehSwUaUrBz8RNSY/BZqCX8ol/1d9nvZ6sfpI3ntSWxjYUq
        0jX36pb6fbWZVzirQOOGeDVoM1+QwQbw5/lho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oqyLsWVl98xrHdeS6EjgosVc8sJ+HekV
        TPPCj+cfthzhJWR85Ib2MZB84D5NyF4Jbzdgd8fkFCr0eNNW5APgfPcpeEMRNI1+
        vS7RVaBIhcoBVFAusIAI+jKRdd8vMSx6Cjcq8IqlKND0sV1Fc7AP/G6gioeCygp/
        jUH+FX8KyKc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74DA9674C6;
        Fri, 10 Mar 2017 14:53:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E022B674C5;
        Fri, 10 Mar 2017 14:53:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #03; Wed, 8)
References: <xmqqvarjz5yv.fsf@gitster.mtv.corp.google.com>
        <20170309010152.klyhhth3ekm2iia2@genre.crustytoothpaste.net>
Date:   Fri, 10 Mar 2017 11:53:39 -0800
In-Reply-To: <20170309010152.klyhhth3ekm2iia2@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Thu, 9 Mar 2017 01:01:52 +0000")
Message-ID: <xmqqo9x8ykl8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42718CEC-05CB-11E7-8635-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Mar 08, 2017 at 03:47:20PM -0800, Junio C Hamano wrote:
>> * bc/object-id (2017-02-22) 19 commits
>>  - wt-status: convert to struct object_id
>>  - builtin/merge-base: convert to struct object_id
>>  - Convert object iteration callbacks to struct object_id
>>  - sha1_file: introduce an nth_packed_object_oid function
>>  - refs: simplify parsing of reflog entries
>>  - refs: convert each_reflog_ent_fn to struct object_id
>>  - reflog-walk: convert struct reflog_info to struct object_id
>>  - builtin/replace: convert to struct object_id
>>  - Convert remaining callers of resolve_refdup to object_id
>>  - builtin/merge: convert to struct object_id
>>  - builtin/clone: convert to struct object_id
>>  - builtin/branch: convert to struct object_id
>>  - builtin/grep: convert to struct object_id
>>  - builtin/fmt-merge-message: convert to struct object_id
>>  - builtin/fast-export: convert to struct object_id
>>  - builtin/describe: convert to struct object_id
>>  - builtin/diff-tree: convert to struct object_id
>>  - builtin/commit: convert to struct object_id
>>  - hex: introduce parse_oid_hex
>> 
>>  "uchar [40]" to "struct object_id" conversion continues.
>> 
>>  Now at v5.
>>  cf. <20170221234737.894681-1-sandals@crustytoothpaste.net>
>
> Were you expecting more work on this series?  I believe I've addressed
> all the review comments that were outstanding, but if I've missed
> something, please let me know.

I myself am not aware but I wasn't the one with most comments to
this series, so we need help from others to reconfirm "Yeah, this
one is now good to go".

Thanks.


