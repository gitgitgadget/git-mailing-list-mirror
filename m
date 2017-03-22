Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3FC20323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760588AbdCVRYR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:24:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56795 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759459AbdCVRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:24:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A54A4799BC;
        Wed, 22 Mar 2017 13:24:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xpCoZtyIpoHjRyDFClPDDhiiAMA=; b=nYo68f
        TsefWNu7pTKQsvRi2SINOx1sKRxx7KNc5jbrwnIoePXY0HMd7Kw0duK9S/vVPIe4
        avgRXE0tKn1Xmyy8m/vCWg+mQIuZyn0Ssbv72C6u2HhAmgRAMaEfnNjrWJrXFt7R
        +1lj/tzIjpV4Gilxeszb/LhCBoBUl0NmmVcm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RWTpAggog0IOI/+cRSy5eCKpjjRd7+kl
        h+CrUe+wTDU6A32E0yQn01WgrpkURboKhJ4FqqCnk1m3+KjvsxpvimOaCSw6NJvF
        ug4sxU3lbZ9mopPMfYy5UPZGtXlzkhCVqpw8hZ1Saeb6dxbxhs/ORhUu5brRvTco
        Q2xrZnHouIs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ED53799BB;
        Wed, 22 Mar 2017 13:24:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16329799BA;
        Wed, 22 Mar 2017 13:24:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: difftool-builtin fixes, was Re: What's cooking in git.git (Mar 2017, #08; Mon, 20)
References: <xmqqefxrtvqa.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703221724500.3767@virtualbox>
Date:   Wed, 22 Mar 2017 10:24:11 -0700
In-Reply-To: <alpine.DEB.2.20.1703221724500.3767@virtualbox> (Johannes
        Schindelin's message of "Wed, 22 Mar 2017 17:25:40 +0100 (CET)")
Message-ID: <xmqqefxpmdhg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E284EC8-0F24-11E7-8E5C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 20 Mar 2017, Junio C Hamano wrote:
>
>> * js/difftool-builtin (2017-03-15) 3 commits
>>   (merged to 'next' on 2017-03-16 at 3fccb60a07)
>>  + difftool: handle modified symlinks in dir-diff mode
>>  + t7800: cleanup cruft left behind by tests
>>  + t7800: remove whitespace before redirect
>> 
>>  "git difftool --dir-diff" used to die a controlled death giving a
>>  "fatal" message when encountering a locally modified symbolic link,
>>  but it started segfaulting since v2.12.  This has been fixed.
>
> David fixed much more than the segfault. He fixed the underlying problem,
> i.e. *also* the "fatal" message.

Yes.  By "this" I meant all the issues described in the previous
sentence.

David, thanks again for the fix.


