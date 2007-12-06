From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG/PATCH] git grep shows the same hit repeatedly for unmerged
 paths
Date: Thu, 06 Dec 2007 08:29:33 +0100
Message-ID: <4757A4DD.901@viscovery.net>
References: <7vsl2gk7e3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0BBG-0005GN-Vm
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 08:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbXLFH3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 02:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbXLFH3h
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 02:29:37 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36087 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbXLFH3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 02:29:37 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J0BA5-0001LZ-81; Thu, 06 Dec 2007 08:28:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 30FF354D; Thu,  6 Dec 2007 08:29:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vsl2gk7e3.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67264>

Junio C Hamano schrieb:
> When the index is unmerged, e.g.
> 
> 	$ git ls-files -u
>         100644 faf413748eb6ccb15161a212156c5e348302b1b6 1	setup.c
>         100644 145eca50f41d811c4c8fcb21ed2604e6b2971aba 2	setup.c
>         100644 cb9558c49b6027bf225ba2a6154c4d2a52bcdbe2 3	setup.c
> 
> running "git grep" for work tree files repeats hits for each unmerged
> stage.
> 
> 	$ git grep -n -e setup_work_tree -- '*.[ch]'
>         setup.c:209:void setup_work_tree(void)
>         setup.c:209:void setup_work_tree(void)
>         setup.c:209:void setup_work_tree(void)
> 
> This should fix it.

Does this change the behavior of grep --cached? IOW, listing the same hit
more than once when --cached is given is a feature, IMHO.

-- Hannes
