From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 13:42:56 +0200
Message-ID: <4C2344C0.2010402@viscovery.net>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 13:43:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkpq-0006nj-V7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab0FXLnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:43:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44679 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0FXLnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:43:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ORkpc-0001mB-Qf; Thu, 24 Jun 2010 13:42:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 86E811660F;
	Thu, 24 Jun 2010 13:42:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <20100624111757.GB3453@pvv.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149583>

Am 6/24/2010 13:17, schrieb Finn Arne Gangstad:
> Assume you start out with a repo that has a lot of text files with
> CRLF checked in (A).
> 
>   C----
>  /     \
> A---B---D
> 
> B: Add "* text=auto" to .gitattributes and normalize all files to LF
> only in repo
> 
> D: try to merge C
> 
> Without this patch you will get a ridiculous number of lf/crlf
> conflicts when trying to merge C into D, since the repository contents
> for C are "wrong" wrt the new .gitattributes file.

What should happen when you have C checked out (i.e., you do not yet have
the updated .gitattributes in your worktree nor index) and merge B?
Currently, you get the identical conflicts, but I suspect that the patch
does not help in this situation. IOW, it breaks the merge symmetry.

-- Hannes
