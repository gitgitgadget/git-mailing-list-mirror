Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0731F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbcJERQt (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:16:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58144 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752820AbcJERQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:16:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC8E424C3;
        Wed,  5 Oct 2016 13:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6fG0eibnJndU
        jdiJCdcsgfQlVgA=; b=RYqoBCejK+GVB/2cM/9OGGtl5GuaLuHzBTq3zlc8aM+6
        AoKFht2VHjKYOApCHpPIB8X24qNeokaG/45BldDMphpY89KxMBfN+ZI8RVisjKaW
        AMv9QqJmCqfmRpFMXnoCvyCMP1spiPgDWvE4/eNT0cbaFqP9tgWnuFUJsVgdzE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SUoRiq
        rr3RK2W8Rbilqt8hBcMK+irY4K7pxpHFQQJAYlVIK4cl0RiQ7YdbUUR90HOuZS7n
        ecnbD4tEq0u4LggJR6mw+CbPZKAKFsjEzoLk0UvQ4iJwTIrRyfbsE/Kai7Oxvt6C
        QlkMhLnP1gLqcpncvGS58d4dpZIvGZyKbd0CM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05331424C2;
        Wed,  5 Oct 2016 13:16:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B8AD424C1;
        Wed,  5 Oct 2016 13:16:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Neukirchen <chneukirchen@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git commit -p with file arguments
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CACsJy8DOqoW8quz-6qSVR2+3aJau2V=qXCx_SoZvBpmU+9+Oxw@mail.gmail.com>
        <20161005102633.GA9948@ash>
Date:   Wed, 05 Oct 2016 10:16:44 -0700
In-Reply-To: <20161005102633.GA9948@ash> (Duy Nguyen's message of "Wed, 5 Oct
        2016 17:26:33 +0700")
Message-ID: <xmqqzimipvgj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E92F7AA-8B1F-11E6-B4AA-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> At the least I think we should clarify this in the document.
>
> How about something like this? Would it help?
>
> -- 8< --
> Subject: [PATCH] git-commit.txt: clarify --patch mode with pathspec
>
> How pathspec is used, with and without --interactive/--patch, is
> different. But this is not clear from the document. These changes hint
> the user to keep reading (to option #5) instead of stopping at #2 and
> assuming --patch/--interactive behaves the same way.
>
> And since all the options listed here always mention how the index is
> involved (or not) in the final commit, add that bit for #5 as well. Thi=
s
> "on top of the index" is implied when you head over git-add(1), but if
> you just go straight to the "Interactive mode" and not read what git-ad=
d
> is for, you may miss it.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---

Excellent. =20

>  Documentation/git-commit.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
> index b0a294d..f2ab0ee 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -29,7 +29,8 @@ The content to be added can be specified in several w=
ays:
>  2. by using 'git rm' to remove files from the working tree
>     and the index, again before using the 'commit' command;
> =20
> -3. by listing files as arguments to the 'commit' command, in which
> +3. by listing files as arguments to the 'commit' command
> +   (without --interactive or --patch switch), in which
>     case the commit will ignore changes staged in the index, and instea=
d
>     record the current content of the listed files (which must already
>     be known to Git);
> @@ -41,7 +42,8 @@ The content to be added can be specified in several w=
ays:
>     actual commit;
> =20
>  5. by using the --interactive or --patch switches with the 'commit' co=
mmand
> -   to decide one by one which files or hunks should be part of the com=
mit,
> +   to decide one by one which files or hunks should be part of the com=
mit
> +   in addition to contents in the index,
>     before finalizing the operation. See the ``Interactive Mode'' secti=
on of
>     linkgit:git-add[1] to learn how to operate these modes.

When re-reading these 5 bullet points, I feel there may be some
unrelated updates needed to clarify (e.g. it is unclear when reading
the description pretending to be a newbie, if it is the "changes"
that is recorded in the index, or if it is the "state"; the answer
is the latter but if the reader's world model is still the former,
the description can mislead to expect a different behaviour).

But regardless of such remaining potential issues, this is a clearly
good change.  Thanks.
