From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 00/16] Tests on Windows - main part
Date: Sat, 21 Mar 2009 22:41:57 +0100
Message-ID: <200903212241.57957.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:43:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8yd-0007g2-1p
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZCUVmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZCUVmD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:42:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30808 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbZCUVmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:42:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DF9991001C
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 22:41:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1300040009
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 22:41:58 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114075>

On Samstag, 21. M=E4rz 2009, Johannes Sixt wrote:
> This is the remaining set of changes after which the test suite
> passes with the MinGW port. Well, almost: There still are a few
> failures, but none of them indicate a serious bug. We will address
> them later.

=46WIW, the tests that still fail are:

# git am does not treat absolute path to mbox file correctly
GIT_SKIP_TESTS +=3D t4150.18
# git am hangs for some not yet know reason
GIT_SKIP_TESTS +=3D t4252.7
# git upload-pack does not write an error message in this case
# (reason unknown; seems to be a race condition)
GIT_SKIP_TESTS +=3D t5530.6
# vim should terminate if its stdin is not a terminal, but it doesn't
# (at least that's what I noted down when I last investigated the issue=
 ;)
GIT_SKIP_TESTS +=3D t7005
# output contains CRLF (I think)
GIT_SKIP_TESTS +=3D t7401.14
# SIGTERM is not sent or not caught - doesn't work with SIGINT, either
GIT_SKIP_TESTS +=3D t7502.18
# output contains CRLF (I think)
GIT_SKIP_TESTS +=3D t7508.1[68]
# perl scripts don't work in test mode
GIT_SKIP_TESTS +=3D t9001 t9200 t9500

and all 'git svn' tests: t91??-*.sh

-- Hannes
