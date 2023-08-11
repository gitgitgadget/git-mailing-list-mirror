Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B64CC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjHKVtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbjHKVtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:49:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20058271B
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:49:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7582C1A6C2A;
        Fri, 11 Aug 2023 17:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mYpxy11c7DCDXO3P4UpcaXPZnbb5RQdaQ6VB90
        IYAgs=; b=QU9lJRaeoMYjRM/kr/5CoPJhiptbHE+gNx6kgtBZq1SzMNyyegyToW
        zYNKBOJfj8GvibVn+X38fq/MyuNHots75b9wbfcIXf3fIHxtydwfs+z2FBgsRLZG
        od9Az5FZ335leLcxRv0JXJ9HcI2d3fFA32UVtpi8g3EgCN+T0O2HI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FCB71A6C29;
        Fri, 11 Aug 2023 17:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9ACCF1A6C28;
        Fri, 11 Aug 2023 17:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Mun Johl'" <Mun.Johl@wdc.com>, <git@vger.kernel.org>
Subject: Re: "fatal: Not a git repository" issued during 'make' from source
 code
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
        <xmqqr0o9qpon.fsf@gitster.g>
        <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
        <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com>
Date:   Fri, 11 Aug 2023 14:49:20 -0700
In-Reply-To: <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 11 Aug 2023 17:46:28
        -0400")
Message-ID: <xmqqr0o9p7vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE1E6E62-3890-11EE-8196-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Did you run 'make configure' before using 'make prefix=/usr/local all doc' ?

A tarball release ships with configure (built out of configure.in)
included, so that should not be necessary.

