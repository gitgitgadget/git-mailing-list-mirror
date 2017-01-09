Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB72205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 03:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759772AbdAIDH7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 22:07:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52594 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751866AbdAIDH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 22:07:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47DE960695;
        Sun,  8 Jan 2017 22:07:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QwDsqxrQaSm74mA1DfivSF0WJVw=; b=WKUQWY
        JtQcbPygT/r2Fv/zU2cacpUum4wtBtrnQt14ac79+uNSExqJv8raLfFt1GUmPQUn
        BwyLWzHTsLqfMNEKmDUckZiBVrt+RYqiKh9risD/OctlhmAC8XfgydJ7fGreC7ct
        5a4A69XbzxsoAMo6FA3tOq0pCvVRTMZgCupSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YJbARn8atTCXCAWSuhqCcgaOpxLH6KHY
        3wWIkJkgNKK/GJTs7Et1Lu2sy6eXpO+q6xwGQyXx+M0hJDXBVIwHUJhKVCGdynVw
        u/E/wx1t/4LwbKNwKnagVka58mB/K/ZYcQx8OBU0FtpMhV52onEuumaXhhRXBUJD
        bJhbxkNPMvs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F0C860693;
        Sun,  8 Jan 2017 22:07:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7BD960691;
        Sun,  8 Jan 2017 22:07:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
References: <20170108061238.2604-1-svnpenn@gmail.com>
        <alpine.DEB.2.20.1701081250580.3469@virtualbox>
        <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>
        <alpine.DEB.2.20.1701081953330.3469@virtualbox>
Date:   Sun, 08 Jan 2017 19:07:55 -0800
In-Reply-To: <alpine.DEB.2.20.1701081953330.3469@virtualbox> (Johannes
        Schindelin's message of "Sun, 8 Jan 2017 19:54:23 +0100 (CET)")
Message-ID: <xmqqy3ylx75g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1B178AA-D618-11E6-A19D-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Steven,
>
> On Sun, 8 Jan 2017, Steven Penny wrote:
>
>> On Sun, Jan 8, 2017 at 5:54 AM, Johannes Schindelin wrote:
>> > I am curious: how do you build Git? I ask because I build Git on Windows
>> > many times a day, and I did not encounter any link problems.
>> 
>> My end goal is to build static native Windows Git via Cygwin and the
>> mingw64-x86_64-gcc-core package.
>
> That is certainly a worthy goal, and I would highly recommend to mention
> that particular cross-compiling setup in the commit message. It's not like
> this is the easiest way to build native Git on Windows...

In addition to the patch being explained well, I also care that it
does not break existing builds.  I do not think it is the case for
you, and I do think the patch does the right thing, but just double
checking to see if you have objections to the change itself.

Thanks.
