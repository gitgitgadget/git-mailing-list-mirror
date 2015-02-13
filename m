From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic
 references
Date: Fri, 13 Feb 2015 15:34:42 +0100
Message-ID: <54DE0B82.6090906@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu> <1423473164-6011-7-git-send-email-mhagger@alum.mit.edu> <20150212215421.GA19618@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 15:35:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMHKe-00066t-1H
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 15:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbbBMOeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 09:34:50 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63755 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839AbbBMOeu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 09:34:50 -0500
X-AuditID: 12074412-f79e46d0000036b4-70-54de0b8503ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 50.C0.14004.58B0ED45; Fri, 13 Feb 2015 09:34:45 -0500 (EST)
Received: from [192.168.69.130] (p5DDB38B4.dip0.t-ipconnect.de [93.219.56.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1DEYgSq012148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 Feb 2015 09:34:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <20150212215421.GA19618@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqNvKfS/EYMYDQYuuK91MFg29V5gt
	3t5cwmjRPeUto8WPlh5mi96+T6wWmze3sziwe+ycdZfdY8GmUo9nvXsYPS5eUvb4vEkugDWK
	2yYpsaQsODM9T98ugTtj2qy3rAWz2Cqe7jzJ3sB4l6WLkZNDQsBE4sim9UwQtpjEhXvr2boY
	uTiEBC4zSkxfP5MRwjnPJPG0ZT5rFyMHB6+AtkT7dg6QBhYBVYlVkw+BDWIT0JVY1NMMNkhU
	IEji0OnHYHFeAUGJkzOfgNkiArIS3w9vBJvJLDCbSeJz7yJGkISwQJjE+jePWCCWzQXafOU5
	G8gyTgE9iTMN+SA1zALqEn/mXWKGsOUltr+dwzyBUWAWkh2zkJTNQlK2gJF5FaNcYk5prm5u
	YmZOcWqybnFyYl5eapGumV5uZoleakrpJkZI2AvtYFx/Uu4QowAHoxIP7wu/uyFCrIllxZW5
	hxglOZiURHm1/wCF+JLyUyozEosz4otKc1KLDzFKcDArifBG3ADK8aYkVlalFuXDpKQ5WJTE
	eX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8H7kvBciJFiUmp5akZaZU4KQZuLgBBnOJSVSnJqX
	klqUWFqSEQ+K1fhiYLSCpHiA9nJyAbXzFhck5gJFIVpPMepyLGjfP5NJiCUvPy9VSpz3G8gO
	AZCijNI8uBWwJPeKURzoY2FeFpBRPMAECTfpFdASJqAlE2fcBllSkoiQkmpgLJy+4IWXy4bd
	N87yKdTvuDr3W0+RBE+rylTxgus+1qzPIrj2ux38+yjjyrXn3vYBr7tPV+o6ObHl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263808>

On 02/12/2015 10:54 PM, Jeff King wrote:
> On Mon, Feb 09, 2015 at 10:12:42AM +0100, Michael Haggerty wrote:
> 
>>  	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>> +		/*
>> +		 * It doesn't make sense to adjust a reference pointed
>> +		 * to by a symbolic ref based on expiring entries in
>> +		 * the symbolic reference's reflog.
>> +		 */
>> +		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
>> +			~(type & REF_ISSYMREF);
>> +
> 
> Isn't this second clause tautological? Unless REF_ISSYMREF covers all
> bits in "type", then "type & REF_ISSYMREF" must always have at least one
> bit 0, and negating it becomes non-zero. Did you mean:
> 
>    !(type & REF_ISSYMREF)
> 
> ?

You're right, of course. Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
