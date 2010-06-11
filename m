From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 07:49:41 +0200
Message-ID: <4C11CE75.7080706@viscovery.net>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 07:49:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMx7l-0003KK-TR
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 07:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab0FKFto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 01:49:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26451 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0FKFto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 01:49:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OMx7d-0002lv-LJ; Fri, 11 Jun 2010 07:49:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 603631660F;
	Fri, 11 Jun 2010 07:49:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148925>

Am 6/10/2010 22:48, schrieb Eyvind Bernhardsen:
> Currently, merging across changes in line ending normalization is
> painful since all lines containing CRLF will conflict uselessly.
> 
> Fix ll-merge so that the "base", "theirs" and "ours" files are passed
> through convert_to_git() before a three-way merge.  This prevents
> differences that can be normalized away from blocking an automatic
> merge.

I think you are going overboard here. Normalization should only happen
only for data that moves from the worktree to the database. But during a
merge, at most one part can come from the worktree, methinks; you are
normalizing all three of them, though.

> This patch has already been useful to me, but I'm not sure it is the
> best possible solution to the problem (especially in terms of
> efficiency), hence the RFC.
> 
> Note that clean and ident filters will also be run, which might be a
> good thing.  Also, the tests require my crlf/text series from pu.
> --
> Eyvind

Please do not put a dash-dash-blank line before the patch; Thunderbird
takes it as the beginning of the signature and truncates the message in
the reply.

-- Hannes
