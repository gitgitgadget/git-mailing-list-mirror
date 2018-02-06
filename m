Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66791F404
	for <e@80x24.org>; Tue,  6 Feb 2018 19:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeBFT56 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 14:57:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64976 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeBFT55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 14:57:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19B14DBD2B;
        Tue,  6 Feb 2018 14:57:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=hY5tdo8k/p1mm
        Vc0nYOwZLL/oAs=; b=EvWBADzenD+FWevr1A4gtgnPFZ5UnAwrVOPffHLziVSgN
        7YjSD0LNSjMzBcJLswf4MEewZatvjgyvuxIAyjy8SgoY0KsGKBc2v+e8HNZYXYHK
        bNx9s65y356Mj+zJQcnBMPDpXJEGkOB0fXBwUydl8J/z1iLvufymIZV5K+TbPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=KxgmDwB
        p5bcvncMJaLlU+Zxj9x0wawyh5UvOIO1yadfNNMCMESumBTlJ1uVmf0DMOPBfkrz
        LDvoKnaqh5J+mgpiV6BPSjYnWUwiLCH+ry9oOFe89WZWcPHJRvuAykE3+5piuAmj
        xbDwf7F/yChyk1qkFYcQnCiio8IYpyP2tJhM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11FCBDBD2A;
        Tue,  6 Feb 2018 14:57:57 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93899DBD29;
        Tue,  6 Feb 2018 14:57:56 -0500 (EST)
Date:   Tue, 6 Feb 2018 14:57:54 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jason Racey <jason@eluvio.com>
Cc:     git@vger.kernel.org
Subject: Re: "git branch" issue in 2.16.1
Message-ID: <20180206195754.GE1427@zaya.teonanacatl.net>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: 066995B0-0B78-11E8-8FD6-692D1A68708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jason,

Jason Racey wrote:
> After upgrading git from 2.16.0 to 2.16.1 (via Homebrew -
> I=E2=80=99m on macOS) I noticed that the =E2=80=9Cgit branch=E2=80=9D c=
ommand
> appears to display the branch listing in something similar
> to a vi editor - though not quite the same. I don=E2=80=99t know
> the technical term for this state. You can=E2=80=99t actually edit
> the output of the command, but you=E2=80=99re in a state where you
> have to type =E2=80=9Cq=E2=80=9D to exit and then the list disappears.
> It=E2=80=99s very inconvenient and it doesn=E2=80=99t seem like it was =
by
> design. I=E2=80=99m using zsh in iTerm2 if that helps. Thanks.

In 2.16.0 `git branch --list` is sent to a pager by default.
(Without arguments, --list is the default, so this applies
to `git branch`).

You can set pager.branch to false to disable this in the
config, or use git --no-pager branch to do so for a single
invocation.

I can't say why you're seeing this with 2.16.1 and not
2.16.0, but I'm not familiar with homebrew, so perhaps
something didn't work as intended in 2.16.0.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Historian, n. A broad-gauge gossip.
    -- Ambrose Bierce, "The Devil's Dictionary"

