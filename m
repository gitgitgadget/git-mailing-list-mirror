From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Advices to imlement update hook
Date: Wed, 09 Feb 2011 17:38:18 +0100
Message-ID: <4D52C2FA.2030103@viscovery.net>
References: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 17:38:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnD3k-0000Cp-Nl
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 17:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab1BIQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 11:38:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14703 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752586Ab1BIQiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 11:38:23 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PnD3b-0001u2-M5; Wed, 09 Feb 2011 17:38:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2B3E31660F;
	Wed,  9 Feb 2011 17:38:19 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166429>

Am 2/9/2011 17:27, schrieb Francis Moreau:
> Hi !
> 
> I'd like to restrict access to one of my repos: the project tracked by
> it has several directories: a/ b/ c/ and I'd like to allow only
> modifications happen in b/ directory.
> 
> I'm planning to use git hooks, not sure which one I should use: if the
> check should happen at the commit or push time or both.
> 
> For now I'm going to use the update hook, so it will happen when pushing.
> 
> Now the question is: what is the best way to do this ?
> 
> I'm planning to use something equivalent to "git-diff-tree oldref
> newref | { grep -v b || exit 1; }" but doesn't look like the best git
> way.
> 
> BTW, from the git-diff-tree manpage:
> 
> 	<path>...
> 	    If provided, the results are limited to a subset of
> 	    files matching one of these prefix strings. i.e., file
> 	    matches /^<pattern1>|<pattern2>|.../ Note that this
> 	    parameter does not provide any wildcard or regexp
> 	    features.
> 
> What does it mean exactly ? what does 'pattern' word mean if wildcard
> or regexp is not supported ?
> I also tried:
> 
>    git diff-tree <oldref> <newref> -- ^b || exit 1
> 
> but it doesn't work.

  git diff-tree --quiet <oldref> <newref> -- b
