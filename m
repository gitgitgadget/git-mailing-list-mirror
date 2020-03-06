Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF80C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9B920705
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EkMKwbuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFV26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:28:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFV26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 16:28:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 303E73EE6D;
        Fri,  6 Mar 2020 16:28:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=37TKThQJswxH8dE+oHUc5ak7zE8=; b=EkMKwb
        uOrtpWooRs/fP5hHSUj+JWbLrGNTOLxLQOShutwVzxAghL8Sj6hVpscAtem21tCk
        i2+smVLYlHSpJheKYrgYyOvSItEv0sJQqYCQ5UFvDRj8cJJWgU9ACbaivHpbHDaJ
        w30VqFLcubobGoUBW7DerplDX5TxKvQhkitZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nq99AW/vIZ4ZKdvj2+kSI84rrlO7K8Yp
        Eq+O3KUTBep0t2YmkdMa7xlRVSQXdkIxNQpS30ECY/eqooeJDiUdKwQzRdl+AfJk
        KywCJbGycTlwDWhylj5DePxNh1PNq9K9Hc8rv34JO+y+56XSHmH417RYoqHymwgB
        8vLktlHX9/U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 282D33EE6C;
        Fri,  6 Mar 2020 16:28:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F3733EE6A;
        Fri,  6 Mar 2020 16:28:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] update how-to-maintain-git
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
        <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
        <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com>
        <CACg5j26uLyyHRx0ouVhUbJ8P20uJgvN4WCqunP5OoXhGyxuadA@mail.gmail.com>
        <xmqqzhct2y91.fsf_-_@gitster-ct.c.googlers.com>
        <CAPig+cStRc2hTmRBEfyaqhyx=M5nQ84rPzOEMVVLabQ2PS_Qzw@mail.gmail.com>
Date:   Fri, 06 Mar 2020 13:28:54 -0800
In-Reply-To: <CAPig+cStRc2hTmRBEfyaqhyx=M5nQ84rPzOEMVVLabQ2PS_Qzw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 6 Mar 2020 14:06:47 -0500")
Message-ID: <xmqqeeu52mw9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BBDC5A0-5FF1-11EA-9BD6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 6, 2020 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>> +   Whether it is the initial round or a subsequent round, the topic
>> +   may not build even in isolation, or may break the build when
>> +   merged to integration branches due to bugs.  There may already be
>> +   an obvious and trivial improvements suggested on the list.  The
>
> s/an//
>
>> +   maintainer often adds an extra commit, with "SQUASH???" in its
>> +   title, to fix things up, before publishing the integration
>> +   branches to make it usable by other developers for testing.
>> +   These changes are what the maintainer is not 100% committed to
>> +   (trivial typofixes etc. are often squashed directly into the
>> +   patches that needs fixing, without being applied as a separate
>
> s/needs/need/
>
>> +   "SQUASH???" commit), so that they can be removed easily as needed.

Thanks.
