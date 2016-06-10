From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for
 files_ref_store
Date: Fri, 10 Jun 2016 14:02:48 +0200
Message-ID: <575AAC68.5000806@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
 <CAPig+cQqnDFQ1=ydQReJimVhL7WrjH9CD1RZ63ddCnNm=YVenA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 14:02:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBL9O-0004mh-TY
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbcFJMCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 08:02:55 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46895 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751559AbcFJMCx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 08:02:53 -0400
X-AuditID: 1207440d-bc7ff7000000090b-9e-575aac6cbcc7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DF.4B.02315.C6CAA575; Fri, 10 Jun 2016 08:02:52 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5AC2n48006033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 08:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CAPig+cQqnDFQ1=ydQReJimVhL7WrjH9CD1RZ63ddCnNm=YVenA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqJuzJircYPtBGYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8CdsXP1feaCk+IVj0/fYWpg/C/YxcjJISFgIrF4+w3G
	LkYuDiGBrYwSm3oamCCcC0wSX19tYwapEhYIk+iauo8dxBYR0Jb4sGETVMd5RokjT9vYQRxm
	gQVMEodnbGABqWIT0JVY1NPMBGLzAnW0bu4AKuLgYBFQlTj/OAgkLCoQInF+3VZWiBJBiZMz
	n4C1cgoESkz+3wkWZxZQl/gz7xIzhC0vsf3tHOYJjPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5
	iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghIc+7g/H/OplDjAIcjEo8vAw7IsOFWBPLiitz
	DzFKcjApifImzo8KF+JLyk+pzEgszogvKs1JLT7EKMHBrCTCm7oKKMebklhZlVqUD5OS5mBR
	EudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuBlWw3UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqX
	klqUWFqSEQ+KyvhiYFyCpHiA9gaAtPMWFyTmAkUhWk8x6nIc2X9vLZMQS15+XqqUOK8PSJEA
	SFFGaR7cCliCe8UoDvSxMG8wSBUPMDnCTXoFtIQJaMnyI+EgS0oSEVJSDYyNzPYL7T4w+k6V
	Z81lPMxjekzhHMtk3UJ1h6Cg2xxnu7Py3H43qby/P0Wh3fJC7e1nRZffBUsI9ajo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296971>

On 06/10/2016 10:08 AM, Eric Sunshine wrote:
> On Fri, Jun 3, 2016 at 5:03 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> We want ref_stores to be polymorphic, so invent a base class of which
>> files_ref_store is a derived class. For now there is a one-to-one
>> relationship between ref_stores and submodules.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> @@ -973,53 +967,54 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>> +/*
>> + * Downcast ref_store to files_ref_store. Die if ref_store is not a
>> + * files_ref_store. If submodule_allowed is not true, then also die if
>> + * files_ref_store is for a submodule (i.e., not for the main
>> + * repository). caller is used in any necessary error messages.
>> + */
>> +static struct files_ref_store *files_downcast(
>> +               struct ref_store *ref_store, int submodule_allowed,
>> +               const char *caller)
>>  {
>>         struct files_ref_store *refs;
>>
>> +       if (ref_store->be != &refs_be_files)
>> +               die("BUG: ref_store is type \"%s\" not \"files\" in %s",
>> +                   ref_store->be->name, caller);
>>
>> +       refs = (struct files_ref_store *)ref_store;
>> +
>> +       if (!submodule_allowed)
>> +               assert_main_repository(ref_store, caller);
>> +
>> +       return refs;
>>  }
> 
> Aside from returning the downcasted value, 'refs' doesn't seem to be
> used for anything, thus could be dropped and  the downcasted value
> returned directly:
> 
>     return (struct files_ref_store *)ref_store;
> 
> Not worth a re-roll.

Good point. I'll fix it.

>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> @@ -521,11 +521,89 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
>> +/*
>> + * A representation of the reference store for the main repository or
>> + * a submodule. The ref_store instances for submodules are kept in a
>> + * linked list.
>> + */
>> +struct ref_store {
>> +       /* The backend describing this ref_store's storage scheme: */
>> +       const struct ref_storage_be *be;
>> +
>> +       /*
>> +        * The name of the submodule represented by this object, or
>> +        * the empty string if it represents the main repository's
>> +        * reference store:
>> +        */
>> +       const char *submodule;
> 
> Tangent: Apart from backward compatibility due to all the existing
> code which tests *submodule to distinguish between the main repository
> and a submodule, is there a technical reason that this ought to store
> an empty string rather than (the more idiomatic) NULL to signify the
> main repository?

No, this was just how the old code worked and I just haven't gotten
around to changing it. I actually started doing the conversion once, but
it was turning into too much of a distraction, so I added the item to my
TODO list instead.

Michael
