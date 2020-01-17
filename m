Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE64C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CC52072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jU+GM4sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgAQV2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:28:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65036 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgAQV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:28:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59A82A8511;
        Fri, 17 Jan 2020 16:28:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xtvVTB2sqQq7NvA9GMHteJ6mdBs=; b=jU+GM4
        syuQKxIruYmHhGzVTQHwQLfMdET0TQVZmjtQa9vJmIA/wDiQ0PgeyCOP8ftiHFDM
        KCd7AHYVHuaEsVh0Q9x3/ZjplWytwZd0omv5ZH9TDnstTNcY2Xggs4yXCjxhWMxR
        de9ZPI2rbcTvR5kUpVMlk7WyOSTQ3BGmVBPS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vqqy//pKgY0pYIywDRno/K0TMyGbiQkL
        E8stw0OdlarX3qILqiNGwRGcGVYu4p8UcW+tHobuiOULnb2NArdDlIAUv8rdlJLq
        nhrRYq6sCBkyhaoJDa++Uok0ek2SgkHB1dZVGosA2YuqsE4MHmIvL9vxzMyHR3B/
        FNVxIINQeBI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5213BA8510;
        Fri, 17 Jan 2020 16:28:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 140C9A850D;
        Fri, 17 Jan 2020 16:28:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] t6025: modernize style
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
        <20200117204426.9347-1-shouryashukla.oo@gmail.com>
        <20200117204426.9347-2-shouryashukla.oo@gmail.com>
        <CAPig+cTW4hATiMYVE7kzcLqK3do9=K8X0nmYjWLOhabgOxZ-XA@mail.gmail.com>
Date:   Fri, 17 Jan 2020 13:28:25 -0800
In-Reply-To: <CAPig+cTW4hATiMYVE7kzcLqK3do9=K8X0nmYjWLOhabgOxZ-XA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 17 Jan 2020 16:15:12 -0500")
Message-ID: <xmqqk15pdb7q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D1B7816-3970-11EA-8671-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       l=$(printf file | git hash-object -t blob -w --stdin) &&
>> +       echo "120000 $l symlink" |
>> +       git update-index --index-info &&
>
> As mentioned[1] in the review of v1, this should be written:
>
>     echo "120000 $l symlink" | git update-index --index-info &&
>
> [1]: https://lore.kernel.org/git/xmqqftgff1r0.fsf@gitster-ct.c.googlers.com/
>
>> +       git commit -m master &&
>> +       git checkout b-symlink &&
>> +       l=$(printf file-different | git hash-object -t blob -w --stdin) &&
>> +       echo "120000 $l symlink" |
>> +       git update-index --index-info &&

Same here.  Funnily, 2/3 improves on this, but I agree that we
should get it right from the get-go.

>> +       git commit -m b-symlink &&
>> +       git checkout b-file &&
>> +       echo plain-file >symlink &&
>> +       git add symlink &&
>> +       git commit -m b-file
>> +'
