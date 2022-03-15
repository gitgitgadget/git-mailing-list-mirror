Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6FC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351315AbiCOTYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351321AbiCOTYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:24:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD1F24
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:22:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57A3E186891;
        Tue, 15 Mar 2022 15:22:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WSg/qED0wWmGEiAW7W1wu+nbY7JoOfu5NIMa+l
        S9nas=; b=E9tggChr946NdeJL8Q08vuD9T2Sw2+1AjpilEgZ+6TMiU0ifXKSWdD
        L/3C57HKp9YdKIa+RjwehnNnRhYkyEZ8JGxYazderR1nGEv2qjLf0eVqWjfFYSbA
        26HyXTt8hed4km96jBvP1x9QVrO5c4+qF4pvonLE7H68RhLtKT/lU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FA76186890;
        Tue, 15 Mar 2022 15:22:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 103A918688F;
        Tue, 15 Mar 2022 15:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
References: <20220304130854.857746-1-a97410985new@gmail.com>
        <20220312164803.57909-1-a97410985new@gmail.com>
        <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
        <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org>
        <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 15 Mar 2022 12:22:49 -0700
In-Reply-To: <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 15 Mar 2022 11:51:26 -0700")
Message-ID: <xmqq1qz3dnqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D9C26D6-A495-11EC-97B4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Interesting, I'll take note. I'm still personally not keen on supporting
> CommonJS-only patterns when we are purportedly trying to show diffs for
> JavaScript, but if we think this fits the style, I'm happy to oblige.

The question is, with these patterns that are aware of CommonJS
convention, would your bog-standard-and-boring vanilla JS code be
detected incorrectly?  Becoming aware of popular conventions without
hurting others would be a good thing.

And the "popular conventions" does not have to be limited to
CommonJS/Node.
