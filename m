From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] archive attribute series
Date: Wed, 15 Apr 2009 19:28:32 -0700
Message-ID: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuHMi-0000cC-8Q
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbZDPC2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 22:28:42 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbZDPC2m
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:28:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZDPC2l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:28:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 87638F2E0
	for <git@vger.kernel.org>; Wed, 15 Apr 2009 22:28:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2481DF2DF for
 <git@vger.kernel.org>; Wed, 15 Apr 2009 22:28:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.6.g08087
X-Pobox-Relay-ID: 4BC031D0-2A2E-11DE-BB9B-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116659>

Here is my attempt to consolidate the fix-ups on Duy's git-archive
enhancements.

I haven't decided if this should go to 1.6.3; it is a sensible change b=
ut
it *is* a change in behaviour that could be seen as incompatible.

Junio C Hamano (1):
  unpack-trees: do not muck with attributes when we are not checking
    out

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  attr: add GIT_ATTR_INDEX "direction"
  archive: do not read .gitattributes in working directory

Ren=C3=A9 Scharfe (2):
  archive tests: do not use .gitattributes in working directory
  archive test: test new --fix-attributes feature

 Documentation/git-archive.txt |    5 ++-
 archive.c                     |   22 ++++++++++++++
 archive.h                     |    1 +
 attr.c                        |   12 ++++++--
 attr.h                        |    3 +-
 builtin-tar-tree.c            |    8 +++++
 t/t5000-tar-tree.sh           |    9 +++--
 t/t5001-archive-attr.sh       |   62 +++++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.c                |    6 ++-
 9 files changed, 117 insertions(+), 11 deletions(-)
 create mode 100755 t/t5001-archive-attr.sh
