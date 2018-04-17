Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9421F404
	for <e@80x24.org>; Tue, 17 Apr 2018 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDQW3w (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 18:29:52 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:37520 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeDQW3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 18:29:51 -0400
Received: by mail-io0-f179.google.com with SMTP id y128-v6so106484iod.4
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=frpQ8twHplTXhzbB30fdzI+ibNtXfIjumtPjwCD8M8E=;
        b=Oqj7j8u+G4D0uB6FBbCMBwfv23X9dn7rssgG6shI2pIQR6GaX4h7OMDJAh8n8opJgG
         uC9yZHnfmfDmHsmwmiBD2qPFq1De7QBpcDEzgEp8KlxpbL//CFbnSsjm4JorqseCF/+o
         LN9X9enqD2avIfVJr2TyEWrp85g1THbF+zT9jbvoLkUwbFGWQDD0JaqyqlRGno+gdvVy
         MyFc0QvdNqsPudmDSi52qfhE39I0UyfdLNNs/wRNaEK4FG7IJXnyqqqLcRMmJV9Ymtuj
         EzYTxl/2XBF3aqWF0FJXE+HF/CV5RiDjCj+5ELp6f4cfbkkEUv6jpSNstECLOeBelqi9
         A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=frpQ8twHplTXhzbB30fdzI+ibNtXfIjumtPjwCD8M8E=;
        b=sm252PYtpm/J2igKZXJKnLOmi21GRCE37BAs+mNKulkQdNQW/YuaH1KZm/QlXuzU6p
         SiSW7AOx8Agm0JcrBoUpNb49WOkcE/3maK7OLI7bWS9RcTPTrvoiPoy6JiPb8Qr9hzM+
         s6FIUkViIm/tm8Apd30AqsS7T/Rgwr3xod0Km8GJ8D722PjsHiSXq+nwoNJSFh7g2mQZ
         3ItctIsX414k1MsFVQQMxK7PLyilGMZ+HK3FtS1nejY3Uf+mBfdDO3dbMJzOpHbgvlAU
         mbZDaRNgVPjE8oETzugRhFUmd3bdK5DLlGouzaqaahk9THjnaDxitn02jMwy8Ml9GvAr
         a46w==
X-Gm-Message-State: ALQs6tASfFh9tttk4MDc6ID7zTfws0v/RfGowx+Q9oKg5w4BUQCcYl2O
        9RuZDm92yrTHS/yxHL5sTMNe77X8TRehgu7H9nax3Q==
X-Google-Smtp-Source: AIpwx4/8TP6t84UReS21m2eYnH8Mpgw8di636k3i/Hs3pMvQtNk8mUvjYEJEkwyUZkUoDq1Th13oTfGjc3ov1jQEUZg=
X-Received: by 10.107.133.68 with SMTP id h65mr3701463iod.271.1524004190745;
 Tue, 17 Apr 2018 15:29:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a78a:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 15:29:10
 -0700 (PDT)
In-Reply-To: <BYAPR08MB3845AD0BC8F24814E0B9936EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com> <2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com>
 <CAE5ih7-iQsBxM3Gn4B1Q9WZ2A0=eTHn9nt3a0LVURppOCQsAWA@mail.gmail.com>
 <BYAPR08MB3845FEE1844EF613C739CB66DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
 <CAJJpmi8hb8iUDaNgrqxSTQAexgUcLQmiyBLx8MsHCa9BN9j43A@mail.gmail.com> <BYAPR08MB3845AD0BC8F24814E0B9936EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
From:   Thandesha VK <thanvk@gmail.com>
Date:   Tue, 17 Apr 2018 15:29:10 -0700
Message-ID: <CAJJpmi9Dpnyont6nBCq6pkZvhKsVW-k6OPRrgzwsx+SpLYxU1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: fix `sync --verbose` traceback due to 'fileSize'
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     Luke Diamand <luke@diamand.org>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah. I didn't realize the script is not using p4 sizes to get the size.
I assumed that it is using p4 sizes. Now I am looking at it using p4
-G print.
However, when the stack trace happened, I verified what is wrong and
found out that the fileSize key is not returned for "p4 -G sizes"
command.


So what I am saying is that we cannot use p4 sizes in this case to
solve the problem as even p4 sizes will fail with the same fileSize
not found stack trace.
We can continue as this is not as Critical. However it is a good idea
to let user know that they need to take action to correct this file at
the perforce side.

So irrespective of we are using p4 print or p4 sizes, the fileSize is
not returned in some cases and warning or aborting is something we
need to do.
Just ignoring may not be a good choice.

On Tue, Apr 17, 2018 at 2:38 PM, Mazo, Andrey <amazo@checkvideo.com> wrote:
> Thandesha,
>
> If I read your patch correctly, it adds a warning in case `p4 -G print` doesn't return "fileSize" (not `p4 sizes`).
> I don't see `p4 sizes` being used by git-p4 at all.
> As I said earlier, for our ancient Perforce server, `p4 -G print` _never_ returns "fileSize".
> So, it's definitely not a reason to abort.
>
> Thank you,
> Andrey
>
> From: Thandesha VK <thanvk@gmail.com>
>> My fix is for the case where p4 -G sizes not returning the key and
>> value for fileSize. This can happen in some cases. Only option at that
>> point of time is to warn the user about the problematic file and keep
>> moving (or should we abort??)
>>
>> Thanks
>> Thandesha
>>
>> On Tue, Apr 17, 2018 at 2:18 PM, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>> Luke,
>>>
>>> Thank you for reviewing and acking my patch!
>>> By the way, did you see Thandesha's proposed patch [1] to print a warning in case of the missing "fileSize" attribute?
>>> Should we go that route instead?
>>> Or should we try harder to get the size by running `p4 -G sizes`?
>>>
>>> [1]  https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com/t/#m6053d2031020e08edd24ada6c9eb49721ebc4e27
>>>
>>> Thank you,
>>> Andrey
>>>
>>> From: Luke Diamand <luke@diamand.org>
>>>> On Tue, 17 Apr 2018, 09:22 Andrey Mazo, <amazo@checkvideo.com> wrote:
>>>>>  Perforce server 2007.2 (and maybe others) doesn't return "fileSize"
>>>>> attribute in its reply to `p4 -G print` command.
>>>>> This causes the following traceback when running `git p4 sync --verbose`:
>>>>> """
>>>>>     Traceback (most recent call last):
>>>>>       File "/usr/libexec/git-core/git-p4", line 3839, in <module>
>>>>>         main()
>>>>>       File "/usr/libexec/git-core/git-p4", line 3833, in main
>>>>>         if not cmd.run(args):
>>>>>       File "/usr/libexec/git-core/git-p4", line 3567, in run
>>>>>         self.importChanges(changes)
>>>>>       File "/usr/libexec/git-core/git-p4", line 3233, in importChanges
>>>>>         self.commit(description, filesForCommit, branch, parent)
>>>>>       File "/usr/libexec/git-core/git-p4", line 2855, in commit
>>>>>         self.streamP4Files(files)
>>>>>       File "/usr/libexec/git-core/git-p4", line 2747, in streamP4Files
>>>>>         cb=streamP4FilesCbSelf)
>>>>>       File "/usr/libexec/git-core/git-p4", line 552, in p4CmdList
>>>>>         cb(entry)
>>>>>       File "/usr/libexec/git-core/git-p4", line 2741, in streamP4FilesCbSelf
>>>>>         self.streamP4FilesCb(entry)
>>>>>       File "/usr/libexec/git-core/git-p4", line 2689, in streamP4FilesCb
>>>>>         self.streamOneP4File(self.stream_file, self.stream_contents)
>>>>>       File "/usr/libexec/git-core/git-p4", line 2566, in streamOneP4File
>>>>>         size = int(self.stream_file['fileSize'])
>>>>>     KeyError: 'fileSize'
>>>>> """
>>>>>
>>>>> Fix this by omitting the file size information from the verbose print out.
>>>>> Also, don't use "self.stream_file" directly,
>>>>> but rather use passed in "file" argument.
>>>>> (which point to the same "self.stream_file" for all existing callers)
>>>>>
>>>>> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
>>>>> ---
>>>>>  git -p4.py | 8 ++++++--
>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/git-p4.py b/git-p4.py
>>>>> index 7bb9cadc6..6f05f915a 100755
>>>>> --- a/git-p4.py
>>>>> +++ b/git-p4.py
>>>>> @@ -2566,8 +2566,12 @@ class P4Sync(Command, P4UserMap):
>>>>>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>>>>>          relPath = self.encodeWithUTF8(relPath)
>>>>>          if verbose:
>>>>> -            size = int(self.stream_file['fileSize'])
>>>>> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
>>>>> +            size = file.get('fileSize', None)
>>>>> +            if size is None:
>>>>> +                sizeStr = ''
>>>>> +            else:
>>>>> +                sizeStr = ' (%i MB)' % (int(size)/1024/1024)
>>>>> +            sys.stdout.write('\r%s --> %s%s\n' % (file['depotFile'], relPath, sizeStr))
>>>>>              sys.stdout.flush()
>>>>>
>>>>>          (type_base, type_mods) = split_p4_type(file["type"])
>>>>> --
>>>>> 2.16.1
>>>>>
>>>> Thanks, that looks like a good fix to me.  Ack.
>>
>> --
>> Thanks & Regards
>> Thandesha VK | Cellphone +1 (703) 459-5386



-- 
Thanks & Regards
Thandesha VK | Cellphone +1 (703) 459-5386
