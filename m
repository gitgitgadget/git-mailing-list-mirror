Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1989C1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF0Qqz (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 12:46:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50337 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0Qqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 12:46:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C24AD156D7C;
        Thu, 27 Jun 2019 12:46:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C1cZgXGXTMvq
        3/ILUBAXoVzVC10=; b=Zhq8VG754lx1S/NcLBijNcuxXXqhXvSfhKh6Edx07dF+
        xOD1slqsLSQJEsvZBXWJxXJQfpAC+3XoO1VbKJ9dc+IUxJutgc+hWDvt6lOH6J6E
        f9dcl1bBkAS4jARMLwBma0/zNB56T4bBptyYb0WMJQ/SOsog19xWP+YGqIlJVXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hy+Fnj
        1DLlIVJSURWnzb9EJZfgJC8hwcVinAjwcddd+YIh69DkpWSpEAZklUXJiG5V5kQd
        ZS0bBIOT1DFM9vvWd3uRe6c2riIIU0e+T/qMEf5IOSTqBrN/2MSaf1u6zOOeS3EP
        O5Terl+4sHwWriFRjeS73DTTYOlH6WkK1IZmI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8951156D7B;
        Thu, 27 Jun 2019 12:46:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E0E5156D7A;
        Thu, 27 Jun 2019 12:46:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Travis not looking so good
References: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
        <20190601004143.GN8616@genre.crustytoothpaste.net>
        <20190602112239.GO951@szeder.dev>
        <20190626203559.GA71590@TaylorsMBP3745.attlocal.net>
        <20190627132319.GB21574@szeder.dev>
Date:   Thu, 27 Jun 2019 09:46:51 -0700
In-Reply-To: <20190627132319.GB21574@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 27 Jun 2019 15:23:19 +0200")
Message-ID: <xmqqy31nasck.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A0F87EC-98FB-11E9-948A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> However, we've always used the macOS build jobs as "build and test
> with the latest and greatest", i.e. they install the latest available
> Perforce and Git-LFS.  To keep up with this tradition we'd need to run
> 'brew update' and in turn would need to 'brew install gcc'.
>
> [1] See e.g. a1ccaedd62 (travis-ci: make the OSX build jobs' 'brew
>     update' more quiet, 2019-02-02) or
>
>     https://public-inbox.org/git/20180907032002.23366-1-szeder.dev@gmai=
l.com/T/#u

Is the reason why you did not submit your bonus patch [*1*] in the series=
 at

  https://public-inbox.org/git/20190614100059.13540-1-szeder.dev@gmail.co=
m/

because it goes the opposite way, i.e. "build and test with whatever
happens to be in the image"?

Unless what happens to come in the image at travis-ci.org is
hopelessly outdated and does not match what normal users run, isn't
it is better to test with "whatever happens to be there" than not to
test at all due to missing compiler?


[Reference]

*1* ... what I picked up from your branch reproduced here

  https://public-inbox.org/git/xmqqy324t4g0.fsf@gitster-ct.c.googlers.com=
/

It is missing explanation and sign-off, but if it lets the build
jobs run, even in a tad stale environment, it may be worth
resurrecting until those who want macOS port working can come up
with a real "with the latest and greatest" alternative.
