From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Thu, 5 Sep 2013 23:20:51 +0100
Organization: OPDS
Message-ID: <926222C46F2240BDA71A004633E8DB7E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 00:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHhuw-0001Bl-TE
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 00:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab3IEWUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 18:20:41 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:24269 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753588Ab3IEWUk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 18:20:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0LAGwCKVJOl3GZ/2dsb2JhbABbgweJbrhbBAQBgSoXdGgBAYEfAQEUAQQBAQ0BAR0RHgEBIQsCCAIBAw4DAwEBAQo5AQQaBgcPDgoJCAIBAgMBhTgHAYISI6B9mXOOFYFLgySBAAOIfYYSmkyBY4E+O4Es
X-IPAS-Result: Av0LAGwCKVJOl3GZ/2dsb2JhbABbgweJbrhbBAQBgSoXdGgBAYEfAQEUAQQBAQ0BAR0RHgEBIQsCCAIBAw4DAwEBAQo5AQQaBgcPDgoJCAIBAgMBhTgHAYISI6B9mXOOFYFLgySBAAOIfYYSmkyBY4E+O4Es
X-IronPort-AV: E=Sophos;i="4.90,849,1371078000"; 
   d="scan'208";a="84369057"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with SMTP; 05 Sep 2013 23:20:38 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233997>

From: "Philip Oakley" <philipoakley@iee.org>
Sent: Saturday, August 31, 2013 11:16 PM
> From: "Christian Couder" <chriscool@tuxfamily.org>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> Documentation/git-replace.txt | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-replace.txt 
>> b/Documentation/git-replace.txt
>> index 736b48c..a2bd2ee 100644
>> --- a/Documentation/git-replace.txt
>> +++ b/Documentation/git-replace.txt
>> @@ -21,10 +21,12 @@ replaced. The content of the 'replace' reference 
>> is the SHA-1 of the
>> replacement object.
>>
>> The replaced object and the replacement object must be of the same 
>> type.
>> -There is no other restriction on them.
>> +This restriction can be bypassed using `-f`.
>>
>> Unless `-f` is given, the 'replace' reference must not yet exist.
>>
>> +There is no other restriction on the replaced and replacement 
>> objects.
>
> Is this trying to allude to the fact that merge commits may be 
> exchanged with non-merge commits? I strongly believe that this ability 
> to exchange merge and non-merge commits should be stated _explicitly_ 
> to counteract the false beliefs that are listed out on the internet.
>
> It's probably better stated in a separate patch for that explicit 
> purpose to avoid mixed messages within this commit.
>

Not sure how this method of preparing a comment patch will pan out..

--->8----
From a0c0e765cfd969c9c8a6ff3a2cb6b2f1391d2e7d Mon Sep 17 00:00:00 2001
From: Philip Oakley <philipoakley@iee.org>
Date: Thu, 5 Sep 2013 22:54:04 +0100
Subject: [PATCH] Doc: 'replace' merge and non-merge commits

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

This is supplemental to Christian Couder's 'replace' patch series
(2013-09-03 69dada4 (Christian Couder): t6050-replace: use some long
option names).

It adds the clarification that merge and non-merge commits are
replaceable.

Merges are often treated as special case objects so tell users that they 
are not special here.

---
 Documentation/git-replace.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-replace.txt 
b/Documentation/git-replace.txt
index 414000e..f373ab4 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -26,6 +26,7 @@ This restriction can be bypassed using `-f`.
 Unless `-f` is given, the 'replace' reference must not yet exist.

 There is no other restriction on the replaced and replacement objects.
+Merge commits can be replaced by non-merge commits and vice versa.

 Replacement references will be used by default by all Git commands
 except those doing reachability traversal (prune, pack transfer and
-- 
1.8.1.msysgit.1
