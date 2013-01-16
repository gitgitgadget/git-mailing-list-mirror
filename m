From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t9902 fails (Was:  [PATCH] attr: fix off-by-one directory component
 length calculation)
Date: Wed, 16 Jan 2013 07:15:51 +0100
Message-ID: <50F64597.2070100@web.de>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <201301152014.28433.avila.jn@gmail.com> <7vwqve2qk3.fsf@alter.siamese.dyndns.org> <201301152053.58561.avila.jn@gmail.com> <7vfw222mv2.fsf@alter.siamese.dyndns.org> <20130115232400.GA16147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQQ==?= <avila.jn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvMJw-0001nw-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 07:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab3APGRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 01:17:24 -0500
Received: from mout.web.de ([212.227.15.4]:62364 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab3APGRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 01:17:23 -0500
Received: from [10.3.239.8] ([94.234.170.140]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MTh7A-1TUvSY2YvQ-00Qfyg; Wed, 16 Jan 2013 07:17:20
 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <20130115232400.GA16147@sigill.intra.peff.net>
X-Provags-ID: V02:K0:pDI4vJw2/8lyeboky8hcECdhdkmNme3ylB6nbXwDVOX
 KZndIMA+XPbg55LmBpUS1bKRaMSblcqr06cRe3edgU91DFQFoT
 o9AdzDxk5O8IbGenNHifo0v5LU53oYVP1YhWJQUuyiR3SUyZKS
 6yruOlRONyP54I+QnIoDGT5HbJGK2Ka9LhhZQ9zFkMAIF6f5SE
 sb/9Q7KK8jDvwV6cV08/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213730>

On 01/16/2013 12:24 AM, Jeff King wrote:
> On Tue, Jan 15, 2013 at 12:49:05PM -0800, Junio C Hamano wrote:
>
>> "Jean-No=C3=ABl AVILA"<avila.jn@gmail.com>  writes:
>>
>>> Btw, the test 10 to t9902 is failing on my Debian testing. Is it a =
known
>>> issue?
>>
>> Which branch?
>
> t9902.10 is overly sensitive to extra git commands in your PATH, as w=
ell
> as cruft in your build dir (especially if you have been building 'pu'=
,
> which has git-check-ignore). Try "make clean&&  make test".
>
> -Peff
This may help, or it may not.

If there are other binaries like
"git-check-email" or "git-check-ignore" in the PATH
=2E....

When you switch to a branch generating a file like
git-check-ignore then "make clean" will know about it
and will remove it.
If you switch to master, then "make clean" will not remove it.

What does "git status" say?

We had a discussion about this some weeks ago, but never concluded.

How about this:
http://comments.gmane.org/gmane.comp.version-control.git/211907
