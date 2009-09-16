From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.4.4
Date: Wed, 16 Sep 2009 16:26:42 -0700
Message-ID: <7v4or2wjwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 01:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3uC-0000V8-W6
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933561AbZIPX04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760403AbZIPX0z
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:26:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbZIPX0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 19:26:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7E205350B;
	Wed, 16 Sep 2009 19:26:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=AOUE
	VCR+eP96B4SJJ7058eoAmhA=; b=L818Y97Zt6dNXU6cin6C7VyUzKaevOwZM+dR
	IXitWeWg0uQhr2kwtIXjXwHzang5qvFRX16h23nXL558XBQsplU2WRkqTNYnD7eB
	4YJ9Bg14p9UGREYzMSdlQpToTg/Vl2eFC2lBs8Ou+T5YJyLfG7rTOiSNOHRn+5VQ
	v3NFfDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=EfQ
	n4H9ftCd5ZwrZbN55kgVfZ2Yw8fQXoJT3TcuQkHhQ+MbqmpFfwtnTsp5VXmHg7C5
	WOHFBmCnWM7ocBb0U9Lb7AP+1VBdmxd/hNnKewL5ikgshDwlCl4G7eCkwXF0C5Ha
	CAJHjPy4T3oy8f1ngZE7iF8MoyFqQgqok2m77Zm4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B334353508;
	Wed, 16 Sep 2009 19:26:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C3B2E53507; Wed, 16 Sep 2009
 19:26:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AF82356-A318-11DE-8152-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128696>


The latest maintenance release GIT 1.6.4.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.4.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.4.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.4.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.4.4-1.fc9.$arch.rpm	(RPM)

This is primarily to fix a http regression introduced by 1.6.4.3

GIT v1.6.4.4 Release Notes
==========================

Fixes since v1.6.4.4
--------------------

* The workaround for Github server that sometimes gave 500 (Internal server
  error) response to HEAD requests in 1.6.4.3 introduced a regression that
  caused re-fetching projects over http to segfault in certain cases due
  to uninitialized pointer being freed.

* "git pull" on an unborn branch used to consider anything in the work
  tree and the index discardable.

* "git diff -b/w" did not work well on the incomplete line at the end of
  the file, due to an incorrect hashing of lines in the low-level xdiff
  routines.

* "git checkout-index --prefix=$somewhere" used to work when $somewhere is
  a symbolic link to a directory elsewhere, but v1.6.4.2 broke it.

* "git unpack-objects --strict", invoked when receive.fsckobjects
  configuration is set in the receiving repository of "git push", did not
  properly check the objects, especially the submodule links, it received.

Other minor documentation updates are included.
