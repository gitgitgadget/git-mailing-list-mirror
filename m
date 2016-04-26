From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] remote.c: spell __attribute__ correctly
Date: Tue, 26 Apr 2016 14:19:05 +0100
Organization: OPDS
Message-ID: <05BBD86AE63E4FA0ADE63F05DBD834C0@PhilipOakley>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley> <20160425211030.GA10309@sigill.intra.peff.net> <20160425211523.GA11227@sigill.intra.peff.net> <2FDBFACB68254498A8F83367553AED80@PhilipOakley> <571E96CE.80606@ramsayjones.plus.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>,
	"Ramsay Jones" <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:22:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9VN-0002Jz-GC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbcDZUWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:22:39 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:61757 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbcDZUWi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:22:38 -0400
Received: from PhilipOakley ([92.22.43.189])
	by smtp.talktalk.net with SMTP
	id v9VDaaZ3rm8hQv9VEauYa8; Tue, 26 Apr 2016 21:22:36 +0100
X-Originating-IP: [92.22.43.189]
X-Spam: 0
X-OAuthority: v=2.2 cv=EbSKe7uC c=1 sm=1 tr=0 a=2rP9O2QEpdw3eaV+VKDZAA==:117
 a=2rP9O2QEpdw3eaV+VKDZAA==:17 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8
 a=PKzvZo6CAAAA:8 a=5J3k7-N-xnN75VLOaPMA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfH8pxPDBxU+vphhp/OYSvraiXqmwvVnEhSG+hkzHFp81HwL1mIHl41nEN6a1xNR2P3RAEKc1EFK3EZz1OHA6vAHthhF387eyMrW36klkL5EPmahQ6sCz
 LOcFr4/CRbROPSPTU/dmKBn+e+tbAz5hWtX+gQYYXBFHHqLgSGLr7lZHazgPCBptBXG9jWIceb6qhy0GElIG19r3Qpt9SbYnneS+cwBCQ3IyG+5/DLArUedH
 rjX+r8v8PcTHnsaifjjXOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292660>

Thnx,
From: "Ramsay Jones" <ramsay@ramsayjones.plus.com>
> On 25/04/16 22:50, Philip Oakley wrote:
>> From: "Jeff King" <peff@peff.net>
>>> On Mon, Apr 25, 2016 at 05:10:30PM -0400, Jeff King wrote:
>>>
>>>> It should be handled in git-compat-util.h, which is included by 
>>>> cache.h,
>>>> which is included by remote.c.
>>>>
>>>> There we have:
>>>>
>>>>   #ifndef __GNUC__
>>>>   #ifndef __attribute__
>>>>   #define __attribute__(x)
>>>>   #endif
>>>>   #endif
>>>>
>>>> which should make it a noop on compilers which don't know about it. Is
>>>> VS (or another file) setting __GNUC__?
>>>
>>> Of course it helps if we spell the name right...
>
> Indeed! ;-)
>
> Not that it matters, but the above #define in git-compat-util.h is not
> the relevant definition - msvc will not see it.

Ah, I see that that block is further guarded with other if/elif/else clauses 
so that it's not seen if _MSC_VER is defined.

git-compat-util.h#L400-411

> However, it does see
> the #define on line 12 of compat/msvc.h. :-D
>
> ATB,
> Ramsay Jones
>
