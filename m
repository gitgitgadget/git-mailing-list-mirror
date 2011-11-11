From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Disappearing change on pull rebase
Date: Fri, 11 Nov 2011 07:56:29 +0100
Message-ID: <4EBCC71D.6000505@viscovery.net>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net> <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com> <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pitucha, Stanislaw Izaak" <stanislaw.pitucha@hp.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 07:56:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROl2U-0000iL-WB
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 07:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1KKG4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 01:56:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6058 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755180Ab1KKG4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 01:56:34 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ROl2M-0000NL-Bd; Fri, 11 Nov 2011 07:56:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1359B1660F;
	Fri, 11 Nov 2011 07:56:29 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185256>

Am 11/10/2011 14:35, schrieb Pitucha, Stanislaw Izaak:
> As mentioned in the original mail - the merge commit did have changes.
> Here's the log of reproducing it. The line containing "2" in changelog
> is gone from master after pull --rebase.
> ...
> disappearing_commit$ git merge --no-ff --no-commit some-branch
> Automatic merge went well; stopped before committing as requested
> disappearing_commit$ echo 2 >> changelog 
> disappearing_commit$ git add changelog
> disappearing_commit$ git commit
> [master e41e4c9] Merge branch 'some-branch'

This is by design. Rebase does not rebase merge commits because it is
assumed that merge commits only do what their name implies - to merge
branches of a forked history. As such, they do not introduce their own
changes. Follow this rule, i.e., make your change in a separate non-merge
commit, and you are fine.

-- Hannes
