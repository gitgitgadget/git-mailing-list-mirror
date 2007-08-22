From: David Jack Olrik <david@olrik.dk>
Subject: Re: [PATCH] Fixed non portable use of expr, and incorrect use of test -eq for string comparison.
Date: Wed, 22 Aug 2007 14:30:03 +0200
Message-ID: <9E40DAA3-69E5-417C-8041-E1980E42DB60@olrik.dk>
References: <11877841633473-git-send-email-david@olrik.dk> <20070822122140.GB11926@informatik.uni-freiburg.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 14:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INpLh-0002FF-Q1
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 14:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbXHVM3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 08:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758400AbXHVM3s
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 08:29:48 -0400
Received: from barcrawl.dk ([149.6.48.213]:57931 "EHLO mail.barcrawl.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758390AbXHVM3s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 08:29:48 -0400
Received: from localhost (barcrawl.dk [149.6.48.213])
	by mail.barcrawl.dk (Postfix) with ESMTP id 40AFA7CB44C;
	Wed, 22 Aug 2007 14:29:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.wange.dk
Received: from mail.barcrawl.dk ([149.6.48.213])
	by localhost (barcrawl.dk [149.6.48.213]) (amavisd-new, port 10024)
	with ESMTP id JfoNnvU26AwI; Wed, 22 Aug 2007 14:29:48 +0200 (CEST)
Received: from [IPv6:::1] (barcrawl.dk [149.6.48.213])
	by mail.barcrawl.dk (Postfix) with ESMTP id DB7567CB447;
	Wed, 22 Aug 2007 14:29:47 +0200 (CEST)
In-Reply-To: <20070822122140.GB11926@informatik.uni-freiburg.de>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56374>


On 22/08/2007, at 14.21, Uwe Kleine-K=F6nig wrote:

> David Jack Olrik wrote:
>> -	if test "`expr index $httpd_only /`" -eq '1' || \
>> +	if test "`echo $httpd_only | cut -c 1`" =3D '/' || \
>>  				which $httpd_only >/dev/null
>
> I wonder why not use:
>
> 	if expr "z$httpd_only" : "z/" >/dev/null

You'd then need to check against 2 instead of 1, which I find less
obvious as we are testing for a '/' at the begining of the string.

--=20
Best regards,
David Jack Olrik <david@olrik.dk>             http://david.olrik.dk
GnuPG fingerprint C290 0A4A 0CCC CBA8 2B37 E18D 01D2 F6EF 2E61 9894
["The first rule of Perl club is  You do not talk about Perl club"]
