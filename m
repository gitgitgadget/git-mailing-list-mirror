From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Tue, 08 Apr 2014 11:03:50 +0200
Message-ID: <5343BB76.2000806@web.de>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com> <533FCA92.8060006@kdbg.org> <5342EFD4.6020007@kdbg.org> <5342FFB4.3000200@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Stefan Zager <szager@chromium.org>,
	=?UTF-8?B?VG9ycw==?= =?UTF-8?B?dGVuIELDtmdlcnNoYXVzZW4=?= 
	<tboegi@web.de>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 08 11:04:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXRx9-00012N-OO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 11:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbaDHJET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 05:04:19 -0400
Received: from mout.web.de ([212.227.17.12]:65144 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbaDHJER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 05:04:17 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MN4K8-1We1Wn1O7E-006dyr; Tue, 08 Apr 2014 11:04:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <5342FFB4.3000200@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:g0GK2UBXGfQrKkZnEjW3OBvkb5C7kHhZ774yDton3dKt/woYlPa
 hrpaIac/sWHQz4igeOOjqWqm5B+q7SxHI/fUWUF5X8IOlQIBxl0rhdyPSs2/f4uCLlKaLgD
 LZvj/wDTANFdHc+eHsB9HSQb5LpfWaEaosJfqVZKwDPZYdWWxhdPbclXWFhXhuNfVejHdhr
 lbaRnQGAkZkvJ8gBnvSnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245920>

On 04/07/2014 09:42 PM, Ramsay Jones wrote:
> On 07/04/14 19:35, Johannes Sixt wrote:
>> Am 05.04.2014 11:19, schrieb Johannes Sixt:
>>> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>>>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>>>   - Enable index-pack threading in msysgit.
>>>>
>>>>   What is the status of this topic?  A failure report exists
>>>>   ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>>>   where the discussion stalled.  Is everybody waiting for everybody
>>>>   else to get the discussion unstuck?
>>> I still have to cross-check Duy's patch. I'll hopefully get to it in the
>>> next days and report back.
>> The test suite passes with Duy's patch ($gmane/245034), but t5302 fails
>> with this patch with a MinGW build. The patches touch the Cygwin
>> configuration, but I cannot test a Cygwin build.
> I haven't tested these on cygwin yet. However, only the old version of
> cygwin is affected (newer cygwin has a thread-safe pread) and, since I
> no longer have an old installation, I _can't_ test it anyway. :(
> (I updated cygwin earlier today and received a brand new cygwin dll
> with today's date!).
>
>> I have, however, lost track of what the objective of these patches is.
>> Is the threaded version significantly faster, and these patches are
>> worth it?
> Indeed. I haven't seen any numbers.
>
> ATB,
> Ramsay Jones
>
CYGWIN:
I managed to test under cygwin 1.7, commit 
03d9d2990b718ef6d859405af399f549c186b4d:
Test was OK.

MINWW: t5302 failed (same what Johannas reported)
  After reverting 9d66f2d97a97e08ae8d7c86 t5302 passed under MINGW

HTH
/Torsten
