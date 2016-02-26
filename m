From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: cover letter and cc list
Date: Fri, 26 Feb 2016 18:05:15 +0530
Message-ID: <56D04683.3080201@synopsys.com>
References: <20150320173504.GA6162@aepfle.de>
 <xmqqpp83ee2z.fsf@gitster.dls.corp.google.com>
 <20150323081840.GB9332@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Olaf Hering <olaf@aepfle.de>, Junio C Hamano <gitster@pobox.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:35:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZHcX-0004iD-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 13:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbcBZMff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 07:35:35 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48791 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbcBZMfe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 07:35:34 -0500
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
	by smtprelay.synopsys.com (Postfix) with ESMTP id 3FBF910C1255;
	Fri, 26 Feb 2016 04:35:32 -0800 (PST)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
	by us02secmta1.internal.synopsys.com (Service) with ESMTP id D07714E213;
	Fri, 26 Feb 2016 04:35:32 -0800 (PST)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
	by us02secmta1.internal.synopsys.com (Service) with ESMTP id 975114E202;
	Fri, 26 Feb 2016 04:35:32 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id 86E3EE67;
	Fri, 26 Feb 2016 04:35:32 -0800 (PST)
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
	by mailhost.synopsys.com (Postfix) with ESMTP id 0159DE66;
	Fri, 26 Feb 2016 04:35:31 -0800 (PST)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Fri, 26 Feb 2016 04:35:31 -0800
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Fri, 26 Feb 2016 18:05:29 +0530
Received: from [10.12.197.208] (10.12.197.208) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Fri, 26 Feb 2016 18:05:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20150323081840.GB9332@aepfle.de>
X-Originating-IP: [10.12.197.208]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287573>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Monday 23 March 2015 01:48 PM, Olaf Hering wrote:
> On Fri, Mar 20, Junio C Hamano wrote:
> 
>>> Olaf Hering <olaf@aepfle.de> writes:
>>> 
>>>>> What does it take to send the cover letter to all people which are 
>>>>> listed in the Cc: list of the following patches? Each patch has a 
>>>>> different Cc: list. The "git send-email --help" command suggests
>>>>> that this cmdline should do it. But the cover letter goes just to the
>>>>> address listed in --to=:
>>>>> 
>>>>> env TMPDIR=/dev/shm LC_ALL=C git send-email -M --stat --annotate \ 
>>>>> --cover-letter --cc-cover --to=$address \ $base..$head
>>> 
>>> First step is not to drive format-patch from within send-email I would
>>> think.  Instead prepare them in files in a directory (with format-patch
>>> -o $dir).  You can edit Cc: header in 0000-*.patch message while you
>>> proof-read what you are going to send out.
> Thanks. Then I misinterpreted what --cc-cover actually means. All Cc: lines
> have to be present in the cover letter already. Would be nice if git would
> run a command like this to put the list into the coverletter:
> 
> # git log --format=%b $base..$head | grep -iw ^cc: | sort -u
> 
> In the meantime I will remember to do that step manually.
> 
> Olaf

I have the exact same requirement, to create a union of CC in patches for
cover-letter. That way sending a series to different people gives them the right
context with cover-letter and individual patch.

Now man git send-email mentions --[no-]cc-cover. I quote

"emails found in Cc: headers in the first patch of the series (typically the
cover letter) are added to the cc list for each email set..."

I certainly want the reverse, but the question is how does one get about getting
an address in cover letter in first place.

Thx,
- -Vineet

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0EaDAAoJEGnX8d3iisJevuMQALMNQv7IiOTc78A0GMDZpBx4
cAEY2mPu29uJG0rRq8vaWxwBEAAoIflqUEiv9ygHwtvI1YDBGgt3RsEuqTMdj1eI
JboZy4cpn04XVKRtcEU1iXf8Qp5uGmOgBUSwP5VaawTpGxIn43KJjyFwvq7h9Sps
lsuOtY5rO1xq1B4ktmolF93unwI5R68moNTHhpOilOcBwbNVApouMnJ0c64ritPw
hn9pUWST+rtL9pbqUas4PRxHL4vUAhIQkswlxxZvaVhlC9WK6AY2nMTWmz0Pcmlc
WbGD1nulGJMXkHR4G02GhSbO2zsy8o5vJii2inFCwl7eWC5LIdfc8w+ssDYJ9Zlz
beXuRxYy5zgQQzCpd9d1o7ZMjbSEuWizgPJ9a+lGPfqeqB/cp9emdbOUOc7CMhXn
5C3nDtOIgkchnZw3otgbUmGQCbiIHTN4tMQHbXrp0suu2mPCkYA9H8SqBRANPy1k
AfU1FCvgQBjGgezV4IOBLrqi3vqoacQqriYIyYmUq0rnuwI6fT09OwfvAa2uVugT
BWuuzpW1gBiiSKfYstC+ZzoZCnD8Ia5HsaKNtFxfxia2ekFC50RTkSR3ScSVnlKI
77uLzflHsoZvFrla1mgLn+D4pn3yzSUdcd9lFIBAkBqgR1T5mKjT3HaSDOdMDJRz
KiRJrh3G8ZC7hYeAj3Kx
=GzhS
-----END PGP SIGNATURE-----
