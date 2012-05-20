From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with relative
 origin URLs
Date: Sun, 20 May 2012 02:34:04 +0200
Message-ID: <4FB83BFC.4000702@web.de>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com> <1337402403-7546-2-git-send-email-jon.seymour@gmail.com> <4FB7ECCF.9020403@web.de> <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 02:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVu6m-0001wB-1S
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 02:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab2ETAeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 20:34:13 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35467 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab2ETAeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 20:34:12 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id A343F1AE8D01B
	for <git@vger.kernel.org>; Sun, 20 May 2012 02:34:10 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.152.157]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M57ja-1S9XCR0lbi-00zGxY; Sun, 20 May 2012 02:34:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
X-Provags-ID: V02:K0:NFfLt3dHE/RojUNYRYB/UZp1Xvy1qEEDHewT0ghFQWL
 Ry0OpKNoFNDcxf4TUFDhJf8Uha3z9kzTHcEencFgtWDM/PwU9q
 /RO2Jc6K4egaQiFcBhlMTh264TRvJjXCuFQrR0cyk1sH9BLXqg
 x/WIsI1Z0OSMITvZT4QrlL5m2KSV9+YQ1uqrC2imJfjgopQrSg
 Kulu5rv0Y+Du+CXY5BGsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198047>

Am 20.05.2012 00:51, schrieb Jon Seymour:
> On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 19.05.2012 06:40, schrieb Jon Seymour:
>>
>> Just a small nit: I'd prefer to replace the 4 occurrences of the term
>> "supermodule" with "superproject".
> 
> Sure. I can't argue with precedent, of course, but I guess I was
> favouring the consistency in the suffixes used with sub and super.

No big deal, but in recent posts "superproject" has been used and
the similarity between "supermodule" and "submodule" fooled me when
I read your RFC patch. So even though a superproject might be the a
submodule of another superproject, I'm all for using the term
"superproject" to make the distinction obvious.

>> So no objection on the code changes from my side.
> 
> I noticed one relative case that is not handled properly yet, but
> there is a workaround. If the superproject's origin URL is of the
> form: foo/bar (a case I actually have myself for reasons I can explain
> if you want me to), then the correct rule doesn't get matched by
> .*/*). The workaround is for the user to change foo/bar style origin
> URLs to ./foo/bar.
> 
> Let me know if I should fix this case now too.

Me thinks that this is subject for a subsequent patch. Having the
URL of the superproject *below* the root directory of the
superproject seems like a rather odd case which warrants a fix of
its own ;-)
