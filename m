From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2014, #04; Tue, 17)
Date: Thu, 19 Jun 2014 17:06:19 +0700
Message-ID: <CACsJy8CXbbNEFigjibd-W3V3RaXOzsptMkufMybYCKPFAHM6UA@mail.gmail.com>
References: <xmqqfvj2jfkg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:06:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxZF9-0001pz-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 12:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbaFSKGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 06:06:51 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:49234 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbaFSKGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 06:06:50 -0400
Received: by mail-qa0-f52.google.com with SMTP id w8so1733222qac.25
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Dw3bsk10IrOA2yJIqf9+6ejAThk1qsd4O/O5tsr6qOU=;
        b=QYmpQKxjpbsnBFWd5YbobAXovWZp1LnfR1v1uHPtr1qppcG4mDh4kuB2QfEdW9m2LQ
         XSdr/GdAAb5u0xVdpXVMFVKtv6NbZbO1v48JQRBVLemwfZmDC0OSkAP82doLqOh67Ut/
         J5hRmK4WOu/Cahi94ybd7GgEdCI6uEmucrdNknG6dwryXhzfdSHHmyQBRLnwFqmov+SO
         xZxOyzfngo8ejWHpkEid1zFmzmfpBnB1NJOgl2JbtutMAaHgbeck0t3O4Q166E5YTEp5
         c1eW7MaqSFzJSxMDvFOCp8V8xKG8HlC+te16ub+Q7zgGy5AFJfmO0E3IdgVmE7DksrWK
         U8zQ==
X-Received: by 10.140.92.144 with SMTP id b16mr4735441qge.41.1403172409117;
 Thu, 19 Jun 2014 03:06:49 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 19 Jun 2014 03:06:19 -0700 (PDT)
In-Reply-To: <xmqqfvj2jfkg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252107>

On Thu, Jun 19, 2014 at 12:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [Stalled]
> * nd/multiple-work-trees (2014-03-25) 28 commits
>  - count-objects: report unused files in $GIT_DIR/repos/...
>  - gc: support prune --repos
>  - gc: style change -- no SP before closing bracket
>  - prune: strategies for linked checkouts
>  - checkout: detach if the branch is already checked out elsewhere
>  - checkout: clean up half-prepared directories in --to mode
>  - checkout: support checking out into a new working directory
>  - use new wrapper write_file() for simple file writing
>  - wrapper.c: wrapper to open a file, fprintf then close
>  - setup.c: support multi-checkout repo setup
>  - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
>  - setup.c: convert check_repository_format_gently to use strbuf
>  - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
>  - setup.c: convert is_git_directory() to use strbuf
>  - git-stash: avoid hardcoding $GIT_DIR/logs/....
>  - *.sh: avoid hardcoding $GIT_DIR/hooks/...
>  - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
>  - $GIT_COMMON_DIR: a new environment variable
>  - commit: use SEQ_DIR instead of hardcoding "sequencer"
>  - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
>  - reflog: avoid constructing .lock path with git_path
>  - *.sh: respect $GIT_INDEX_FILE
>  - git_path(): be aware of file relocation in $GIT_DIR
>  - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
>  - path.c: rename vsnpath() to do_git_path()
>  - git_snpath(): retire and replace with strbuf_git_path()
>  - path.c: make get_pathname() call sites return const char *
>  - path.c: make get_pathname() return strbuf instead of static buffer
>
>  A replacement for contrib/workdir/git-new-workdir that does not
>  rely on symbolic links and make sharing of objects and refs safer
>  by making the borrowee and borrowers aware of each other.

Anything I can do to get this going again? The only thing I just found
(and have not fixed) is, I think $GIT_DIR/info/excludes and
$GIT_DIR/info/sparse-checkout should be per-worktree, not shared.
-- 
Duy
