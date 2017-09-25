Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76312047F
	for <e@80x24.org>; Mon, 25 Sep 2017 05:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753756AbdIYFj1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 01:39:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752975AbdIYFj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 01:39:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88781B357E;
        Mon, 25 Sep 2017 01:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sHH8TJc+nrJpatunN9VJ4J9//Y8=; b=LLh4SI
        iEY91vx1C/tXOrMMpzAFGUZ/XzT2kkmfh/G2I02QB4WZ/OaxTfbyctGvdo1jrsnn
        oTfze0ekk5SHBtbJDHz2X6O6lDLNUJOB1am63ZlOYwQdz5NrsioJLnt8k4pPiudJ
        oR284KAtCli0Jp9OdO95cxMDStod5m6FXAGQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M1ujjcf0SdW6X6ER3tKuW5rvzkRQ46Jm
        stCQVIATFSM8WfF9gpFku/22Xgp/ykrwpIwSE5YVX+AnqtUDeP7pbY4HCUkdKYBw
        OTOs/QlLTrUbU2rkXY6cZ1iTfy0CaUo+xoWOSA4Ctn0/A9pGX3IJE1zCUb+LwQ4z
        UrVlwBleWWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F033B357D;
        Mon, 25 Sep 2017 01:39:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA0B3B357C;
        Mon, 25 Sep 2017 01:39:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse-options: only insert newline in help text if needed
References: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
        <1506312485-8370-3-git-send-email-drafnel@gmail.com>
Date:   Mon, 25 Sep 2017 14:39:23 +0900
In-Reply-To: <1506312485-8370-3-git-send-email-drafnel@gmail.com> (Brandon
        Casey's message of "Sun, 24 Sep 2017 21:08:05 -0700")
Message-ID: <xmqqing7e3qs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3A32E5C-A1B3-11E7-8620-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Casey <drafnel@gmail.com> writes:

> Currently, when parse_options() produces a help message it always emits
> a blank line after the usage text to separate it from the options text.
> If the option spec does not define any switches, or only defines hidden
> switches that will not be displayed, then the help text will end up with
> two trailing blank lines instead of one.  Let's defer emitting the blank
> line between the usage text and the options text until it is clear that
> the options section will not be empty.

This somehow looks familiar.  I think (together with the fix in 2/3)
this makes it definitely better.  

I also wonder if we want the final blank line, but that is sort-of a
different issue.

Thanks.
