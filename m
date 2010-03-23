From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 17:20:58 +0100
Message-ID: <4BA8EA6A.4030607@viscovery.net>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>	 <1269353235.14299.0.camel@kheops>	 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>	 <1269354326.14299.7.camel@kheops> <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: sylvain@abstraction.fr, git@vger.kernel.org,
	howard@e-learndesign.co.uk
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 17:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu6qt-0005pY-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 17:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0CWQVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 12:21:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52100 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752665Ab0CWQVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 12:21:04 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nu6qh-0000eq-Ew; Tue, 23 Mar 2010 17:20:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 277E11660F;
	Tue, 23 Mar 2010 17:20:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143029>

Am 3/23/2010 17:05, schrieb Scott Chacon:
> Why would we teach someone to do that instead of just recommending the
> far less obscure 'git push -f'?  A leading '+' on the refspec is
> ridiculously confusing compared to "just tell it to force the push
> with -f".  Am I forgetting something?

-f is dangerous. I was once bitten badly by a hastily typed

   git push -f repo

that pushed two branches instead of only one: One needed an urgent update
(that was the good one), but it also pushed the other one, which was not
yet prepared for publication.

By teaching the +refspec form, you force the user to be careful which
branch is rewound. Yes, you can still say +refs/heads/*, but if you do
that, you are much more explicit than with "push -f repo", where the
affected branches are hidden in the config file.

-- Hannes
