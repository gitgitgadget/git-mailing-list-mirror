From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 06/15] diff-defaults.patch
Date: Sun, 25 Apr 2010 03:38:57 -0500 (CDT)
Message-ID: <20100316084823.GC26540@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054326.850936000@mlists.thewrittenword.com>
 <7vsk80n31u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:39:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xMm-0006ug-Mu
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab0DYIi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:38:59 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:58911 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:38:58 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 0724F5CC0
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 09:00:00 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 0724F5CC0
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id B3D2FA47
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:38:57 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 720E757C; Sun, 25 Apr 2010 03:38:57 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vsk80n31u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145727>

On Tue, Mar 16, 2010 at 12:22:53AM -0700, Junio C Hamano wrote:
> "Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:
> 
> > By default the testsuite calls 'diff -u' whenever a file comparison is
> > called for.  Unfortunately that throws a "diff: unknown option '-u'"
> > error for most non-GNU diffs.
> >
> > This patch sets GIT_TEST_CMP to 'cmp' on all the architectures where
> > that happens.
> 
> Wouldn't most of these platforms you listed have a working "diff -c" at
> least?  Using it would make debugging the tests easier, as it would be
> more readable than output from "cmp".

Yes, I've checked, and everything I have access to supports "diff -c"
with the vendor implementation.

> I also saw your patch to install-webdoc used "$DIFF -u"; as the patch
> series seem to assume a unified-capable diff implementation is available
> somewhere, perhaps you do not need this patch after all, but instead just
> need to default GIT_TEST_CMP to "$DIFF -u" in t/test-lib.sh, no?

That is more than adequate for me, since one of our packages is GNU
diffutils, and my git build recipe puts the path to our diffutils
package first in PATH before launching configure and make.

However, anyone else that wants to build git on a non-"diff -u"
capable machine won't necessarily have this luxury.  At the moment
it's hard for me to tell whether the diff changes are a net win, since
I can't get the testsuite to run properly on any of the architectures
that would be affected.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
