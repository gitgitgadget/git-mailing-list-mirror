Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD9F1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756007AbdACTo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:44:59 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35980 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdACTo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:44:57 -0500
Received: by mail-it0-f65.google.com with SMTP id n68so51758262itn.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5TJurEigN9xwmgbVbfacrzskDdc9YCm/F2hvHD6MewU=;
        b=gwtayrsYpFkxWoDQ0dU9PjoAOIsmCsLekL352tz1OJq+sNz0eNnk+H7KnsH5ogTSUd
         nROo74Mt2gpybCoGdxAMdHHGAZWq0widuEs4tPrlZKsA6Pa11dNSjI/6w3iLTkTOgzFA
         F6K1pl5Q+lMwA6PX+TaTrIkYDb4pAjhmA6nlOvKxiBRTp+pgKvl7l4HWXaZURqqh2p35
         84Xwgf2fN5fRCNrOgyUqu0W13HNdW/lAamzi439afhznH0XDJQB9Qw1zEuU2Z5dLEUYH
         6WTfOCrzzXQE/Ztxnj91o+PrxUFG0PdQTJ+D6xmteQkZw+N7lLPI7nEkxFo2Fzv+oWWS
         A/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5TJurEigN9xwmgbVbfacrzskDdc9YCm/F2hvHD6MewU=;
        b=hYyuAmZXVZhNlNOSoHYkY656V8YL70icRTfCf20obBQ0r9MSlG32viVxhYfN5GTKYz
         J1Ltrys4npX9XXOl+QYqa/3SOAnBeucknDAx5SY4ambom85XkTTo8USr5maYcbbPwrwj
         9owU7W81LrVHf8NGsg2kkvYYsfDaBddvRDroUHnHELjBZZU4OSTBQDmd1QOBTxmKDiJ5
         oEpZ7FM/n0DHpd/fByJ4R8PndZlwaoa7V4MAP5OaNHDSRpqnmwgmXONgaht6mavCOdxh
         aQ2MwD8mlEeDR8GPdUbuWxtFpg0DjdWeiavKJN4nJGR8z6dl5YaBloimWObVBqJG+hyk
         GocQ==
X-Gm-Message-State: AIkVDXLTzCdGIA/U+SrvD+tkMlCydY6GI5XC1U2qIvGWAfBlUKbtGD8E+5DrOEvCP/FPczoLSKD+o/D7xFt2Dw==
X-Received: by 10.36.61.207 with SMTP id n198mr55847149itn.60.1483472696751;
 Tue, 03 Jan 2017 11:44:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 3 Jan 2017 11:44:56 -0800 (PST)
In-Reply-To: <CAGZ79kZRFLzD7wcAnFvke9vBxxTAgE7=Ud7F_O95EfkWqz=LJw@mail.gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <20170102184536.10488-1-pranit.bauva@gmail.com> <20170102184536.10488-2-pranit.bauva@gmail.com>
 <CAGZ79kZRFLzD7wcAnFvke9vBxxTAgE7=Ud7F_O95EfkWqz=LJw@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 4 Jan 2017 01:14:56 +0530
Message-ID: <CAFZEwPPfE_WSn2QbmER+5mkaC8RnVDs5gsSJE+Y0v-CfYaZB2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t9813: avoid using pipes
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, luke@diamond.org,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stefan,

On Tue, Jan 3, 2017 at 11:28 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jan 2, 2017 at 10:45 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> The exit code of the upstream in a pipe is ignored thus we should avoid
>> using it.
>
> for commands under test, i.e. git things. Other parts can be piped if that makes
> the test easier. Though I guess that can be guessed by the reader as well,
> as you only convert git commands on upstream pipes.
>
>> By writing out the output of the git command to a file, we can
>> test the exit codes of both the commands.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> Thanks for taking ownership of this issue as well. :)

Welcome! ;)

>> ---
>>  t/t9813-git-p4-preserve-users.sh | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
>> index 798bf2b67..9d7550ff3 100755
>> --- a/t/t9813-git-p4-preserve-users.sh
>> +++ b/t/t9813-git-p4-preserve-users.sh
>> @@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
>>                 make_change_by_user usernamefile3 Derek derek@example.com &&
>>                 P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
>>                 export P4EDITOR P4USER P4PASSWD &&
>> -               git p4 commit |\
>> -               grep "git author derek@example.com does not match" &&
>> +               git p4 commit >actual 2>&1 &&
>
> Why do we need to pipe 2>&1 here?
> Originally the piping only fed the stdout to grep, so this patch changes the
> test? Maybe
>
>     2>actual.err &&
>     test_must_be_empty actual.err
>
> instead?

I tried this out but it seems that travis-ci build fails[1]. And I
don't have p4 on my machine to test what's happening actually. But I
just pushed out a few thing modifications to travis and it seems that
actual.err isn't really empty for some reason. So I think, I just
leave it as,

git p4 commit >actual &&
grep "git author derek@example.com does not match" actual &&

What do you think?

[1]: https://travis-ci.org/pranitbauva1997/git/jobs/188633734

Regards,
Pranit Bauva
