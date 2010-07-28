From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.2.1 (also 1.7.1.2 and 1.7.0.7)
Date: Wed, 28 Jul 2010 10:41:33 -0700
Message-ID: <7vd3u74i7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 19:41:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAdZ-000367-Uw
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab0G1Rlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 13:41:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab0G1Rlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 13:41:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B47E6C8021;
	Wed, 28 Jul 2010 13:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=0fCXEvp/7wZwlWvbZ4Kyq2Xkp
	FE=; b=K+IuEIdlSW7y3Z9U+PaKsqxBaEm99vhubZhCOkfB/hxRhD5wlTr/k0xwH
	YEMFLC5O7tANDL1PBA4pvQMX0QmZgt1yDkuGOPGpO9Z7sHD8FGq6a8ejoO/F3Ko+
	qvxpzRpf9jLhMWLgn3bmlHmHn2oUZNClt9AQ3B2nnvtzZQf2yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=sLRkR0lpRopjbyPpQ3p
	Za5BU6lzofa1ZRKPpdE0OHuIwOoBEUhNpXgbxF9C49yp4U9gOapFNu7fvMRjV58w
	b07jLFjuuytqB7E78K8L2dMpj5GIZlTYPAWW29FV64mx5EJHlfvsb5oIYjqNXc94
	ZMLezAUUVT+F/WTCyLLZ+OgI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D5ACC801C;
	Wed, 28 Jul 2010 13:41:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 861E2C801B; Wed, 28 Jul
 2010 13:41:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5FDD7184-9A6F-11DF-9D8C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152111>

The latest maintenance release Git 1.7.2.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.2.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.2.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.2.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.2.1-1.fc11.$arch.rpm	(RPM)

Two fixes to segfaulting bugs in this release have also been merged to
produce maintenance releases for older codebase, 1.7.0.7 and 1.7.1.2,
primarily for people who do not want to have .2 in the third digit of t=
he
version of git they use for whatever reason ;-)


Git v1.7.2.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.2
------------------

 * "git instaweb" wasn't useful when your Apache was installed under a
   name other than apache2 (e.g. "httpd").

 * Similarly, "git web--browse" (invoked by "git help -w") learned that
   chrome browser is sometimes called google-chrome.

 * An overlong line after ".gitdir: " in a git file caused out of bound=
s
   access to an array on the stack.

 * "git config --path conf.var" to attempt to expand a variable conf.va=
r
   that uses "~/" short-hand segfaulted when $HOME environment variable
   was not set.

 * Documentation on Cygwin failed to build.

 * The error message from "git pull blarg" when 'blarg' is an unknown
   remote name has been improved.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.2 are as follows:

Brandon Casey (1):
      git-rebase--interactive.sh: use printf instead of echo to print c=
ommit message

Dan McGee (3):
      git-instaweb: Fix custom apache log placement
      git-instaweb: Fix Apache environment variable passing
      git-instaweb: Don't assume Apache executable is named apache2

Greg Brockman (1):
      Check size of path buffer before writing into it

Johannes Sixt (1):
      t3700-add: fix dependence on stdout and stderr buffering

Jon Seymour (1):
      INSTALL: configure /etc/xml/catalog to build docs on Cygwin

Jonathan Nieder (1):
      config --get --path: check for unset $HOME

Junio C Hamano (3):
      Git 1.7.0.7
      Git 1.7.1.2
      Git 1.7.2.1

Matthieu Moy (1):
      Clarify help message when no remote is specified in fetch/pull.

Nathan W. Panike (1):
      Add a google-chrome option for web--browse

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      git-read-tree.txt: acknowledge the directory matching bug in spar=
se checkout

Stephen Boyd (2):
      request-pull.txt: Document -p option
      commit: remove full stop from usage help for -u

Thomas Rast (5):
      Cast execl*() NULL sentinels to (char *)
      Document receive.denyDeleteCurrent
      Documentation/git-push: Explain status output in more detail
      Fix 'git' wrapper usage string
      Makefile: add check-docs exception for gitrevisions
