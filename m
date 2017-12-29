Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54681F404
	for <e@80x24.org>; Fri, 29 Dec 2017 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbdL2OEX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 29 Dec 2017 09:04:23 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp ([133.41.12.55]:27801 "HELO
        huc12-ckmail02.hiroshima-u.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1750905AbdL2OEW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Dec 2017 09:04:22 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp (localhost [127.0.0.1])
        by dummy.hiroshima-u.ac.jp (Postfix) with ESMTP id 1C0A5167029;
        Fri, 29 Dec 2017 23:04:21 +0900 (JST)
Received: from huc12-smtp01.hiroshima-u.ac.jp (huc12-smtp01.hiroshima-u.ac.jp [133.41.12.52])
        by huc12-ckmail02.hiroshima-u.ac.jp (Postfix) with ESMTP id 1129A4E39;
        Fri, 29 Dec 2017 23:04:21 +0900 (JST)
Received: from [133.41.217.107] (217-107.cup.hiroshima-u.ac.jp [133.41.217.107])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by huc12-smtp01.hiroshima-u.ac.jp (Postfix) with ESMTPSA id 09906D3471;
        Fri, 29 Dec 2017 23:04:21 +0900 (JST)
Message-ID: <5A464B6D.1010102@hiroshima-u.ac.jp>
Date:   Fri, 29 Dec 2017 23:04:29 +0900
From:   suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Junio C Hamano <gitster@pobox.com>, avarab@gmail.com
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-archive: accepts --owner --group aslike GNU tar.
References: <20171228090527.25056-1-mpsuzuki@hiroshima-u.ac.jp> <548d442f05e24e22a1cf4e0074f23f16@OS2PR01MB1147.jpnprd01.prod.outlook.com>
In-Reply-To: <548d442f05e24e22a1cf4e0074f23f16@OS2PR01MB1147.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1808-8.1.0.1062-23560.003
X-TM-AS-Result: No--12.258-10.0-31-10
X-imss-scan-details: No--12.258-10.0-31-10
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-MatchedRID: 7bm+sNYxqsZITndh1lLRAe5i6weAmSDKp/xyq10Na6cbIszkLg3+MeFC
        kwH4BI1v4Zg/Bawpaj2Wx/CoW9y5jNuMXzh4YuvyBEfU2vugRF0UqWKocoJo6SUUPaRV5do4Oq7
        cUynyolVeL0AIhlwMMjwLILmNaFe8ZCSBV6VCLjXx5KZMlKYS/cdvO1Rp+sgmmI1RpP/+oMmoBf
        Cx2HzmBpbTSn0tZbEP79qQreYAxVf96A2LlkWhmHQEQEU5OIef7f6JAS2hKPgL/50zj0KL7Pz8v
        ajouc6XY1S8Eynlu8Jfm5yulXbrRZYeam+R4okHMQFn2MESINE2Ag6nbdtNWd14Aqe8EzF8pmLG
        Y/BSLFLrPvoOyguoo09AnH5ZaFw7mOB2bikpqTBKNzbmytc2CBeN8ZMPETMt+y7yU0OquytRTU0
        EGTEAlZmOWQgbks9H6iZnFJHRET7cx97ZZVZcMp4CIKY/Hg3AnCGS1WQEGtCduxHPxofvNpYzX8
        0HJ4XXRHBmOnaJEu/EQdG7H66TyH4gKq42LRYkn4VdUfOfvspoEpxr0691PpRnQzsd7HzEPc8L6
        xPKWZZ+3BndfXUhXQ==
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio, Ævar

Thank you very much for your reviews, in spite of my many
overlooking of the requirements written in the documents.

To classify various cases, I modified my patch heavily.
It would be posted soon.

I found that some Python scripts are included in the git
repository, but nothing in t/ directories. A helper written
in Python is not welcomed? If so, I would rewrite the
helper in C (perl's standard library does not have a parse
of tarfile). So, please do not review parse-tar-file.py.

Regards,
mpsuzuki

Junio C Hamano wrote:
> suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp> writes:
> 
>> Current tar output by git-archive has always root:root.
> 
> Thanks for a patch.  On top of Ævar's comments...
> 
>> ...
>> * t/t5005-archive-uid-gid.sh: a test script comparing
>>   uid, gid, uname, gname between the options and
>>   generated tar file.
>> ---
> 
> Before the "---" line, we need to get the patch signed off by the
> author (see Documentation/SubmittingPatches).
> 
>> diff --git a/archive-tar.c b/archive-tar.c
>> index c6ed96ee7..8546a6229 100644
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -204,10 +204,10 @@ static void prepare_header(struct archiver_args *args,
>>  	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
>>  	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
>>  
>> -	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
>> -	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
>> -	strlcpy(header->uname, "root", sizeof(header->uname));
>> -	strlcpy(header->gname, "root", sizeof(header->gname));
>> +	xsnprintf(header->uid, sizeof(header->uid), "%07o", args->uid);
>> +	xsnprintf(header->gid, sizeof(header->gid), "%07o", args->gid);
>> +	strlcpy(header->uname, args->uname ? args->uname : "root", sizeof(header->uname));
>> +	strlcpy(header->gname, args->gname ? args->gname : "root", sizeof(header->gname));
> 
> Would it be cleaner to make sure aregs->[gu]name is always set
> (i.e. stuff "root" when it is not given)?
> 
>>  	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
>>  	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
>>  
>> diff --git a/archive.c b/archive.c
>> index 0b7b62af0..db69041f1 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -8,6 +8,7 @@
>>  #include "parse-options.h"
>>  #include "unpack-trees.h"
>>  #include "dir.h"
>> +#include "git-compat-util.h"
> 
> The coding guideline says that "git-compat-util.h" (or one of the
> well-known header that includes it) should be the first file to be
> included, and we already include "cache.h" as the first thing, so
> I do not think you want this addition here.
> 
>> @@ -417,6 +418,57 @@ static void parse_treeish_arg(const char **argv,
>>  	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
>>  	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
>>  
>> +static void set_args_uname_uid(struct archiver_args *args,
>> +		const char* tar_owner, int set_gid_too)
> 
> The asterisk sticks to the variable name, not the type name, i.e.
> 
> 	const char *tar_owner
> 
>> +{
>> +	if (!args || !tar_owner)
>> +		return;
>> +
>> +	const char* col_pos = strchr(tar_owner, ':');
>> +	struct passwd* pw = NULL;
> 
> Decl after statement.
> 
>> +	if (col_pos) {
>> +		args->uname = xstrndup(tar_owner, col_pos - tar_owner);
>> +		args->uid = atoi(col_pos + 1);
>> +		return;
>> +	}
>> +
>> +	args->uname = xstrndup(tar_owner, strlen(tar_owner));
>> +	pw = getpwnam(tar_owner);
>> +	if (!pw)
>> +		return;
> 
> This means that upon error, the caller gets a half-filled args
> structure and without any indication.
> 
>> diff --git a/t/parse-tar-file.py b/t/parse-tar-file.py
> 
> Hmph.  Do we still use Python around here?
> 

