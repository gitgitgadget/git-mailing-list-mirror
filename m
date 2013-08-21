From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v5 1/2] xread, xwrite: Limit size of IO, fixing IO of
 2GB and more on Mac OS X
Date: Wed, 21 Aug 2013 21:50:32 +0200
Message-ID: <52151A08.6060103@web.de>
References: <1376926879-30846-1-git-send-email-prohaska@zib.de> <1376981035-23284-1-git-send-email-prohaska@zib.de> <1376981035-23284-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 21 21:50:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCEQS-0006vU-AD
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab3HUTug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:50:36 -0400
Received: from mout.web.de ([212.227.15.3]:63245 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498Ab3HUTuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:50:35 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LvOd9-1WCLL007ql-010Z78 for <git@vger.kernel.org>;
 Wed, 21 Aug 2013 21:50:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376981035-23284-2-git-send-email-prohaska@zib.de>
X-Provags-ID: V03:K0:sINkS2d/nE/Pkr/fBGzXLNyAkbrCdtTPHrALWQRVkio5Abmg46x
 Y/3BX3h+vNZwiyUKy3nWhxUrqlzG3eHTqaCdnwfbYcjCOgUCS7fhAiiibDxvmlQOvyW2Wrs
 LcN0QZsrt2pobRQAtKq+80Q+l/DeEt1OUajuCpM4GCgAnzGpJNrEfA6GktUHeMfaeGyIyWD
 z+CglsDrZSpjJsvGFruHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232723>

On 2013-08-20 08.43, Steffen Prohaska wrote:
[]
Thanks for V5. It was tested OK on my system here.
(And apologies for recommending a wrapper on top of a wrapper).

One question is left: 
As xread() is tolerant against EAGAIN and especially EINTR,
could it make sense to replace read() with xread() everywhere?

(The risk for getting EINTR is smaller when we only read a small amount
of data, but it is more on the safe side)

And s/write/xwrite/

/Torsten
