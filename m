From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Thu, 21 May 2015 20:45:18 +0100
Organization: OPDS
Message-ID: <3516DC60279A42188EE2AA394921FC70@PhilipOakley>
References: <20150521041435.GA18978@peff.net> <20150521041619.GC5196@peff.net> <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 21:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvWPE-0006vl-5r
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbbEUTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 15:45:19 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:15479 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755385AbbEUTpS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 15:45:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DHEAB7NF5VPF4aFlxcgxCBMoZNbcMnBAQCgU1NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQEDCAEBLh4BASELAgMFAgEDFQMJJRQBBBoGBwMUBgEJCQgCAQIDAYgGAxa1PZ0+ASuLOoJNgjiDHoEWBYwChnh4oSyBBIMYPTGCRwEBAQ
X-IPAS-Result: A2DHEAB7NF5VPF4aFlxcgxCBMoZNbcMnBAQCgU1NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQEDCAEBLh4BASELAgMFAgEDFQMJJRQBBBoGBwMUBgEJCQgCAQIDAYgGAxa1PZ0+ASuLOoJNgjiDHoEWBYwChnh4oSyBBIMYPTGCRwEBAQ
X-IronPort-AV: E=Sophos;i="5.13,471,1427756400"; 
   d="scan'208";a="681721771"
Received: from host-92-22-26-94.as13285.net (HELO PhilipOakley) ([92.22.26.94])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 21 May 2015 20:45:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269650>

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> Hi Peff,
>
> On 2015-05-21 06:16, Jeff King wrote:
>
>> diff --git a/Documentation/git-clone.txt 
>> b/Documentation/git-clone.txt
>> index f1f2a3f..ffeb03b 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -107,6 +107,9 @@ objects from the source repository into a pack in
>> the cloned repository.
>>  transfer and stop borrowing from them after a clone is made
>>  by making necessary local copies of borrowed objects.
>>
>> +--seed <repository>::
>> + A convenient shorthand for `--dissociate --reference=<repository>`.
>> +
>
> Since you want to advertise this as an easier way than 
> `--dissociate --reference=<repository>`, it might make sense to avoid 
> sending the reader that way, too.
>
> Maybe something like
>
> --seed <repository>::
>    Fetch objects from <repository> instead of the clone URL when 
> possible. This is useful when a (possibly partial) clone already 
> exists locally, to avoid transferring the same objects again.
>

Would it be worth mentioning here that a bundle is a satisfactory 
alternative to repository?

+--seed <repository|bundle>::
+    Fetch objects from <repository> or <bundle> instead of the clone 
URL when possible. This is useful when a (possibly partial) clone 
already exists locally, to avoid transferring the same objects again.

I haven't checked if the invocation would accept a bundle filename, but 
I'm presuming it can in the same way that clone does.

--
Philip 
