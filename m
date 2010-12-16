From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.3.4, 1.6.6.3 and others
Date: Wed, 15 Dec 2010 22:02:35 -0800
Message-ID: <7v8vzqntl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Dec 16 07:03:10 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1PT6vl-0006Pt-Qy
	for glk-linux-kernel-3@lo.gmane.org; Thu, 16 Dec 2010 07:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab0LPGCz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Dec 2010 01:02:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0LPGCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2010 01:02:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 114A13ECF;
	Thu, 16 Dec 2010 01:03:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=bGS7
	emxiy2ehQGG0KvSBNX/j+3Y=; b=IQCPOUiz/NjbcXEZSOHWun+1f8Iw1wUK/GUS
	WhB/kD4Ggnj04JRPTE/iklo2Ct26UBCXAZqqxMkS0rsyPFIV7FTxwNF7k7CTcpDv
	/18VGs99B6dgGikAMYkK7C92Yj3/Z6NtTOgfBc7+qQKD0jBsXs1hkw+GHx4BPaxT
	0WxcOuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=eoJ
	iK+AWCzR0oBUcrlJoIweCE9En1gp0qHnS4qw/aEdKF8jeaVt371pzoD2F+qwCKvM
	52bvL5YFay0gnrp1i2ffmrMXF0jkrd2AEmWkbLxQkSdU2/J4BqjNxc1uIGkMQwi3
	nSOtPQoSE7PPrFCOiAXiFcLiWQOpJEBEni4cll6w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D48853ECE;
	Thu, 16 Dec 2010 01:03:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6453C3ECD; Thu, 16 Dec 2010
 01:03:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 27699A1A-08DA-11E0-8124-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163801>

The latest maintenance release Git 1.7.3.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.3.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.3.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.3.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.3.4-1.fc13.$arch.rpm	(RPM)

Among many fixes since v1.7.3.3, it contains a fix to a recently
discovered XSS vulnerability in Gitweb (CVE 2010-3906).  A backport
to an earlier maintenance track 1.6.6.3 is available (replace 1.7.3.4 with
1.6.6.3 above).

The Gitweb fix has also been backported to maintenance tracks of other
earlier releases (1.7.2.5, 1.7.1.4, 1.7.0.9, 1.6.5.9, and 1.6.4.5) and are
available from the main repository and shortly will be available from its
mirrors:

  git://git.kernel.org/pub/scm/git/git.git/
  git://repo.or.cz/alt-git.git/
  git://git-core.git.sourceforge.net/gitroot/git-core/git-core/
  git://github.com/git/git.git/

----------------------------------------------------------------

Git v1.7.3.4 Release Notes
==========================

Fixes since v1.7.3.3
--------------------

 * Smart HTTP transport used to incorrectly retry redirected POST
   request with GET request.

 * "git apply" did not correctly handle patches that only change modes
   if told to apply while stripping leading paths with -p option.

 * "git apply" can deal with patches with timezone formatted with a
   colon between the hours and minutes part (e.g. "-08:00" instead of
   "-0800").

 * "git checkout" removed an untracked file "foo" from the working
   tree when switching to a branch that contains a tracked path
   "foo/bar".  Prevent this, just like the case where the conflicting
   path were "foo" (c752e7f..7980872d).

 * "git cherry-pick" or "git revert" refused to work when a path that
   would be modified by the operation was stat-dirty without a real
   difference in the contents of the file.

 * "git diff --check" reported an incorrect line number for added
   blank lines at the end of file.

 * "git imap-send" failed to build under NO_OPENSSL.

 * Setting log.decorate configuration variable to "0" or "1" to mean
   "false" or "true" did not work.

 * "git push" over dumb HTTP protocol did not work against WebDAV
   servers that did not terminate a collection name with a slash.

 * "git tag -v" did not work with GPG signatures in rfc1991 mode.

 * The post-receive-email sample hook was accidentally broken in 1.7.3.3
   update.

 * "gitweb" can sometimes be tricked into parrotting a filename argument
   given in a request without properly quoting.

Other minor fixes and documentation updates are also included.
