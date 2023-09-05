Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECA1CCF9E5
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 23:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjIEX0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjIEX0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 19:26:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0651F9E
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 16:26:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B66DE25B46;
        Tue,  5 Sep 2023 19:26:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=t4+eG5SPpiPNjqvhj8leeO8CCoQNF1Df25nr3c
        9WmFs=; b=ybYjMBME272gwg4BBLl/pxjPwiPSK01rkVFJheYWeOChGRiy390Uwm
        NJqI+4Y0J9hnnX26qDNQUMFiUsSysoaZPv52F5KzF9TEUGS6fFkE2iZojilpyKCQ
        YgYYhTflqO1EqGdxobd+dopRaUZ2F36m4liUzuyttpiNhnuYPU0ys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE74125B45;
        Tue,  5 Sep 2023 19:26:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35ACF25B44;
        Tue,  5 Sep 2023 19:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Young <hanyang.tony@bytedance.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] show doc: redirect user to git log manual instead of
 git diff-tree
In-Reply-To: <20230905121219.69762-1-hanyang.tony@bytedance.com> (Han Young's
        message of "Tue, 5 Sep 2023 20:12:19 +0800")
References: <20230905121219.69762-1-hanyang.tony@bytedance.com>
Date:   Tue, 05 Sep 2023 16:26:26 -0700
Message-ID: <xmqq7cp4p5gd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2C46694-4C43-11EE-9190-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Young <hanyang.tony@bytedance.com> writes:

> While git show accepts options that apply to the git diff-tree command,
> some options do not make sense in the context of git show.

Wow, "diff-tree" is a bit too arcane, I would agree.

Strictly speaking, "options to control how the changes are shown"
are options that are meant for "diff" command (e.g. "--stat", "-w"),
but "log" understands some of the "diff" command options, the
updated text is *not* incorrect.

Because "show" is about displaying individual commits and not range,
some options that are meant for the "log" command (e.g.
"--first-parent", "--no-merges") do not make much sense.  So

    Some options that `git log` command understands can be used to
    control how the changes the commit introduces are shown.

or something like that, perhaps?  I dunno.

> -The command takes options applicable to the 'git diff-tree' command to
> +The command takes options applicable to the 'git log' command to
>  control how the changes the commit introduces are shown.
>  
>  This manual page describes only the most frequently used options.
