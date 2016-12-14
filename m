Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8E71FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbcLNSwK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 13:52:10 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33170 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbcLNSwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 13:52:09 -0500
Received: by mail-qt0-f181.google.com with SMTP id p16so32031947qta.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 10:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bAeRjDq5Q0Lo4uSkyLAOsLTojzRc4/LXhuSuXxXx/2M=;
        b=oCHhXimnTD2aqHsIP3nU/S95R4CKyvg4ieyvl1LFkKri3ApGCjFUMAFjHoPi1xJHxO
         YcwD9J3Ftp+vwoivb073RrpZS1o7gMT4J+u/LPe27L2VZwplnOpGp60OenjB+dJL08f6
         HqeyRK3IypNaVPOUnN5gIcIo9inTRKaSVMtQTFBJJf9syCwawkN9x7rzsbAkGyn/qf/O
         eklMroqCUTCl1Hpm7OJqxTFWt+FVsqUtpQeChU7sEy50doglQAf6Zt/A4Ml29w32a6ta
         PPLTZae/hVjYdLKVkQRaZ2N6X7zwPPnz6pv+09otLxY8Yj7J1X8IXUOPuDwTiOmpD9rL
         zIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bAeRjDq5Q0Lo4uSkyLAOsLTojzRc4/LXhuSuXxXx/2M=;
        b=B+RrJ7izjI9NV+8aBljy9ikSbd54ql3h3j86ml1QPVZOAoLdswIDSKYh9vNClw6hjz
         DFpP44meARlrxdzNS8YqkYAWliEBCahpKLgcILcorcgoWXRYfha9XTYl5iMXJEzhkBM4
         maVTUz0s85mD5/5i2H9QSDQaPd+4akuwBWFmfMF8hf+08MxRerTBfossj9ZFg95UUNIt
         nU0Lo/Yld4ZI5Rd2wHGNIVtjgYUBFrGiNHrkHiVf/h1lY5yBUlf72hTwKxxNJBVzbR5C
         Ng9DaSb19IbIw1UcfGdSHApAUk7w5cQZVReWMCMTH8QgbSQ/ZesBzaT2xvKLRlhDAV3/
         IJSQ==
X-Gm-Message-State: AKaTC019TPxWOP3ztJsM1gE2PLjXVJmCckcMtins4x47hI5fDkpRxsLMxl8gZFX0gVrR7do21pViOjk44I81lazT
X-Received: by 10.200.50.53 with SMTP id x50mr88578164qta.207.1481741528473;
 Wed, 14 Dec 2016 10:52:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 14 Dec 2016 10:52:07 -0800 (PST)
In-Reply-To: <xmqqbmwexs9x.fsf@gitster.mtv.corp.google.com>
References: <20161213205622.841-1-sbeller@google.com> <20161213205622.841-5-sbeller@google.com>
 <xmqqbmwexs9x.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Dec 2016 10:52:07 -0800
Message-ID: <CAGZ79kZ=PqTKt5xDobnR5oqwz84i10ZobmQb6QqeA3aSkbrd8Q@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] ok_to_remove_submodule: absorb the submodule git dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 10:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> It is a major reason to say no, when deciding if a submodule can be
>> deleted, if the git directory of the submodule being contained in the
>> submodule's working directory.
>>
>> Migrate the git directory into the superproject instead of failing,
>> and proceed with the other checks.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 2d13744b06..e42efa2337 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1026,11 +1026,22 @@ int ok_to_remove_submodule(const char *path, unsigned flags)
>>       struct strbuf buf = STRBUF_INIT;
>>       int ok_to_remove = 1;
>>
>> +     /* Is it there? */
>>       if (!file_exists(path) || is_empty_dir(path))
>>               return 1;
>>
>> -     if (!submodule_uses_gitfile(path))
>> -             return 0;
>> +     /* Does it have a .git directory? */
>> +     if (!submodule_uses_gitfile(path)) {
>> +             absorb_git_dir_into_superproject("", path,
>> +                     ABSORB_GITDIR_RECURSE_SUBMODULES);
>> +
>> +             /*
>> +              * We should be using a gitfile by now. Let's double
>> +              * check as losing the git dir would be fatal.
>> +              */
>> +             if (!submodule_uses_gitfile(path))
>> +                     return 0;
>> +     }
>
> It feels a bit funny for a function that answers yes/no question to
> actually have a side effect, but probably it is OK.  It feels dirty,
> but I dunno.

Another approach would be to return more than yes/no but the reason
why it is a no. And then the caller would call absorb_git_dir_into_superproject.

> A brief reading of the above makes us wonder what should happen if
> the absorb_git_dir_into_superproject() call fails, but a separate
> "submodule_uses_gitfile()" is needed to see if it failed?  Perhaps
> the function needs to tell the caller if it succeeded?

I don't know about the double check as I think we should really be sure before
deleting that repo, but absorb_git_dir_into_superproject would fail/die
if it would not actually absorb it, so maybe it is too much caution.

So I'd omit the double check in a reroll.

>
>>
>>       argv_array_pushl(&cp.args, "status", "--porcelain",
>>                                  "--ignore-submodules=none", NULL);
