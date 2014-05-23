From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE costruct
Date: Fri, 23 May 2014 16:38:57 -0400
Message-ID: <CAPig+cTt-+k3ufUX=MSo1z1tdU3+BRjJ7hO7iQ8bdhfJ4b-J3Q@mail.gmail.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	dak@gnu.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:39:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnwF7-0002P2-5i
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaEWUi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:38:59 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:46562 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaEWUi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:38:58 -0400
Received: by mail-yh0-f48.google.com with SMTP id a41so4706867yho.7
        for <git@vger.kernel.org>; Fri, 23 May 2014 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iPi9TtNZ6d7yIJDVl9uLmoTYtc3DAbVQOBkO2eB0ZgQ=;
        b=jQQAnAQieppjHQSqyBDHpfgAyLlm3aSq0IPTahfUaUEpwrgmnUB/oxnOeoX2tRv54B
         MQZ+NA/rgnZ2n3t3avrU4Ih5le7POtG7BsENg1PgESylrNO6vG+Jlld0oI9i3QeIuX1z
         7a1AfclswhPC6bXXX5ZqZYsEMLwriMHybcEqiq+mIQ0nV7jvjQo7HBrZ4mNgp6LebC19
         8vj5h2flmK2Q35C6qC2xucEvhseFjKge7VyOQLZsj0bLgIdkUHUHG8kvuFSqjcSySkuz
         /tqNQNFApu/7Gb3m1hOG3l6Q7YqlGmOSrZ5UTfP/VmT4m5IbwLwBwBgACvQW/7VBw487
         xJww==
X-Received: by 10.236.170.37 with SMTP id o25mr7452297yhl.145.1400877537889;
 Fri, 23 May 2014 13:38:57 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Fri, 23 May 2014 13:38:57 -0700 (PDT)
In-Reply-To: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: s--Mw8HuF11fAStN3tZjA7p_ZhY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250029>

On Fri, May 23, 2014 at 6:15 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Subject: Get rid of the non portable shell export VAR=VALUE costruct

s/costruct/construct/
s/non portable/non-portable/

> Found by check-non-portable-shell.pl
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the second version of the patch that includes
> Junio suggestions.
>
>  contrib/subtree/t/t7900-subtree.sh |    3 ++-
>  git-remote-testgit.sh              |    3 ++-
>  git-stash.sh                       |    3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 66ce4b0..8dc6840 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -8,7 +8,8 @@ This test verifies the basic operation of the merge, pull, add
>  and split subcommands of git subtree.
>  '
>
> -export TEST_DIRECTORY=$(pwd)/../../../t
> +TEST_DIRECTORY=$(pwd)/../../../t
> +export TEST_DIRECTORY
>
>  . ../../../t/test-lib.sh
>
> diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
> index 1c006a0..a9c75a2 100755
> --- a/git-remote-testgit.sh
> +++ b/git-remote-testgit.sh
> @@ -13,7 +13,8 @@ refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
>
>  test -z "$refspec" && prefix="refs"
>
> -export GIT_DIR="$url/.git"
> +GIT_DIR="$url/.git"
> +export GIT_DIR
>
>  force=
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 4798bcf..4621d81 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -94,7 +94,8 @@ create_stash () {
>                 # ease of unpacking later.
>                 u_commit=$(
>                         untracked_files | (
> -                               export GIT_INDEX_FILE="$TMPindex"
> +                               GIT_INDEX_FILE="$TMPindex" &&
> +                               export GIT_INDEX_FILE &&
>                                 rm -f "$TMPindex" &&
>                                 git update-index -z --add --remove --stdin &&
>                                 u_tree=$(git write-tree) &&
> --
