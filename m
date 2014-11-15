From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Sat, 15 Nov 2014 08:42:53 +0100
Message-ID: <546703FD.9070507@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu> <1416036379-4994-3-git-send-email-mhagger@alum.mit.edu> <5467018D.7000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpY0x-0007m4-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbaKOHnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 02:43:09 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62698 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752675AbaKOHnH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 02:43:07 -0500
X-AuditID: 12074413-f792c6d000000bc8-21-546703ff0255
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.B9.03016.FF307645; Sat, 15 Nov 2014 02:42:55 -0500 (EST)
Received: from [192.168.69.130] (p5DDB2373.dip0.t-ipconnect.de [93.219.35.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAF7grSq012186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 15 Nov 2014 02:42:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <5467018D.7000103@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqPufOT3EYNZbcYuuK91MFg29V5gt
	Fv47ym6xvynJYk33DiYHVo+ds+6ye1y8pOzxeZOcR/OU86wBLFHcNkmJJWXBmel5+nYJ3Bk7
	J5YUrOWoWLXzNXsD43m2LkZODgkBE4mpS7cxQthiEhfurQeKc3EICVxmlPj1ogXKOc8k8WDN
	O3aQKl4BbYljt7Yyg9gsAqoS71q2MoHYbAK6Eot6msFsUYEgiZN7rkPVC0qcnPmEBcQWEfCT
	2LjoFVicWSBH4sHHD2C2sECYxPQJJ6GWzWCUuLRrFdgCTgFNiR3bN7BCNOhJ7Lj+C8qWl9j+
	dg7zBEaBWUh2zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsY
	IYEtvINx10m5Q4wCHIxKPLwXJqWFCLEmlhVX5h5ilORgUhLlLbgDFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCe+Q7UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMH7
	gik9REiwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKvxxcBoBUnxAO29AdLOW1yQ
	mAsUhWg9xagoJc67GiQhAJLIKM2DGwtLV68YxYG+FObdCFLFA0x1cN2vgAYzAQ1mPJYKMrgk
	ESEl1cDIPVNa9IvHsYRTxo0LTjw+eevUqetP0wwDJI7o+E6YPyGj7dq7dKaym48+TY48lLmj
	pGTGnqL7TG8sbx0Vvc6lUT61dvJh/kNcDwrrL08pDAp4xhWxzths0u9Xs8qaXjTU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2014 08:32 AM, Stefan Beller wrote:
> On 14.11.2014 23:26, Michael Haggerty wrote:
>> There is no reason for $GIT_DIR/config to be executable, plus this
>> change will help clean up repositories affected by the bug that was
>> fixed by the previous commit.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  config.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 9e42d38..0942e5f 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1653,7 +1653,15 @@ int git_config_set_multivar_in_file(const char *config_filename,
>>  			MAP_PRIVATE, in_fd, 0);
>>  		close(in_fd);
>>  
>> -		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
>> +		/*
>> +		 * We make of the executable bits because (a) it
> 
> We make *use* of

Thanks for catching this. But it's even worse. I meant to type "mask off".

Junio, would you mind fixing this if there is no other reason for a
re-roll? Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
