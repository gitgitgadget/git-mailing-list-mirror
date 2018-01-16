Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55DB1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeAPS5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 13:57:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57068 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeAPS5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 13:57:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E7C1CCDB8;
        Tue, 16 Jan 2018 13:57:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RJPZTpEpzHboP5zyiit0r0boX8s=; b=bDr9DK
        u11i5U2yIScBlSTlaaVbGGx4uq9/tRX2OAqSfnPdP8xyufhNK4gzAG8i8ymdRC/A
        ALyUWpv4eKRpmCbdHquJuuQOMYjD4aKPPimdCZZ3YxpQL7xvzAI/blZcpq7YWq0S
        K2lsbxhOc70m96cdfRM3bovUhh0uSrRBL43i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mFJKIXOVWjRud+oesQYFt9tAclyv/eM3
        UpYFSVhGzndYKT2UDhQBSMhs7Pn2TXKbNfrSA7fOGvDWKM+4v9T3v5x5HsMyWWz9
        i+dLVLEZqZwjJotE5oCgR4YbymNz301VLRuq3RV9BCq0NqYGLsTwP4muMWWnJayU
        7T0tQLlcjMI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04103CCDB7;
        Tue, 16 Jan 2018 13:57:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F9B4CCDB6;
        Tue, 16 Jan 2018 13:57:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Keith Smiley <k@keith.so>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
        <20171229224825.31062-1-szeder.dev@gmail.com>
        <87y3ll6s0e.fsf@evledraar.gmail.com>
        <20171230005222.GT3693@zaya.teonanacatl.net>
        <87vago76i8.fsf@evledraar.gmail.com>
        <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
        <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
        <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
Date:   Tue, 16 Jan 2018 10:57:34 -0800
In-Reply-To: <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 16 Jan 2018 17:02:25 +0700")
Message-ID: <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DF3B72C-FAEF-11E7-96FB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 16, 2018 at 4:43 AM, Keith Smiley <k@keith.so> wrote:
>> So it sounds like either we should deprecate rm, or I should update the patch to the suggested method where we just complete remotes, but not rm in the list of completions.
>
> I vote for deprecation. I could send a patch to start warning to
> switch from 'rm' to 'remove'. Then perhaps we can delete it after two
> releases. It's not classified as plumbing should we don't have worry
> too much about scripts relying on 'remote rm'.

I do not know about "two releases" part (which amounts to merely
20-24 weeks), but looking at "git remote -h" output and seeing that
we do spell out "rename" (instead of saying "mv" or something cryptic),
it probably makes sense to remove "rm" some time in the future.

I actually do think "rm" is _already_ deprecated.  

"git remote --help" does not mention it in its synopsis section and
it merely has ", rm" after "remove" as if an afterthought.  I am not
sure if it is worth being more explicit, perhaps like this?

 Documentation/git-remote.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 577b969c1b..149db90346 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -93,7 +93,8 @@ the configuration file format.
 'rm'::
 
 Remove the remote named <name>. All remote-tracking branches and
-configuration settings for the remote are removed.
+configuration settings for the remote are removed.  `rm` is a deprecated
+synonym that will be removed in future versions of Git.
 
 'set-head'::
 
