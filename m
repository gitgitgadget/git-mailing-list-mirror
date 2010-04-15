From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 08:45:19 +0200
Message-ID: <4BC6B5FF.6030406@viscovery.net>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org> <7vfx2xpyam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 08:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2IpQ-0003B1-Sj
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 08:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab0DOGpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 02:45:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5657 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0DOGpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 02:45:24 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O2IpD-0006Kq-La; Thu, 15 Apr 2010 08:45:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 642061660F;
	Thu, 15 Apr 2010 08:45:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vfx2xpyam.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144952>

Am 4/14/2010 22:35, schrieb Junio C Hamano:
> "git reflog expire" (and "git gc") examines the reflog entries and
> discards old/stale ones using two criteria.  The entries that are older
> than "reflogexpire" (defaults to 90 days) are unconditionally removed, and
> the entries that are older than "reflogexpireunreachable" (defaults to 30
> days) are removed if the entry point at commits that are not reachable
> from the value of the ref.
> 
> This is reasonable for local branches, remote tracking branches and tags.
> You (or other people) may have failed experiments that have been made and
> then later discarded by resetting the tip of the branch back, and setting
> the value of "reflogexpireunreachable" shorter than that of "reflogexpire"
> will prune the entries that describe these failed experiments earlier than
> the entries that describe the steps that led to the current history.
> 
> It however doesn't make much sense for "HEAD" reflog.  When you switch
> between branches, it is normal that the tip of the branch you were on is
> not an ancestor of the branch you have switched to.  Expiring the entries
> that describe what you did while on the previous branch earlier than usual
> does not help.

Does not help what? What is the problem?

-- Hannes
