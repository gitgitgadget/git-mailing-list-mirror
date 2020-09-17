Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F37C2BBD1
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05752222D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mQinyBIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgIQPox (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:44:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52815 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgIQPoF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:44:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5662C8EAB0;
        Thu, 17 Sep 2020 11:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ThOe4CcASo94
        4ApxOjMRu2wzhfw=; b=mQinyBIYtS0Yu/YwtfsIoqs4VO6jWk/5gN0ml/K3Xf5v
        L8j9soAfZqpYq5VGbpAvSu+PnhX8ODO+98GtTSbeZB7V8SLQt3rzuJ+TVde8TMDr
        w9VTcWa0yluodu2ZmYKInJTASbHX/tKKwBOYknnNSqN3NsvOpal813TQSmOuUt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iuyskV
        wcFJuDjdwAI0acni7ulYe5VW3453jRe4u9x/ySMANM3Co6VEy1MKXorYBp9/buFV
        L4o72iFd7rlI13eQ6OaBeyS6ZXKgzZ8g0rwcu6WI1g5xTz6B+w2aRB3xTp2MSbi1
        IAsjohhxKuhSDgfwN++HzxWrjiqXM0P7e26AQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CD948EAAF;
        Thu, 17 Sep 2020 11:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B541C8EAAE;
        Thu, 17 Sep 2020 11:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less flippant
References: <87sgbghdbp.fsf@evledraar.gmail.com>
        <20200917112830.26606-3-avarab@gmail.com>
Date:   Thu, 17 Sep 2020 08:43:51 -0700
In-Reply-To: <20200917112830.26606-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 17 Sep 2020 13:28:30 +0200")
Message-ID: <xmqqv9gcs91k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96709180-F8FC-11EA-A482-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As amusing as Linus's original prose[1] is here it doesn't really expla=
in
> in any detail to the uninitiated why you would or wouldn't enable
> this, and the counter-intuitive reason for why git wouldn't fsync your
> precious data.
>
> So elaborate (a lot) on why this may or may not be needed. This is my
> best-effort attempt to summarize the various points raised in the last
> ML[2] discussion about this.
>
> 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
>     files", 2008-06-18)
> 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 6 deletions(-)

When I saw the subject in my mailbox, I expected to see that you
would resurrect Christoph's updated text in [*1*], but you wrote a
whole lot more ;-) And they are quite informative to help readers to
understand what the option does.  I am not sure if the understanding
directly help readers to decide if it is appropriate for their own
repositories, though X-<.


Thanks.

[Reference]

*1* https://public-inbox.org/git/20180117193510.GA30657@lst.de/

>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> index 74619a9c03..5b47670c16 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -548,12 +548,42 @@ core.whitespace::
>    errors. The default tab width is 8. Allowed values are 1 to 63.
> =20
>  core.fsyncObjectFiles::
> -	This boolean will enable 'fsync()' when writing object files.
> -+
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not us=
e
> -journalling (traditional UNIX filesystems) or that only journal metada=
ta
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteba=
ck").
> +	This boolean will enable 'fsync()' when writing loose object
> +	files. Both the file itself and its containng directory will
> +	be fsynced.
> ++
> +When git writes data any required object writes will precede the
> +corresponding reference update(s). For example, a
> +linkgit:git-receive-pack[1] accepting a push might write a pack or
> +loose objects (depending on settings such as `transfer.unpackLimit`).
> ++
> +Therefore on a journaled file system which ensures that data is
> +flushed to disk in chronological order an fsync shouldn't be
> +needed. The loose objects might be lost with a crash, but so will the
> +ref update that would have referenced them. Git's own state in such a
> +crash will remain consistent.
> ++
> +This option exists because that assumption doesn't hold on filesystems
> +where the data ordering is not preserved, such as on ext3 and ext4
> +with "data=3Dwriteback". On such a filesystem the `rename()` that drop=
s
> +the new reference in place might be preserved, but the contents or
> +directory entry for the loose object(s) might not have been synced to
> +disk.
> ++
> +Enabling this option might slow git down by a lot in some
> +cases. E.g. in the case of a na=C3=AFve bulk import tool which might c=
reate
> +a million loose objects before a final ref update and `gc`. In other
> +more common cases such as on a server being pushed to with default
> +`transfer.unpackLimit` settings the difference might not be noticable.
> ++
> +However, that's highly filesystem-dependent, on some filesystems
> +simply calling fsync() might force an unrelated bulk background write
> +to be serialized to disk. Such edge cases are the reason this option
> +is off by default. That default setting might change in future
> +versions.
> ++
> +In older versions of git only the descriptor for the file itself was
> +fsynced, not its directory entry.
> =20
>  core.preloadIndex::
>  	Enable parallel index preload for operations like 'git diff'
