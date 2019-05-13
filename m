Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FAA1F461
	for <e@80x24.org>; Mon, 13 May 2019 05:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfEMFOS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 01:14:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64572 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMFOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 01:14:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C140B1563E7;
        Mon, 13 May 2019 01:14:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cXkAIGpmBkQyBGLN2gPyLGa1kHc=; b=Jm0igB
        kdVfHYmyxg0rWAN48NvDHgdErqtdI+HDBXHVzwHQRN2/SL7vwpFpleEKVhai5nZ+
        tKhU1zI8IeZx1KMn9iZasBzr7u3QJgdqOIQ8KDj/e1bi9vPzU5wIc8zuhUy/fxsf
        DbvaDzpwWoqXiqtUs0lc+attQJ1M8z9nNMcVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kDAIBe4aLscsalxFy2Hx+OC7QgJUOc59
        vxM+B9A//meQi2cDBkkKEFzaqXgTqOnLYepVJmYi1uFG4cyM066JaxM5MPXyeQF5
        +W8jr2YKadGcwIVQwmU2cgtDTUQDl2ii7Xc6wymqmCf+pxe5qxokiPpY9Neyyv4G
        xp3pSjiEIW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8D11563E6;
        Mon, 13 May 2019 01:14:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E41641563E5;
        Mon, 13 May 2019 01:14:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/14] cmd_{read,write}_tree: rename "unused" variable that is used
References: <20190509212558.GA15438@sigill.intra.peff.net>
        <20190509212724.GA15837@sigill.intra.peff.net>
Date:   Mon, 13 May 2019 14:14:15 +0900
In-Reply-To: <20190509212724.GA15837@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 9 May 2019 17:27:24 -0400")
Message-ID: <xmqqlfzbc4wo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4A6891A-753D-11E9-BE2E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I kind of hate "cmd_prefix"; I was tempted to just call it "prefix" so
> that all of the cmd_* functions were consistent, but I worried that it
> really would get confused with the local variables (even if those
> variables are renamed, as I do here).

I tend to agree with your temptation to make things consisten,
especially because you already do the renaming of existing "prefix"
to "tree_prefix".

Perhaps in a few release cycles, these can be renamed again to be
consistent with everybody else, and I won't die if this were called
cmd_prefix until then ;-)

