From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 21/38] refs: make pack_refs() virtual
Date: Thu, 9 Jun 2016 16:46:45 +0200
Message-ID: <57598155.3040101@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <22e49ca0f50831538d07d115d56b4af4e457a80c.1464983301.git.mhagger@alum.mit.edu>
 <xmqqy46grjg5.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Thu Jun 09 16:47:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB1EZ-0003Tm-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 16:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbcFIOqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 10:46:50 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53325 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752058AbcFIOqt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 10:46:49 -0400
X-AuditID: 1207440f-8a7ff700000008e4-03-57598158b9c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E3.73.02276.85189575; Thu,  9 Jun 2016 10:46:48 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59EkjsW007328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 10:46:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqy46grjg5.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqBvRGBlu0DZVwWL+phOMFl1Xupks
	GnqvMFt0T3nLaPGjpYfZYuZVa4szbxoZHdg9ds66y+7xrHcPo8fFS8oe+5duY/NY/MDLY8Hz
	++wenzfJBbBHcdskJZaUBWem5+nbJXBn/FrsUrCPs2Lh7m3MDYyH2LsYOTkkBEwkFjT9Zeti
	5OIQEtjKKDH/9QNWCOc8k8Tj418YQaqEBSwlLu7YyAZiiwioSUxsO8QCUbSTUeLngaWMIA6z
	wCwmiY6tF8E62AR0JRb1NDOB2LwC2hJrn3wHi7MIqEh86Z4CtltUIETi/LqtrBA1ghInZz5h
	AbE5Bawl5uy5CWYzC+hJ7Lj+ixXClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzE
	zJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJCQ59/B2LVe5hCjAAejEg+vRkpEuBBrYllxZe4h
	RkkOJiVRXu+SyHAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwStUA53pTEyqrUonyYlDQHi5I4
	r/oSdT8hgfTEktTs1NSC1CKYrAwHh5IEL3cDUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpq
	UWJpSUY8KCrji4FxCZLiAdr7oR5kb3FBYi5QFKL1FKMux5H999YyCbHk5eelSonz/gEpEgAp
	yijNg1sBS3CvGMWBPhbm7QK5hAeYHOEmvQJawgS0ZPmRcJAlJYkIKakGRh25SctX/tBMWV+z
	aPbHFTlfxJ5kGy1fqpb0PI6/VcCwM+92AVe4ZPSb8yfilZPefrbqXcB/UKvXt1DT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296890>

On 06/07/2016 07:35 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c               | 7 +++++++
>>  refs/files-backend.c | 6 ++++--
>>  refs/refs-internal.h | 4 ++++
>>  3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 79ef443..f4f5f32 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1418,6 +1418,13 @@ void assert_main_repository(struct ref_store *refs, const char *caller)
>>  }
>>  
>>  /* backend functions */
>> +int pack_refs(unsigned int flags)
>> +{
>> +	struct ref_store *refs = get_ref_store(NULL);
>> +
>> +	return refs->be->pack_refs(refs, flags);
>> +}
>> +
> 
> Makes me wonder what it even means to "pack_refs" in the context of
> other possible backends (e.g. lmdb), but higher level API users
> (e.g. "gc") needs something to call to give the backend "here is a
> chance for you to optimize yourself" cue, so perhaps it is OK.

My thinking exactly. This might end up being renamed to optimize_refs()
and be made an optional part of the ref_store interface. But it seemed
premature to worry about that.

Michael
