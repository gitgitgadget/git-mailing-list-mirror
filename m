From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Tue, 13 Nov 2012 21:51:43 +0100
Message-ID: <50A2B2DF.1080704@web.de>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com> <50A2978D.6080805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Douglas Mencken <dougmencken@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:52:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYNSi-0007mr-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab2KMUvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:51:47 -0500
Received: from mout.web.de ([212.227.15.4]:51925 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab2KMUvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:51:46 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MYw31-1TlJjf0sZX-00VdBm; Tue, 13 Nov 2012 21:51:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <50A2978D.6080805@ramsay1.demon.co.uk>
X-Provags-ID: V02:K0:hx0EB6/1lYyUv1RyFrma+OiYQhFO+qYel1tUVeHu/KD
 40E1g7elikObIYWz24QgPSM8CBAnaQcOSkJdptiDV7FN1+qibn
 thhxlHDUGTd3989yZZSbhOS4ts0a//v6ljqt0OdBCpTVwC+fUp
 91sKCmuPfFhmZmw6ifQrJ0AYOjMLUP8C8F49glMVzomWF4Vlth
 9cwWVsLjqUP1n6+ULj8Bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209674>

On 13.11.12 19:55, Ramsay Jones wrote:
> Douglas Mencken wrote:
>> *Any* git clone fails with:
>>
>> fatal: premature end of pack file, 106 bytes missing
>> fatal: index-pack failed
>>
>> At first, I tried 1.8.0, and it failed. Then I tried to build 1.7.10.5
>> then, and it worked. Then I tried 1.7.12.2, but it fails the same way
>> as 1.8.0.
>> So I decided to git bisect.
>>
>> b8a2486f1524947f232f657e9f2ebf44e3e7a243 is the first bad commit
>> ``index-pack: support multithreaded delta resolving''
> 
> This looks like the same problem I had on cygwin, which lead to
> commit c0f86547c ("index-pack: Disable threading on cygwin", 26-06-2012).
> 
> I didn't notice which platform you are on, but maybe you also have a
> thread-unsafe pread()? Could you try re-building git with the
> NO_THREAD_SAFE_PREAD build variable set?
> 
> HTH.
> 
> ATB,
> Ramsay Jones

This is interesting.
I had the same problem on a PowerPC 
(Old PowerBook G4 running Linux).

Using NO_THREAD_SAFE_PREAD helped, thanks for the hint.
(After recompiling without NO_THREAD_SAFE_PREAD I could clone
from this machine again, so the problem is not really reproducable)

Are there more people running PowerPC (on the server side) ?
/Torsten

 
