Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A52C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F88F2074F
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b2KGtgi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbgF3Pjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:39:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53354 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbgF3Pjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:39:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F4EE5A9B2;
        Tue, 30 Jun 2020 11:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u0GmDEo9v2bi
        MA2Hw7Ww8ybLI18=; b=b2KGtgi7HXkKCoccTf2NWrwm8iFNKBNxmFh1DedD/T9a
        U3LVesmMQ7/6iH6z9Ogzvqf7ye3XHsBDFoTFxIe8qc7ZSkH7OW14eiaAECybP9OZ
        dMrhZml7RrNWxi5tEhCZAOplMpib9EC+Pzy8I5/KT1DixcffHuqN642a7BTGhdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wm5t5y
        Sw3xcN6zKl1FL1aW7hHaG6t5IU1Um7mz/a2XheSvgoL0GjFogn9AP+M0RKZgCJv+
        gzvKs764+9B1HQI7IJtDG74mqPNev15axMMeNUO+xpX534NkcO6s231I8AyVn7wI
        22WwRN3QEU6WjIRUOMduvWWt4hVBlCMvKd3Eg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 259675A9B1;
        Tue, 30 Jun 2020 11:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA4655A9AF;
        Tue, 30 Jun 2020 11:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #06; Mon, 29)
References: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
        <20200630010627.GE20303@danh.dev>
Date:   Tue, 30 Jun 2020 08:39:41 -0700
In-Reply-To: <20200630010627.GE20303@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Tue, 30 Jun 2020 08:06:27 +0700")
Message-ID: <xmqq5zb8ftqa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EAC3F8D8-BAE7-11EA-A34C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-06-29 18:00:11-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> * js/default-branch-name (2020-06-24) 9 commits
>>   (merged to 'next' on 2020-06-25 at 8f962f9219)
>>  + testsvn: respect `init.defaultBranch`
>>  + remote: use the configured default branch name when appropriate
>>  + clone: use configured default branch name when appropriate
>>  + init: allow setting the default for the initial branch name via the=
 config
>>  + init: allow specifying the initial branch name for the new reposito=
ry
>>  + docs: add missing diamond brackets
>>  + submodule: fall back to remote's HEAD for missing remote.<name>.bra=
nch
>>  + send-pack/transport-helper: avoid mentioning a particular branch
>>  + fmt-merge-msg: stop treating `master` specially
>>  (this branch is used by hn/reftable.)
>>=20
>>  The name of the primary branch in existing repositories, and the
>>  default name used for the first branch in newly created
>>  repositories, is made configurable, so that we can eventually wean
>>  ourselves off of the hardcoded 'master'.
>>=20
>>  Will merge to 'master'.
>
> Hi Junio,
>
> I've posted a following up patch to change git-subtree in contrib
> because of the change in fmt-merge-msg at <20200629162003.GD20303@danh.=
dev>

I did see the message by the time I sent out the "What's cooking"
report, but given that the report is typically written after the
day's integration cycle queued all new and updated topics, shuffled
order of topics in 'seen', and possibly merged a bunch of topics to
either 'master' or 'next', some new patches I see after the process
for the day started may not be included.

> Don't know if it should be reviewed and merged separately, or it
> should go with this topic?

I think this is trivially correct, and especially with Dscho's Ack
we saw, it can be safely queued on top of the default-branch-name
topic and graduate together.

Thanks.
