From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add testcase for merging in a CRLF repo, showing that
 conflict file is in LF only
Date: Mon, 09 Jun 2008 15:37:41 +0200
Message-ID: <484D3225.3020900@viscovery.net>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 15:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ha4-0004bY-Ae
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 15:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYFINhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 09:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbYFINhq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 09:37:46 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53701 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYFINhp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 09:37:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K5hZ7-00067r-Gz; Mon, 09 Jun 2008 15:37:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 473FB6C4; Mon,  9 Jun 2008 15:37:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <26299.4828321554$1213013668@news.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84382>

Marius Storm-Olsen schrieb:
> An LF only conflict file results in the resolved file being in LF,
> the commit is in LF and a warning saying that LF will be replaced
> by CRLF, and the working dir ends up with a mix of CRLF and LF files.

After reading these 3 lines I've no idea what you are talking about. Can
you translate this to English, please? ;-)

>  Sorry, no patch to actually *fix* the problem.

Then you should use test_expect_failure instead of test_expect_success.
And maybe also mention it in the commit message.

> +test_expect_success 'Check that conflict file is CRLF' '
> +	git reset --hard a &&
> +	! git merge side &&

	test_must_fail git merge side &&

> +	cat file | remove_cr | append_cr >file.temp &&
> +	test_cmp file file.temp
> +'

-- Hannes
