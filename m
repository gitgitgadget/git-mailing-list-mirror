From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 18:04:02 -0700
Message-ID: <7v4pyb74al.fsf@assigned-by-dhcp.cox.net>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
	<20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<20060623123904.GL21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 03:04:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtwZR-00059c-Ie
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 03:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933171AbWFXBEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 21:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWFXBEF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 21:04:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4568 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S933171AbWFXBEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 21:04:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624010403.PUIB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 21:04:03 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060623123904.GL21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 14:39:04 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22463>

Petr Baudis <pasky@suse.cz> writes:

>> By the way, you also need to adjust the testsuite so that it
>> finds the Perl modules from freshly built tree before
>> installing.  I think (but haven't checked yet) the stuff written
>> in Python does that already, so you might want to mimic it.
>
> It should be enough to -I../perl/blib/lib -I../perl/blib/arch/auto/Git.

-- >8 --
[PATCH] Perl interface: make testsuite work again.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/test-lib.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 05f6e79..fba0c51 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -206,6 +206,8 @@ PYTHON=`sed -e '1{
 	PYTHONPATH=$(pwd)/../compat
 	export PYTHONPATH
 }
+PERL5LIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
+export PERL5LIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
-- 
1.4.1.rc1.gf2641
