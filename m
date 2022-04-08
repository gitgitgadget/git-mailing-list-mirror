Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD1EC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 01:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiDHBWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 21:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiDHBWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 21:22:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785212756
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 18:20:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30A1A10076C;
        Thu,  7 Apr 2022 21:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=DsrJGbgp6LiOZ1KoaBkiBY85f
        oDWE8BQ8aYq5UQTlK0=; b=MzHQut2cQ++9xdlVFavw8yPZFWjZoy9aFpV8oxgcR
        MKzXcjy+3pYuzALYTZB2MSspCcFICBxQxIRwmMelH0hSrsaw97+JSyJLzH+kmj12
        hWY1jhCKe2qlrt3tHKEwdnFgkKCULLqwXN4RpBlqZUAKiua48JlkB+8JeZkqf145
        f4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2886B10076A;
        Thu,  7 Apr 2022 21:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90A6C100768;
        Thu,  7 Apr 2022 21:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Josh Steadmon <steadmon@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0
References: <xmqqo81gpokn.fsf@gitster.g>
Date:   Thu, 07 Apr 2022 18:20:33 -0700
Message-ID: <xmqq1qy8qske.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16F803DC-B6DA-11EC-A510-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> An early preview release Git v2.36.0-rc0 is now available for
> testing at the usual places.  It is comprised of 661 non-merge
> commits since v2.35.0, contributed by 80 people, 25 of which are
> new faces [*].

Thanks for finding and fixing many oops glitches in this preview so
quickly.  Hopefully with the tip of 'master/main' today, we can tag
a bug-free -rc1 tomorrow ;-)

$ git shortlog --no-merges v2.36.0-rc0..master
Adam Dinwoodie (1):
      configure.ac: fix HAVE_SYNC_FILE_RANGE definition

Carlo Marcelo Arenas Bel=C3=B3n (1):
      git-compat-util: really support openssl as a source of entropy

Fangyi Zhou (1):
      submodule-helper: fix usage string

Josh Steadmon (1):
      ls-tree: `-l` should not imply recursive listing

Martin =C3=85gren (1):
      git-ls-tree.txt: fix the name of "%(objectsize:padded)"

Todd Zullinger (1):
      doc: replace "--" with {litdd} in credential-cache/fsmonitor

Victoria Dye (1):
      contrib/scalar: fix 'all' target in Makefile

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      Documentation/Makefile: fix "make info" regression in dad9cd7d518
      Documentation: add --batch-command to cat-file synopsis



