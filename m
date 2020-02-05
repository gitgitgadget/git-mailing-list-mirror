Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2545C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652CE214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p0OYG3c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEUGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:06:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54873 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEUGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 15:06:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFCDEAF4B8;
        Wed,  5 Feb 2020 15:06:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t2M4+KzWHp3w
        +smhjATytjJ1w1k=; b=p0OYG3c8hvQVKZ/5M/vSGvphrIT9c6dbZNhzh9ZYFe/b
        uj3lD9FdPYzE7poUssedtc+h1G464WL9+YqsRc5RoJHMhcDKlFy/5R4chemCWCyK
        dF7cU5H/2QzfCHS4Uywjcdm/FIE38KBce9F4Dbm2FwUjLYUGhc9HoRMZ+s30lFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XueGKj
        jM8NQVEMqZMZqEnA6A7J4io7i8F+hKN+1r7AQEWSExEwFg0Y6/g6tLh16QL9Ujv0
        TaHzS9mYMmx2IGvE0/dlDTchkDZ3HNbmFMYvMwEXBXe0bApkTJSXcKXD+cstQjfu
        e84YNMYlY1LQ7LhGMkJ6XRG8g+HtPeP9ClVA8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7916AF4B7;
        Wed,  5 Feb 2020 15:06:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18ED8AF4B5;
        Wed,  5 Feb 2020 15:06:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 08/15] bugreport: include user interactive shell
References: <20200124033436.81097-1-emilyshaffer@google.com>
        <20200124033436.81097-9-emilyshaffer@google.com>
        <CAN0heSq9AdF_WPmSkxDA3cPzOQBAbuw4oa+8azvLtjbP-jQfKw@mail.gmail.com>
Date:   Wed, 05 Feb 2020 12:06:46 -0800
In-Reply-To: <CAN0heSq9AdF_WPmSkxDA3cPzOQBAbuw4oa+8azvLtjbP-jQfKw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 30 Jan 2020 23:28:40
 +0100")
Message-ID: <xmqqmu9w6bop.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AEF8954-4853-11EA-BA7C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Fri, 24 Jan 2020 at 04:41, <emilyshaffer@google.com> wrote:
>> +       char *shell =3D NULL;
>
> (Unnecessary initialization.)
>
>> +       shell =3D getenv("SHELL");
>> +       strbuf_addf(sys_info, "$SHELL (typically, interactive shell): =
%s\n",
>> +                   shell ? shell : "(NULL)");
>
> Thanks for avoiding a classic pitfall. :-)
>
> "<unused>" instead of "(NULL)"? "NULL" is mostly an implementation
> detail.

Isn't that <unset>?
