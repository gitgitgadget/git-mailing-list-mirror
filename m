From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Rebasing multiple branches
Date: Tue, 21 Dec 2010 15:06:05 +0100
Message-ID: <4D10B44D.5090309@viscovery.net>
References: <4D10AE5B.2080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Leonid Podolny <leonidp.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 15:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV2r1-0003Fb-QE
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 15:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab0LUOGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 09:06:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29856 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751800Ab0LUOGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 09:06:09 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PV2qs-0000e2-FK; Tue, 21 Dec 2010 15:06:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3525B1660F;
	Tue, 21 Dec 2010 15:06:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D10AE5B.2080700@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164034>

Am 12/21/2010 14:40, schrieb Leonid Podolny:
>         B--o--o--o--o--o--o  <--branch A
>        /                   \
> o--o--A--o--E  <--master    C--o--o--o--D  <--branch C
>        \                   /
>         C--o--o--o--o--o--o  <--branch B
> 
> I would like to rebase all three branches A, B and C onto commit E,...

git rebase master A
git rebase master B
git merge A
git rebase -i HEAD C

The last rebase I propose as interactive so that you can remove those
commits before D~3 that you have already rebased, because they are likely
to conflict unnecessarily, and you would --skip them anyway.

(Note: "C" is the branch C, not the commit C. Please make labels
unambiguous next time.)

-- Hannes
