Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C825EC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 17:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGMRLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGMRLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 13:11:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CB2D53
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 10:11:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 245EB1A9DF2;
        Thu, 13 Jul 2023 13:11:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8jN569YbsZGCfCqMObT1ZA0vz7/xdnnPf5Fluh
        BtGmI=; b=iytmqTQI8xC6pP/Glj5RLT2gJ+EGdFwFb3blIHaPFHeDE2mKbyWrws
        vILmvYpNwuk8qR9igdEbn5y68zerehjFSzcuJAqpKCBXBkCGFSNDCumJkg649iJX
        HJdYkPzYhYQ0Mv4CRteq/LjgFUWeEHuUQMcomXmi0hnKxpXUG3vKY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A95E1A9DF1;
        Thu, 13 Jul 2023 13:11:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DEEE1A9DEF;
        Thu, 13 Jul 2023 13:11:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "nick" <nick@nicholasjohnson.ch>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
Date:   Thu, 13 Jul 2023 10:11:04 -0700
In-Reply-To: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous> (nick@nicholasjohnson.ch's
        message of "Thu, 13 Jul 2023 16:27:46 +0000")
Message-ID: <xmqqlefjpwif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4053F48E-21A0-11EE-BA73-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"nick" <nick@nicholasjohnson.ch> writes:

> hooks. Perhaps a config option to automatically set the date to a time
> before Git was invented?

For some use cases that are outside of how Git was designed to be
used, such configuration might be useful, but I am not yet convinced
that it is worth the engineering effort for this project to review,
accept and maintain changes to implement it.

Just my personal opinion, of course ;-)

After all, if you leave series of commits that stress the fact that
you not just fail to keep, but do deliberately avoid to keep, a
reliable record of when you made your changes, half the value of
keeping your work in source code management system vanishes.  When
somebody comes to your project and says certain parts of your code
were stolen from their proprietary IP, wouldn't you rather be able
to produce the record of who did what at which time to refute their
claim by showing that your project members invented the code long
before they claim they were stolen from them?
