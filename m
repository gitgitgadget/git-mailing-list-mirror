From: esr@thyrsus.com (Eric S. Raymond)
Subject: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 15:48:28 -0500 (EST)
Message-ID: <20121127204828.577264065F@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 21:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdS5I-0002VP-UT
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab2K0Usc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:48:32 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:57614
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab2K0Usc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 15:48:32 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 577264065F; Tue, 27 Nov 2012 15:48:28 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210595>

Because I do a lot of work on repository conversion tools, I've had
to learn a lot of detail about ontological mismatches between
version-control systems - especially places where you lose metadata
moving between them.

In general, git metadata can carry forward almost all the metadata in
a Subversion repository.  Among the handful of minor exceptions (empty
directories, flow structure, certain kinds of mergeinfos) there is one
that stands out because it seems to be an implementation detail rather
than a consequence of fundamentally different design decisions.

I refer to the one-second precision of git timestamps.  Subversion
stores its commit and property-change timestamps to microsecond
precision; conversion tools have to throw the subsecond part of
this information away.

Has going to timestamps with the full precision of the system clock
been considered and rejected, or am I the first to bring this up?

If I were to write refactoring patches that treated "timestamp" as
an ADT, with a view towards hiding the difference between int and
float timestamps and eventually experimenting with float ones, 
would they be accepted?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

Every Communist must grasp the truth, 'Political power grows out of
the barrel of a gun.'
        -- Mao Tse-tung, 1938, inadvertently endorsing the Second Amendment.
