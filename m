From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sun, 17 Jun 2012 20:30:42 +0200
Message-ID: <4FDE2252.5030802@kdbg.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> <7vwr38bmj5.fsf@alter.siamese.dyndns.org> <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net> <7vd34z96lv.fsf@alter.siamese.dyndns.org> <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net> <7vmx427aj0.fsf@alter.siamese.dyndns.org> <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Jun 17 21:00:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgKhz-0002Kx-Br
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 21:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832Ab2FQTAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 15:00:18 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:32844 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757703Ab2FQTAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 15:00:17 -0400
X-Greylist: delayed 1769 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2012 15:00:17 EDT
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by lbmfmo03.bon.at (Postfix) with ESMTP id EE428CE08C
	for <git@vger.kernel.org>; Sun, 17 Jun 2012 20:31:11 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 77B12130053;
	Sun, 17 Jun 2012 20:26:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CCAAE19F6F9;
	Sun, 17 Jun 2012 20:30:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200127>

Am 17.06.2012 15:46, schrieb David Kilzer:
> If it could be guaranteed that all changes in a merge commit would be
> preserved when running "git rebase -i -p" with rerere.autoupdate
> enabled, I think that would be an argument for not returning control
> to the user during the rebase operation.  However, changes to
> non-conflicted files in a merge commit are currently lost in this
> case, so it would be too dangerous to enable this behavior now.

You can test this patch:

  git://repo.or.cz/git/mingw/j6t.git preserve-merges-by-cherry-pick

I think it suits you needs unless you run into the one use-case where
the patch is a regression (as documented by the new test_expect_failure
in the test suite).

-- Hannes
