From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 14:53:03 +0100
Message-ID: <475E963F.3000804@viscovery.net>
References: <20071204130922.731c407a@pc09.procura.nl>	<Pine.LNX.4.64.0712041343040.27959@racer.site>	<20071204140326.14d9e7a0@pc09.procura.nl>	<Pine.LNX.4.64.0712041439590.27959@racer.site>	<20071204150102.7f3ec3e9@pc09.procura.nl>	<47556EE2.6040105@op5.se>	<20071204152240.6cb6018e@pc09.procura.nl>	<Pine.LNX.4.64.0712041536180.27959@racer.site>	<20071204155655.053f4fb4@pc09.procura.nl>	<7vve7e49or.fsf@gitster.siamese.dyndns.org>	<20071210145123.7c34af6d@pc09.procura.nl>	<7vfxy9fxh3.fsf@gitster.siamese.dyndns.org> <20071211143323.27c860db@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, arjen@yaph.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J25YB-0006RZ-BO
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbXLKNxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 08:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbXLKNxI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:53:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21039 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbXLKNxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 08:53:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J25Wt-0000up-Qu; Tue, 11 Dec 2007 14:52:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2B712546; Tue, 11 Dec 2007 14:53:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071211143323.27c860db@pc09.procura.nl>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67856>

H.Merijn Brand schrieb:
> I have put the output of
> 
> % make -i test | & perl -ne'm/^\*\s+ok\s+\d+:/ or print' > git-make-test.log
> 
> on http://www.xs4all.nl/~procura/git-make-test.log
> 
> which leaves only the following tests as failures:
> 
> t3901-i18n-patch.sh        t4201-shortlog.sh            t5100-mailinfo.sh
> t5405-send-pack-rewind.sh  t5500-fetch-pack.sh          t5505-remote.sh
> t5510-fetch.sh             t5515-fetch-merge-logic.sh   t5516-fetch-push.sh
> t5520-pull.sh              t5600-clone-fail-cleanup.sh  t5700-clone-reference.sh
> t5701-clone-local.sh       t6002-rev-list-bisect.sh     t6003-rev-list-topo-order.sh
> t6022-merge-rename.sh      t6026-merge-attr.sh          t6200-fmt-merge-msg.sh
> t7003-filter-branch.sh     t9300-fast-import.sh         t9301-fast-export.sh
> t9500-gitweb-standalone-no-errors.sh
> 
> How close am I to success?

There are a number of tests that pass only if you have iconv, most notably
t3901 and t5100. pull, clone, merge, filter-branch are shell scripts with
plenty of opportunities to stumble over incompatible/unportable constructs.

-- Hannes
