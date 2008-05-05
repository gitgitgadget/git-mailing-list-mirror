From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 00/10] Fix git's test suite to pass when the path contains
 spaces
Date: Mon, 05 May 2008 09:03:49 +0200
Message-ID: <481EB155.6050501@viscovery.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Mon May 05 09:05:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsukt-0000IQ-QC
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 09:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222AbYEEHD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbYEEHD7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:03:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34879 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbYEEHD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:03:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jsujm-0007Sl-71; Mon, 05 May 2008 09:03:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D6C4A6D9; Mon,  5 May 2008 09:03:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81235>

Bryan Donlan schrieb:
> This patch series fixes bugs in git and git's testsuite to allow all tests
> to pass when the working directory contains whitespace and/or shell
> metacharacters.

Thanks a lot, it's appreciated.

> Bryan Donlan (10):
>   git-rebase.sh: Fix --merge --abort failures when path contains
>     whitespace
>   config.c: Escape backslashes in section names properly
>   git-send-email.perl: Handle shell metacharacters in $EDITOR properly
>   test-lib.sh: Add a test_set_editor function to safely set $VISUAL
>   Use test_set_editor in t9001-send-email.sh
>   test-lib.sh: Fix some missing path quoting
>   lib-git-svn.sh: Fix quoting issues with paths containing shell
>     metacharacters
>   Don't use the export NAME=value form in the test scripts.
>   Fix tests breaking when checkout path contains shell metacharacters
>   Rename the test trash directory to contain spaces.

The last patch breaks t9400-git-cvsserver-server.sh on my system:

* expecting success: cat request-anonymous | git-cvsserver --strict-paths
pserver $SERVERDIR >log 2>&1 &&
   sed -ne \$p log | grep "^I LOVE YOU$"
* FAIL 9: req_Root (strict paths)
        cat request-anonymous | git-cvsserver --strict-paths pserver
$SERVERDIR >log 2>&1 &&
           sed -ne \$p log | grep "^I LOVE YOU$"

D-Quoting $SERVERDIR helps. ;)

Please post an incremental diff when you resend it. Feel free to add:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
