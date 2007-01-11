From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: MinGW port (was: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows)
Date: Thu, 11 Jan 2007 10:35:41 +0100
Organization: eudaptics software gmbh
Message-ID: <45A604ED.5EF73A1E@eudaptics.com>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com> <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 11 10:35:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wLD-000741-6O
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbXAKJfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbXAKJfU
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:35:20 -0500
Received: from main.gmane.org ([80.91.229.2]:34274 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965333AbXAKJfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:35:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H4wL1-0006Kv-W9
	for git@vger.kernel.org; Thu, 11 Jan 2007 10:35:12 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 10:35:11 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 10:35:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36563>

Martin Langhoff wrote:
> How much does qgit4 depend on using commandline git? IOWs, how far
> from not needing cygwin+git, and shipping a git+qgit compiled against
> the MinGW that QT4 has?

FWIW, I'm slowly working on a MinGW port of git, based on Dscho's
initial work.

Currently, the tool set passes about 60-70% of the tests.

This works: The tools that you commonly need to work on a local repo,
except merges ([*]): commit, rebase, reset, log, diff and their
plumbing.

This does not work: pull, fetch, clone; mostly due to fork()
difficulties in their plumbing (fetch-pack, send-pack, etc.)

[*] because shell scripts like merge-one-file can't be invoked from an
exe like merge-index, yet. Fortunately this looks like the easiest part
to solve.

-- Hannes
