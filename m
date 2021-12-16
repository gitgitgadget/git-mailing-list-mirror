Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73426C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhLPVca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:32:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhLPVca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:32:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F218FB4D5;
        Thu, 16 Dec 2021 16:32:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CtYp6o7cphZwnhQzctQeFDNIC9TQaLQlMGV74k
        DGpkI=; b=daMKjDOeTfmzpOn8u8rqU3l2qRy89dTiiHEgio3Zbf+RdLQPLXoefA
        9QpblN8MTsbNqLW+fQksyMQRixsWE+VIARkCc3bBJl/jHrfpcQ39kwNhdoUieqOi
        QWYTjG6lzRPWyEZZLvTOB50Llq5fZIrFUUBFABrovmcu/g4DypdYA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9675CFB4D4;
        Thu, 16 Dec 2021 16:32:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03CAEFB4D3;
        Thu, 16 Dec 2021 16:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     kashav madan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, kashav madan <kshvmdn@gmail.com>
Subject: Re: [PATCH] help: add space after autocorrect prompt
References: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
        <xmqqh7b933ej.fsf@gitster.g>
        <20211216062709.b4tcagi6qcqhasrh@gmail.com>
Date:   Thu, 16 Dec 2021 13:32:27 -0800
In-Reply-To: <20211216062709.b4tcagi6qcqhasrh@gmail.com> (Johannes
        Altmanninger's message of "Thu, 16 Dec 2021 07:27:09 +0100")
Message-ID: <xmqq35ms9qxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB767406-5EB7-11EC-A463-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>>  - It does not leave a SP before where the end-user input goes;
>>  - It append (y/N) _after_ question mark;
>
> I actually prefer this one;
>
> 	Run 'status' instead? [y/N] 
>
> sounds better than
>
> 	Run 'status' instead [y/N]? 
>
> but that's not a strong opinion.

It is fine to have your own preference, but we are discussing to
make the three, two of which use "[choices]? " while only one uses
"? (choices)", consistent.  

So I'd prefer to see us turn the odd man out to do "[choices]? "
first.  Adjusting to your personal preference can be proposed after
the dust settles for the consistency fix.

Thanks.
