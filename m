Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C0C1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 21:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbcLSV3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 16:29:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752966AbcLSV3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 16:29:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED37458048;
        Mon, 19 Dec 2016 16:29:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hARGyWxSn4W3/tPkE3CEN0/p5Ig=; b=bvKG9q
        Sfk/Nk6zVTgquJXdQy1jAGneoeiDV0hQxy4TqzyR8+EdW6F5xtmNwRcfx7NtVIpw
        +qiwj87j3kNrzu8ipO+UHQ4QIgS5HRbrYM4CZhD0MjanQcdHECp49MnnrIlMomwG
        IIRb1TqaRH+AfAkjn0cCvOhhuKcNCefdS+YOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dWSz3TPgMriEWwbBiF0CxSwPqT4XjIzo
        7ZooTtZdaq6xG5uSIFrvogitC8+WftY+h++OCkctP7klUwzTh43dRWANKTgSomTC
        sDzhajaz2bupSSxj7VlbwCbsuX55Ux0cluOkBP8O2ijPrK6gKZjZmmt36brkkfYQ
        T1Gwq/cCg0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E572558047;
        Mon, 19 Dec 2016 16:29:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F92358046;
        Mon, 19 Dec 2016 16:29:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, luke@diamand.org
Subject: Re: [PATCH v1] git-p4: add diff/merge properties to .gitattributes for GitLFS files
References: <20161218190140.3732-1-larsxschneider@gmail.com>
Date:   Mon, 19 Dec 2016 13:29:38 -0800
In-Reply-To: <20161218190140.3732-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sun, 18 Dec 2016 20:01:40
        +0100")
Message-ID: <xmqqy3zbmwu5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FDBFB12-C632-11E6-BCE4-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The `git lfs track` command generates a .gitattributes file with diff
> and merge properties [1]. Set the same .gitattributes format for files
> tracked with GitLFS in git-p4.
>
> [1] https://github.com/git-lfs/git-lfs/blob/v1.5.3/commands/command_track.go#L121
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks.  Luke, does this look ok?

>
> Notes:
>     Base Commit: d1271bddd4 (v2.11.0)
>     Diff on Web: https://github.com/git/git/compare/d1271bddd4...larsxschneider:e045b3d5c8
>     Checkout:    git fetch https://github.com/larsxschneider/git git-p4/fix-lfs-attributes-v1 && git checkout e045b3d5c8
>
>  git-p4.py                 |  4 ++--
>  t/t9824-git-p4-git-lfs.sh | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52462..87b6932c81 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1098,10 +1098,10 @@ class GitLFS(LargeFileSystem):
>                  '# Git LFS (see https://git-lfs.github.com/)\n',
>                  '#\n',
>              ] +
> -            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
> +            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs diff=lfs merge=lfs -text\n'
>                  for f in sorted(gitConfigList('git-p4.largeFileExtensions'))
>              ] +
> -            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
> +            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs diff=lfs merge=lfs -text\n'
>                  for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(f)
>              ]
>          )
> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
> index 110a7e7924..1379db6357 100755
> --- a/t/t9824-git-p4-git-lfs.sh
> +++ b/t/t9824-git-p4-git-lfs.sh
> @@ -81,9 +81,9 @@ test_expect_success 'Store files in LFS based on size (>24 bytes)' '
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		/file2.dat filter=lfs -text
> -		/file4.bin filter=lfs -text
> -		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
> +		/file2.dat filter=lfs diff=lfs merge=lfs -text
> +		/file4.bin filter=lfs diff=lfs merge=lfs -text
> +		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
> @@ -109,7 +109,7 @@ test_expect_success 'Store files in LFS based on size (>25 bytes)' '
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		/file4.bin filter=lfs -text
> +		/file4.bin filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
> @@ -135,7 +135,7 @@ test_expect_success 'Store files in LFS based on extension (dat)' '
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		*.dat filter=lfs -text
> +		*.dat filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
> @@ -163,8 +163,8 @@ test_expect_success 'Store files in LFS based on size (>25 bytes) and extension
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		*.dat filter=lfs -text
> -		/file4.bin filter=lfs -text
> +		*.dat filter=lfs diff=lfs merge=lfs -text
> +		/file4.bin filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
> @@ -199,8 +199,8 @@ test_expect_success 'Remove file from repo and store files in LFS based on size
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		/file2.dat filter=lfs -text
> -		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
> +		/file2.dat filter=lfs diff=lfs merge=lfs -text
> +		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
> @@ -237,8 +237,8 @@ test_expect_success 'Add .gitattributes and store files in LFS based on size (>2
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		/file2.dat filter=lfs -text
> -		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
> +		/file2.dat filter=lfs diff=lfs merge=lfs -text
> +		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
> @@ -278,7 +278,7 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
>  		#
>  		# Git LFS (see https://git-lfs.github.com/)
>  		#
> -		/file6.bin filter=lfs -text
> +		/file6.bin filter=lfs diff=lfs merge=lfs -text
>  		EOF
>  		test_path_is_file .gitattributes &&
>  		test_cmp expect .gitattributes
