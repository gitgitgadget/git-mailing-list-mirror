From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7.6
Date: Wed, 18 Jan 2012 17:14:07 -0800
Message-ID: <7v39bclcio.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 02:14:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RngaB-0001y9-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 02:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab2ASBOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 20:14:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431Ab2ASBOK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 20:14:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFBD6593;
	Wed, 18 Jan 2012 20:14:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=+IojqhoYN3vE9pQ6tds5Yzy9i
	L8=; b=mnVGdK/URlXsJQekHB6CZB8VmHQYf+GZrc/ijIy44ns2e93bG8ThOUK2g
	HrgbljobWij86z4q8tg6FuKvirRbwulnPEmzCS4dq2OsSYiQ/13TflDs5Nn3bdKO
	FDrGt2Txf9c1p96aV+YIw6Bipmo7UJlqjxgo5Ydg2qlTSWjbYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ste6JcHvkWD3HNbu3ib
	qwcNeopB6xk02c1sQn22JJyo4057Zg76+BZpouvT7tw/qK1IWxE3WQnO1UNGfXbj
	xssnb+Quu3sdkNmvqGYNzify0QHWdt7p22rmBHorec7Li+bbNwEgjqfXF+MYZ4ka
	LbbfqPhVsqHx4dyAsfeGFLYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 246A06592;
	Wed, 18 Jan 2012 20:14:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 566F06591; Wed, 18 Jan 2012
 20:14:09 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3B4DB36-423A-11E1-B500-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188785>

An maintenance release Git 1.7.7.6 is available.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

483dc95de0e26f0154fb23444589266b59848cfe  git-1.7.7.6.tar.gz
8bcbd0a53fd3b937a9991aa096220a1a0eb2f771  git-htmldocs-1.7.7.6.tar.gz
0fd7452c88d0b3ccb08d9b2b91b552680b0209e0  git-manpages-1.7.7.6.tar.gz

Also the following public repositories all have a copy of the v1.7.7.6
tag and the maint-1.7.7 branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.7.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.7.5
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

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.7.5 are as follows:

Clemens Buchacher (1):
      Documentation: read-tree --prefix works with existing subtrees

Jack Nagel (1):
      Add MYMETA.json to perl/.gitignore

Jeff King (4):
      attr: don't confuse prefixes with leading directories
      attr: drop misguided defensive coding
      attr: fix leak in free_attr_elem
      thin-pack: try harder to use preferred base objects as base

Jens Lehmann (1):
      docs: describe behavior of relative submodule URLs

Junio C Hamano (8):
      attr.c: make bootstrap_attr_stack() leave early
      attr.c: clarify the logic to pop attr_stack
      Documentation: rerere's rr-cache auto-creation and rerere.enabled
      Prepare for 1.7.6.6
      Prepare for 1.7.7.6
      Update draft release notes to 1.7.6.6
      Update draft release notes to 1.7.7.6
      Git 1.7.7.6

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      t2203: fix wrong commit command
      diff-index: enable recursive pathspec matching in unpack_trees

Thomas Rast (1):
      Documentation: rerere.enabled is the primary way to configure rer=
ere
