From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.4.3
Date: Sun, 13 Sep 2009 03:12:02 -0700
Message-ID: <7v1vmbw3v1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 12:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmm4V-0004pP-8h
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbZIMKMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 06:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbZIMKMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:12:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZIMKMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 06:12:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D3404F743;
	Sun, 13 Sep 2009 06:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=SPKW
	aFgNzrwtZKrO+UejbP+1/nQ=; b=wJuQtRO0EMl5GlVWyjnneigNM4WRhrV5w7+x
	9xm90vf3N1vFHBDYi5mTJ0wNargSdogLAmMM4WO/sMf7kwxXh87X5mUC3YA99uSd
	Swibrs7LTL1YvuhLGQiShB1Yrz5gC40nJRl5zpzBhm+uG6Y/VIdSP4HWFYk/JB7z
	1LWTtxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=mp2
	gX/srxJC/OeujuJym+/RwC89PvblJzUJFzLbemCv3c42CAKYE6fyFEufCTvGlrHi
	Pj0cyJrrEl3cmXoP12H7pjDF5vEuzKRGP3zhd+QlmJiee9l1GLuRuZOUWxzSHN1O
	QLIh1QS7P24mH+PdfoOiRq/7bxyb3EP5QLuXjaho=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 187134F742;
	Sun, 13 Sep 2009 06:12:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5AEFC4F741; Sun, 13 Sep 2009
 06:12:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E873C8EE-A04D-11DE-92EF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128350>

The latest maintenance release GIT 1.6.4.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.4.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.4.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.4.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.4.3-1.fc9.$arch.rpm	(RPM)


GIT v1.6.4.3 Release Notes
==========================

Fixes since v1.6.4.2
--------------------

* "git clone" from an empty repository gave unnecessary error message,
  even though it did everything else correctly.

* "git cvsserver" invoked git commands via "git-foo" style, which has long
  been deprecated.

* "git fetch" and "git clone" had an extra sanity check to verify the
  presense of the corresponding *.pack file before downloading *.idx
  file by issuing a HEAD request.  Github server however sometimes
  gave 500 (Internal server error) response to HEAD even if a GET
  request for *.pack file to the same URL would have succeeded, and broke
  clone over HTTP from some of their repositories.  As a workaround, this
  verification has been removed (as it is not absolutely necessary).

* "git grep" did not like relative pathname to refer outside the current
  directory when run from a subdirectory.

* an error message from "git push" was formatted in a very ugly way.

* "git svn" did not quote the subversion user name correctly when
  running its author-prog helper program.

Other minor documentation updates are included.
