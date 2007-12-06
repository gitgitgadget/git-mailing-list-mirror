From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG/PATCH] git grep shows the same hit repeatedly for unmerged
 paths
Date: Thu, 06 Dec 2007 09:24:25 +0100
Message-ID: <4757B1B9.2050606@viscovery.net>
References: <7vsl2gk7e3.fsf@gitster.siamese.dyndns.org>	<4757A4DD.901@viscovery.net> <7v3auggs8x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 09:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0C2N-0003iy-CS
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 09:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbXLFIY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 03:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbXLFIY3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 03:24:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7418 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbXLFIY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 03:24:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J0C1B-0002tM-VG; Thu, 06 Dec 2007 09:23:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 072C654D; Thu,  6 Dec 2007 09:24:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v3auggs8x.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67270>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Junio C Hamano schrieb:
>>> When the index is unmerged, e.g.
>>>
>>> 	$ git ls-files -u
>>>         100644 faf413748eb6ccb15161a212156c5e348302b1b6 1	setup.c
>>>         100644 145eca50f41d811c4c8fcb21ed2604e6b2971aba 2	setup.c
>>>         100644 cb9558c49b6027bf225ba2a6154c4d2a52bcdbe2 3	setup.c
>>>
>>> running "git grep" for work tree files repeats hits for each unmerged
>>> stage.
>>>
>>> 	$ git grep -n -e setup_work_tree -- '*.[ch]'
>>>         setup.c:209:void setup_work_tree(void)
>>>         setup.c:209:void setup_work_tree(void)
>>>         setup.c:209:void setup_work_tree(void)
>>>
>>> This should fix it.
>> Does this change the behavior of grep --cached? IOW, listing the same hit
>> more than once when --cached is given is a feature, IMHO.
> 
> Yeah, --cached should grep for each stage.  It doesn't?

No, it doesn't. Neither before nor after this change. (I actually thought it
 would without this change, but I obviously was wrong.)

-- Hannes
