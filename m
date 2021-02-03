Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3048BC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D2264F68
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBCUHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:07:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62488 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhBCUHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:07:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08686ABC42;
        Wed,  3 Feb 2021 15:06:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4fK+IyyIj+Rmgx33UWPXPX+CP/g=; b=ID5Wcx
        svPTa4SfVuXg/j2FWwhTbJdnQsVC7pc9lKQ/iPmEoc3EqmcpOIj/q3e0rzmgzYZ8
        i5EuypYdwXBP9+FmhP2YXA4DBhZnXy51xNIjwEPYWYmNpjbXOXF3tMtVb38G4ojI
        USR4gakFSE9Pq066NxOdK7lQFUz3y9envjK14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fA1ml++rXY/cqVorTMklogxtPBJgwnqr
        boDp/ZHOqMiXkrAYWe+Vxo9LRok3jvRVNs+Vc33qvPsMJ1MeKqnfpoT0rY8bp0qt
        6lgxyOQ4ckbTTOrSE2CRMlVRuqf8mA/r9kXbUHuptleWdJPDztHNFH8/SRu36DfI
        IqBiNQf3CUk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3336ABC40;
        Wed,  3 Feb 2021 15:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75B75ABC3F;
        Wed,  3 Feb 2021 15:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Feiyang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Feiyang <github@feiyangxue.com>,
        Feiynag Xue <fxue@roku.com>, Luke Diamand <luke@diamand.org>,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: [PATCH] git-p4: remove deprecated function "encodeWithUTF8()"
References: <pull.862.git.1612371471347.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 12:06:46 -0800
In-Reply-To: <pull.862.git.1612371471347.gitgitgadget@gmail.com> (Feiyang via
        GitGitGadget's message of "Wed, 03 Feb 2021 16:57:50 +0000")
Message-ID: <xmqqtuqsc3vt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5855B926-665B-11EB-ADE1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Feiyang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Feiynag Xue <fxue@roku.com>
>
> commit d38208a297e76bbfbfa8e485632c217aaafa9486 introduced function "decode_path()" to replace "encodeWithUTF8()". This old function "encodeWithUTF8()" no longer has reference by any code in this file.
>
> Signed-off-by: Feiynag Xue <fxue@roku.com>

 - Please line-wrap your log message to reasonable length, like around
   70 columns.

 - We refer to an existing commit like this: d38208a2 (git-p4:
   convert path to unicode before processing them, 2019-12-13)

   You can ask "git show -s --pretty=reference d38208a2" to produce
   such a string with versions of Git that are recent enough (like
   v2.25 or newer), or --pretty='format:%h (%s, %ad)' can be used
   instead of --pretty=reference for older version of Git.

 - Please Cc: those who are likely to know the area to ask for their
   reviews.  This patch addresses a fallout from an existing commit,
   and its author would be a good candidate.

 - "deprecated" is probably not the word you wanted to use here, as
   it has a connotation that something was suboptimal with it, and
   it got replaced by something else.  Reading your description, I
   think you are removing a function that is no longer used.

   I'd suggest rewriting it to something like:

     Subject: git-p4: remove "encodeWithUTF8()" that is no longer used

     d38208a2 (git-p4: convert path to unicode before processing
     them, 2019-12-13) introduced the function "decode_path()" to
     replace the "encodeWithUTF8()" method of P4Sync class, which no
     longer is used anywhere.

     Remove it.

Thanks.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-862%2Ffeiyeung%2Fremove-encodeWithUTF8-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-862/feiyeung/remove-encodeWithUTF8-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/862
>
>  git-p4.py | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93ac40..2c7e5498afa 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2939,18 +2939,6 @@ def writeToGitStream(self, gitMode, relPath, contents):
>              self.gitStream.write(d)
>          self.gitStream.write('\n')
>  
> -    def encodeWithUTF8(self, path):
> -        try:
> -            path.decode('ascii')
> -        except:
> -            encoding = 'utf8'
> -            if gitConfig('git-p4.pathEncoding'):
> -                encoding = gitConfig('git-p4.pathEncoding')
> -            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
> -            if self.verbose:
> -                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
> -        return path
> -
>      # output one file from the P4 stream
>      # - helper for streamP4Files
>  
>
> base-commit: e6362826a0409539642a5738db61827e5978e2e4
