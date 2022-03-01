Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E48DC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiCAC76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCAC74 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:59:56 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA295AEFF
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:59:15 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3533918686E;
        Mon, 28 Feb 2022 21:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1U4DJNtsFs4Jwwqb6CXZouWTwqeqYcec8ThjNb
        9fBJw=; b=gzMK4lJK1l8zsr35kMQkkFp1d6geu17Un8H9w3XUOcC5smK6QbbAZE
        3CwumIuKpOUsMInPH0tuzIKJe31DeFWZNbhBMZXBpD3jxm54qnsMwpG3tRcBXUwp
        gVvuN5DpION2IyDZNjU14Kp50AorisPb+fVf1kBv3zbbyzZlWgYSg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D71218686D;
        Mon, 28 Feb 2022 21:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ADB3E18686C;
        Mon, 28 Feb 2022 21:59:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqzgmd5uzu.fsf@gitster.g>
Date:   Mon, 28 Feb 2022 18:59:11 -0800
In-Reply-To: <xmqqzgmd5uzu.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        26 Feb 2022 10:43:33 -0800")
Message-ID: <xmqqee3mwf7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92BE0EAE-990B-11EC-90D7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> FWIW, CI run on "seen" uses this series.

Another "early impression".  I had to open this one today,

    https://github.com/git/git/runs/5367854000?check_suite_focus=true

which was a jarring experience.  It correctly painted the fourth
circle "Run ci/run-build-and-tests.sh" in red with X in it, and
after waiting for a while (which I already said that I do not mind
at all), showed a bunch of line, and then auto-scrolled down to the
end of that section.

It _looked_ like that it was now ready for me to interact with it,
so I started to scroll up to the beginning of that section, but I
had to stare at blank space for several minutes before lines are
shown to occupy that space.  During the repainting, unlike the
initial delay-wait that lets me know that it is not ready by showing
the spinning circle, there was no indication that it wants me to
wait until it fills the blank space with lines.  Not very pleasant.

I do not think it is so bad to say that it is less pleasant than
opening the large "print test failures" section and looking for "not
ok", which was what the original CI UI we had before this series.
But at least with the old one, once the UI becomes ready for me to
interact with, I didn't have to wait for (for the lack of better
phrase) such UI hiccups.  Responses to looking for the next instance
of "not ok" was predictable.

Thanks.
