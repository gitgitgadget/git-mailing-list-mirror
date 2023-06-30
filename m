Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E97EB64D9
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 02:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF3CVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 22:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF3CVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 22:21:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB43585
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 19:21:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 688B419B5E6;
        Thu, 29 Jun 2023 22:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=TUOepPD12n+5Vnk9aR9MOGY9KZyegeaCdoBr1mkHvkc=; b=MDPL
        pM3F/hqsxrR+65yuZEFZHXewgoIfUq/B3lDGu8WjOPfMrPKdmlBjrG5l+HeJIYZS
        TrFNUPKiuAfU0wUfmWQsrUZue+9XFZEQUGQaREQJJfVVmNdADxzTtW3h+gbAGi8v
        LdcXcbT+vTO61etMqep8BOfiEy3q2sSC68xUi7M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61B1319B5E5;
        Thu, 29 Jun 2023 22:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C264619B5E4;
        Thu, 29 Jun 2023 22:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Vinayak Dev <vinayakdev.sci@gmail.com>, git@vger.kernel.org
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use
 trace_printf()
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
        <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
        <xmqq1qhu9ifp.fsf@gitster.g>
        <CAJoAoZnaU7WsCpnZY0Pvjg4_GJMZADF0FNC9fNZK56ShX2JO+g@mail.gmail.com>
Date:   Thu, 29 Jun 2023 19:21:17 -0700
Message-ID: <xmqqwmzl7krm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC244522-16EC-11EE-9449-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> ... I do very much
> like the idea of keeping the reference source in contrib/ as a set of
> patches, maybe along with a script to apply them (or a readme with the
> right `git am` invocation), and then checking that they still build.
> Checking that against the contents of the document is trickier,
> though, like you mentioned. Hm.

An approach to avoid two things (i.e. sample source and the code
snippet in the documentation) going out of sync is not to have two
of them in the first place.  If we give up readability of the MFOW
document in its source form, you may be able to arrange the code
snippet to be incorporated by the build test and documentation at
the same time.

