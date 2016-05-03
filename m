From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner
 cases
Date: Tue, 3 May 2016 18:30:26 +0200
Message-ID: <f9da0d57-2d85-6a1c-5a28-13956102f37b@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-2-git-send-email-mh@glandium.org>
 <xmqqzis7nn02.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 03 18:31:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axdDp-0000TD-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801AbcECQaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:30:46 -0400
Received: from mout.web.de ([212.227.17.12]:52529 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933398AbcECQao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:30:44 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MTh6a-1b6Oeq1xQm-00QW6g; Tue, 03 May 2016 18:30:28
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqzis7nn02.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:ouG+mGqKCq67sMRkJiD2n4mO2DJrFW97u0esdlUC9QK4plTxmUF
 PeP7nSmDN4+6YO9hBkkS0eHFOhHasmneR5jbEawY+n6OLqtP77D35X41JNiREXOiVBvwa7B
 nzrcFJVj/a5YmuX3eOnIsYMGokZD7fzJcAl6GnjpmMiBZLYoh1u4/kt2CDGS1UpCCqr/woU
 LyqrE4YkZsbTh3hTcM6Kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IWXeEktflOU=:BF+JPet6G54AmOxXU9XSEZ
 fmUR+PTgMeA1YtZ52iNDE2fnigWC0xpQiSwLNvA/jjSL2MPxw68yhKKiT9dYr3yiMzefRzlAa
 ZRG6kdR47QECrTFsn3rnX3pLYz9lnHwMZf7lqxSRD37yy8spoSaYbWZpZOnY8CMvnflfMnWqF
 BuCqY5DOCRTY2cg0Vr5EJI7QLOJEy+eV4Er6dTIEfYDAtPA6ou2OlvhagGUTRTN6Z1DjdMy+V
 EhOQep2sPWR5AP7w+1ZGDaiPwETC5Jab8rj/EuPvoXrvyiP61UmmjjRUuzjoj8wLGwgC0KEGu
 ntK1c771wdVcJgPk/2YPFQYMFW5zwgyJiR1PER2kLCz2A/3I9jGP0iXGUB2PAKJ5DwrVjw/U/
 ixYYP0za6+r5OXCkUYjCndxkRM29T8wd9RXHR+3oNN9AEaO9tcAcX2sZ+Gk3ZAhUYMQjUtzyt
 8tHWuNFjsW8M7soZofKHpbsDU0RwfPlARMYJ7hihrf+j3Qo8KJNAefRtwxH0RH7a2KG63clCK
 Ravat/AfjHpDLh8mWe6QAlX3DZQltboLfdM0yx2GwdQ8ObhdA+1rnOjVfsW/C5PKh2lOuu8L2
 6gpl8ayyHlsi80a8p0hAFPnUiqF6rl9wucFZAl1J+7ywVRKGpMN09jCevvP0xB4g+YOCI3Z1H
 FHvCSSFXC1gVXVX6rUun3peXZzFTOlAvA606ej2p4FyCeCucyx8PraFmJsYqc7ssA0y69gFfm
 9z80Oy4aTokdo/7Dc67WRlbLEKC8BjAEx8JTi7xO4RyItZ62R/Ms6cAAy7+/IjJ7QBH0TRkW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293415>

On 2016-05-03 18.07, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
>> t5603-clone-dirname uses url patterns that are not tested with
>> fetch-pack --diag-url, and it would be useful if they were.
>>
>> Interestingly, some of those tests, involving both a port and a
>> user:password pair, don't currently pass. Note that even if a
>> user:password pair is actually not supported by git, the values used
>> could be valid user names (user names can actually contain colons
>> and at signs), and are still worth testing the url parser for.
> 
> I am not sure about the last part of this (and the tests in the
> patch for them).  When you are constrained by the Common Internet
> Scheme Syntax, i.e.
> 
>     <scheme>://<user>:<password>@<host>:<port>/<url-path>
> 
> you cannot have arbitrary characters in these parts; within the user
> and password field, any ":", "@", or "/" must be encoded.
> 
I thinnk we have an old bug here:
	if (is_url(url_orig))
		url = url_decode(url_orig);
	else
		url = xstrdup(url_orig);

The the url should be separated into the components first,
and afther that url-path should got into url_decode,
and may be password, username....
(That's out of my head)
