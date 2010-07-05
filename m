From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing
 list argument to for loop
Date: Mon, 05 Jul 2010 08:19:26 +0200
Message-ID: <4C31796E.9050109@viscovery.net>
References: <80typu1ozt.fsf@tiny.isode.net> <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil> <4C30D4D5.3020900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com, Brandon Casey <drafnel@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 08:19:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVf1l-000309-2H
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 08:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0GEGTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 02:19:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56350 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab0GEGTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 02:19:30 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OVf1b-0006Ug-5M; Mon, 05 Jul 2010 08:19:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 328271660F;
	Mon,  5 Jul 2010 08:19:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <4C30D4D5.3020900@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150244>

Am 7/4/2010 20:37, schrieb Michael J Gruber:
> Brandon Casey venit, vidit, dixit 02.07.2010 20:50:
>> In this case, the for loop in the Makefile expands to look like this:
>>
>>    for p in ; do
>>
>> and ksh complains like this:
>>
>>    /bin/ksh: syntax error at line 15 : `;' unexpected
>>
>> The existing attempt to work around this issue, introduced by 70b89f87,
>> tried to protect the for loop by first testing whether REMOTE_CURL_ALIASES
>> was empty, but it does not seem to work.  So adopt Bruce Stephens's
> 
> What does that mean? Either it works or it doesn't. I did work back
> then. Does it (i.e.: the test for emtyness) fail to work for certain shells?

Before the test for emptyness can happen, the complete statement must be
parsed, but ksh finds a syntax error in the statement and, therefore,
cannot even begin to execute the statement. (ksh doesn't follow POSIX in
this regard, where this would not be a syntax error.)

-- Hannes
