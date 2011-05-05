From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5.1
Date: Wed, 04 May 2011 18:35:46 -0700
Message-ID: <7vfwouc4jx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu May 05 03:36:07 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QHnU6-0002XY-Gl
	for glk-linux-kernel-3@lo.gmane.org; Thu, 05 May 2011 03:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab1EEBf7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 4 May 2011 21:35:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1EEBf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2011 21:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEFA05FE1;
	Wed,  4 May 2011 21:38:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=+
	0SVWuLq8DNRDGNajT/+VS7dGF4=; b=pEBCmglsUWX7/MSDyEXGD/XxLPcSgflMq
	16uHhUjJXObWhVaYWjT/wTPGcW1tRNT1HvUtV977R0waXt+pV0Um1E/darJgF2qE
	lakNdmtOr8tZO17d/r9owFEEQEvLxhYckzrsAe36mDgckntHcWw7c16/tldYONAG
	N4k5YfjxH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=eJc
	hDLIdZ7fzEHH+PF0TjedOmCTwtxp2iiz9unQdRpKj8XjUAKYBkf8skfnDxbk7dtK
	pwDY9ED9jDbMPsQMWKcRhOSI364XnQ634GC4v0rSgH9LhHqcg8vgcUJYqzf4Uilo
	+S3A1hwSW7c4iQkjiQP/R4vfq7pkEaJBvili+6oM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8535D5FE0;
	Wed,  4 May 2011 21:37:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C2A45FDE; Wed,  4 May 2011
 21:37:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D5641AA-76B8-11E0-B054-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172784>

The latest maintenance release Git 1.7.5.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.5.1-1.fc13.$arch.rpm	(RPM)



Git v1.7.5.1 Release Notes
==========================

Fixes since v1.7.5
------------------

 * When an object "$tree:$path" does not exist, if $path does exist in the
   subtree of $tree that corresponds to the subdirectory the user is in,
   git now suggests using "$tree:./$path" in addition to the advice to use
   the full path from the root of the working tree.

 * The "--date=relative" output format used to say "X years, 12 months"
   when it should have said "X+1 years".

 * The smart-HTTP transfer was broken in 1.7.5 when the client needs
   to issue a small POST (which uses content-length) and then a large
   POST (which uses chunked) back to back.

 * "git clean" used to fail on an empty directory that is not readable,
   even though rmdir(2) could remove such a directory.  Now we attempt it
   as the last resort.

 * The "--dirstat" option of "diff" family of commands used to totally
   ignore a change that only rearranged lines within a file.  Such a
   change now counts as at least a minimum but non zero change.

 * The "--dirstat" option of "diff" family of commands used to use the
   pathname in the original, instead of the pathname in the result,
   when renames are involved.

 * "git pack-object" did not take core.bigfilethreashold into account
   (unlike fast-import); now it does.

 * "git reflog" ignored options like "--format=.." on the command line.

 * "git stash apply" used to refuse to work if there was any change in
   the working tree, even when the change did not overlap with the change
   the stash recorded.

 * "git stash apply @{99999}" was not diagnosed as an error, even when you
   did not have that many stash entries.

 * An error message from "git send-email" to diagnose a broken SMTP
   connection configuration lacked a space between "hello=<smtp-domain>"
   and "port=<smtp-server-port>".

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.5 are as follows:

Alex Riesen (1):
      clean: unreadable directory may still be rmdir-able if it is empty

Dan McGee (2):
      stash: add two more tests for --no-keep-index
      stash: ensure --no-keep-index and --patch can be used in any order

Jeff King (3):
      stash: fix accidental apply of non-existent stashes
      stash: drop dirty worktree check on apply
      upload-pack: start pack-objects before async rev-list

Johan Herland (4):
      --dirstat: Describe non-obvious differences relative to --stat or regular diff
      --dirstat-by-file: Make it faster and more correct
      Teach --dirstat not to completely ignore rearranged lines within a file
      --dirstat: In case of renames, use target filename instead of source filename

Jon Seymour (1):
      stash: fix false positive in the invalid ref test.

Junio C Hamano (4):
      Teach core.bigfilethreashold to pack-objects
      http: clear POSTFIELDS when initializing a slot
      Start 1.7.5.1 maintenance track
      Git 1.7.5.1

Michael J Gruber (6):
      builtin/log.c: separate default and setup of cmd_log_init()
      t/t1411: test reflog with formats
      reflog: fix overriding of command line options
      t1506: factor out test for "Did you mean..."
      sha1_name: Suggest commit:./file for path in subdir
      date: avoid "X years, 12 months" in relative dates

Sylvain Rabot (1):
      git-send-email: fix missing space in error message

Valentin Haenel (1):
      git-add.txt: document 'add.ignoreErrors'
