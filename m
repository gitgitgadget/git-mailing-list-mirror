From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.12.3
Date: Mon, 08 Oct 2012 12:53:23 -0700
Message-ID: <7vmwzwk9le.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 22:11:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLJfx-0001tD-9y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 22:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2JHULa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 16:11:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab2JHUL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 16:11:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0963194E1;
	Mon,  8 Oct 2012 16:11:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=B
	3cerlPoeHrjDwCk3qOJ5h3B+uo=; b=nJyEwAmwOxSO3wuENgbnnLxbbpgRmyHyp
	2z9Qw1kOROg2Ji7A+y9BYVWOUcEWYrsmjKfJwf3OWsAESTLPOytLGrtS7DoTM9+Y
	30nD7Tmz5Y5pqXDOU0c5N6FXP4ztNJNiHYNn6HUHO9Socao6EeCQgazzO/Be0T7t
	6TXMkcok2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=BFlO2nZS32s5bk7uX9cRPNeeC7qzbDlRssljh7F4HHyjSSRnRbeXUmtd
	wfO3B2zI1z0uif6GHy2iyLsab3MuDrXsZzzjxm11jnS9l5AK/1Fpvt9h+/z0KbFL
	mY0dfHtlADFCa1lIeK1va0g/RtX6AoZIws5kBGfLy16nPGx7CpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8D9794E0;
	Mon,  8 Oct 2012 16:11:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EFEE94DF; Mon,  8 Oct 2012
 16:11:27 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57449A32-1184-11E2-8534-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207266>

The latest maintenance release Git v1.7.12.3 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

a071f03f6aab76b283828db1fdedbedb90085eb5  git-1.7.12.3.tar.gz
6f976c27aab7250f1a35b2b002ac7a07c3266cf4  git-htmldocs-1.7.12.3.tar.gz
49584f0b72e4a13f9a4df771bbde9cf70f25d317  git-manpages-1.7.12.3.tar.gz

Also the following public repositories all have a copy of the v1.7.12.3
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git 1.7.12.3 Release Notes
==========================

Fixes since v1.7.12.2
---------------------

 * "git am" mishandled a patch attached as application/octet-stream
   (e.g. not text/*); Content-Transfer-Encoding (e.g. base64) was not
   honored correctly.

 * It was unclear in the documentation for "git blame" that it is
   unnecessary for users to use the "--follow" option.

 * A repository created with "git clone --single" had its fetch
   refspecs set up just like a clone without "--single", leading the
   subsequent "git fetch" to slurp all the other branches, defeating
   the whole point of specifying "only this branch".

 * "git fetch" over http had an old workaround for an unlikely server
   misconfiguration; it turns out that this hurts debuggability of the
   configuration in general, and has been reverted.

 * "git fetch" over http advertised that it supports "deflate", which
   is much less common, and did not advertise the more common "gzip" on
   its Accept-Encoding header.

 * "git receive-pack" (the counterpart to "git push") did not give
   progress output while processing objects it received to the puser
   when run over the smart-http protocol.

 * "git status" honored the ignore=dirty settings in .gitmodules but
   "git commit" didn't.

Also contains a handful of documentation updates.

----------------------------------------------------------------

Changes since v1.7.12.2 are as follows:

Jeff King (3):
      receive-pack: redirect unpack-objects stdout to /dev/null
      receive-pack: send pack-processing stderr over sideband
      receive-pack: drop "n/a" on unpacker errors

Junio C Hamano (3):
      git blame: document that it always follows origin across whole-file renames
      Start preparing for 1.7.12.3
      Git 1.7.12.3

Linus Torvalds (1):
      mailinfo: don't require "text" mime type for attachments

Orgad Shaneh (1):
      commit: pay attention to submodule.$name.ignore in .gitmodules

Peter Krefting (1):
      l10n: Fix to Swedish translation

Ralf Thielow (1):
      clone --single: limit the fetch refspec to fetched branch

Ramkumar Ramachandra (1):
      submodule: if $command was not matched, don't parse other args

Shawn O. Pearce (2):
      Revert "retry request without query when info/refs?query fails"
      Enable info/refs gzip decompression in HTTP client
