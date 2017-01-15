Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6380A20A17
	for <e@80x24.org>; Sun, 15 Jan 2017 02:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbdAOCfr (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 21:35:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52525 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750780AbdAOCfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 21:35:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 090B1610BD;
        Sat, 14 Jan 2017 21:35:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HnQQQ2znp5vcX32Yyi/LRtdEpbE=; b=G/QF4x
        UgJGK/x9VA18DUUv/V9nHud0W8CqFOb2q1vcrxy5TjIBL7j/O/SottOqJJraQCSZ
        O77vVjCKaYDewzu3C+kpljbsjVkfF82+G27STlrOCVRTBdIImexQc15S8L3sFyR8
        LirLa+kN/5rH4fMy/F3IDQ4/IoaKYoSTJ9RkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fZFBuYtcZKo4nLldTpu14TY2smGhdkL9
        FF2OW/kw+tBqsQcz2CiNkMQiEAoKAc58yQNN9NEaONRP+OWEzhvM4EYppV+bvnsW
        5EDAT6GQJ5kyRFqaF68eBADKzbLP2LoUiz0R+ClmaMdpGFYVMBcIKSjXzrxBsixi
        u8H5kZEEaFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E61B6610BB;
        Sat, 14 Jan 2017 21:35:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F855610BA;
        Sat, 14 Jan 2017 21:35:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Andrew Janke <floss@apjanke.net>,
        Paul Mackerras <paulus@samba.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk pull request // was: Re: gitk: "lime" color incompatible with older Tk versions
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
        <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
        <20170113112043.j7nowdilolswyk2k@gmail.com>
        <20170114084825.lcecrbtxny3ntulf@gmail.com>
Date:   Sat, 14 Jan 2017 18:35:43 -0800
In-Reply-To: <20170114084825.lcecrbtxny3ntulf@gmail.com> (David Aguilar's
        message of "Sat, 14 Jan 2017 00:48:25 -0800")
Message-ID: <xmqq37gldp8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 505B5322-DACB-11E6-A62F-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> On Fri, Jan 13, 2017 at 03:20:43AM -0800, David Aguilar wrote:
>> 
>> Ping.. it would be nice to get this patch applied.
>
> Sorry for the noise, and thank you Paul for the fix.
> This was already fixed by Paul in gitk@22a713c72df.
>
> I'm sure Junio will merge gitk.git into git.git soon enough so I
> can sit tight until then, but while I'm here I might as well
> send out a pull request:
>
> The following changes since commit 22a713c72df8b6799c59287c50cee44c4a6db51e:
>
>   gitk: Follow themed bgcolor in help dialogs (2016-03-19 14:12:21 +1100)
>
> are available in the git repository at:
>
>   git://ozlabs.org/~paulus/gitk.git 
>
> for you to fetch changes up to fbf426478e540f4737860dae622603cc0daba3d2:
>
>   gitk: Update copyright notice to 2016 (2016-12-12 20:46:42 +1100)

Pinging Paul to signal me that his tree is ready to pull from is
appreciated, and asking Paul if his tree is ready to be pulled and
then relaying his answer to me is also fine, but I am sensing that
this message is neither.  So let me double check.

Paul, is it a good time to pull, or do you still have something not
published yet that should go together with what you have already
queued?

Thanks.

>
> ----------------------------------------------------------------
> Markus Hitter (3):
>       gitk: Turn off undo manager in the text widget
>       gitk: Remove closed file descriptors from $blobdifffd
>       gitk: Clear array 'commitinfo' on reload
>
> Paul Mackerras (2):
>       gitk: Use explicit RGB green instead of "lime"
>       gitk: Update copyright notice to 2016
>
> Rogier Goossens (3):
>       gitk: Add a 'rename' option to the branch context menu
>       gitk: Allow checking out a remote branch
>       gitk: Include commit title in branch dialog
>
> Satoshi Yasushima (1):
>       gitk: Fix Japanese translation for "marked commit"
>
> Stefan Dotterweich (1):
>       gitk: Fix missing commits when using -S or -G
>
> Vasco Almeida (2):
>       gitk: Makefile: create install bin directory
>       gitk: Add Portuguese translation
>
>  Makefile    |    1 +
>  gitk        |  166 +++++--
>  po/bg.po    |    4 +-
>  po/ca.po    |    6 +-
>  po/de.po    |    4 +-
>  po/es.po    |    4 +-
>  po/fr.po    |    4 +-
>  po/hu.po    |    4 +-
>  po/it.po    |    4 +-
>  po/ja.po    |   13 +-
>  po/pt_br.po |    4 +-
>  po/pt_pt.po | 1376 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  po/ru.po    |    4 +-
>  po/sv.po    |    8 +-
>  po/vi.po    |    4 +-
>  15 files changed, 1549 insertions(+), 57 deletions(-)
>  create mode 100644 po/pt_pt.po
>
> Thanks,
