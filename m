Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D7C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 18:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiC2Sw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiC2Sw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 14:52:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74E1EA5C9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 11:50:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7604710ACB8;
        Tue, 29 Mar 2022 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fyeRK+Oj8zGi
        BRDxVamNOiL5IzHp9UmzjnE3NBR5WVM=; b=fmZ2GFibfEGJAogGBkSnj4hJxTGT
        1uSva93YmOIyrR4Zfsz8fLtnMeBHXCpY+AbWy36kIJudtCQek+o9EisA40e8G/mn
        206Bi5DbcFDZBqM+J+VCMSOsWQW2zfd6NOBT00K+ycck6aEN2KFt8sgTbKOVDLE+
        Y+ajboit7fYMt3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AC0B10ACB7;
        Tue, 29 Mar 2022 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A98710ACAF;
        Tue, 29 Mar 2022 14:50:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v7 4/4] vimdiff: add description to already existing
 diff/merge tools
References: <20220328223019.271270-1-greenfoo@u92.eu>
        <20220328223019.271270-5-greenfoo@u92.eu> <xmqqh77gww6c.fsf@gitster.g>
        <f56a7a0b-8525-c4cc-7bc7-5ac4bba59206@gmail.com>
Date:   Tue, 29 Mar 2022 11:50:40 -0700
In-Reply-To: <f56a7a0b-8525-c4cc-7bc7-5ac4bba59206@gmail.com> (Philippe
        Blain's message of "Tue, 29 Mar 2022 13:24:25 -0400")
Message-ID: <xmqqmth8twxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 21F5EBDC-AF91-11EC-9677-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio, Fernando,
>
> Le 2022-03-29 =C3=A0 12:38, Junio C Hamano a =C3=A9crit=C2=A0:
>> Fernando Ramos <greenfoo@u92.eu> writes:
>>=20
>>> ---
>>=20
>> Missing log message and sign off.  "add description" tells us what
>> it did, which is easily visible in the patch text already.  The log
>> message should say why we are adding them, and the rationale has to
>> be better than "adding is better than not adding".  E.g. "in output
>> of X and Y, we only show the names without explanation on what they
>> are, which is not helpful enough" would be a helpful log message.
>
> I might add that the prefix of the commit message title should be chang=
ed
> to 'mergetools: '=20
>
>>=20
>> Doesn't the change in [3/4] to include these strings in generated
>> mergetools-*.txt file depend on this in place?
>>=20
>> Thanks.
>>=20
>
> The list of available values are already generated in the  mergetools-d=
iff.txt and
> mergetools-merge.txt files before this series. After 3/4 we also
> include the description of the values. In 3/4 descriptions are only add=
ed for
> vimdiff and friends, so the rest of the tools would simply be listed wi=
thout=20
> descriptions. After 4/4 all tools have a description.

OK.  I wonder how that affects our discussion to switch to the
description list?  This adds what appears as the description.
Before this step, it would be <dl>...</dl> inside which <dt> appears
but not <dd>.
