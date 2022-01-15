Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50EC433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiAOAZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:25:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63173 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiAOAZW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:25:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 186791146B8;
        Fri, 14 Jan 2022 19:25:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DpQaKaivWC4eJW7bQESJ3meRoDgiit239REfk6DqEtw=; b=gdpf
        ejtG+exmO74DlAi+oka2ObQERAjFZ1h0yIE52QW/wbylTclG4D3MyJrMK3FXGSGO
        150H7/mwvsQnrSai1QaCxP46iX8QzRDfiBlNuHuq28GTq/AuYcFpdm/yX056/gjW
        E1L61i81dMSaOE3GyLsfHP6u7EbsACxiPe8v74o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11AEC1146B5;
        Fri, 14 Jan 2022 19:25:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80FD81146AC;
        Fri, 14 Jan 2022 19:25:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
        <CADMgQSQC4T+MBgbFROy0cmB8FFk=EgikPfErwpMbduaFvEebDA@mail.gmail.com>
Date:   Fri, 14 Jan 2022 16:25:20 -0800
Message-ID: <xmqqwnj17slr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF08664-7599-11EC-B9B1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> On Fri, Jan 14, 2022 at 1:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> Apparently, it is not a common knowledge at least for you (and
>> probably others).  Perhaps we should add a paragraph to the cli help
>> and explicitly mention "options first and then args", before we go
>> on to say "among args, revs first and then pathspecs".
>
> It's much clearer now, thanks for the detailed answer.
>
> Another question, if I want to follow your advice and add a short
> paragraph in git CLI document, should this patch continue in the
> current RFC patchset or launch a new patchset?

If I were you, I would retract the ls-remote topic and create a
brand new topic that is about clarifying/enhancing the gitcli.txt
file, which has nothing to do with ls-remote, because the command
line option/argument convention is not specific to a single command.
