Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E8C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF0A2073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GIm009PW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgAGQPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:15:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57696 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgAGQPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:15:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41504ADB5B;
        Tue,  7 Jan 2020 11:15:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CyhXgSifRQPHdR2TPbJXJ8ZPUsY=; b=GIm009
        PWQ2UiDSJehNDBMzbpDHwU+MBXdA71YXL39jmM9NGtJDnullErTboOEXHbGGCPzq
        7OUftxQjgLih+WXYjRafske6iOdipGpoiU1mdr9Jf8Xe0vyvT/XMQ0K+FLaFsWtz
        VTcDxjN2i/Blp2GjKBMkjBYragSwUR3PNpJpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UflGuJsM+bWVaOd874lo6tWouMs0F0H7
        R8yYYyr+lxwXVvidtf9kuw71MrXMzVamlmE4+9vm3DpfSd608MuNR/4QmtanPnyw
        DkhX/h/pzr8OJ0SZ/xQ+AntVcjJT3CUmwJ4WBcmOTRX4LOwzfuWbWJjW5sNwya2r
        1atldTojJCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39A45ADB59;
        Tue,  7 Jan 2020 11:15:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E80B6ADB48;
        Tue,  7 Jan 2020 11:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
        <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
        <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
        <20200107013401.GI6570@camp.crustytoothpaste.net>
Date:   Tue, 07 Jan 2020 08:15:16 -0800
In-Reply-To: <20200107013401.GI6570@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 7 Jan 2020 01:34:01 +0000")
Message-ID: <xmqqlfqj6y5n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6607324-3168-11EA-990D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I can see the argument that this makes it a little harder for mechanical
> processing across versions, but I suspect most of that looks something
> like "sed -i -e '/^squash! /d' COMMIT_EDITMSG" and it probably won't be
> affected.

With the left-anchoring, the search pattern will no longer find that
line if "squash!" is commented out, but people tend to be sloppy and
do not anchor the pattern would not notice the difference.  Perhaps
the downside may not be too severe?  I dunno.

> We do make occasional slightly incompatible changes across
> versions in order to improve user experience, and I think a lot of folks
> who use squash commits will find this a pleasant improvement.

