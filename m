From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/6] New and improved DAG appliedness series
Date: Sun, 10 Jun 2007 02:54:47 -0700
Message-ID: <20070610094322.12000.56284.stgit@bill>
References: <20070518063015.GA13516@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:54:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxK8M-0006XN-7D
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbXFJJyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 05:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXFJJyw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:54:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1821 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXFJJyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:54:52 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1HxK8I-0008R5-00; Sun, 10 Jun 2007 10:54:50 +0100
In-Reply-To: <20070518063015.GA13516@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49699>

This took a while, but here it is. (Actually, I finished this about a
week ago, but had no Internet connection so I couldn't send it.)

The series starts with basically the same DAG appliedness test as
before, with the same known performance bug. Later on in the series,
the mechanism is changed to one that doesn't have the bug. I kept the
intermediate, slow state because the changesets read better that way,
and because the new mechanism is more complicated than the old so it
might be useful to be able to compare their output in case some bug
turns up further down the road.

To test the performance, I used a script (which I've unfortunately
misplaced) that (in the kernel repository) reset to one point 10000
commits in the past and one 5000 commits in the past, pushed a few
patches at each spot, and then created 100 applied and 100 unapplied
patches on top of upstream HEAD. This triggers the performance bug
with the first algorithm since we have unapplied commits very far from
HEAD.

Both algorithms are documented in the patches that introduce them.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
