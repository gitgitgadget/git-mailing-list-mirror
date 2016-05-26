From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to
 the end?
Date: Thu, 26 May 2016 10:54:06 +0200
Message-ID: <5746B9AE.5050307@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <xmqq7fej5njv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 10:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5r3k-0003nu-2E
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 10:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbcEZIyX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 04:54:23 -0400
Received: from mout.web.de ([212.227.15.4]:59217 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbcEZIyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 04:54:21 -0400
Received: from [192.168.178.36] ([79.237.57.138]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Mf0W1-1avAlD1DD7-00OYKJ; Thu, 26 May 2016 10:54:14
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqq7fej5njv.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:0mlrAaEG0nFjWqdb0lUx5B2/35s0BlQ6k7o6l/2yGpMMwFPjRF+
 +KDz9jrtBnMyr1RUpwfD8uhWN+Uy/l6KXZSZNi7h6A0ojRV7M/pcvck0nknardLHYwwI/iY
 c5FAQIXbxRU1UAVjJq7nlFcKnOvxN/qPm568Tq63SIx970MBMn8YVzkNV3JwcvdtBV4ZEyD
 FQ7xcAs9wHqBCueJc68sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+59fI9KfunI=:55s/z6KNFNJU3E660nfVWC
 KhhWWqTTiLw3XZplQJh+/3mwCIMGspc/J+q6YUjoNiXAbg5l77l9vv2QbvHox3cbOaabXG2be
 Jbqqnc+TNQWJJi/z4+zEJ0akQ6Sj7yKcnyFNLWhRnPZjBtPtkxuqJNooOZzcXiTA3aPRD41zI
 gPC0tyzyHAbrWk5J1r7xtCayGDm87r82HnWR1NoKrpBx8wuhanIV69PQyI/u8onLAomZi+wsI
 WP+BibQjYx1905E3gpIYLUwo41SlfQJ5R8S4Iz16Kf5m7/gOKeIOywM3qnmjtxAi/9qg0RWYr
 ptTaZLk5SNIVZfuwTdc+ijqNSiT4JIq4EY4OtZ84jx0kRmD9hxH0yM7fYAey7VArcdCyWcO7D
 cy3of9gShHqcGoZL4Ccyn7YZxr1vY3J83UJDkLBEmlDgHjsenmgaWTlc25IAaNOARiARRRDli
 qZnReBxnJX6m3q83RhSDFEZx8vLOoqa1npZVrzPYahmB8MprQ7ehkCPMdHgXmJWWHk3oi+zBj
 9d8jG123jHvmIdHQwD7aK6VckbxYBGAYKT93vIuU0Am1O5rjNiAlUiNQRmBhzbIcA5RLn3WFm
 NOvukyL7b4QnOi2hERHV0fHfC2UR19MVa9qJGLy+NqQNDPbPjPYyBqPAwco8VfZxtyi5KZ0Qn
 +dWcITHeMaS3HI4/Lhp4iMVO/IQRjRFlqpd5gAFBWZfIW/M2TASeeXW0FcBBw7rm+jnRLTXgY
 dDcZOGjtGSUHI4unP9Mp7EkuxmnQs9LLbjcLTjkNKbB5rsrDJWKmIlgd4JC48ps2Rmtm+o// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295639>

Am 24.05.2016 um 20:16 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>    diff: factor out match_func_rec()
>>    diff: handle appended chunks better with -W
>>    diff: ignore empty lines before added functions with -W
>>    diff: don't include common trailing empty lines with -W
>>    grep: don't extend context to trailing empty lines with -W
>>
>>   grep.c        | 28 ++++++++++++++++++++++++--
>>   xdiff/xemit.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++-------
>>   2 files changed, 82 insertions(+), 9 deletions(-)

> It is curious that this much behaviour change does not need any
> changes in the test scripts.  We do not have sufficient coverage,
> perhaps?

Well, -W is not tested at all.  I'll include some in the next round.  N=
o=20
need to hurry, it's too late to land in 2.9.0 anyway.

Ren=C3=A9
