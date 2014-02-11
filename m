From: David Kastrup <dak@gnu.org>
Subject: Profiling support?
Date: Tue, 11 Feb 2014 12:17:40 +0100
Message-ID: <87d2itc2zv.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 11 12:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDBLY-0001sv-14
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 12:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbaBKLRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 06:17:44 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47767 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaBKLRn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 06:17:43 -0500
Received: from localhost ([127.0.0.1]:46810 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDBLS-0005ny-CK
	for git@vger.kernel.org; Tue, 11 Feb 2014 06:17:42 -0500
Received: by lola (Postfix, from userid 1000)
	id E6211E04F9; Tue, 11 Feb 2014 12:17:40 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241942>


Looking in the Makefile, I just find support for coverage reports using
gcov.  Whatever is there with "profile" in it seems to be for
profile-based compilation rather than using gprof.

Now since I've managed to push most of the runtime for basic git-blame
operation out of blame.c proper, it becomes important to figure out
where most of the remaining runtime (a sizable part of that being system
time) is being spent.  Loop counts like that provided by gcov (or am I
missing something here?) are not helpful for that, I think I rather need
the kind of per-function breakdown that gprof provides.

Is there a reason there are no prewired recipes or advice for using
gprof on git?  Is there a way to get the work done, namely seeing the
actual distribution of call times (rather than iterations) using gcov so
that this is not necessary?

-- 
David Kastrup
