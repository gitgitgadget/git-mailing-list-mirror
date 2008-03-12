From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: git latest master: a6828f536119c3288b0be772e3870f1a464d017d -- error in t3404-rebase-interactive.sh on Solaris
Date: Wed, 12 Mar 2008 10:17:31 -0400
Message-ID: <8ec76080803120717p13ee91a8o96934070c4589a9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 15:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZRma-0006up-UD
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 15:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYCLORh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 10:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbYCLORh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 10:17:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:62284 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYCLORg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 10:17:36 -0400
Received: by wr-out-0506.google.com with SMTP id 50so1936655wra.13
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=sDY+3K/RdBIvhiiyqNGKDJL4k1llCUWlG22o7S3K8fM=;
        b=b0Hc1xt5/CNQjXySaLWsYnc5aU4rvvvG0ZXioX5wzxFW0ovADwSc2J+inC8jHAJZ0nHCTxIul5wV2WwaKDvXCgTNMBQBfAZpu26UnI5vT8CGCESUXsA5rPRT88uSlq5nu097KJZzlRLNLlC9I/DuwcvBI6uIaPR2zoEL95oT8sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=wI0XqQTq3/TMDuTRPqUZhN4XLiHod/OwpQsmq7J9UQzlZpC+37ndLx0uGDWLXpJZNNddIaNuFQYu7fCijxNv25gQaI5i3M3f5tlOXYFw5g009ndINxKb7LfHpQti6cR/OF8Taco017gy3H5dqdZsHWmsB5ynPq1Ee4xcNwGzzok=
Received: by 10.141.67.21 with SMTP id u21mr5110306rvk.222.1205331451460;
        Wed, 12 Mar 2008 07:17:31 -0700 (PDT)
Received: by 10.141.201.19 with HTTP; Wed, 12 Mar 2008 07:17:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76951>

looks like the grep located in /usr/bin has a problem.  When I put the
XPG4 earlier on my bath than /usr/bin this test passes.  So, this is
not strictly a bug, but I'm sure a lot of Solaris users out there have
/usr/bin earlier than XPG4, so it's probably something you should be
aware of.


Created commit cac536e: I
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file6
*   ok 1: setup

* expecting success:
        git rebase -i F &&
        test $(git rev-parse I) = $(git rev-parse HEAD)

grep: illegal option -- q
grep: illegal option -- e
Usage: grep -hblcnsviw pattern file . . .
Nothing to do
* FAIL 2: no changes are a nop

                git rebase -i F &&
                test $(git rev-parse I) = $(git rev-parse HEAD)

xs5-trd-p1.grn:warmstro>

-Whit
