Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CDC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 11:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F316261019
	for <git@archiver.kernel.org>; Sat,  8 May 2021 11:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhEHLNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 07:13:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50599 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhEHLNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 07:13:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5FA7B8DB5;
        Sat,  8 May 2021 07:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=68upWYfUZfXm
        ypu/60OvjO3zk7hu8B5/yWrSw629qPI=; b=NRnFJM1DN/llXn5vkRbWEQpdvXfs
        8n78v68R646FsAzJo5ayYIQpzyEpnH/4FsXA7645jCfL/LVlKB7483j/uQO6tQcW
        RadiOgmlQW+vMS4nk447UqHQeJWbUSM6r92ZbiMzh5uDcKnf0k1oIvFPe3rw+u+G
        PS9uCtJ1MJE9Yrk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97F6DB8DB4;
        Sat,  8 May 2021 07:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 400A2B8DB3;
        Sat,  8 May 2021 07:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Moch <stefanmoch@mail.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        dwh@linuxprogrammer.org, git <git@vger.kernel.org>
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
References: <20210508022225.GH3986@localhost>
        <CAP8UFD0vp-zZv=Q1+KWv8PHnxTuspTw2aSCUp8QUic0HOSyq4w@mail.gmail.com>
        <xmqqim3tvhlr.fsf@gitster.g> <609645cb11f72_1fc6d208ee@natae.notmuch>
        <f4f782c4-3adc-8c1c-428d-8037426fc475@mail.de>
Date:   Sat, 08 May 2021 20:12:02 +0900
In-Reply-To: <f4f782c4-3adc-8c1c-428d-8037426fc475@mail.de> (Stefan Moch's
        message of "Sat, 8 May 2021 12:11:51 +0200")
Message-ID: <xmqqlf8ptr7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 377B220E-AFEE-11EB-9963-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Moch <stefanmoch@mail.de> writes:

> Good idea to write this down. How to use the mailing list is only
> sparsely documented. The following files talk about sending to the
> mailing list:
>
>  1. README.md
>  2. Documentation/SubmittingPatches
>  3. Documentation/MyFirstContribution.txt
>  4. MaintNotes (in Junio's =E2=80=9Ctodo=E2=80=9D branch, sent out to t=
he list from
>     time to time as =E2=80=9CA note from the maintainer=E2=80=9D)
>
> 2, 3 and 4 mention sending Cc to everyone involved.
>
> 2 is about new messages.
>
> 3 and 4 specifically talk about keeping everyone in Cc: in replies.
> Both in the context of =E2=80=9Cyou don't have to be subscribed and you
> don't need to ask for Cc:=E2=80=9D.

In case somebody wants to write a doc, a better pair of references
than what I quoted earlier to draw material from are:

https://public-inbox.org/git/7v4pndfjym.fsf@assigned-by-dhcp.cox.net/
https://public-inbox.org/git/7vei7zjr3y.fsf@alter.siamese.dyndns.org/

