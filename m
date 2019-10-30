Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74B31F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfJ3BCD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 21:02:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55983 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfJ3BCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 21:02:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A5721C0D6;
        Tue, 29 Oct 2019 21:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5cMAWViosIB3
        gWaGKI3MtI864qc=; b=s3cou6yf54zXUk4K8R3Q3NUEqamRmtyjVflfB1TkyBrz
        fPZtbKRXh3OU4/CCPUJ4gFJ0QPMt5NQV2qX2+FpP3G5/kSE4RrjheuYqA6R9OvS3
        c6zd1uFSqm5kCx99CokXXo1IaWmfXCUWZGk4OZhqK6lfzg7cAZH9kWeZMMZfw9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rkMh7X
        X78P2vxzs56DLqlagfTz4nI5e3OligKnXU2z62wLjO179jNowMTUOSB40nI6LPnJ
        Gwy9lwTeFbujxqchvS3BpOXxSnimcFH+6Sb3mGXO83IHzbbQ5JF47K20cM9+QQ2i
        Lkp//4hT1uBC5Oonwh4WWTad+7SXWLUNpth4s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B7021C0D5;
        Tue, 29 Oct 2019 21:02:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73E501C0CB;
        Tue, 29 Oct 2019 21:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <philippe.blain@me.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] worktree: teach "add" to ignore submodule.recurse config
References: <pull.430.git.1572196585.gitgitgadget@gmail.com>
        <xmqqtv7ta9lz.fsf@gitster-ct.c.googlers.com>
        <85CAC41A-A0EA-4E22-BC22-F57A59D76678@me.com>
Date:   Wed, 30 Oct 2019 10:01:58 +0900
In-Reply-To: <85CAC41A-A0EA-4E22-BC22-F57A59D76678@me.com> (Philippe Blain's
        message of "Tue, 29 Oct 2019 08:33:21 -0400")
Message-ID: <xmqqd0ef59mh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E03EF96E-FAB0-11E9-9A6A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <philippe.blain@me.com> writes:

> Hi Junio,
>
> That indeed makes the trick. Thanks!  Should I send a separate
> patch series with this patch ?  How would that work ? "Signed-off
> by" me and "Based-on-patch-by" you ?

As I said, I am not sure if we even want a work-around or would want
to just tell the compiler folks to fix their product, so I do not
want to even have to decide if I should apply such a patch ;-)

But if this were a case where somebody suggested a small diff with
"something like this perhaps?" and you wrapped it up as a proper
patch (with log message, necessary bugfixes and clean-ups, and
possibly tests if needed), just adding "Helped-by: somebody"
followed by your s-o-b would be the norm.  Anything more extensive
you may want to give more credit to the original than helped-by, but
in this case I do not think it even deserves that.

>
> Philippe.
>
>> Le 27 oct. 2019 =C3=A0 22:26, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>>=20
>> I am not sure if the compiler needs fixing in this case, but the
>> following may work it around.
>>=20
>> builtin/merge.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index e2ccbc44e2..0746f11df2 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -826,9 +826,12 @@ static void prepare_to_commit(struct commit_list =
*remoteheads)
>> 			strbuf_commented_addf(&msg, "\n");
>> 		}
>> 		strbuf_commented_addf(&msg, _(merge_editor_comment));
>> -		strbuf_commented_addf(&msg, _(cleanup_mode =3D=3D COMMIT_MSG_CLEANU=
P_SCISSORS ?
>> -			scissors_editor_comment :
>> -			no_scissors_editor_comment), comment_line_char);
>> +
>> +		if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS)
>> +			strbuf_commented_addf(&msg, _(scissors_editor_comment));
>> +		else
>> +			strbuf_commented_addf(&msg, _(no_scissors_editor_comment),
>> +					      comment_line_char);
>> 	}
>> 	if (signoff)
>> 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
