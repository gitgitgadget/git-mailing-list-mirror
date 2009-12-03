From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 01:21:13 -0800
Message-ID: <7v638o76ra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755713AbZLCJVZ@vger.kernel.org Thu Dec 03 10:21:51 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755713AbZLCJVZ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG7sj-0000hw-RN
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Dec 2009 10:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbZLCJVZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 3 Dec 2009 04:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbZLCJVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Dec 2009 04:21:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbZLCJVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Dec 2009 04:21:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E98EBA3616;
	Thu,  3 Dec 2009 04:21:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=e9CZ
	csPCXi3l3X0nVW5WfpM8bCw=; b=CIva6WqwFbuDU6+2V/0Udtqaiipux0rlVVgV
	qcOpr4344N+fHpJoarhS1spV3QE5LOeHK41DKZH5sW4gPVWJSGqISfnCJ0juyG9v
	ureObPMubyRkhy/b1xpm5zjtk/1AVO0HjMPzy1xWPaYScBFTvqwNMCeBAiiJwY0y
	TzdfIF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LwB
	8ofbIpr2RpABj/V0ZUAD9L7XCykLApcVrvqMakJqQKoodymdyNZ8oWwO8iQdzmkS
	+bj6elHvsAh7zyTBy6jpGjnrS+HYucIqJ/VOVcQWJ4I2QOvOv+p4EjJwZo4zczvm
	jKhUZEOUFxT/yai18wBdwolafgSNWQ0HGmd02ZRQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC4F3A3615;
	Thu,  3 Dec 2009 04:21:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 087C5A3614; Thu,  3 Dec 2009
 04:21:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37F33BC8-DFED-11DE-AF0B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134443>

The latest maintenance release Git 1.6.5.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.4-1.fc11.$arch.rpm	(RPM)

Contains some minor fixes that have been accumulated; all of them
appear in the upcoming 1.6.6 release as well.

This should fix the problem that man pages formatted on FC11 boxes are
littered with "man.base.url.for.relative.link" strings reported earlier
today.

Git v1.6.5.4 Release Notes
==========================

Fixes since v1.6.5.3
--------------------

 * "git help" (without argument) used to check if you are in a directory
   under git control. There was no breakage in behaviour per-se, but this
   was unnecessary.

 * "git prune-packed" gave progress output even when its standard error is
   not connected to a terminal; this caused cron jobs that run it to
   produce crufts.

 * "git pack-objects --all-progress" is an option to ask progress output
   from write-object phase _if_ progress output were to be produced, and
   shouldn't have forced the progress output.

 * "git apply -p<n> --directory=<elsewhere>" did not work well for a
   non-default value of n.

 * "git merge foo HEAD" was misparsed as an old-style invocation of the
   command and produced a confusing error message.  As it does not specify
   any other branch to merge, it shouldn't be mistaken as such.  We will
   remove the old style "git merge <message> HEAD <commit>..."  syntax in
   future versions, but not in this release,

 * "git merge -m <message> <branch>..." added the standard merge message
   on its own after user-supplied message, which should have overrided the
   standard one.

Other minor documentation updates are included.

----------------------------------------------------------------

Changes since v1.6.5.3 are as follows:

David Aguilar (1):
      help: Do not unnecessarily look for a repository

David Soria Parra (1):
      Documentation: Document --branch option in git clone synopsis

Greg Price (1):
      Documentation: undocument gc'd function graph_release()

Jeff King (1):
      prune-packed: only show progress when stderr is a tty

Junio C Hamano (7):
      builtin-apply.c: pay attention to -p<n> when determining the name
      Do not misidentify "git merge foo HEAD" as an old-style invocation
      merge: do not add standard message when message is given with -m option
      Prepare for 1.6.5.4
      Documentation/Makefile: allow man.base.url.for.relative.link to be set from Make
      Unconditionally set man.base.url.for.relative.links
      Git 1.6.5.4

Michael J Gruber (1):
      Documentation: Fix a few i.e./e.g. mix-ups

Nicolas Pitre (1):
      pack-objects: split implications of --all-progress from progress activation

Stephen Boyd (1):
      instaweb: restart server if already running
