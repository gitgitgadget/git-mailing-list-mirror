From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Fri, 15 Jul 2011 23:41:41 +0200
Message-ID: <4E20B415.8030004@web.de>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <1310668419989-6584432.post@n2.nabble.com> <4E2094B4.3090009@web.de> <1F026B57884A5841B330471696849DE9113122B5@MBX021-W4-CA-5.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Marlene Cote <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:41:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhq8q-0007yb-AF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1GOVln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:41:43 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:34726 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab1GOVlm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:41:42 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8257F195839E3;
	Fri, 15 Jul 2011 23:41:41 +0200 (CEST)
Received: from [93.240.112.253] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qhq8j-0001zj-00; Fri, 15 Jul 2011 23:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1F026B57884A5841B330471696849DE9113122B5@MBX021-W4-CA-5.exch021.domain.local>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18LjexNaGb1XWqXk4uKS/wbxQciaBke7cQmJOlF
	DTw6+FCaVs6eDInzExwtDk7l9I+9CuUJUdlKQtSqNplncdxs5U
	iEWpVRJH3/pDwwW/68pw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177237>

Am 15.07.2011 22:32, schrieb Marlene Cote:
> How would you find an appropriate commit?

The same way you resolve conflicts for a regular file: If you are unlucky
and the merge strategy doesn't resolve the conflict for you automatically
(or at least gives you a hint what /could/ be the resolution), you have
to use human judgment to find an appropriate resolution. In most cases
that will be a commit where both conflicting commits show up in the
history (and maybe you'll even have to create one yourself by doing a
proper merge in the submodule).

Where I work we have a simple best practice that guarantees us git will
always find a proper resolution itself: We only record commits that are
on the submodules master branch in the superproject. To put it in other
words: merge the submodule first before you commit in the superproject.
