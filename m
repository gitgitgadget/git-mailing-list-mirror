From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Subject: Re[2]: [PATCH 1/3] Fixes bug: git-diff: class methods are not detected in hunk headers for Pascal
Date: Wed, 5 Jan 2011 14:53:02 +0300
Message-ID: <4510264083.20110105145302@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <201101041813.45053.trast@student.ethz.ch>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 12:52:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaRuv-0000fW-BN
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 12:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1AELwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 06:52:32 -0500
Received: from smtp5.mail.ru ([94.100.176.132]:41489 "EHLO smtp5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab1AELwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 06:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=9sQhzXrgKuojRxLubPfhK7KEgsIWi4P3zpWZcqA0qoE=;
	b=n4Luz7TLyMl/XH83D1EwumeXs9ZhsJN5TGPwsaVhMHRXcslje0GQCoPaHXqrw+shPg6hkFseWzhuC1SdnMab6eLCuhbsloWSctdvqe+X+cz6bIINUPu7eG69KjNe+gvK;
Received: from [85.140.55.58] (port=44529 helo=ppp85-140-55-58.pppoe.mtu-net.ru)
	by smtp5.mail.ru with asmtp 
	id 1PaRun-0003XA-00; Wed, 05 Jan 2011 14:52:29 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <201101041813.45053.trast@student.ethz.ch>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164561>

Hello, Thomas

TR> But the last line very conspicuously already mentions 'class', so w=
hy
TR> does it fail?
Yes, As you already discovered that last line match for class/record
definition but not for class methods.

I did as you said I changed commit message (also included
"Acked-by:"). So should I re-submit patch to the maillist as a new one
or as an answer to this thread?

TR> Zapped wrote:
>> Signed-off-by: Zapped <zapped@mail.ru>

TR> As Junio already said, please provide a real name for the sign-off.
TR> But I also found the commit message and content confusing, probably
TR> because I haven't programmed Pascal for 15 years.

TR> You said

TR>   Fixes bug: git-diff: class methods are not detected in hunk heade=
rs for Pascal

>>  PATTERNS("pascal",
>> -      "^((procedure|function|constructor|destructor|interface|"
>> +      "^(((class[ \t]+)?(procedure|function)|constructor|destructor=
|interface|"
>>               "implementation|initialization|finalization)[ \t]*.*)$=
"
>>        "\n"
>>        "^(.*=3D[ \t]*(class|record).*)$",

TR> But the last line very conspicuously already mentions 'class', so w=
hy
TR> does it fail?

TR> I had to look up a bit of Pascal syntax.  Google helped with

TR>   http://www.freepascal.org/docs-html/ref/ref.html

TR> which answers this.  Also, as stated in SubmittingPatches, we
TR> generally word the messages as stating the behaviour of the changed
TR> version in the present tense.  So a better commit message would be

TR>   userdiff: match Pascal class methods

TR>   Class declarations were already covered by the second pattern, bu=
t
TR>   class methods have the 'class' keyword in front too.  Account for
TR>   it.

TR>   Signed-off-by: =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=9A=D1=
=80=D0=B5=D0=B7=D0=BE=D0=B2 <zapped@mail.ru>

TR> Ok, now I feel silly for only having a two-liner despite my
TR> complaints.

TR> That being said, I have now verified that the patch is good, and, y=
ou
TR> can include my

TR>   Acked-by: Thomas Rast <trast@student.ethz.ch>

TR> in a reroll if you fix the above.
