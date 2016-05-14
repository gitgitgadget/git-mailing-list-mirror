From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Sat, 14 May 2016 07:40:11 +0200
Message-ID: <998a4fcd-ecd8-7e0c-860e-7f12ec02b1f9@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
 <xmqqinyhaoxn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 14 07:40:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1SJb-0000OW-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 07:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbcENFk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 01:40:27 -0400
Received: from mout.web.de ([212.227.17.11]:62054 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbcENFk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 01:40:27 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LxfOx-1bgqfd1m9L-017EO1; Sat, 14 May 2016 07:40:14
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqinyhaoxn.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:lmfuIFEf7mDrvhPPF4Nhphv16wBrHyOLLtuVZcrRHChZQ2yLzyd
 zh3SRab7jUaYLVGWySFpv6Vhzr0Yw6Eqy92m4IFEfxXR6Jm61v5+ITPcSMY9pzxZYQYuVnw
 NMjKjAoBHSsA8mm+jwyXYgaOoqRY88M9uvQ7UN5CycvqS2h4RlcuEy7NGjlULHjYSEe1OMq
 PO4Sncx69rebrtC4h+Pgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JYGhLzBkoB0=:mw+aFeaA8qbqSyFLqREcNV
 UG7AOiuHcJ+jvWeDIWUZUf6D8Ip6wVbZQJ7ltLyu0B7ZVAMNQxveP/lBEtpet9AoU65frAVqt
 oRZv9aTkpZjy40svoXa3M26JWeg/0v5PIa8lQnLG7hmR5UDBzaTcs5rMKzkgvrHn57CAay3N2
 uOxUjlMW6W446NhCPqWXMNecLgIc0vHjYBwYexI+14bGAdXlIhdYsxBzrRdfdsf9Zql9iBuEb
 wAANgTBtLXLiZzvp8aQiD0ousVnHB4awVNXEfkaYi7tq4FoTWq3moH7XQeXW1K70Q3Nri7taG
 dU+1P0MkTR3Aw1vtdRCHumfwh5XzkRh9cbyUDTs5DIgKPFw3v2MA/kPr5ZO7ruOgbmncw6tPA
 3s9DZGWnaKJVwvJjWKiISDJErT0WRVXLXWmF5PK5vR37X70RBF3zCohafWDx/tcunk7QcczgF
 gTmKE7qo/pqFMBdxinWfpHXTcKw79KgppBq09PP0YFZiNxqaFukVdQ27e5bBdy/FKqPevBUE0
 zVQHR0Yb2ZtUO9npqpLt4WsU5nB05xZ2sVSnZ8GkYWlRzryx6d9efjCHcVWpq8EFTMa6Bgsqk
 ua6eSCDMUJXtjMNQKx/4CMkqKtJhB6+s8fGQ6eoq45qA03Oufad4DNuUgeNCC3f5nm0qsjWXr
 GbsshfxylutnoVemupj/X62M4hhkIzU2fgz816TWtUKYp5Wiz581KIp7IXZHO9ng37rfulYa3
 AWnj7n5QC7wZ4gJ3/abzkqTX8qLkiY+K6Ef2qwjYfQf//Vt8eyRdtUbGbYn6W8ByomlmgV8o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294601>

On 13.05.16 18:43, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> 
>> If you use .gitattributes to enable CRLF->LF rewriting, then commit a
>> file that would have its line endings rewritten, the "CRLF will be
>> replaced by LF" warning is printed several times over; I'd expect it to
>> be printed only once.
>>
>> There's a test case in t0020 -- "safecrlf: print warning only once" --
>> that checks the warning is only printed once when using `git add`, but
>> nothing that seems to check the same thing on `git commit`.  The
>> unnecessary multiple warnings seem to have existed since at least v1.6.0
>> (the warnings appear to have been added in v1.5.5 in 21e5ad5, but I
>> couldn't get that to build on my current box), and I'm seeing them on my
>> Cygwin box's build of the current next branch (d10caa2) and on my CentOS
>> box's v2.8.1 release.
> 
> Torsten, I know you are not heavily invested in "commit" codepath,
> but since you've been actively touching the CRLF area, I wonder
> perhaps you might be interested in taking a look?
> 
I have seen this double warning as well, but never digged further,
as it is most probably in the code outside convert.c

I can put it on the TODO list, and I think it would make sense to add
a TC in t0020, which is marked as test_expect_failure.
 
