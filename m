Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2FCB203E2
	for <e@80x24.org>; Wed,  9 Nov 2016 23:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbcKIXNf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:13:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752760AbcKIXNf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:13:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6A044D8C8;
        Wed,  9 Nov 2016 18:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=16o9bIesVWY47aBmsS+NiOly/rA=; b=CRcQQs
        QNllnlSWIE5KYgvgjtniINB0CsG1TgTlIutjp75HGgu7vUEhBmFPWDPezyFyVqrU
        WCLTVT5veA3OSfhKEGRZyW8APi9koY72cBpmPfdogxWSQsGkfvSVXtJ6rXeZd/X3
        LJp/TykC6UzPgGr8iul3TE9xH4hq1O/kIvE1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sfWBR6u0RG7FuEjIbVRiJnJUuznk/Cqx
        1gMWDztZMwWUMbotyUvLB3IxCpwCnHOXxDc3hSv9l5FCHS9suOP6gNBJzo9BAPrZ
        zmJOaqEAUqTMuRI1m24riul11lTuJIBEW87J+5Ojti5TWY5qipxYFlqkdhLC9iNm
        1Ml50xI5xQo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE92E4D8C7;
        Wed,  9 Nov 2016 18:13:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 495B84D8C6;
        Wed,  9 Nov 2016 18:13:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
        <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
        <22561.44597.59852.574831@chiark.greenend.org.uk>
        <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
        <22562.32428.287354.214659@chiark.greenend.org.uk>
        <xmqqa8d9b3jh.fsf@gitster.mtv.corp.google.com>
        <22562.65461.845411.29907@chiark.greenend.org.uk>
Date:   Wed, 09 Nov 2016 15:13:32 -0800
In-Reply-To: <22562.65461.845411.29907@chiark.greenend.org.uk> (Ian Jackson's
        message of "Wed, 9 Nov 2016 10:51:33 +0000")
Message-ID: <xmqqeg2k8cwz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22849A44-A6D2-11E6-9DD9-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

>> But I think the right
>> place to do so would be Edit -> Preferences menu in Gitk, and the
>> settings will be stored in ~/.gitk or ~/.config/git/gitk or whatever
>> gitk-specific place.
>
> This is not correct, because as I have explained, this should be a
> per-tree configuration:

I do not have fundamental opposition to make it part of .git/config,
but the name "gitk.something" or if you are enhancing git-gui at the
time perhaps "gui.something" would be appropriate.  

But it is still silly to have this kind of information that is very
specific to Gitk in two places, one that is pretty Gitk specific
that core-git does not know anything about, the other that are part
of the configuration storage of the core-git.  In the longer term,
it is necessary for them to be accessible from gitk's "Edit ->
Preferences" mechanism somehow, I would think, rather than forcing
users to sometimes go to GUI to tweak and sometimes run "git config".
