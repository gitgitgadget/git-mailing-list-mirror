Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0466A20229
	for <e@80x24.org>; Thu, 10 Nov 2016 19:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbcKJTHR (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 14:07:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57698 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755081AbcKJTHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 14:07:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA6424DA9C;
        Thu, 10 Nov 2016 14:07:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vsMZsAbav+Fk
        Y7744yJajifj2JU=; b=jWUHeetQ70yTElP+VeV6FOrBj9yRQ04v3R2Ix9QaXhdg
        0UPXJY7eXgQLHNDvNCzh3pRkGkawJMjiw3UHg2LClNztA2nJWY3OnpWSMcLMPwTB
        lTbwxmHACesDH5hxXaBOv1UF6RnLG5DE08SZiZ/6xk00g3iXGNaDlwewP2WuJo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Eaytlq
        DmlPro4uaNk/KTKibJfMjKEhxKnp1ckiHqRkogvlUWrVN0iB97hXI1IASBiiLRW3
        DhZB9CdbalHuONnfGyGwxODyK7W/3ZIcUkCC8jVktFam0TVKhha1ZlvPS2R7tDz1
        LpY4grEn6VTJHYUHNlc76DO8G/2oPDXCaaseo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0CA44DA9A;
        Thu, 10 Nov 2016 14:07:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B8994DA98;
        Thu, 10 Nov 2016 14:07:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] rebase: add --forget to cleanup rebase, leave everything else untouched
References: <20161026094658.20704-1-pclouds@gmail.com>
        <20161109091131.17933-1-pclouds@gmail.com>
        <xmqqh97g9zut.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D9SHjwb2Ug_DYKmSO+dDxkkqwBFViQrW4eDqbJFjHESw@mail.gmail.com>
        <CACsJy8CHWZyFgZu1=VKCQc+hbHUmZiAQ9ToL=NDF=YBEkLfbog@mail.gmail.com>
Date:   Thu, 10 Nov 2016 11:07:12 -0800
In-Reply-To: <CACsJy8CHWZyFgZu1=VKCQc+hbHUmZiAQ9ToL=NDF=YBEkLfbog@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 10 Nov 2016 18:22:31 +0700")
Message-ID: <xmqqfumz6tnj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3CED95C-A778-11E6-8B22-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Nov 10, 2016 at 6:09 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Nov 10, 2016 at 3:12 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>>>
>>>> ---
>>>>  v2 changes just the subject line
>>>
>>> That's not sufficient, is it?  What you did in the documentation
>>> would raise the same "Hmph, is this only about HEAD?" and unlike the
>>> commit subject, it will carve it in stone for end-users.
>>
>> Oops. I forgot about git-rebase.txt. How about this?
>>
>> --forget::
>>         Abort the rebase operation but leave HEAD, the index and
>> working tree untouched.
>
> Or, since --abort describes it as "reset HEAD to the original branch",
> we could write "Abort the rebase operation. Unlike --abort, HEAD is
> not restored back to the original branch". Index and worktree are
> implied by "not restored". Not sure if it's too subtle.

I think you are moving in the right direction, even though "Abort
it; unlike --abort, does this instead" is a bit hard to follow.
