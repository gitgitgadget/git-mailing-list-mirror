From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2014, #04; Tue, 17)
Date: Thu, 19 Jun 2014 13:40:16 -0700
Message-ID: <xmqqfvj0fxan.fsf@gitster.dls.corp.google.com>
References: <xmqqfvj2jfkg.fsf@gitster.dls.corp.google.com>
	<CACsJy8CXbbNEFigjibd-W3V3RaXOzsptMkufMybYCKPFAHM6UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:40:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxj8W-0003HQ-KO
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934571AbaFSUkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:40:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60338 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932343AbaFSUkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:40:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2F041FA3B;
	Thu, 19 Jun 2014 16:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T82vxKN5121qIT/XVRspP4mkeRY=; b=EyUonz
	Y37UdWZhH45wY9p/ee0/9YH8Oxjcrca/4yrLHRGY8x7siO4MPbIvLFwLhoWysqyx
	0fXU417jk4xt9zP1jPDg3rDNCPc0q7IDrz/1jd7RZHrTb6RUDyl5SuMpNyO4tmdv
	QYNP9U3+DY2ZJhSdoXL4q2paDjEudw+ASfda4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+zZMp99+TaHvph0JipQ+eWDJiTKpavj
	VEFz/gwTEe96IBqNalQVDTq8Xp9Cbo6eAspfYeT3MCItPHpxEohB380VazugnGJf
	DRKdU2f7OXPzjZd20/KJHZTKtEvYSOzsmgRNzeRqGtOFJOF5L/dN+QmRQZM0El0Y
	FrMg0KSLkxc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 998CE1FA3A;
	Thu, 19 Jun 2014 16:40:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3DF141FA32;
	Thu, 19 Jun 2014 16:40:14 -0400 (EDT)
In-Reply-To: <CACsJy8CXbbNEFigjibd-W3V3RaXOzsptMkufMybYCKPFAHM6UA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 19 Jun 2014 17:06:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA60CF84-F7F1-11E3-9E24-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252181>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jun 19, 2014 at 12:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> [Stalled]
>> * nd/multiple-work-trees (2014-03-25) 28 commits
>>  - count-objects: report unused files in $GIT_DIR/repos/...
>>  - gc: support prune --repos
>>  - gc: style change -- no SP before closing bracket
>>  - prune: strategies for linked checkouts
>>  - checkout: detach if the branch is already checked out elsewhere
>>  - checkout: clean up half-prepared directories in --to mode
>>  - checkout: support checking out into a new working directory
>>  - use new wrapper write_file() for simple file writing
>>  - wrapper.c: wrapper to open a file, fprintf then close
>>  - setup.c: support multi-checkout repo setup
>>  - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
>>  - setup.c: convert check_repository_format_gently to use strbuf
>>  - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
>>  - setup.c: convert is_git_directory() to use strbuf
>>  - git-stash: avoid hardcoding $GIT_DIR/logs/....
>>  - *.sh: avoid hardcoding $GIT_DIR/hooks/...
>>  - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
>>  - $GIT_COMMON_DIR: a new environment variable
>>  - commit: use SEQ_DIR instead of hardcoding "sequencer"
>>  - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
>>  - reflog: avoid constructing .lock path with git_path
>>  - *.sh: respect $GIT_INDEX_FILE
>>  - git_path(): be aware of file relocation in $GIT_DIR
>>  - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
>>  - path.c: rename vsnpath() to do_git_path()
>>  - git_snpath(): retire and replace with strbuf_git_path()
>>  - path.c: make get_pathname() call sites return const char *
>>  - path.c: make get_pathname() return strbuf instead of static buffer
>>
>>  A replacement for contrib/workdir/git-new-workdir that does not
>>  rely on symbolic links and make sharing of objects and refs safer
>>  by making the borrowee and borrowers aware of each other.
>
> Anything I can do to get this going again? The only thing I just found
> (and have not fixed) is, I think $GIT_DIR/info/excludes and
> $GIT_DIR/info/sparse-checkout should be per-worktree, not shared.

I threw it into the stalled category because you said even you do
not use it yourself (you may also have said that it has issues
already known and not fixed) in the first place.  If we want to
resuscitate it, a good point to start is to refresh it with a reroll
to address known issues, I would guess.

Thanks.
