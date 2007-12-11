From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 10:20:55 +0100
Message-ID: <475E5677.9090507@viscovery.net>
References: <20071204130922.731c407a@pc09.procura.nl>	<Pine.LNX.4.64.0712041343040.27959@racer.site>	<20071204140326.14d9e7a0@pc09.procura.nl>	<Pine.LNX.4.64.0712041439590.27959@racer.site>	<20071204150102.7f3ec3e9@pc09.procura.nl> <47556EE2.6040105@op5.se>	<20071204152240.6cb6018e@pc09.procura.nl>	<Pine.LNX.4.64.0712041536180.27959@racer.site>	<20071204155655.053f4fb4@pc09.procura.nl>	<7vve7e49or.fsf@gitster.siamese.dyndns.org>	<20071210145123.7c34af6d@pc09.procura.nl> <7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 11 10:21:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J21Iw-000068-VJ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 10:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbXLKJVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 04:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXLKJVF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 04:21:05 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3861 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbXLKJVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 04:21:03 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J21HX-0001Tr-Rs; Tue, 11 Dec 2007 10:20:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 742D5546; Tue, 11 Dec 2007 10:20:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67828>

Junio C Hamano schrieb:
> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
>> 3 I am willing to believe that HP_UX' vsnprintf () is broken, or
>>   at least does not conform to the expectations in the GNU world,
>>   but chickening out like the way strbuf_addf () does is maybe a
>>   bit too rude, so I forced a minimum of 64bytes available. That
>>   fixes a lot!
>>
>>   but it still breaks t4013 :(
> 
> I think Shawn had something similar for Solaris, and if it is a small
> cost to help portability, it does not feel so bad.

Windows's vsnprintf() is broken in two regards: (1) It returns -1 if the
buffer is too small; (2) the size parameter is not the size of the buffer,
but the max. number of chars to write (i.e. does not count the NUL). How
broken is HP-UX's? Maybe we can share the implementation? See:

http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=5fd41ffacdef5454acbe51f5e23a97eb5158226d
http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=e88aa8cbe816526bb0a7d37eaf2f5eb40ff36ae1

-- Hannes
