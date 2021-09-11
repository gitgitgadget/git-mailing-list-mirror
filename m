Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD86C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3013D61209
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhIKAeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 20:34:05 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:59837 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKAeE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 20:34:04 -0400
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 96705207B5;
        Fri, 10 Sep 2021 20:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=7hlX/4X0mmfyiCCAthyljpnvC
        Gw=; b=JWHftkmNErgYhD2Rfon66z0xqORe3lDy54KIxkgy/DFkfr37UeUMyennZ
        QMV3eBuUuXxO5EqKamdzcL8zhEsXkAJkfEG+cj78y1vVmjofEiWyVb2QGIifi9wM
        DjIyp1Cl/TW4uHPNOh/y0jg5a7k2uEDRKDZ9l0Nu2fm6ZWfgdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=tJJyOdtE5+Dg27gOInv
        FHnoUJ6/MnQFtW/mQqKB7VGVe7yr8MwGtRS+osFZVKshN1ixleSjJuvr+GHDaGOd
        1FcnzICZxUoptoAlqhw4b0oHQ0jLSEltwR7qM01XNd/hwlLgwakjL+gMG0J574v7
        7hL7ZBRrcqjYY4Fr7cqNMab8=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 77ACD207B2;
        Fri, 10 Sep 2021 20:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D75F4E90CD;
        Fri, 10 Sep 2021 20:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Gwyneth Morgan <gwymor@tilde.club>, Fangyi Zhou <me@fangyi.io>,
        git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros 
        <christopher.diaz.riv@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros <chrisadr@gentoo.org>,
        Ed Maste <emaste@freebsd.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: Re: [PATCH] .mailmap: Update mailmap
References: <20210910130236.40101-1-me@fangyi.io>
        <YTt4RymWg+TOEmUf@tilde.club>
        <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
Date:   Fri, 10 Sep 2021 17:32:50 -0700
Message-ID: <xmqqa6kkosst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBBD5B1A-1297-11EC-9AE6-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 10, 2021 at 03:22:47PM +0000, Gwyneth Morgan wrote:
>
>> The line for Jessica Clarke should probably just be
>>=20
>> Jessica Clarke <jrtc27@jrtc27.com>
>>=20
>> That works the same and doesn't put a reference to an old name.
>
> Thanks, that's a good suggestion. I kind of wonder if these mass
> mailmap-cleanup patches are a good idea in general. They are making
> assumptions about how people want their names to be represented, and
> whether and how they want any mappings to appear. Maybe that's somethin=
g
> we should be leaving to people to propose for their own identities.
>
> Of course people who aren't active in the project anymore may not bothe=
r
> to do the cleanup, and of course messy data makes me sad. But on the
> whole, I'm not sure it's that big a deal either way.

I am not enthused by the idea of replying to this thread, knowing
that many of the CC'ed addresses will bounce X-<, but I agree with
you on all three counts.  Even for those who are no longer active,
it makes sense to unify multiple idents that are spelled differently
to help "git shortlog", but which one to unify to is not something
we can decide without their input.

Which leads me to suggest something like the attached patch.  I
wrote "Please notify us" for those who are no longer active and
forgot how .mailmap entries are spelled to ask for help correcting.

Of course, the updated instruction does not prevent a motivated
volunteer to contact the people _individually_ and then send in
a patch with entries that the volunteer secured consent, perhaps
in the form of Acked-by ;-)


 .mailmap | 5 +++++
 1 file changed, 5 insertions(+)

diff --git i/.mailmap w/.mailmap
index 9c6a446bdf..20b581c879 100644
--- i/.mailmap
+++ w/.mailmap
@@ -4,6 +4,11 @@
 # and/or not always written the same way, making contributions from the
 # same person appearing not to be so.
 #
+# If you find an incorrect entry that affects yourself, please notify us
+# at <git@vger.kernel.org> and suggest corrections.  Because the way peo=
ple
+# want their names to be represented varies, please refrain from touchin=
g
+# entries for other people unless you positively know that the updated
+# entries are what they want.
=20
 <nico@fluxnic.net> <nico@cam.org>
 Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
