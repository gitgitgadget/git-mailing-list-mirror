From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.3.rc1
Date: Fri, 10 Sep 2010 16:09:59 -0700
Message-ID: <7vvd6dfb5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Sep 11 01:10:29 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OuCjh-0004kr-Bh
	for glk-linux-kernel-3@lo.gmane.org; Sat, 11 Sep 2010 01:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab0IJXKJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 10 Sep 2010 19:10:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0IJXKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2010 19:10:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEAB1D522C;
	Fri, 10 Sep 2010 19:10:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=LVIL
	CEjzCvIlsSCP9MQXBTKhoYA=; b=xnEonrsb4QHryFHPcxq4I/Lrncpe3jUnXLao
	yWtossOfWQPfSj14Tl1iWUKuSg6cdaTD4GDdtrA7B6oyxXg6SD0u8rYj17EM5dTb
	OOuKfR5Q+33Htw8YjvLMGM/MV7S+nYKDz+EUFv/7rdHG2GvGNdyT2CZrp+tvK35C
	Cf5g2rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=w0O
	rhrsV22cQOcTytg2c1v81un2t+htu17hZzISaNp007u4JKy+1G7E520MQ5/5G9I4
	ABzEOTCNRTYDr94vBjSHobKyrqQ8Rv9K2qq+XdwPInKiGC+X/ArhFl5i2KXU3KTu
	5prJMclolUwh3yDsEWz4MJziuJMe+mfvwj2CYNWg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AC6CD5226;
	Fri, 10 Sep 2010 19:10:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ECBED5222; Fri, 10 Sep
 2010 19:10:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BCE9E56-BD30-11DF-8697-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155984>

A release candidate Git 1.7.3.rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.3.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.3.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.3.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.3.rc1-1.fc11.$arch.rpm	(RPM)



Git v1.7.3 Release Notes (draft)
================================

Updates since v1.7.2
--------------------

 * git-gui got various updates and a new maintainer, Pat Thoyts.

 * Gitweb allows its configuration to change per each request; it used to
   read the configuration once upon startup.

 * When git finds a corrupt object, it now reports the file that contains
   it.

 * "git checkout -B <it>" is a shorter way to say "git branch -f <it>"
   followed by "git checkout <it>".

 * When "git checkout" or "git merge" refuse to proceed in order to
   protect local modification to your working tree, they used to stop
   after showing just one path that might be lost.  They now show all,
   in a format that is easier to read.

 * "git clean" learned "-e" ("--exclude") option.

 * Hunk headers produced for C# files by "git diff" and friends show more
   relevant context than before.

 * diff.ignoresubmodules configuration variable can be used to squelch the
   differences in submodules reported when running commands (e.g. "diff",
   "status", etc.) at the superproject level.

 * http.useragent configuration can be used to lie who you are to your
   restrictive firewall.

 * "git rebase --strategy <s>" learned "-X" option to pass extra options
   that are understood by the chosen merge strategy.

 * "git rebase -i" learned "exec" that you can insert into the insn sheet
   to run a command between its steps.

 * "git rebase" between branches that have many binary changes that do
   not conflict should be faster.

 * "git rebase -i" peeks into rebase.autosquash configuration and acts as
   if you gave --autosquash from the command line.


Also contains various documentation updates.


Fixes since v1.7.2
------------------

All of the fixes in v1.7.2.X maintenance series are included in this
release, unless otherwise noted.

 * "git merge -s recursive" (which is the default) did not handle cases
   where a directory becomes a file (or vice versa) very well.

 * "git fetch" and friends were accidentally broken for url with "+" in
   its path, e.g. "git://git.gnome.org/gtk+".

 * "git fetch $url" (i.e. without refspecs) was broken for quite some
   time, if the current branch happen to be tracking some remote.

 * "git note remove" created unnecessary extra commit when named object
   did not have any note to begin with.

 * "git -c foo=bar subcmd" did not work well for subcmd that is not
   implemented as a built-in command.
