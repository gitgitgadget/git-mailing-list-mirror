From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 10 Jun 2016 19:04:04 +0200
Message-ID: <575AF304.8070407@kdbg.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <5734B805.8020504@kdbg.org>
 <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
 <5759DB31.2000106@kdbg.org> <alpine.DEB.2.20.1606100852550.3039@virtualbox>
 <CAP8UFD1zSAxyHfZgBbfoF=th0waZWEhvHP+4jUxxVO+rU9N9RA@mail.gmail.com>
 <alpine.DEB.2.20.1606101307080.3039@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 19:04:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBPr2-0005RW-1p
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 19:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbcFJREM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 13:04:12 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:44074 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcFJREJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 13:04:09 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rR7n12CZ6z5tlF;
	Fri, 10 Jun 2016 19:04:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B3A4952A4;
	Fri, 10 Jun 2016 19:04:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <alpine.DEB.2.20.1606101307080.3039@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297013>

Am 10.06.2016 um 13:11 schrieb Johannes Schindelin:
> On Fri, 10 Jun 2016, Christian Couder wrote:
>> On Fri, Jun 10, 2016 at 9:01 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> I lost track in the meantime: were those issues with unclosed file handles
>>> and unreleased memory in the error code paths addressed systematically? My
>>> mail about that seems to have been left unanswered, almost as if my
>>> concerns had been hand-waved away...
>>
>> Haven't I answered to your email in this thread:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/292403/
>>
>> ?
>
> Not really. The reply (which I had not quite connected with my mail
> because they were over a week apart) says this:
>
>> I fixed this by moving the "close(fd)" call just after the
>> "apply_patch()" call.

This bug in v1 was discovered by the test suite and fixed in v2.

>
> and this:
>
>> I will have another look at the 2 other places where there are
>> open()/close() or fopen()/fclose() calls.
>
> but nothing about a careful, systematic investigation of all error code
> paths. As a consequence, I fully expect to encounter test failures as soon
> as I test your patch series again, simply because resources are still in
> use when they should no longer be used. In other words, my expectations
> are now lower than they have been before, my concerns are not at all
> addressed.

Do you trust the test suite to some degree? It passes after the above 
bug was fixed in v2. In addition, haven't found any problems so far 
during daily use.

>> This is the newest iteration:
>>
>> https://github.com/chriscool/git/commits/libify-apply-use-in-am65
>
> And that cute 65 in the name is the revision.

Yeah, that number is painful. I would appreciate an unversioned branch 
name, too.

-- Hannes
