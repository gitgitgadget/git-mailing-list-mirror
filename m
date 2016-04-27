From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Apr 2016, #07; Mon, 25)
Date: Wed, 27 Apr 2016 14:56:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604271454250.2896@virtualbox>
References: <xmqqoa8xia1j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:56:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avP1P-0003TG-GP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 14:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbcD0M4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 08:56:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:54191 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbcD0M4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 08:56:40 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mh5h7-1bHjDh1x5t-00MLKP; Wed, 27 Apr 2016 14:56:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoa8xia1j.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9hnSa6Ew/FpGLiy3wXW8TSGcue06o5EJCAf8XjBV6mW+e9XgwqD
 soeDWiZp+1I0NvWHDFG1wzojbIsNAVAH/ps19eFIVVMxOGTJJheutj3bx4P/zNrHxUWxR2w
 zfGwDY4Bk5aGXMr5nlJ0J9t5QNdHsNJBXie6irk/2hlJ52EsDWM8r95Q+Ku/54ToE9UizkQ
 EUb/O5AY5bZoOmaUU84ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7pyjtX4cHk8=:zpCax8R9TQkh3uTgU3ZpnY
 wl8RNtoYQDqhPRTvtqWBLoO2tBdPbxTdGSyCcy1nqnmSxXvFis83LRKLl/XJJLY9f94NYNrBe
 +BVdaXUN7Y/6BJ+HejHYRkEfJ2LIFX0okrBuU4fFNE1u6VOIiuKThVZWFpgQ0Mxtp9OP9mapk
 ju9FKgRnhAzq+fb5BE7uWhEDSkPJInnm7/chMlL8mb2/q6ZtsnyyQQHtLocdELGzlbpO71vrp
 JtHXRMGpB7Ng7/vnJm8VSB4kRMDT65ngrvvJ693cZZ9qOXacKYIja9lf/ft25crYdKvC9PkKy
 FpZpMC8z/d7TSrq2DO+Yq0uypPI8DG4p/ib+Gfzy0SMPNkaHqQbrZNRRHvt2PB+4Hr4im/pny
 hPHCt0A3aD/cO25NOr4PsTAz1bG4CxUH6Ylz9Gsmx90XTBulSS6A6DEUKsaUgh1WDn390elTs
 bmwukkqGl1gD7NJfLC+X4kDD0GDhqo8lWTNAuUDUsW/H/U0f91MDtxZIyDkL0tPcmsllKR++l
 o33NYXgEK9U4hBGk+69b8IiAxt23FvzSwvrgAvqqxwOsgcuZsjJ1Ybb5uzfMc6tz0LNu03A7t
 zvG1d8EvUdcUrNiCY3FOvQSi9OZRepn0D0FLr4TbM8dC1oaU5DgZORucEK1lkhV4xxkx4b5QH
 OWAQC8N9SF75PbN8VN3dqbnx1iwqyUh95OPmE7qIryg9usu5/DIag191qKXLMazGSnDf9eVr1
 mCCYN1fe60h0kuF9Ot5y35IbpALzAweuoKMjyUhQhSAoSsphBgK7iO2mw2gHDKs/qMl8ibt+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292722>

Hi Junio,

On Mon, 25 Apr 2016, Junio C Hamano wrote:

> * js/win32-mmap (2016-04-22) 3 commits
>   (merged to 'next' on 2016-04-22 at cd39c60)
>  + mmap(win32): avoid expensive fstat() call
>  + mmap(win32): avoid copy-on-write when it is unnecessary
>  + win32mmap: set errno appropriately
> 
>  mmap emulation on Windows has been optimized.

Please note that it is not purely an optimization. It is also a bug fix in
case of a pretty full disk: on Windows, mmap() is backed by the page file
if it is in copy-on-write mode, and that can fail when the free space on
the drive that has the page file drops below a certain threshold.

Thanks,
Dscho
