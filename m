Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F73C1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCBF206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DLO66QbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCVXpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:45:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62280 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCVXpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 19:45:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5ED5D778B;
        Sun, 22 Mar 2020 19:45:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/ANg7IgVwv8og3F6w8bGbv3kBA=; b=DLO66Q
        bHMm1QatRLeJAVSQuLBEPL6SYVHHOBwdN5JwGYOUhydgGWtFy58QJWE2lPNUA03/
        p5ntmYBOGodk5ItoEG3sy6DQSvnB1vN4UFiYyiajlRAgeC7U78ufR1+Ot/mLGFP5
        olFsKpA3PBrxHpQrszwwuQi7BDcLUwBOL8Xz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LxNYP6sS4PV7nvTmAUixuyVPrZSbBqlC
        liGomBEeEyWvtJwVtfJMxdmY0UWhYL9WKpECi2apbqF5KGlqrDMKlsxCppvqNVby
        iV1G1I5Ci/M0UgFT7GdcO+wqsnwO+7XskkRGNxdsF4dRFV2hRBl72OG+3XMlBXmG
        B+aN+LGwReQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD5E3D778A;
        Sun, 22 Mar 2020 19:45:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 072EED7787;
        Sun, 22 Mar 2020 19:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/2] t: fix whitespace around &&
References: <20200315180902.13750-1-rybak.a.v@gmail.com>
        <20200322211422.15129-1-rybak.a.v@gmail.com>
        <20200322211422.15129-2-rybak.a.v@gmail.com>
Date:   Sun, 22 Mar 2020 16:45:37 -0700
In-Reply-To: <20200322211422.15129-2-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sun, 22 Mar 2020 22:14:22 +0100")
Message-ID: <xmqqr1xk6jj2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BFC3B7E-6C97-11EA-AA1A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Add missing spaces before '&&' and switch tabs around '&&' to spaces.

The latter is especially appreciated---people just don't pay
attention and it is much harder to spot with eyeballs than the
former.

> Also fix the space after redirection operator in t3701 while we're here.

I started writing "hmm, doesn't it belong to the previous step" and
then realized that this one is a bat between animals and birds ;-)

Thanks.
