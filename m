From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Disappearing change on pull rebase
Date: Fri, 11 Nov 2011 11:04:58 +0100
Message-ID: <4EBCF34A.3090908@viscovery.net>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net> <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com> <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net> <4EBCC71D.6000505@viscovery.net> <CAGK7Mr6D6-4aNceTDCYTHabA3vnxh+uvQ=GOeS_3nrL9rjmc9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pitucha, Stanislaw Izaak" <stanislaw.pitucha@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 11:05:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROnz9-00086V-L0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 11:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab1KKKFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 05:05:05 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53378 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1KKKFC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 05:05:02 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ROnyk-0001I1-Q7; Fri, 11 Nov 2011 11:04:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 767861660F;
	Fri, 11 Nov 2011 11:04:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <CAGK7Mr6D6-4aNceTDCYTHabA3vnxh+uvQ=GOeS_3nrL9rjmc9w@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185259>

Am 11/11/2011 10:50, schrieb Philippe Vaucher:
>> This is by design. Rebase does not rebase merge commits because it is
>> assumed that merge commits only do what their name implies - to merge
>> branches of a forked history. As such, they do not introduce their own
>> changes. Follow this rule, i.e., make your change in a separate non-merge
>> commit, and you are fine.
> 
> Doesn't this create a problem if you pull, resolve a conflit but do NOT
> push, then pull --rebase some more commits later on? As I understand
> it, the conflict resolution commit will be a merge commit and will be
> thrown away by the git pull --rebase.

You are correct, but it is not a problem: During the rebase, the same
conflicts will arise as during the merge, and you will be forced to
resolve them before you can complete the rebase. Therefore, nothing will
be lost.

-- Hannes
