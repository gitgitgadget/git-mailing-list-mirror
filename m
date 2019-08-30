Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1001F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfH3TZ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:25:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57083 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3TZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:25:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3833B165847;
        Fri, 30 Aug 2019 15:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2jkJgq3W8RZ+
        FL1/Na/FzR0gFFs=; b=V5viE2Yoctt7Y/2qg7LIxnK1UAx5Vjkfe+4x7WDoSX6N
        N1/n/9xcvWBZOdM9Fl+uLLpguVcDHGqRURkwLECatZTqkL7eRhys3SL5uzTyWsm1
        C49bd0WFZ5kt04T7SZhbPScLe9aDjHGuhK2EGfr1fSg8lsDDhmbRG78ysF+CCtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lNhdIk
        b7cWS5qEwIfK1AuZ051qOZQs/lkYEN/X0IUZC6MvUzI8lqJvf9yi4p9V5IsaRtEs
        vCbwIt9UJ8J2kD4Y4LieOl/CisFtIEydGCHaKSLyH4LJ68IMyv/WiRx/jVYWNDVF
        cwnlyoZnA2uWF8fD9D5myg8mHK+yeu+6/uIcM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FB61165842;
        Fri, 30 Aug 2019 15:25:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 983D6165840;
        Fri, 30 Aug 2019 15:25:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Albert Vaca Cintora <albertvaka@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
        <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
        <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
        <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
        <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com>
        <CAAQViEv1wWGTzQ29t0qi9rYoRY=Y86GL7E5rR4XySOBoeRx2pg@mail.gmail.com>
        <xmqqd0gmzk0c.fsf@gitster-ct.c.googlers.com>
        <20190830202635.0bc7e14f@kitsune.suse.cz>
Date:   Fri, 30 Aug 2019 12:25:52 -0700
In-Reply-To: <20190830202635.0bc7e14f@kitsune.suse.cz> ("Michal
 =?utf-8?Q?Such=C3=A1nek=22's?=
        message of "Fri, 30 Aug 2019 20:26:35 +0200")
Message-ID: <xmqqmufqxxof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBAD19C6-CB5B-11E9-9CD9-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

>> But requiring an additional single "f" when doing "rm -rf .git"?  Is
>> that realy too much of a hassle?  The option "-f" is to allow people
>> deal with an unusual situation, while preventing everyday use from
>> doing something harmful unintendedly.  And removing a cloned
>> repository is an unusual situation that would not happen every day,
>> no?
> ...
> I am not in this situation so often but indeed I sometimes clone
> several repositories in a day to search for a patch or piece of code
> and then don't need them anymore. Some people may be in such situation
> more often or regularly.

But between these two:

	$ git clone --no-read-only-file-in-git https://github.com/foo/bar
	...sightsee...
	$ rm -r bar

to avoid "f" in "rm -r", vs.

	$ git clone https://github.com/foo/bar
	...sightsee...
	$ rm -rf bar

to clone a repository you only have a tentive interest in just like
any other more permanent repositories, I am not sure how the former
is preferrable.
