From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 6 May 2011 10:51:08 +0200
Message-ID: <20110506085107.GB3719@camk.edu.pl>
References: <20110505191027.GA3242@camk.edu.pl>
 <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
 <4DC3A685.4080300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 06 10:51:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIGkr-0000AQ-9k
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 10:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab1EFIvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 04:51:15 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:48016 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab1EFIvP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 04:51:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id A606D5F0049;
	Fri,  6 May 2011 10:51:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VvE3RJpzmw+1; Fri,  6 May 2011 10:51:08 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 37B9B5F0046;
	Fri,  6 May 2011 10:51:08 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 254E780AC5; Fri,  6 May 2011 10:51:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC3A685.4080300@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172960>

On Fri, May 06, 2011 at 09:43:01AM +0200, Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 05.05.2011 22:02:
> > Kacper Kornet <draenog@pld-linux.org> writes:
> >> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> >> ---
> >>  t/t1506-rev-parse-diagnosis.sh |    4 ++--
> >>  1 files changed, 2 insertions(+), 2 deletions(-)

> >> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> >> index 4a6396f..bad09f9 100755
> >> --- a/t/t1506-rev-parse-diagnosis.sh
> >> +++ b/t/t1506-rev-parse-diagnosis.sh
> >> @@ -8,8 +8,8 @@ exec </dev/null

> >>  test_did_you_mean ()
> >>  {
> >> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
> >> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
> >> +	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
> >> +	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
> >>  	test_cmp expected error
> >>  }

> >> -- 
> >> 1.7.5

> > [Reference]

> > *1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

> Other than that, I have no objections if this patch makes more shells
> happy and no happy ones unhappy.

> Is your ksh OK with all other tests?

Yes. The only other patch which is applied during our building process
is: 

diff -ur git-1.7.0.3.orig/t/t1304-default-acl.sh
git-1.7.0.3/t/t1304-default-acl
.sh
--- git-1.7.0.3.orig/t/t1304-default-acl.sh     2010-03-22
01:35:03.000000000 +0
000
+++ git-1.7.0.3/t/t1304-default-acl.sh  2010-03-23 19:53:49.069813289
+0000
@@ -9,6 +9,8 @@
 # => this must come before . ./test-lib.sh
 umask 077

+LOGNAME=$(whoami)
+
 . ./test-lib.sh

 # We need an arbitrary other user give permission to using ACLs. root


But it is specific to our build environment.

-- 
  Kacper Kornet
