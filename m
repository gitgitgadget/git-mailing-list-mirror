From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Sat, 15 Mar 2014 19:34:18 +0700
Message-ID: <CACsJy8B3OPe1B4J8-4v_Oq0ZJpWfms8SmrrbfvYHzJ3WpE8P6w@mail.gmail.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 13:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOnni-00047E-CA
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 13:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbaCOMeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 08:34:50 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60667 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbaCOMet (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 08:34:49 -0400
Received: by mail-qa0-f53.google.com with SMTP id w8so3567546qac.26
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tnCWxB5e0rUql7zdVWoik/QEMUmY8DgzcyMEeoBQrss=;
        b=jKG1TAw/4aVRZ4wYafksZgZQU4dJHYQn2Khirg2PHFGT5e4pwFzRk2nplLegi1Pf7T
         EFQ0/kXJqQXVQo+D1+DBQO7oqbXk9U1TgcupnFIb8basO/u4Mnzd+eu7oE6evRdhKZ71
         YiSaMQaQRn5raxmSMpKcRaWVNPYXlrbjPn2dLKHoutIXDgKFrsDRxEyVh5O2l2G2dGe4
         UBvEDSMq+eQL+3cY1LVpzzHLJWjQ2p/5sTshKLgVrP9Q3/CNEwSDLgNGrm3wsZkPxLeN
         8Ppx+JW8FG2VSVBO2uEcIVWX7rrE3tg7GSx7NvHFOQeu52XRLaDU64HbqEY+2J+80dSJ
         s2Og==
X-Received: by 10.224.161.140 with SMTP id r12mr16365044qax.24.1394886888999;
 Sat, 15 Mar 2014 05:34:48 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Sat, 15 Mar 2014 05:34:18 -0700 (PDT)
In-Reply-To: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244153>

On Sat, Mar 15, 2014 at 5:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/multiple-work-trees (2014-03-06) 28 commits
>  - FIXUP: minimum compilation fix
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
>  - Add new environment variable $GIT_COMMON_DIR
>  - commit: use SEQ_DIR instead of hardcoding "sequencer"
>  - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
>  - reflog: avoid constructing .lock path with git_path
>  - *.sh: respect $GIT_INDEX_FILE
>  - Make git_path() aware of file relocation in $GIT_DIR
>  - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
>  - path.c: rename vsnpath() to do_git_path()
>  - Convert git_snpath() to strbuf_git_path()
>  - path.c: make get_pathname() return strbuf instead of static buffer
>
>  The series needs a serious review.

There are two minor fixes [1] [2] on top of v5, but I'm not going to
send v6 again unless I see more substantial changes. Just give me a
signal or something before you merge to next so I have a chance to fix
them if v6 never comes.

[1] http://article.gmane.org/gmane.comp.version-control.git/243693
[2] http://article.gmane.org/gmane.comp.version-control.git/243692
-- 
Duy
