Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B5C2D0D1
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 23:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24573207FF
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 23:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OqbLi/aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL2XOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 18:14:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62413 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2XOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 18:14:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBE349758D;
        Sun, 29 Dec 2019 18:14:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OIzoo0s2omcP
        /SDRuUDjW7UbhY4=; b=OqbLi/aPXAF1NbGCIYN41ukYXCTdzCnsH+EL0MqUvxd0
        DCuH3JoIdY2QuaCqlavJC0kGOvQJvbUVIG8nIMFcHMm4hP9erXRJF6vz+UIsxK3C
        aKtvOAs7BpopfFXlahOi0KnOZC0LkL9BMlM+7Zz2rDP2ziost7w8N/mXZYj2iUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WKn7eR
        FW/Z/6pKjWJZiX9Wqt8BsM3qoKfxfVpB3nOqq+kV2N1k11ZNBo8Dwio5FF53DnYK
        GH4QsfUQhY2dFxCkFxHMeMrpT0/UWyOETP04OuGQXH5QSSO4Qg+VOMsRMX8dN2MU
        CuG9Zld3RYoWxLYriT5/0yVkGLDMd7l7LUo7g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4CE79758C;
        Sun, 29 Dec 2019 18:14:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CD0B9758B;
        Sun, 29 Dec 2019 18:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zoli =?utf-8?Q?Szab=C3=B3?= <zoli.szabo@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-gui: add possibility to open currently selected file
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
        <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
        <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
        <xmqqy2uxiemt.fsf@gitster-ct.c.googlers.com>
        <ee041086-3579-190d-e607-1973bcc94c23@gmail.com>
Date:   Sun, 29 Dec 2019 15:14:43 -0800
In-Reply-To: <ee041086-3579-190d-e607-1973bcc94c23@gmail.com> ("Zoli
 =?utf-8?Q?Szab=C3=B3=22's?=
        message of "Sun, 29 Dec 2019 22:15:34 +0200")
Message-ID: <xmqqh81iiv18.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00D307DC-2A91-11EA-9AEB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zoli Szab=C3=B3 <zoli.szabo@gmail.com> writes:

> On 2019.12.28 00:32, Junio C Hamano wrote:
>
>> The phrasing on the title is a bit awkward.  "add possibility to do
>> X" is better spelled "allow doing X", no?
>
> Thank you, Junio, for the hint. Updated the commit message accordingly
> (PATCH v2).

Also, do not start the body of the proposed log message with half
sentence.  The title is supposed to be a full sentence.


