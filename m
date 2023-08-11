Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B7EC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjHKUj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKUjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:39:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13196FD
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:39:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C572A266BB;
        Fri, 11 Aug 2023 16:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UrHo+/DWFoLs9Gehtmd/81UYEBkdNOM9aydXTo
        Y6LWk=; b=OtZgUJGjqnAJ3B5sDtZwqw98eD5GRXCvSGBHpR9repnE6S6KJe/0gG
        PNDRKzK7FVaCVmZvwIR+KElXr5D5tgSoY8PeKkrlV0jwrBAgRwoQQqwieD0B1QvF
        3yDLmuV1EU0dgvgUkHGoKVSHzrIdO7eI/rYaseP0PB0Yyjq/tzy/k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF134266BA;
        Fri, 11 Aug 2023 16:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C10C266B9;
        Fri, 11 Aug 2023 16:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Mun Johl'" <Mun.Johl@wdc.com>, <git@vger.kernel.org>
Subject: Re: "fatal: Not a git repository" issued during 'make' from source
 code
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
Date:   Fri, 11 Aug 2023 13:39:20 -0700
In-Reply-To: <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 11 Aug 2023 16:18:37
        -0400")
Message-ID: <xmqqr0o9qpon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 269C36A2-3887-11EE-B474-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
>>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I run
> 'make
>>prefix=/usr/local all doc', I get the following error:
>>
>>fatal: Not a git repository (or any parent up to mount point /tools)
>>
>>Which I infer means that I need to do the build within a git repo.  Is that
> correct?  Or
>>have I missed some basic step in the build process?
>
> Yes, you must be in the cloned git repository in order to run the build.

Shouldn't we be able to build out of a tarball?
