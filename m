From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1.4
Date: Tue, 19 Feb 2013 23:42:32 -0800
Message-ID: <7va9qzzb13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 20 08:43:11 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1U84KZ-0001o6-1F
	for glk-linux-kernel-3@plane.gmane.org; Wed, 20 Feb 2013 08:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934439Ab3BTHmi (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 20 Feb 2013 02:42:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934386Ab3BTHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Feb 2013 02:42:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CEC591DA;
	Wed, 20 Feb 2013 02:42:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	dcWHItnaOy/RQTngMo2ppiQI8o=; b=Ftr+mTLok4VKp6elET6HhYcnjLzIS3GbP
	oxA7hFa5WbGyTsHVo7alsWAQvSxXEPYguJid3tR1tL/1q+ujF/M1BPVXHQtV1ci9
	2awG0ELgWs5HQNE7GQAl0heyCv9TNKzoMCGQbdbBGNtLVcI06TbxYPe2VdOhH2MW
	wkOb4UyBO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Hxe2mJ29/LeXBe8YSBo+JWnfnTf+Erf4J0bNWBfzK4m7VPWAA8bGpZT7
	fYZmpmgsXWA4BFnAg+22Vv7S5fDYeo1zO0FzzjZ8ng6fGZDSITytZSSrhgby+WF7
	jKW8+8uy5++50+Rr0dS4tCSLIqgqLWhKNlp08cjw0+Q1pi51o38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C7591D9;
	Wed, 20 Feb 2013 02:42:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCEBF91D4; Wed, 20 Feb 2013
 02:42:34 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17DC7C18-7B31-11E2-AA1D-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216689>

The latest maintenance release Git v1.8.1.4 is now available at the
usual places.

This is primarily to tighten the host verification when imap-send is
talking to your mail server via TLS/SSL.  The topic that was merged to
the tip of 'maint' track consists of 3 patches and is based on the
1.7.6 maintenance track.  This is to make it easier for the distro
folks to merge the topic to their older maintenance branches to issue
hotfix binary releases if they wanted to.

This release itself also contains many small updates to the
user-manual.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

553191fe02cfac77386d5bb01df0a79eb7f163c8  git-1.8.1.4.tar.gz
bb71df6bc1fdb55b45c59af83102e901d484ef53  git-htmldocs-1.8.1.4.tar.gz
98c41b38d02f09e1fcde335834694616d0a615f7  git-manpages-1.8.1.4.tar.gz

Also the following public repositories all have a copy of the v1.8.1.4
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git 1.8.1.4 Release Notes
=========================

Fixes since v1.8.1.3
--------------------

 * "git imap-send" talking over imaps:// did make sure it received a
   valid certificate from the other end, but did not check if the
   certificate matched the host it thought it was talking to.

Also contains various documentation fixes.

----------------------------------------------------------------

Changes since v1.8.1.3 are as follows:

Junio C Hamano (2):
      imap-send: move #ifdef around
      Git 1.8.1.4

Matthieu Moy (1):
      Replace filepattern with pathspec for consistency

Oswald Buddenhagen (2):
      imap-send: the subject of SSL certificate must match the host
      imap-send: support subjectAltName as well

W. Trevor King (9):
      user-manual: Fix 'both: so' -> 'both; so' typo
      user-manual: Fix 'http' -> 'HTTP' typos
      user-manual: Fix 'you - Git' -> 'you--Git' typo
      user-manual: Rewrite git-gc section for automatic packing
      user-manual: use 'remote add' to setup push URLs
      user-manual: give 'git push -f' as an alternative to +master
      user-manual: mention 'git remote add' for remote branch config
      user-manual: use 'git config --global user.*' for setup
      user-manual: use -o latest.tar.gz to create a gzipped tarball
