From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/20] safe_create_leading_directories(): set errno on
 SCLD_EXISTS
Date: Thu, 18 Feb 2016 16:33:04 +0100
Message-ID: <56C5E430.1070705@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
 <7ddc8ac89f36b01494fbdc6f97bf1ca258b3e885.1455626201.git.mhagger@alum.mit.edu>
 <xmqqziuzi1jo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 16:40:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWQgw-0004qC-GX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 16:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425148AbcBRPk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 10:40:26 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43817 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756384AbcBRPkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2016 10:40:25 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2016 10:40:25 EST
X-AuditID: 12074412-b07ff70000006da4-ab-56c5e434d61a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F7.CB.28068.434E5C65; Thu, 18 Feb 2016 10:33:08 -0500 (EST)
Received: from [192.168.69.130] (p548D6911.dip0.t-ipconnect.de [84.141.105.17])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1IFX5JY007405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Feb 2016 10:33:06 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <xmqqziuzi1jo.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqGvy5GiYwdsuWYv5m04wWnRd6Way
	aOi9wmzxYe0hNoveyb2sFj9aepgd2Dyebp/C7PHifIXHs949jB4XLyl7LHh+n93j8ya5ALYo
	bpukxJKy4Mz0PH27BO6M17Oesxc84amY8rCRsYGxi6uLkZNDQsBEYsnXL0xdjFwcQgJbGSUW
	XDrIAuGcZ5K4duUtG0iVsECExPWWo0wgtoiAmsTEtkNQRTsZJU5N/MEK4jALbGCUaG5qYAWp
	YhPQlVjU08wEsUNOord7EguIzSugLfFvyk1GEJtFQFVi4/cedhBbVCBE4v3X56wQNYISJ2c+
	AavnFLCWOLvuGpjNLKAnseP6L1YIW16ieets5gmMArOQtMxCUjYLSdkCRuZVjHKJOaW5urmJ
	mTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCGhL7SDcf1JuUOMAhyMSjy8G14cCRNiTSwrrsw9
	xCjJwaQkyqu582iYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe3XuBcrwpiZVVqUX5MClpDhYl
	cd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErwTHgM1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+al
	pBYllpZkxIPiNb4YGLEgKR6gvZtA2nmLCxJzgaIQracYFaXEea1BEgIgiYzSPLixsIT2ilEc
	6Eth3pePgKp4gMkQrvsV0GAmoME5lw6BDC5JREhJNTDqJrVmGXalql/garNp5+hwXfx7/Rux
	7AOBtxw+RP2VWP9q1iHtWX9eddySdDmmd7Bqh7V4xvboxMPemqWztq/s+O0e9kUs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286609>

On 02/17/2016 08:23 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The exit path for SCLD_EXISTS wasn't setting errno, as expected by at
>> least one caller. Fix the problem and document that the function sets
>> errno correctly to help avoid similar regressions in the future.
> 
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 568120e..a1ac646 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -135,8 +135,10 @@ enum scld_error safe_create_leading_directories(char *path)
>>  		*slash = '\0';
>>  		if (!stat(path, &st)) {
>>  			/* path exists */
>> -			if (!S_ISDIR(st.st_mode))
>> +			if (!S_ISDIR(st.st_mode)) {
>> +				errno = EEXIST;
>>  				ret = SCLD_EXISTS;
> 
> Hmm, when does this trigger?  There is a non-directory A/B, you are
> preparing leading directories to create A/B/C/D, and you find A/B
> exists but is not a directory so you cannot create A/B/C underneath
> it?
> 
> That sounds more like ENOTDIR to me.

Yes, you're right. Thanks.

> Does the caller expect EEXIST, or both?

I don't know of any callers that branch based on errno, but several use
strerror() or die_errno() to report the error to the user. The few
callers that care about the reason for the failure base their behavior
on the return value.

But there are a lot of callers and I haven't audited each of them
carefully. Given that this error path currently doesn't necessarily set
errno *at all*, I think using a plausible value is strictly an improvement.

I'll change it to ENOTDIR in the next round.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
