Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9A9207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbcJFSlr (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 14:41:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64145 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933303AbcJFSlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 14:41:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C93A447C7;
        Thu,  6 Oct 2016 14:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MoZdCF4J92lnFLDeDCDdPqf/aSI=; b=II+tmt
        WphoocdP8SDrJupvhTxj9p6Xr5bnLySE6KAkgr0ImBcCSXwjcQjFj6y4l7a2i+mM
        pG/FsFjCTlLzfC/9gCTJQHB8Dy2DoyAnASzLAz3xw/SkjK0FClA/afOpbNit/PPs
        sEE+OwN3ELHS8BdbTV+lm47LF4BrrrbMInjwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ycwl3iL/PJGUxG3qiXNl/I7KLry3LSs5
        UdOWJreiwSRsox4Og3hmtmuBLooM0iBxgecNr1xXAg9PRxUIRv3GzZuY48v9y8Cu
        vJjXaJ45dgrKLY/TjQJxzcbp5MIelk3pmiWJoPWSakt4pU3vdK0hjTLB2L8f1VBJ
        EdxHw+bdDLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65768447C6;
        Thu,  6 Oct 2016 14:41:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF909447C5;
        Thu,  6 Oct 2016 14:41:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the script
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
        <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609121019290.129229@virtualbox>
        <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610061459390.35196@virtualbox>
        <5ed8aaea-9fbe-11b0-49b7-1b42567d4918@kdbg.org>
Date:   Thu, 06 Oct 2016 11:41:12 -0700
In-Reply-To: <5ed8aaea-9fbe-11b0-49b7-1b42567d4918@kdbg.org> (Johannes Sixt's
        message of "Thu, 6 Oct 2016 18:23:27 +0200")
Message-ID: <xmqqa8ehl3qv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75FF3BFA-8BF4-11E6-829F-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Let me take the opportunity to say
>
>    Thank You Very Much!
>
> for the new implementation of rebase -i. I'm using your branch
> rebase-i-extra, and it is such a pleasure to work with on Windows
> compared to the old fully scripted version.

Thanks for testing.  

Having more guinea pigs ^W ^W testers before the series is reviewed
here would be a nice boost and would hopefully encourage more
reviewers to help the series into a good shape to be upstreamed ;-)

> ---- 8< ----
> [PATCH] sequencer: strip CR from the end of exec insns
>
> It is not unheard of that editors on Windows write CRLF even if the file
> originally had only LF. This is particularly awkward for exec lines of a
> rebase -i todo sheet. Take for example the insn "exec echo": The shell
> script parser (either of the sequencer or of the shell that is invoked,
> I do not know) splits at the LF and leaves the CR attached to "echo",
> which leads to the unknown command "echo\r".

Interesting find.  So it's not just ltrim is being lenient only to
end-user typo, but not doing rtrim can actively hurt ;-)

> Work it around by stripping CR before the command specified with exec is
> passed to the shell.

Makes sense.

