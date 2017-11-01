Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E926020450
	for <e@80x24.org>; Wed,  1 Nov 2017 02:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbdKACsF (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 22:48:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932674AbdKACsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 22:48:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93B7DBC79F;
        Tue, 31 Oct 2017 22:48:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hrgLcSLcSHpzv4X886VvGl43zao=; b=vUThwk
        Fzx50jApaJJ9NXMIrEXxlhjcUNo4Vq++G2RYW/6St5dP6J5kGqltjA9cpKSdpmdy
        0pEX/RlLV3+/whc2yRzNry95BZrFjlBVGSSWk/n5s3rtgNo8FJMGBkswyp3OHeEL
        wpT4ucUIZTGztmlpMqNIGryAX1k7iVyL7u1p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nPySZAc/ksfhEu2WbWv2BrJmaFmv3oe1
        1T9SiNuDv1arpqRNYOIazcR7BhX67vDvFVc1J/TrrOgUMNOd2pojGugqfsF9IHJ2
        oGshh5BnjxeYCnvbRCcsOL9fJLPmLyUVWZp1Hc88Mykq0O2Z8solk4UmCzYd78Go
        cjR6mzavRIQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89098BC79E;
        Tue, 31 Oct 2017 22:48:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2B7BBC79D;
        Tue, 31 Oct 2017 22:48:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Subject: Re: Meaning of two commit-ish hash in git diff
References: <ab9b5c63-ca38-6157-6732-78aa5d5f291f@gmail.com>
        <xmqqd1542b5r.fsf@gitster.mtv.corp.google.com>
        <2A1B66E868594FC984FED8F0EDEAF900@PhilipOakley>
        <127f7748-4b5d-f6be-2c64-fa4ee079b871@gmail.com>
Date:   Wed, 01 Nov 2017 11:48:02 +0900
In-Reply-To: <127f7748-4b5d-f6be-2c64-fa4ee079b871@gmail.com> (Yubin Ruan's
        message of "Wed, 1 Nov 2017 09:07:20 +0800")
Message-ID: <xmqqfu9yww7x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1511495C-BEAF-11E7-B8F9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

>>> IOW, if you have the contents of the blob whose object name is
>>> f8886b4, by applying this patch, you will get a blob whose object
>>> name is a1c96df.
>>>
>>> The information is used by "git am -3" when the patch does not apply
>>> cleanly to fall back to the 3-way merge.
>> 
>> The ability to 'git describe` those blob object IDs is currently the subject of a patch series
>> https://public-inbox.org/git/20171031211852.13001-1-sbeller@google.com/
>> 
>> Maybe see if would have helped ;-)
>
> What would be other use case of the blob object / blob name ?

Perhaps start from "git cat-file blob $name".  And follow the path
your imagination leads you to ;-)


