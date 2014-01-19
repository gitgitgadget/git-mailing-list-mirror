From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Verifiable git archives?
Date: Sun, 19 Jan 2014 01:35:00 +0100
Message-ID: <52DB1DB4.7080806@alum.mit.edu>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com> <xmqqsiswapav.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Lutomirski <luto@amacapital.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 01:35:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4gMX-0003xF-Qr
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 01:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaASAfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 19:35:06 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43768 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751539AbaASAfF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 19:35:05 -0500
X-AuditID: 1207440c-b7f566d000004272-4f-52db1db7d5a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E2.FF.17010.7BD1BD25; Sat, 18 Jan 2014 19:35:03 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0J0Z0lo001823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Jan 2014 19:35:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqsiswapav.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqLtd9naQwYqHfBZdV7qZLBp6rzBb
	rF7bwOrA7HH/zV8Wj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y8PILS8Fyzop19/cxNzAe
	YO9i5OSQEDCR2P3vHQuELSZx4d56ti5GLg4hgcuMEn9mvmCEcM4zSTTe2soIUsUroC1xatMz
	JhCbRUBVYsOrfWCT2AR0JRb1NIPFRQWCJVZffsACUS8ocXLmEzBbREBNYmLbITCbWcBOouPh
	X2YQWxhoTsvuVWDzhQTqJV5veg9WwylgLfFq8R4gmwPoOnGJnsYgiFYdiXd9D5ghbHmJ7W/n
	ME9gFJyFZNssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRES
	0jw7GL+tkznEKMDBqMTDm8FwO0iINbGsuDL3EKMkB5OSKO8nEaAQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEd7gDbeChHhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxW
	wNgVEixKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFcHwxMIZBUjxAe81A2nmLCxJz
	gaIQracYdTlWbPj0h1GIJS8/L1VKnPemDFCRAEhRRmke3ApYAnvFKA70sTCvDcgoHmDyg5v0
	CmgJE9ASkdibIEtKEhFSUg2MTvr7xJ82mbc4SK94vtEma+PxaI9NZgHPm6y2Tax+X3DhhTWT
	maPNWrn60kzzB+tlGdk8spLeLPtslPLi86ME6cMt63y/RTDN8REznfUvdu3RFRPP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240671>

On 01/09/2014 09:11 PM, Junio C Hamano wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
> 
>> It's possible, in principle, to shove enough metadata into the output
>> of 'git archive' to allow anyone to verify (without cloning the repo)
>> to verify that the archive is a correct copy of a given commit.  Would
>> this be considered a useful feature?
>>
>> Presumably there would be a 'git untar' command that would report
>> failure if it fails to verify the archive contents.
>>
>> This could be as simple as including copies of the commit object and
>> all relevant tree objects and checking all of the hashes when
>> untarring.
> 
> You only need the object name of the top-level tree.  After "untar"
> the archive into an empty directory, make it a new repository and
> "git add . && git write-tree"---the result should match the
> top-level tree the archive was supposed to contain.
> [...]

This wouldn't work if any files were excluded from the archive using
gitattribute "export-ignore" (or "export-subst", which you already
mentioned in a follow-up email).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
