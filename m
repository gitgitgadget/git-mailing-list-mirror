Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8190C3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E120842
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BATEpPHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgCCOat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:30:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51077 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgCCOat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:30:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E96B527CD;
        Tue,  3 Mar 2020 09:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yxqmEhTJdCxqV4P38JoJGZxNftE=; b=BATEpP
        HMCpvLyA0I8ENiMS02TaFFqNVaPow94BCwoOkDOUo9i5UMyDdzUAI5+/VNss+Bn6
        BrPRj7qHmuhzjRRWCp1g/3Ugy/Eu74GV7+HIFeW4ApP39UakkcXZwdJvXC7QE4iv
        HL3vJ4vZiBgGmlc2IWf9DObzEZMG0dLz/emzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mk3VVkx9wm5g3eNemCV7xPJkhoHKvYHj
        k1uEXWgS+WqHL0fGVvnDls7+2NPK0FwGzTIv+WN6V+fEZbNQPtQRdTyrhcuv1ToY
        GgjpnJozCbYZFXb/coSpk1GZBy3hzUsKQtfSumr2CfrGVqr67ssnhHewlUrochHd
        QUXra0CvASw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 044E6527CC;
        Tue,  3 Mar 2020 09:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50DE5527CA;
        Tue,  3 Mar 2020 09:30:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Takuya N via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Takuya Noguchi <takninnovationresearch@gmail.com>
Subject: Re: [PATCH] doc: use 'ref' instead of 'commit' for merge-base arguments
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
        <CAGyf7-Ez1Fx-VUVmDWxRxLaZcU+Tu4kZ+F2+0uNKkx2oftjEJQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2003031507500.46@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Mar 2020 06:30:44 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2003031507500.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Mar 2020 15:08:08 +0100 (CET)")
Message-ID: <xmqqd09ta4tn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9224CD7C-5D5B-11EA-968F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > The notation <commit> can be misunderstandable only for commit SHA1,
>> > but merge-base accepts any commit references. Like reflog, the name of
>> > arguments should be <ref> instead of <commit>.
>>
>> To me, this change goes too far in the opposite direction: Now it
>> sounds like the command only accepts refs, when it actually accepts
>> any "commit-ish"--i.e., anything that can be coerced to a commit.
>> ("git worktree" uses this term in its usage for "add", for example.)
>
> Maybe we can go for `rev` instead of `ref`?

That's much better than 'ref', but I do not see why 'commit' is
wrong in the first place.  There are many ways to name an object,
and `rev` is an old colloquial way to say "object name".  Here,
however, we want only commit objects, no?
