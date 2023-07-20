Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D778CEB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 18:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGTSSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGTSSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 14:18:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A29270B
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 11:18:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0363026E44;
        Thu, 20 Jul 2023 14:18:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uk4qxc+v4H5WHtJWsA0cH7hkJ9Ks26QVxzTS3f
        deYi4=; b=rZlxigITQ5NO60FU06YqxK/v3hJ2licMDsmlRVIs1qz+9beQOQBzHG
        BOTn443MbrDMDytkzEwO0rhHECqo1kqKpmt67x16Px3i45cGMmF854MrGDFE1XtU
        NqT5TXRRt7Jw5wmxVSy8MVC6iGib/pmGOFVbDhZPvw7qAKvS+ik8E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F04A526E43;
        Thu, 20 Jul 2023 14:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78C9626E40;
        Thu, 20 Jul 2023 14:18:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
        <ZLlNtbAbVcYH7eFb@adams>
Date:   Thu, 20 Jul 2023 11:18:08 -0700
In-Reply-To: <ZLlNtbAbVcYH7eFb@adams> (Adam Majer's message of "Thu, 20 Jul
        2023 17:07:54 +0200")
Message-ID: <xmqqr0p230rj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7D93020-2729-11EE-B6E9-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer <adamm@zombino.com> writes:

> I'll try again with inline patch. I think it wasn't picked up since it
> was mime encoded by the mail client..
>
> - Adam
>
>
> From 90be51143e741053390810720ba4a639c3b0b74c Mon Sep 17 00:00:00 2001

Remove all the above lines (including the "From <commit object
name>").  If you want to add a note that should not be recorded in
the message of the resulting commit, write it _after_ the three-dash
line after your sign-off.

> From: Adam Majer <adamm@zombino.com>
> Date: Wed, 28 Jun 2023 14:46:02 +0200
> Subject: [PATCH] doc: sha256 is no longer experimental

It is not technically incorrect to have these three lines here, but
when you are presenting your own work, it is preferrable to do
without them.  The "From:" address line and "Subject:" text line do
not have to be here---most people should be able to make the
corresponding e-mail headers to have the value they want to use,
and while the above "Date:" might be the time you wrote the commit,
it is way earlier than the time the contents of the commit was
presented for consideration to the general public, which is recorded
in the e-mail header of the message you are sending.

So, the body of the message usually should start from here (below).

In general, please follow [[describe-changes]] part of the
Documentation/SubmittingPatches document, and also "git log
--no-merges" of recent contributions by others.  "The purpose of
this patch is" is not how we usually talk about our work.

> The purpose of this patch is to remove scary wording that basically
> stops people using sha256 repositories not because of interoperability
> issues with sha1 repositories, but from fear that their work will
> suddenly become incompatible in some future version of git.
>
> We should be clear that currently sha256 repositories will not work with
> sha1 repositories but stop the scary words.
>
> Signed-off-by: Adam Majer <adamm@zombino.com>
> ---
>  Documentation/git.txt                      | 4 ++--
>  Documentation/object-format-disclaimer.txt | 8 ++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index f0cafa2290..666dbdb55c 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -553,8 +553,8 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	If this variable is set, the default hash algorithm for new
>  	repositories will be set to this value. This value is
>  	ignored when cloning and the setting of the remote repository
> -	is always used. The default is "sha1". THIS VARIABLE IS
> -	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
> +	is always used. The default is "sha1". See `--object-format`
> +	in linkgit:git-init[1].

This side looks OK (just removing the single sentence).

>  Git Commits
>  ~~~~~~~~~~~
> diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.txt
> index 4cb106f0d1..1e976688be 100644
> --- a/Documentation/object-format-disclaimer.txt
> +++ b/Documentation/object-format-disclaimer.txt
> @@ -1,6 +1,2 @@
> -THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
> -in an early stage.  A SHA-256 repository will in general not be able to
> -share work with "regular" SHA-1 repositories.  It should be assumed
> -that, e.g., Git internal file formats in relation to SHA-256
> -repositories may change in backwards-incompatible ways.  Only use
> -`--object-format=sha256` for testing purposes.
> +Note: SHA-256 repositories currently will not be able to share work
> +with "regular" SHA-1 repositories.

The original did not have this problem because it had enough
surrounding context, but the updated text now risks getting misread
as if there are "regular" and "special" SHA-1 repositories, the
latter of which might work better with SHA-256.

And the message about SHA-256's non-experimental status can probably
be a lot stronger, after the discussion we had recently.  How about
saying something like:

    Note: there is no interoperability between SHA-256 repositories
    and SHA-1 repositories right now.  We historically warned that
    SHA-256 repositories may need backward incompatible changes
    later when we introduce such interoperability features, but at
    this point we do not expect that we need to make such a change
    when we do so, and the users can expect that their SHA-256
    repositories they create with today's Git will be usable by
    future versions of Git without losing information.

which would probably be much closer to what you wanted to hear?

Thanks.
