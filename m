From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.4
Date: Wed, 18 Jan 2012 17:15:18 -0800
Message-ID: <7vwr8ojxw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 02:15:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RngbC-0002W0-DR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 02:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab2ASBPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 20:15:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab2ASBPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 20:15:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E78665B6;
	Wed, 18 Jan 2012 20:15:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=zBxxLEHbM0TNz/CaxgjNXUrf8
	wU=; b=HZsoUJoPJfITrtlQ7N5u82Jd80v6y8Mw9GZ+xqu3/hjQr7eop92gTePp4
	7BvLWZpSMcJXBSePI9AGRrClTcZeCLnyUvb/oQY93TFAakKU1qZxIHHAWq5aHEJW
	mRNTv0Ek/a+mtPKxdM/ruECBJvoBpwNOoqx+i5L35NMXgudrf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=YBBRXB4QAS8esXBVsc4
	tmv9Ntjng0c8ZXZuppkl4DJcjKd0jN6rct3jGcXMki2QWNV5+ff2JI5zCkVengW7
	KHWm/2Ey2G+uoWsmHeqq4oKbc28Z+Nb3v8uCMaitM558WpW4QyRHusnlB9TgjBWF
	CBi52IqGlOoBEZR46ROyicPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2444565B5;
	Wed, 18 Jan 2012 20:15:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A87B565B4; Wed, 18 Jan 2012
 20:15:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DA12E18-423B-11E1-87D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188786>

The latest maintenance release Git 1.7.8.4 is available.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

add7b05f26216181d1b148dde298432132552b0f  git-1.7.8.4.tar.gz
ac2b89d8d4418c7633ee2344e89eb7dfcb81522a  git-htmldocs-1.7.8.4.tar.gz
4372c423a0d2f7df33b5b39727a81f0a7b40669d  git-manpages-1.7.8.4.tar.gz

Also the following public repositories all have a copy of the v1.7.8.4
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.8.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.8.3
--------------------

 * The code to look up attributes for paths reused entries from a wrong
   directory when two paths in question are in adjacent directories and
   the name of the one directory is a prefix of the other.

 * A wildcard that matches deeper hierarchy given to the "diff-index" c=
ommand,
   e.g. "git diff-index HEAD -- '*.txt'", incorrectly reported addition=
s of
   matching files even when there is no change.

 * When producing a "thin pack" (primarily used in bundles and smart
   HTTP transfers) out of a fully packed repository, we unnecessarily
   avoided sending recent objects as a delta against objects we know
   the other side has.

 * "git send-email" did not properly treat sendemail.multiedit as a
   boolean (e.g. setting it to "false" did not turn it off).

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.8.3 are as follows:

Jeff King (5):
      send-email: multiedit is a boolean config option
      attr: don't confuse prefixes with leading directories
      attr: drop misguided defensive coding
      attr: fix leak in free_attr_elem
      thin-pack: try harder to use preferred base objects as base

Junio C Hamano (11):
      attr.c: make bootstrap_attr_stack() leave early
      attr.c: clarify the logic to pop attr_stack
      Documentation: rerere's rr-cache auto-creation and rerere.enabled
      Prepare for 1.7.6.6
      Prepare for 1.7.7.6
      Prepare for 1.7.8.4
      Update draft release notes to 1.7.6.6
      Update draft release notes to 1.7.7.6
      Update draft release notes to 1.7.8.4
      Git 1.7.7.6
      Git 1.7.8.4

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      t2203: fix wrong commit command
      diff-index: enable recursive pathspec matching in unpack_trees
