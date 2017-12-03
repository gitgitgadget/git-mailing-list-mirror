Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8533920A40
	for <e@80x24.org>; Sun,  3 Dec 2017 00:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdLCA2D (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 19:28:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58066 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751494AbdLCA2C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 19:28:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DB43B3594;
        Sat,  2 Dec 2017 19:28:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F4XgAFqS31sIoiraPVtol1ET4HA=; b=Jk46sF
        fUvewSxg4D9B+iXdXjscN11DzBLJAXOFZSXiDUMHnaFO4P7IaOERhpP5Vn6jEamD
        BCRA4wLpfwcrjWlXkfGh4/CTYPz0LeQFXDjDfxBbTECRcnT5okfMgCqnGmjTx+W1
        CJ/7l6zUdumyqN2G1c9Qz70T6i7CLJ9lNfoRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hw8+B1DNnNUXPsoT1pniOKoSOWCVrH/b
        cjK/7RSu+b0HEq9t/7GV0MtI2jRf1ko2vkFkM4AJOWgiiUd2V/SAC73bISkitbOs
        8gEAyWPZz5ZoWMtBTnIYqoxznBMB6jiPushnrzRSfrsIGDdzgqBjVeEkDn1GnmRX
        h6taQUhzSKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98529B3593;
        Sat,  2 Dec 2017 19:28:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1008B358F;
        Sat,  2 Dec 2017 19:27:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #08; Tue, 28)
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
        <787549da-b6ea-2c26-037c-bd4d86d316ad@jeffhostetler.com>
Date:   Sat, 02 Dec 2017 16:27:58 -0800
In-Reply-To: <787549da-b6ea-2c26-037c-bd4d86d316ad@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 1 Dec 2017 11:49:03 -0500")
Message-ID: <xmqqbmjgmz8x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0FD7AC6-D7C0-11E7-870C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 11/28/2017 8:17 PM, Junio C Hamano wrote:
>> [Cooking]
>>
>>
>> * jh/object-filtering (2017-11-22) 6 commits
>>    (merged to 'next' on 2017-11-27 at e5008c3b28)
>>   + pack-objects: add list-objects filtering
>>   + rev-list: add list-objects filtering support
>>   + list-objects: filter objects in traverse_commit_list
>>   + oidset: add iterator methods to oidset
>>   + oidmap: add oidmap iterator methods
>>   + dir: allow exclusions from blob in addition to file
>>   (this branch is used by jh/fsck-promisors and jh/partial-clone.)
>>
>>   In preparation for implementing narrow/partial clone, the object
>>   walking machinery has been taught a way to tell it to "filter" some
>>   objects from enumeration.
>>
>>   Will merge to 'master'.
>
> Could we wait on this.  I'd like to send up a V6 that
> addresses the assert() questions raised.  And Jonathan
> Nieder had a few suggestions that I want to address.

Thanks for stopping me.

As with any topic that is already in 'next', please send in
necessary updates as patches that apply on top of the existing
patches (in other words, we no longer "reroll"; rather, we now go
"incremental").

