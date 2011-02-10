From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Thu, 10 Feb 2011 08:46:35 +0100
Message-ID: <4D5397DB.3060609@viscovery.net>
References: <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org> <20110207055314.GA5511@sigill.intra.peff.net> <7vhbcguytf.fsf@alter.siamese.dyndns.org> <20110207195035.GA13461@sigill.intra.peff.net> <20110208100518.GA9505@neumann> <20110209210312.GB2083@sigill.intra.peff.net> <7vipwsomq8.fsf@alter.siamese.dyndns.org> <20110209234621.GA12575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 10 08:46:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnREm-0001bR-Na
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 08:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067Ab1BJHqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 02:46:42 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44328 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1BJHql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 02:46:41 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PnREZ-0005Wj-Sx; Thu, 10 Feb 2011 08:46:36 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 992F01660F;
	Thu, 10 Feb 2011 08:46:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110209234621.GA12575@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166475>

Am 2/10/2011 0:46, schrieb Jeff King:
> The current behavior is:
> 
>   add:    error (and suggest "git add .")
>   add -u: relative
>   add -A: relative
>   add -i: full-tree
>   add -p: full-tree
>   archive: relative
>   checkout: full-tree (e.g., "git checkout -f")[1]
>   checkout-index: n/a (only checks out arguments)
>   clean: relative
>   commit -a: full-tree[2]
>   diff: full-tree
>   diff-files: full-tree
>   grep: relative
>   ls-files: relative
>   ls-tree: relative[3]
>   status: shows full-tree, relative by default, absolute
>           with status.relativePaths
>   reset --hard: full-tree[4]
>   log/show/etc: full-tree[5]
>   blame: error[6]

    rerere forget: relative

It is a destructive command, and the rerere cache is precious, IMO.
Therefore, I'd vote to make 'git rerere forget' without a pathspec an error.

-- Hannes
