Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4ED20966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754896AbdC3Uau (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:30:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59066 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751284AbdC3Uat (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D68BB6ECE7;
        Thu, 30 Mar 2017 16:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EtN0EOjnZ8B85u2Y9Gxd8HjIlvY=; b=i44Snj
        WtgbGcY55cCVckHvZrTrRsfDh7PVrQRAlQ/8VYTD6YUZ6xwaBDt9vSaWcnT6Mg2v
        fcSYMz2ki+es9AYisQ9tktFxJOdUTqR27VF6XbBU8Fr8rC2vMVh6x/BXJO3nsUZK
        u/Mv7OGhZeFiDcnvqChrzqch/XP+5e6hZ91gU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=US6aevjXR8AfEhsnnzB7NIkmsyVSRTUI
        sw4LbJDexLtt98B+A3If2swLXr3dQFVd4IAijPR0NrYZQ9Jen9QtQeDeKDXJajRw
        IBQBFA+HiWOvH2rCirXeMsQYZE9mlK+bKJUjp4wgs+9LM52Iib8UYKZDnyIeZ/ng
        maPtSXC56fs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE00B6ECE6;
        Thu, 30 Mar 2017 16:30:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F6596ECE5;
        Thu, 30 Mar 2017 16:30:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-compat-util.h:735:13: error: conflicting types for 'inet_ntop'
References: <CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com>
        <xmqqbmskatz3.fsf@gitster.mtv.corp.google.com>
        <CAH8yC8mMzZGebmZ23dsgY6Zkxk3w_Kpt7O6Z-0CwRQyTBF5uvg@mail.gmail.com>
Date:   Thu, 30 Mar 2017 13:30:46 -0700
In-Reply-To: <CAH8yC8mMzZGebmZ23dsgY6Zkxk3w_Kpt7O6Z-0CwRQyTBF5uvg@mail.gmail.com>
        (Jeffrey Walton's message of "Thu, 30 Mar 2017 16:06:36 -0400")
Message-ID: <xmqqefxe33t5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1B503E6-1587-11E7-BB91-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> On Wed, Mar 29, 2017 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeffrey Walton <noloader@gmail.com> writes:
>>
>>> Some more 2.12.2 testing on Solaris 11.3 x86_64:
>>>
>>> $ make V=1
>>> gcc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ
>>> credential-store.o -MMD -MP -I/usr/local/include -m64 -m64 -I.
>>> -D__EXTENSIONS__ -D__sun__ -DUSE_LIBPCRE -I/usr/local/include
>>> -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
>>> -I/usr/local/include -I/usr/local/include -DNO_D_TYPE_IN_DIRENT
>>> -DNO_INET_NTOP -DNO_INET_PTON  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H
>>
>> Looking at config.mak.uname, nothing in SunOS section seems to set
>> NO_INET_NTOP or NO_INET_PTON.  Why is your build setting them?
>
> Thanks. It looks like the following is the culprit (from config.log).
> Am I supposed to specify the socket library, or is Autotools supposed
> to specify it?
>
> To date, I've been specify the libraries I request, like IDN2, PCRE,
> cURL and OpenSSL.
>
> I don't recall specifying a socket library in the past, so I'm not
> sure what is supposed to happen here.

I'd be hated for saying this by many people, but my suspicion is
that those who build Git are often better off ignoring the autoconf
part of the build procedure, as it is my impression that ./configure
we ship is not as well maintained as the Makefile.  

Looking through the first part of Makefile, I notice that INET_NTOP
and INET_PTON bits are not described; we probably should add these
two close to where we say "Define NO_IPV6 if you lack IPv6 support".

