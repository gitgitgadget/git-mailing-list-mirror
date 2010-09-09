From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 3/4] t/t4018: test whether the word_regex patterns compile
Date: Thu, 09 Sep 2010 14:39:32 -0500
Message-ID: <j45XQiddacaKt4L280HjYoaYzAnnDCuR2Yspxw_iRDyU3Y9YkKMxAQ@cipher.nrlssc.navy.mil>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil> <rRj7JpFIk_D_n7-wGkkucC32o5VKAledjObzc1bFHX8SBUchsp6UDflVKjnjY9xKm9Q48ir5iu8@cipher.nrlssc.navy.mil> <20100909192331.GD32508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmyC-0008EY-BT
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0IITjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:39:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49962 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0IITjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:39:35 -0400
Received: by mail.nrlssc.navy.mil id o89JdWYf005364; Thu, 9 Sep 2010 14:39:32 -0500
In-Reply-To: <20100909192331.GD32508@sigill.intra.peff.net>
X-OriginalArrivalTime: 09 Sep 2010 19:39:32.0409 (UTC) FILETIME=[B9C1DA90:01CB5056]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155894>

On 09/09/2010 02:23 PM, Jeff King wrote:
> On Thu, Sep 09, 2010 at 02:02:47PM -0500, Brandon Casey wrote:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Previously (e3bf5e43), a test was added to test whether the builtin
>> xfuncname regular expressions could be compiled without error by regcomp.
>> Let's do the same for the word_regex patterns.  This should help catch any
>> cross-platform incompatibilities that exist between the pattern creator's
>> system and the various platforms that the test suite is commonly run on.
> 
> Definitely something we should be doing, but one nit:
> 
>> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
>> index 61de8a2..620cd02 100755
>> --- a/t/t4018-diff-funcname.sh
>> +++ b/t/t4018-diff-funcname.sh
>> @@ -40,6 +40,11 @@ do
>>  		! ( git diff --no-index Beer.java Beer-correct.java 2>&1 |
>>  			grep "fatal" > /dev/null )
>>  	'
>> +	test_expect_success "builtin $p wordRegex pattern compiles" '
>> +		! ( git diff --no-index --word-diff \
>> +			Beer.java Beer-correct.java 2>&1 |
>> +			grep "fatal" > /dev/null )
>> +	'
> 
> Why the subshell? Shouldn't just testing the pipeline outcome work?

Notice the similarity between the added lines and the lines just
above them?  Where were you when I submitted those? :)

Thanks,
-Brandon
