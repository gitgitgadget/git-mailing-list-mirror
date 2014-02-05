From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 18:54:56 +0100
Message-ID: <52F27AF0.7030007@web.de>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com> <20140205011632.GA3923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7Y=?= =?UTF-8?B?Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>, git@vger.kernel.org,
	Jochen Haag <zwanzig12@googlemail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:55:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6gk-0002Ob-CD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbaBERy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:54:59 -0500
Received: from mout.web.de ([212.227.15.3]:50472 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbaBERy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:54:57 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lcxfc-1VTDDE0BhA-00iCme for <git@vger.kernel.org>;
 Wed, 05 Feb 2014 18:54:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140205011632.GA3923@sigill.intra.peff.net>
X-Provags-ID: V03:K0:nz3QR+CYj+jfN6v5/MhHFIG6KusLO8/9uDCp3OFhSmn8RxFBE1C
 EOApdr+hksMDCQfh80sbzMtK6+KIs7ouDwYBT4C3M5v+x0qyM40j5wxEnAXZeNZa4LYoJpb
 81Ap4Pdj1KJGCZscfwvSfsfxypjDFU8LOpOk/wJ0qf/Th8bxCw9yfzu0Q8qs36MS8o2T54k
 vlBpYZs9B9EGnzd9H/DvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241626>

On 2014-02-05 02.16, Jeff King wrote:
> On Tue, Feb 04, 2014 at 03:40:15PM -0800, Junio C Hamano wrote:
> 
>>  * Somehow this came to my private mailbox without Cc to list, so I
>>    am forwarding it.
>>
>>    I think with 1190a1ac (pack-objects: name pack files after
>>    trailer hash, 2013-12-05), repacking the same set of objects may
>>    have less chance of producing colliding names, especially if you
>>    are on a box with more than one core, but it still would be a
>>    good idea to get this part right in the upcoming release.
> 
> Actually, since 1190a1ac, if you have repacked and gotten the same pack
> name, then you do not have to do any rename dance at all; you can throw
> away what you just generated because you know that it is byte-for-byte
> identical.
> 
> You could collide with a pack created by an older version of git that
> used the original scheme, but that is quite unlikely (on the order of
> 2^-160).
> 
> -Peff
OK, I messed up the email so it went only to Junios mailbox. Sorry for confusion.

Jochen, it could be good if you could test this version of the patch
(I couldn't reproduce the problem here)

/Torsten
