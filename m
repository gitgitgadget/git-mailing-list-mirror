Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB08720248
	for <e@80x24.org>; Fri,  5 Apr 2019 01:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfDEBGC (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 21:06:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50672 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfDEBGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 21:06:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF3D12AAA8;
        Thu,  4 Apr 2019 21:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=dmoUBQtsPr6sm
        zBqt9A+UFXJxhk=; b=K/KJU6Y/qNOJAWXtx74yGEXss+f92VyHJMZN09Z5Frnax
        6ABQ9vK+evH6IzXMpdgouDYW5j2xP2FQ4DfMjQa82UJCO2LXf0uA0NqyIUIwqLXe
        6W1DZnbBKt31Efsdy1UrIzEHBmtxAYgNznLe3pY9gQlucS2GhhRfL2/I/KJzpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=sCVWlFc
        xTq4vZx3zFzK/QQKRwp7p/cm5TcFMm9WHVpUzEnXoGEbGE37V6JmtYVdKBFsHffO
        MyNeJbQNdz29PrAEcwvrQqKdkFaTrQmOWfi1tArQ9BpydmjVKFzditw1oggUBr3m
        Nt735wLtZt1JNHWt7aLKOabf8pW0JqOa1Hx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46F0612AAA6;
        Thu,  4 Apr 2019 21:05:58 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C76A212AAA5;
        Thu,  4 Apr 2019 21:05:57 -0400 (EDT)
Date:   Thu, 4 Apr 2019 21:05:56 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
Message-ID: <20190405010556.GN4047@pobox.com>
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: F8686324-573E-11E9-BDF4-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano wrote:
> * sg/asciidoctor-in-ci (2019-04-01) 6 commits
>  - ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build=
 job
>  - ci: stick with Asciidoctor v1.5.8 for now
>  - ci: install Asciidoctor in 'ci/install-dependencies.sh'
>  - Documentation/technical/protocol-v2.txt: fix formatting
>  - Documentation/technical/api-config.txt: fix formatting
>  - Documentation/git-diff-tree.txt: fix formatting
>=20
>  Update our support to format documentation in the CI environment,
>  either with AsciiDoc ro Asciidoctor.
>=20
>  Will merge to 'next'.

Martin mentioned this in reply to the patch thread=B9 but it
looks like it slipped by unnoticed.  There's some extraneous
comments in 28216d13f4 ("ci: stick with Asciidoctor v1.5.8
for now", 2019-03-29) which would be good to trim before
this hits next.

    commit 28216d13f43b07e41bdd83b786ae31c00c657e06
    Author: SZEDER G=E1bor <szeder.dev@gmail.com>
    Date:   Fri Mar 29 20:52:46 2019 +0100

        ci: stick with Asciidoctor v1.5.8 for now
       =20
        On Fri, Mar 29, 2019 at 01:35:19PM +0100, SZEDER G=E1bor wrote:
        > The release of Asciidoctor v2.0.0 two days ago broke our docume=
ntation
       =20
        Well, what happened "two days ago" when I sent v2 is now seven da=
ys
        ago...  Let's just say "recent" instead.
       =20
          --- >8 ---
       =20
        Subject: ci: stick with Asciidoctor v1.5.8 for now
       =20
        The recent release of Asciidoctor v2.0.0 broke our documentation
        ...

=B9 <CAN0heSrQrVQ+t3ZH1igU8zZLjjyhzZshFgarLcZOumWMBRN2Tg@mail.gmail.com>

Thanks,

--=20
Todd
