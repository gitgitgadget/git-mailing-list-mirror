From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 20:55:22 +0100
Message-ID: <54B5782A.2010003@kdbg.org>
References: <54B5579B.4080607@kdbg.org> <xmqqtwzucxwf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB7Ys-0002vB-ND
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 20:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbbAMTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 14:55:27 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:48106 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753786AbbAMTzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 14:55:25 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kMMvt4yXtz5tlC;
	Tue, 13 Jan 2015 20:55:22 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1982519F8CC;
	Tue, 13 Jan 2015 20:55:22 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqtwzucxwf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262351>

Am 13.01.2015 um 19:56 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> The new code does change some properties of the generated files:
>>
>>  - They are a bit smaller.
>>  - They are not sparse anymore.
>>  - They do not compress well anymore.
>>  - The smaller of the four files is now a prefix of the larger.

Would you kindly strike the last bullet point when you apply the patch,
because it is not true, as I just noticed:

>> +	test-genrandom seed1 2000000 >large1 &&
...
>> +	test-genrandom seed2 2500000 >huge &&

The seeds are different so that the files are completely dissimilar.
This does not affect the rest of the analysis I gave in the commit message.

Thanks,
-- Hannes
