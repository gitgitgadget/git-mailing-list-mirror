From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 1 Sep 2015 16:35:04 +0200
Message-ID: <55E5B798.40108@web.de>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
 <1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
 <55E52BA7.6020303@web.de> <6BD3F017-37E4-4677-BCCE-D84E7031B780@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, luke@diamand.org, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 16:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWmeb-0003jA-2S
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 16:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbIAOfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 10:35:10 -0400
Received: from mout.web.de ([212.227.15.4]:65213 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbbIAOfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 10:35:09 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LkhQi-1YwLN72R0e-00aUHD; Tue, 01 Sep 2015 16:35:05
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <6BD3F017-37E4-4677-BCCE-D84E7031B780@gmail.com>
X-Provags-ID: V03:K0:ZqSAaWzx2Ef3doHZggwSp84DNbGSyAFqCjrsNvEngqr4JcVFALX
 RSHjOFW+Zmhuo9aOsYRZYSodgpTFB/9dKF1+cLAf/Gwn0jWJkmyrje7kSHV9mEGhLmoFBO8
 h75si0BZaDXsbL+iUBCA/iNS2CFmlDSCIRN68yi/sGwi4ara3Vz6cvFvvnWg+MFyL3pYojX
 CRWVv6dHyOF1l3i0v8rlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1BLzYUtua+c=:xqsiA0LO2M1ghixHIo0zBd
 5XMpuw9ujIA/78FMNGT90SYoCoR55z/3uxiNuiSQHMVd1zN74jyYv/4yHd4dSnCU9smEtfBNV
 hX5RT3vLCTYbW5rT37R3RNyKlJRPpGVSu8cyvPSCqJBTXWCd+opYGyBNU7fVSreeTPjHleO9K
 Gu3llUSA6d4GqnGLMAb6E7Xe+82aDC1E+fYjvuCh6hQCodHDBM86QmYQLnXb84t+Btw3KDM7N
 kfKqBRi8ZnfXWbl9Gx8EJPGvyg/unAN7MFdbNITK0SjscSL5fTN9qyXn2nCE3p4tuvpko4/z9
 s0iG1ttudqRLmDJpMcH99xHYk1bXM4drZ5Cd9g5QNehRlW9fWXF1WUxQCIViG6HHpXVy9WAzd
 ofd4LatNl5lEp/FFl4C2HRLXNWdIIcSemcNnNSS3EYjgQOjk8JuGzJamTgMPDbbxsNbITfU4C
 yoE14N9zZgXOHMsiF77smmBORh8+kxHHKMC55kLAB7vetBwdk7scmWpRIbg88uhPYk1Ao6Qu3
 0yuberW8R3G2zJq/TWbSA4VPDXUf3dM50KJYqFqcEFYDJZEp1rIJwWluLBRWNfDXTBPgghus3
 hvoi0/IHMj8ro9Kr5tAuytFvWJzqOeidLrTAlmg82BAlXBTZQl42eOhfqSeIWC9xpjvMTIjdp
 RVoyJaAZwVHTmHP1ru4ghB7dDwXHK1pGjCvK0DkQbH6wKe5U1Jig2obhWg4E8RwE0q2cwK30A
 FdVX6BS7zHbsMBTkCdd/Y9cX8uZjkovheOVUKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276981>

On 2015-09-01 14.47, Lars Schneider wrote:
>>> +test_expect_success 'Create a repo containing iso8859-1 encoded paths' '
>>> >> +	cd "$cli" &&
>>> >> +
>>> >> +	ISO8859="$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso8859-1)" &&
>>> >> +	>"$ISO8859" &&
>>> >> +	p4 add "$ISO8859" &&
>>> >> +	p4 submit -d "test commit"
>>> >> +'
>> > Sorry for being persistant,
>> > but you can't create files with names that  are ISO-8859-1 encoded under Mac OS,
>> > we end up like this:
>> > 
>> > a-%E4_o-%F6_u-%FC.txt
> You are right. However, my goal is not to create a file with ISO-8859-1 characters in Mac OS. My goal is to create this file in Perforce and this approach seems to work.
> 
>> > 
But this line creates a file, doesn't it ?
>"$ISO8859" &&

(I just wonder how this works on you machine )

And, may be, we could fill the file with some content, to be double-sure that
the file name conversion works with Perforce ?

like
echo content >"$ISO8859" &&

and test the content later ?
