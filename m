From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.6.4
Date: Fri, 23 Sep 2011 16:37:53 -0700
Message-ID: <7vlitesucu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Sep 24 01:38:11 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R7FJo-0000PO-CC
	for glk-linux-kernel-3@lo.gmane.org; Sat, 24 Sep 2011 01:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab1IWXh4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 23 Sep 2011 19:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab1IWXhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2011 19:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3D7656EF;
	Fri, 23 Sep 2011 19:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=J/i1qUOJUEB3IAo6Pk05veVoXYo=; b=VrBUBxK/v2x3vAT36UyrDq/M6fOz
	h9pWAWTpQHibZiCWmsYxVpGTXIDlGB/hFD9zbUXEsqBtfQ8d/37IQJHS84IuQBIB
	X0bXcp95PgWUqlAzNPWTzqJTexAe7JM245ORQRMH0OHPCFBCuEsJXJgG8DDZGvlQ
	EHUvrmc2vVPJJhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	mWoojL97QZ8zv3FDTnx35WHSWJ855MRu4udj84sbxAYEuqQrv2FbNHvYmvdnVsae
	Mh87t76s5k4tm1FmBuFh4jMmtO1imHT7pmR5wJ2oBgY6SiWmHDL5FtvU9CaEcpTF
	vXgCCiForRKZBiUYiJaMWue3iCXaoD95ZaGc8voiR+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB0C856EE;
	Fri, 23 Sep 2011 19:37:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 503A456EC; Fri, 23 Sep 2011
 19:37:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F313188-E63D-11E0-A84D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182013>

The latest maintenance release Git 1.7.6.4 is available but not at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

df91e2c32d6097ab1c9d0edc56dd8cecb4e9b686  git-1.7.6.4.tar.gz
6abd985e24b6585284cef7fae2e3046ba9201356  git-htmldocs-1.7.6.4.tar.gz
c6f6d92f4005a7eccaf89e851c45768c18f7e65a  git-manpages-1.7.6.4.tar.gz

Also the following public repositories all have a copy of the v1.7.6.4
tag and the maint branch that the tag points at:

        url = git://repo.or.cz/alt-git.git
        url = https://code.google.com/p/git-core/
        url = git://git.sourceforge.jp/gitroot/git-core/git.git
        url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
        url = https://github.com/gitster/git


Git v1.7.6.4 Release Notes
==========================

Fixes since v1.7.6.3
--------------------

 * The error reporting logic of "git am" when the command is fed a file
   whose mail-storage format is unknown was fixed.

 * "git branch --set-upstream @{-1} foo" did not expand @{-1} correctly.

 * "git check-ref-format --print" used to parrot a candidate string that
   began with a slash (e.g. /refs/heads/master) without stripping it, to make
   the result a suitably normalized string the caller can append to "$GIT_DIR/".

 * "git clone" failed to clone locally from a ".git" file that itself
   is not a directory but is a pointer to one.

 * "git clone" from a local repository that borrows from another
   object store using a relative path in its objects/info/alternates
   file did not adjust the alternates in the resulting repository.

 * "git describe --dirty" did not refresh the index before checking the
   state of the working tree files.

 * "git ls-files ../$path" that is run from a subdirectory reported errors
   incorrectly when there is no such path that matches the given pathspec.

 * "git mergetool" could loop forever prompting when nothing can be read
   from the standard input.

Also contains minor fixes and documentation updates.
