From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 12/16] diff: use tempfile module
Date: Wed, 12 Aug 2015 17:13:59 +0200
Message-ID: <55CB62B7.8060706@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>	<404c8bc508639a5723420691d9daa122f10d7cd4.1439198011.git.mhagger@alum.mit.edu> <xmqqbnedr3sp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPXjS-0005EN-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 17:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbbHLPOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 11:14:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53619 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753333AbbHLPOR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 11:14:17 -0400
X-AuditID: 12074412-f79a76d000007c8b-f9-55cb62baa9c0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AF.7F.31883.AB26BC55; Wed, 12 Aug 2015 11:14:02 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D5A.dip0.t-ipconnect.de [79.201.125.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7CFDxtI013969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 12 Aug 2015 11:14:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqbnedr3sp.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLsr6XSowdVfbBZdV7qZLBp6rzBb
	PJl7l9mB2ePhqy52j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y/PMZY0GzQsX/mRMZGxjv
	S3YxcnJICJhI3P3Rwghhi0lcuLeerYuRi0NI4DKjxIE5x5khnPNMEh3HVgNVcXDwCmhLvHpZ
	DtLAIqAq8XzSX3YQm01AV2JRTzMTSImoQJDE65e5IGFeAUGJkzOfsIDYIgJqEhPbDoHZzAKm
	ErcezmQDsYUFzCUmLl/BArFqK6PEpv/dTCAJTgFriXvfNzJBNOhJ7Lj+ixXClpdo3jqbeQKj
	wCwkO2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJDQFdrB
	uP6k3CFGAQ5GJR7em32nQoVYE8uKK3MPMUpyMCmJ8t5MOB0qxJeUn1KZkVicEV9UmpNafIhR
	goNZSYS3LgQox5uSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwbsyEahR
	sCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtXQ3SzltckJgLFIVo
	PcWoKCXOuwckIQCSyCjNgxsLS0ivGMWBvhTmTQWp4gEmM7juV0CDmYAGp8udAhlckoiQkmpg
	5P8xdUWK3eeGgJMdhsuLmZ02pznFzndsuKlwbdb2SDeNbslranaKTx5Lrv9aPq8/SvvIjgLG
	C8fO3IjjzY9yFq169yHeRevF2ezi4o4LR1cf/uL6IJHf97RmQeMU+UgvxrjjNRXW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275771>

On 08/11/2015 10:03 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  diff.c | 29 +++++++----------------------
>>  1 file changed, 7 insertions(+), 22 deletions(-)
> 
> Nice code reduction.
> 
>> diff --git a/diff.c b/diff.c
>> index 7500c55..dc95247 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2,6 +2,7 @@
>>   * Copyright (C) 2005 Junio C Hamano
>>   */
>>  #include "cache.h"
>> +#include "tempfile.h"
>>  #include "quote.h"
>>  #include "diff.h"
>>  #include "diffcore.h"
>> @@ -312,7 +313,7 @@ static struct diff_tempfile {
>>  	const char *name; /* filename external diff should read from */
>>  	char hex[41];
>>  	char mode[10];
>> -	char tmp_path[PATH_MAX];
>> +	struct tempfile tempfile;
>>  } diff_temp[2];
>>  
>>  typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
>> @@ -564,25 +565,16 @@ static struct diff_tempfile *claim_diff_tempfile(void) {
>>  	die("BUG: diff is failing to clean up its tempfiles");
>>  }
>>  
>> -static int remove_tempfile_installed;
>> -
>>  static void remove_tempfile(void)
>>  {
>>  	int i;
>>  	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
>> -		if (diff_temp[i].name == diff_temp[i].tmp_path)
>> -			unlink_or_warn(diff_temp[i].name);
>> +		if (is_tempfile_active(&diff_temp[i].tempfile))
>> +			delete_tempfile(&diff_temp[i].tempfile);
> 
> I suspect that this indicates that there is something iffy in the
> conversion.  The original invariant, that is consistently used
> between claim_diff_tempfile() and remove_tempfile(), is that .name
> field points at .tmp_path for a slot in diff_temp[] that holds a
> temporary that is in use.  Otherwise, .name is NULL and it can be
> claimed for your own use.

No, prepare_temp_file() sometimes sets diff_tempfile::name to
"/dev/null", and sometimes to point at its argument `name`. In either of
these cases .tmp_path can hold anything, and the file is *not* cleaned
up even though the diff_temp entry is considered by
claim_diff_tempfile() to be in use.

If I'm not mistaken, the old invariant was:

* Iff diff_tempfile::name is NULL, the entry is not in use.
* Iff diff_tempfile::name == diff_tempfile::tmp_path, then the entry is
in use and refers to a temporary file that needs to be cleaned up.
* Otherwise, the entry is in use but the corresponding file should *not*
be cleaned up.

The new invariant is:

* Iff diff_tempfile::name is NULL, the entry is not in use. In these
cases, is_tempfile_active() is always false.
* Iff is_tempfile_active(diff_tempfile::tempfile), then it refers to a
file that needs to get cleaned up. In these cases name points at the
tempfile object's filename.
* If neither of the above is true, then the entry is in use but the
corresponding file should not be cleaned up.

> Here the updated code uses a different and new invariant: .tempfile
> satisfies is_tempfile_active() for a slot in use.  But the check in
> claim_diff_tempfile() still relies on the original invariant.

That is not true. The is_tempfile_active() check is only used in
remove_tempfile() when deciding whether to clean up the file. The check
in claim_diff_tempfile() wants to know whether the entry is in use, so
it uses the other check.

> The updated code may happen to always have an active tempfile in
> tempfile and always set NULL when it clears .name, but that would
> mean (1) future changes may easily violate one of invariants (we
> used to have only one, now we have two that have to be sync) by
> mistake, and (2) we are keeping track of two closely linked things
> as two invariants.
> 
> As the value that used to be in the .name field can now be obtained
> by calling get_tempfile_path() on the .tempfile field, perhaps we
> should drop .name (and its associated invariant) at the same time?

This is also incorrect. See my first paragraph above.

I will change this patch to document the invariants.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
