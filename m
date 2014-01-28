From: David Sharp <dhsharp@google.com>
Subject: Re: [PATCH v2] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 14:02:04 -0800
Message-ID: <CAJL_ekuuu+AZH7n4fKzUXqou-nhf96QpcQ-utvMNYRjx4BrTUg@mail.gmail.com>
References: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com>
 <1390944060-783-1-git-send-email-dhsharp@google.com> <xmqqmwiflr37.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 23:02:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Gjl-0007Y8-5z
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 23:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbaA1WCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 17:02:25 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51652 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728AbaA1WCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 17:02:24 -0500
Received: by mail-ie0-f178.google.com with SMTP id x13so1175335ief.23
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 14:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xgNAoFVIrCiB6rBTCJhe5UpzPiQX3IDCbX3l9krk4Fg=;
        b=a/QKTKH0x8Yw2Toql8wEf1O++hWC9sSD0YBNpuApxGT+q/Q674unjFuhY+N1bdWNd0
         oHvQDtEn4sYBHRLSvFH9vsH/j/8jIZawf4P8yYks2OdiH++vDlbOnXQsqf+DK4cUJIpz
         4zcQF5ebP4H0qh6ElTr8/BEzfPKdgGGKUPtiod+GuienHGyWnfKhRby7e9IBixKCOYvU
         w+ACYOzJzolrILlUae/fs/tx98u8uwDmpAOkVNxCDDDLU6b6PlohBDTDOp2ybhbcGA9t
         6BpEUPdGUArLXf0NP/GaUQlLV1hVpWQ8nGaLFgSKiKQVuZJ88daxBVjLeg4rq0ralh3t
         Sw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xgNAoFVIrCiB6rBTCJhe5UpzPiQX3IDCbX3l9krk4Fg=;
        b=CTQXP8QXlVeZSouSPS/4p0XZ3yaMl7iP2yhTx1L9ypZjgYaptkq5c1ruCCPKoaDmS8
         m8obibRe1WNx2yy6Vw268L96LvLDWvCtgcaV+pHlqPeQcuTa/mMOL3W9NwS8/U7uJGmg
         gg4KLG6FvQPNwHV4qwuexkcSUxjMSdbjFbGou+tv8HUAVELn3DMIEhaFpF3vBghhzBYq
         74RHs1uk31LCKU7VDWprusHsCClHuMxaYGKC/6DDXiT4UMJ5FIzxfSPrVzniS76uBXIp
         5PIfA5isct6FTAxMq4cZmEpvp4aTVTB5g37kemyDDJY4+X2s/7UQnwsEAJWfYlsztg2E
         j2XQ==
X-Gm-Message-State: ALoCoQm/pE/rUxOv9gvcaM5jBtLyu+UL3OUaXbOJnMpq2aLzYk+K+PK+RjdAJq98VsKm4RWFE7oyg5eoA0wSU83iITsNhc6cHdCXE/qpReP2qhZczjcyBb7aWUPi/cr7wo30NUcuYE8oHv/8wJxcqw/fQ6YNyBLTxJEjpfEqHYhuj+BtyO3o94BeoKqj9cuL53Tv094jQ+pZ
X-Received: by 10.50.78.200 with SMTP id d8mr5138719igx.38.1390946544449; Tue,
 28 Jan 2014 14:02:24 -0800 (PST)
Received: by 10.64.224.137 with HTTP; Tue, 28 Jan 2014 14:02:04 -0800 (PST)
In-Reply-To: <xmqqmwiflr37.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241196>

On Tue, Jan 28, 2014 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Sharp <dhsharp@google.com> writes:
>
>> Without this patch, git-rev-parse --prefix, --default, or
>> --resolve-git-dir, without a value argument, would result in a segfault.
>> Instead, die() with a message.
>
> When I sent the review message, I actually was on the fence between
> checking i vs argc and checking the nullness myself.  I realize,
> after seeing the actual patch below, that we are protecting against
> picking up a NULL and blindly passing it on in the codepaths that
> follow, so the updated code does look a lot better, at least to me.

It's a matter of perspective, I guess. When checking the index, to me,
I saw that it is protecting against reading past the end of an array,
which is at least as bad as sending NULL to codepaths that don't
accept NULL. I do think that everybody knows that reading past the end
of an array is bad, while not necessarily everybody knows that the
argv array is null-terminated.

>
> Thanks.
>
>>
>> Signed-off-by: David Sharp <dhsharp@google.com>
>> ---
>>  builtin/rev-parse.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>> index aaeb611..45901df 100644
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -547,15 +547,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>>                               continue;
>>                       }
>>                       if (!strcmp(arg, "--default")) {
>> -                             def = argv[i+1];
>> -                             i++;
>> +                             def = argv[++i];
>> +                             if (!def)
>> +                                     die("--default requires an argument");
>>                               continue;
>>                       }
>>                       if (!strcmp(arg, "--prefix")) {
>> -                             prefix = argv[i+1];
>> +                             prefix = argv[++i];
>> +                             if (!prefix)
>> +                                     die("--prefix requires an argument");
>>                               startup_info->prefix = prefix;
>>                               output_prefix = 1;
>> -                             i++;
>>                               continue;
>>                       }
>>                       if (!strcmp(arg, "--revs-only")) {
>> @@ -738,9 +740,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>>                               continue;
>>                       }
>>                       if (!strcmp(arg, "--resolve-git-dir")) {
>> -                             const char *gitdir = resolve_gitdir(argv[i+1]);
>> +                             const char *gitdir = argv[++i];
>>                               if (!gitdir)
>> -                                     die("not a gitdir '%s'", argv[i+1]);
>> +                                     die("--resolve-git-dir requires an argument");
>> +                             gitdir = resolve_gitdir(gitdir);
>> +                             if (!gitdir)
>> +                                     die("not a gitdir '%s'", argv[i]);
>>                               puts(gitdir);
>>                               continue;
>>                       }
