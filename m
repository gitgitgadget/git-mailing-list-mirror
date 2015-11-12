From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Thu, 12 Nov 2015 06:27:08 +0100
Message-ID: <5644232C.2060700@web.de>
References: <56428A6A.5010406@ramsayjones.plus.com> <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com> <56437F3F.7050305@ramsayjones.plus.com> <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com> <5643ABF0.5080207@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 06:28:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwkQa-0001a7-K9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 06:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbKLF1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 00:27:44 -0500
Received: from mout.web.de ([212.227.17.12]:49428 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbbKLF1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 00:27:43 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LpNwf-1aZg8D2t7N-00f9DI; Thu, 12 Nov 2015 06:27:20
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <5643ABF0.5080207@ramsayjones.plus.com>
X-Provags-ID: V03:K0:sHxecZ4hTOjjmeNzGmZp57wlDGP9MCpMRwD79Fku1yx5Ylk+fUD
 NMrEwR0Kp3Knl3qcyw5FX5e6D67monxcEubMzxmNXbyyj6t0H1KhNCkddkVaJJvbNvlFsaL
 fPLXcNI4tInt93TkibbU7I6kH1F8zQt9ahPyTeN027DaLFBT/rvzUqKARqIt5NyZfOzFeQN
 58oL3tunD2bU70QpPFu+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tHOr5BACSN0=:AdDMtvt7KLYgC09cYmO/T1
 gIuSP/7+0PKEzq7FkABFgEGtgsTC7kd7odjCpB+QvEngw9mc173Wpc8rpOD8AYOcWTAIiFwKH
 L8l/4R0F6zquN2BosPCP2YLD0QocF31y8CGtckEkCjz+qVW0ixboengpNccaIF3GF477hmSqL
 M7TrjtVD5bYry0p8qSYzxIdPjmunFY/d5gSshZcJWC/ZfxQGzDaXW5euc3hXwOeAL/XKrE0LR
 2oDudLBsRix55AdWUUE087jpiWN7FSEHxQ4rHi6O17UJ4Pl7QpaSJOYVwcoCmb4j6tNFXeANp
 vkvREAlA1RKzyty/Plcwf9ODobKbeGVFfcyBEjXPRo47qliIP7SbZqvwZilFtdVyOuCr+MFDm
 ZVT2NbphKjYruXInAtBnznBnz54o3c8Txu0bfvUX4sL34utyvOlDP5g3bSmdjgjxWDoDDpjB5
 HOH3CIgs+noPPv0jKZ7voZPEGYFEyGcTLO8detQ2PqhDD2YauAlIkZLKEIHmi7+B3MXC9Z21R
 Z5axH+860SA7sca/tKB2oOJKXMRBMvDyS9BrblD/Xf7rLB0Ytw9Qawxndm6Q4sMFk1jkVDX0J
 nOO6AD8t1D/++/fUy+yjISO1iC8v2LwireZb3zhXq4CxYrCbjesoF5I2uUdVqsj3kDiBfKjR6
 /MbrciFQ9w/IT8IxJ5zl+Ap8XP4DzFQ/iPN3Xl6DTm5ZlF/pwuxAtNoRCv3ba/owWaJO8Ws7A
 0VBt81qYrsB8O8VGeNNRiVH1FvOia+PJua/as+4nFvB7/xKPajIxElr13KCQCqYaE4jguSti 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281212>

 >Ah. OK, so %ld for long and %lld for long long, I suppose. Only if you 
have a system that's support it.

Linux does, Windows not.

>Hmm, not that it matters, but I wonder what the PRId64 macro is. ;-)
It's "I64d" for Windows, and "lld" for all Gnu based systems and others,

When you do printf("%lld %ld", long_long_var, long_var),
the "printf runtime" under Windows will treat "%lld" as "%ld", and print
the lower part of long_long_var.
And will not pull a long long from stack, but a long, resulting i all kinds of confusion

So whenever a long long is printed, I can warmly recommend to use

PRId64
