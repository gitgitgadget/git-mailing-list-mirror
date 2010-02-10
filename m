From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.6.2
Date: Wed, 10 Feb 2010 15:41:11 -0800
Message-ID: <7vvde4veug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 11 00:41:33 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NfMBY-00026W-FT
	for glk-linux-kernel-3@lo.gmane.org; Thu, 11 Feb 2010 00:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab0BJXl1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 10 Feb 2010 18:41:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab0BJXlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Feb 2010 18:41:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2051C98BBF;
	Wed, 10 Feb 2010 18:41:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=hYd0
	PlSOni3kYOUqdSQW7i0azm4=; b=InCPFhVVVXsiNoHrsDdUJZubwStmkV06V2Gc
	QfZiefkGo/Mdg0fFvQYoJDj2o6Go6mHNSWIryrppc5zt+q3Nng8Upqkvv8OBi8qT
	Sjusa6U1TFS3nHdWhWKNS3T3e6mFSqZMkEKe+SGgjrO8cMy3Ej3ZXGhHiFYLJ6Sb
	gsaXEKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FNi
	zhE+UEcWIaAVpw1L0GXEekeMixnJwYDAMmsMLzQ8aua7DC+EyJqqXG13BywzA/o4
	Hsp8HAJtSNXdmJPAzjazmgJlOseKrx5hMMKr/CZPpJBDmYM1pgxp8V3DhKYTfbpU
	JGJZIS8B17MJK/ujKJcoWS719EgNkW/Jun9JqYkE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEBED98BB6;
	Wed, 10 Feb 2010 18:41:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C41BE98BB3; Wed, 10 Feb
 2010 18:41:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8C0FB22-169D-11DF-9E74-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139567>

The latest maintenance release Git 1.6.6.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.6.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.6.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.6.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.6.2-1.fc11.$arch.rpm	(RPM)

Git v1.6.6.2 Release Notes
==========================

Fixes since v1.6.6.1
--------------------

 * recursive merge didn't correctly diagnose its own programming errors,
   and instead caused the caller to segfault.

 * The new "smart http" aware clients probed the web servers to see if
   they support smart http, but did not fall back to dumb http transport
   correctly with some servers.

 * Time based reflog syntax e.g. "@{yesterday}" didn't diagnose a misspelled
   time specification and instead assumed "@{now}".

 * "git archive HEAD -- no-such-directory" produced an empty archive
   without complaining.

 * "git blame -L start,end -- file" misbehaved when given a start that is
   larger than the number of lines in the file.

 * "git checkout -m" didn't correctly call custom merge backend supplied
   by the end user.

 * "git config -f <file>" misbehaved when run from a subdirectory.

 * "git cvsserver" didn't like having regex metacharacters (e.g. '+') in
   CVSROOT environment.

 * "git fast-import" did not correctly handle large blobs that may
   bust the pack size limit.

 * "git gui" is supposed to work even when launched from inside a .git
   directory.

 * "git gui" misbehaved when applying a hunk that ends with deletion.

 * "git imap-send" did not honor imap.preformattedHTML as documented.

 * "git log" family incorrectly showed the commit notes unconditionally by
   mistake, which was especially irritating when running "git log --oneline".

 * "git status" shouldn't require an write access to the repository.

Other minor documentation updates are included.
