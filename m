From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 37/38] refs: make lock generic
Date: Thu, 9 Jun 2016 17:21:30 +0200
Message-ID: <5759897A.7040502@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <d2a3cb56d7276c00174a08fe609d63e00755b205.1464983301.git.mhagger@alum.mit.edu>
 <xmqqlh2griq3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:25:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB1mA-000074-5P
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 17:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbcFIPVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 11:21:36 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63408 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932075AbcFIPVf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 11:21:35 -0400
X-AuditID: 1207440d-bc7ff7000000090b-81-5759897ed08a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 22.F5.02315.E7989575; Thu,  9 Jun 2016 11:21:34 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59FLVPh009209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 11:21:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqlh2griq3.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqFvXGRlucOUcn8X8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1hZn3jQyOrB77Jx1l93jWe8eRo+Ll5Q99i/dxuax+IGXx4Ln
	99k9Pm+SC2CP4rZJSiwpC85Mz9O3S+DOmHBoMXPBf+6KmYefMTcwPuTsYuTkkBAwkZjQf4S5
	i5GLQ0hgK6NE77eVbBDOeSaJg7/XsIJUCQsYSRx/1coMYosIqElMbDvEAlG0k1Fi37IZYA6z
	wCwmiY6tFxlBqtgEdCUW9TQzgdi8AtoSqzdPZAGxWQRUJM6v2swGYosKhEicX7eVFaJGUOLk
	zCdgNZwC1hInOs+AzWEW0JPYcf0XK4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6
	uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIUHPu4Px/zqZQ4wCHIxKPLwaKRHhQqyJZcWV
	uYcYJTmYlER5Zdojw4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8Na1AeV4UxIrq1KL8mFS0hws
	SuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8mzqAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPz
	UlKLEktLMuJBcRlfDIxMkBQP0F65TpC9xQWJuUBRiNZTjLocR/bfW8skxJKXn5cqJc6bDLJD
	AKQoozQPbgUsxb1iFAf6WJiXH6SKB5ge4Sa9AlrCBLRk+ZFwkCUliQgpqQbGyZuSOHP/nD9x
	ZG6Se8qcD0sCn7BJvD9VMHNBRnpEpeeed+GaF+cwJ4Qz/Q9co3+u7eWHSU5c2w/6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296894>

On 06/07/2016 07:50 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> From: David Turner <dturner@twopensource.com>
>>
>> Instead of including a files-backend-specific struct ref_lock, change
>> the generic ref_update struct to include a void pointer that backends
>> can use for their own arbitrary data.
> 
> Hmph.

I don't know what your comment means. This step is a consequence of the
design decision to stick with a single ref_transaction class that is
used by all ref_stores, which was nice because it avoided the need to
virtualize the functions
ref_transaction_{begin,update,create,delete,verify}.

>> @@ -3591,7 +3590,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>  		for (parent_update = update->parent_update;
>>  		     parent_update;
>>  		     parent_update = parent_update->parent_update) {
>> -			oidcpy(&parent_update->lock->old_oid, &lock->old_oid);
>> +			struct ref_lock *parent_lock = parent_update->backend_data;
>> +			oidcpy(&parent_lock->old_oid, &lock->old_oid);
>>  		}
>> ...
>> @@ -3745,7 +3745,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
>>  	/* Perform updates first so live commits remain referenced */
>>  	for (i = 0; i < transaction->nr; i++) {
>>  		struct ref_update *update = updates[i];
>> -		struct ref_lock *lock = update->lock;
>> +		struct ref_lock *lock = update->backend_data;
> 
> OK, and files_* backend method downcasts it to what it wants, which
> is good.

Michael
