From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Wed, 25 Jul 2012 19:36:22 +0100
Message-ID: <50103CA6.4050901@ramsay1.demon.co.uk>
References: <500AEB11.4050006@ramsay1.demon.co.uk> <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk> <20120724192103.GB5210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su7Zn-0005nh-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 21:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2GYTsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 15:48:51 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:43385 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752250Ab2GYTsu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 15:48:50 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id DC040A0C080;
	Wed, 25 Jul 2012 20:48:48 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 18A65A0C07F;	Wed, 25 Jul 2012 20:48:48 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Wed, 25 Jul 2012 20:48:47 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120724192103.GB5210@burratino>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202188>

Jonathan Nieder wrote:
> [...]
>> No, I don't think this would be a good direction to go in. This may
>> not be a good idea either, but if you wanted to add a check here, then
>> maybe something like this (totally untested):
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index acda33d..53a2422 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -354,6 +354,9 @@ test_done () {
>>  	case "$test_failure" in
>>  	0)
>>  		# Maybe print SKIP message
>> +		if test -n "$skip_all" && test $test_count -gt 0; then
>> +			error "Can't use skip_all after running some tests"
>> +		fi
>>  		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
>>  
>>  		if test $test_external_has_tap -eq 0; then
> 
> I think preventing invalid TAP output like this would be a very good
> thing!  As a start, this patchlet looks good to me, and then I guess
> we'll have to think more about what happens when a person wants to
> skip_all_remaining after a test has already been run.
> 
> Care to format it as a "git am"-able patch, or should I?

Yes, I will happily create a proper (tested) patch and send it to the list.

However, given that we are now in the RC period, I probably won't get to it
immediately; I need to set aside *at least* one full evening to running the
testsuite on cygwin! ;-)

ATB,
Ramsay Jones
