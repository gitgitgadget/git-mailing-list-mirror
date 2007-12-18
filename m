From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] filter-branch: Remove broken and unnecessary summary
 of rewritten refs.
Date: Tue, 18 Dec 2007 12:21:18 +0100
Message-ID: <4767AD2E.4040906@viscovery.net>
References: <1197963047-15930-1-git-send-email-johannes.sixt@telecom.at> <7vejdk1g3h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 12:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4aWA-0008UJ-L8
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 12:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbXLRLVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 06:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbXLRLVX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 06:21:23 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14561 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbXLRLVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 06:21:22 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4aVy-0007ei-R5; Tue, 18 Dec 2007 12:21:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A060D54D; Tue, 18 Dec 2007 12:21:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vejdk1g3h.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68732>

Junio C Hamano schrieb:
> Sounds sensible.  Applied.

It seems lately I can't get a thing right on the first try. Would you please
squash this in as long as you haven't pushed out the commit? $count is
now unused.

Thank you!

--- >8 ---

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index e730897..f8bdc14 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -342,7 +342,6 @@ done < "$tempdir"/heads

 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-count=0
 echo
 while read ref
 do
@@ -380,7 +379,6 @@ do
 	;;
 	esac
 	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1
-	count=$(($count+1))
 done < "$tempdir"/heads

 # TODO: This should possibly go, with the semantics that all positive given
