From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Wed, 18 Mar 2015 11:20:09 +0100
Message-ID: <55095159.40106@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> <CACsJy8AiHHKBD4vV5aJec9CGzBqfSCNU6-j=LjDhsp2VrC55+A@mail.gmail.com> <550949BC.1020500@alum.mit.edu> <20150318100338.GA26998@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYB5U-0005Jx-8e
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 11:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbbCRKU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 06:20:27 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50474 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753123AbbCRKU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 06:20:26 -0400
X-AuditID: 1207440e-f79bc6d000000c43-9b-5509515b6853
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 11.C6.03139.B5159055; Wed, 18 Mar 2015 06:20:11 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96AE4.dip0.t-ipconnect.de [79.201.106.228])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2IAK94l010001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Mar 2015 06:20:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <20150318100338.GA26998@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqBsdyBlqsOchn0XXlW4mi4beK8wW
	3VPeMlr8aOlhdmDx2DnrLrvHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd8WHdSpaC
	Ht6K95tOsjQwHuXqYuTkkBAwkTi7aTErhC0mceHeerYuRi4OIYHLjBJPl/1jhHAuMElsePSI
	HaSKV0BTYuvMu4wgNouAqsS5761MIDabgK7Eop5mMFtUIEji5a2/jBD1ghInZz5hAbFFBGQl
	vh/eCBZnFiiXePT+PlhcWCBcYum92UwQy04xSvxr2MgGkuAU0JOYvugFVIO6xJ95l5ghbHmJ
	5q2zmScwCsxCsmMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSnd
	xAgJab4djO3rZQ4xCnAwKvHwSlzlCBViTSwrrsw9xCjJwaQkypvqzxkqxJeUn1KZkVicEV9U
	mpNafIhRgoNZSYRX1BMox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS
	4PUIAGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VrfDEwXkFSPEB77UHaeYsL
	EnOBohCtpxgVpcR5jUASAiCJjNI8uLGwRPWKURzoS2HeCpAqHmCSg+t+BTSYCWhwSzsbyOCS
	RISUVAOjvsqEReo8Mxe17+Gub1FuuSBUJcfBFrd/4aqW8jo98RdFya2pzvXyPy8m3Mu513Os
	WV7W5H8Th81hgRtvNJ+aZLzMnrbhCTPHPXl5g2nXJP9ONVVXlWObxuwceWdV0JY0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265713>

On 03/18/2015 11:03 AM, Jeff King wrote:
> On Wed, Mar 18, 2015 at 10:47:40AM +0100, Michael Haggerty wrote:
> 
>> But in case you have some reason that you want upload-pack.c to be
>> converted right away, I just pushed that change (plus some related
>> cleanups) to my GitHub repo [1]. The branch depends only on the first
>> patch of the "numparse" patch series.
>>
>> By the way, some other packet line parsing code in that file doesn't
>> verify that there are no trailing characters on the lines that they
>> process. That might be another thing that should be tightened up.
> 
> Do you mean that upload-pack gets a pkt-line of length N that contains a
> line of length M, and then doesn't check that M==N?  We use the space
> between M and N for passing capabilities and other metadata around.
> 
> Or do you mean that we see lines like:
> 
>   want [0-9a-f]{40} ...\n
> 
> and do not bother looking at the "..." that comes after the data we
> expect? That I can believe, and I don't think it would hurt to tighten
> up (we shouldn't need it for extensibility, as anybody trying to stick
> extra data there should do so only after using a capability flag earlier
> in the protocol).

The latter. For example here [1], the "have" command and its SHA-1 are
read from the line, but I don't see a check that there are no characters
after the SHA-1. The same here [2].

Michael

[1]
https://github.com/gitster/git/blob/9ab698f4000a736864c41f57fbae1e021ac27799/upload-pack.c#L404-L429
[2]
https://github.com/gitster/git/blob/9ab698f4000a736864c41f57fbae1e021ac27799/upload-pack.c#L550-L565

-- 
Michael Haggerty
mhagger@alum.mit.edu
