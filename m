Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220BC1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeDQVY4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:24:56 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38032 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDQVYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:24:55 -0400
Received: by mail-it0-f45.google.com with SMTP id 19-v6so18125795itw.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ME/k8DHPWymWvth8fhKOwes+CdmytzN38UaZFe4ZxLw=;
        b=WGO60B3ff4aqj2NtwvsPDtEbrEnjC6P0YQQQ5SHHCjHPk72aw2Z3y2SAHhmr3jI2ho
         iueOe4lVCnDBUJwiMyJCSOnRiXg5gYOCEZZgK93Zg1UbqKWVQtwkI09KHQ5kQe1poJZ3
         MehQg2NidaqYJXmBlkRuIT5vj7BwMumzNry+D5IZtL3EsN3cGwCct7vmT3TpIz3OaTv/
         8e2saA1Gr1vO3Aq7XAb3jhxvWfeCtxCiX3IwOOiWL7YTKkugRHxOBZkf3mRzLemA9MFP
         uMwpVAuIWAtp5vvfi9NJyeQ2+eEYW0pXU5t4WFlEwbbX4JqYnDugUaFTxlzg7Z5LV4nM
         f0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ME/k8DHPWymWvth8fhKOwes+CdmytzN38UaZFe4ZxLw=;
        b=sj0yY4sjooKd/VUI3Ft7UC5L9OE8Cw4nZho1HCcd1JTWtYhhtQRj0950byCY2Qc2xt
         VhWQ/W2s6DOdrnSwgCoETWOzQEMrPGkKNS431f1Y+iJY5pFABvNXFk30Hn9lUKdT9Erg
         AQevCBTb4UiNBZ/ALyTPmKxI62ux56t0Dacepnwk68fnny1Mrmiu0EQXC/PEAQd9Ixzv
         Em+7uZKdmo1c/GcBxMDd0QBzGYgSrF/giXShcp3kLnw/gl99UoIfXP8UA1/i8wA7Zwga
         HKSuwPk7I+jIsIwBRy5Yj4gwAP6aVhRxxC+syHgwICMeWK7+4ZDbU3yPZ5D3vSV8BXpK
         +k4A==
X-Gm-Message-State: ALQs6tBUwknVUTu03+50QWpcHO2xF1agMsPEu14JXwzA9UbbsKk0Ltms
        2xOjaJCX5voHTBrT162Ht3s9aLqbrXQ2VduQnkQ=
X-Google-Smtp-Source: AIpwx48e7enMjF1Se5qdZVyNutNuOE11bRgq1GgblQTqM/lEbOkSKsenGb67qW34Z6H2ISyyooJr3CGl6RPf+1Us/44=
X-Received: by 2002:a24:6881:: with SMTP id v123-v6mr3081153itb.32.1524000294485;
 Tue, 17 Apr 2018 14:24:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a78a:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 14:24:13
 -0700 (PDT)
In-Reply-To: <BYAPR08MB3845FEE1844EF613C739CB66DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com> <2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com>
 <CAE5ih7-iQsBxM3Gn4B1Q9WZ2A0=eTHn9nt3a0LVURppOCQsAWA@mail.gmail.com> <BYAPR08MB3845FEE1844EF613C739CB66DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
From:   Thandesha VK <thanvk@gmail.com>
Date:   Tue, 17 Apr 2018 14:24:13 -0700
Message-ID: <CAJJpmi8hb8iUDaNgrqxSTQAexgUcLQmiyBLx8MsHCa9BN9j43A@mail.gmail.com>
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

My fix is for the case where p4 -G sizes not returning the key and
value for fileSize. This can happen in some cases. Only option at that
point of time is to warn the user about the problematic file and keep
moving (or should we abort??)

Thanks
Thandesha

On Tue, Apr 17, 2018 at 2:18 PM, Mazo, Andrey <amazo@checkvideo.com> wrote:
> Luke,
>
> Thank you for reviewing and acking my patch!
> By the way, did you see Thandesha's proposed patch [1] to print a warning in case of the missing "fileSize" attribute?
> Should we go that route instead?
> Or should we try harder to get the size by running `p4 -G sizes`?
>
> [1] https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com/t/#m6053d2031020e08edd24ada6c9eb49721ebc4e27
>
> Thank you,
> Andrey
>
> From: Luke Diamand <luke@diamand.org>
>> On Tue, 17 Apr 2018, 09:22 Andrey Mazo, <amazo@checkvideo.com> wrote:
>>>  Perforce server 2007.2 (and maybe others) doesn't return "fileSize"
>>> attribute in its reply to `p4 -G print` command.
>>> This causes the following traceback when running `git p4 sync --verbose`:
>>> """
>>>     Traceback (most recent call last):
>>>       File "/usr/libexec/git-core/git-p4", line 3839, in <module>
>>>         main()
>>>       File "/usr/libexec/git-core/git-p4", line 3833, in main
>>>         if not cmd.run(args):
>>>       File "/usr/libexec/git-core/git-p4", line 3567, in run
>>>         self.importChanges(changes)
>>>       File "/usr/libexec/git-core/git-p4", line 3233, in importChanges
>>>         self.commit(description, filesForCommit, branch, parent)
>>>       File "/usr/libexec/git-core/git-p4", line 2855, in commit
>>>         self.streamP4Files(files)
>>>       File "/usr/libexec/git-core/git-p4", line 2747, in streamP4Files
>>>         cb=streamP4FilesCbSelf)
>>>       File "/usr/libexec/git-core/git-p4", line 552, in p4CmdList
>>>         cb(entry)
>>>       File "/usr/libexec/git-core/git-p4", line 2741, in streamP4FilesCbSelf
>>>         self.streamP4FilesCb(entry)
>>>       File "/usr/libexec/git-core/git-p4", line 2689, in streamP4FilesCb
>>>         self.streamOneP4File(self.stream_file, self.stream_contents)
>>>       File "/usr/libexec/git-core/git-p4", line 2566, in streamOneP4File
>>>         size = int(self.stream_file['fileSize'])
>>>     KeyError: 'fileSize'
>>> """
>>>
>>> Fix this by omitting the file size information from the verbose print out.
>>> Also, don't use "self.stream_file" directly,
>>> but rather use passed in "file" argument.
>>> (which point to the same "self.stream_file" for all existing callers)
>>>
>>> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
>>> ---
>>>  git -p4.py | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/git-p4.py b/git-p4.py
>>> index 7bb9cadc6..6f05f915a 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -2566,8 +2566,12 @@ class P4Sync(Command, P4UserMap):
>>>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>>>          relPath = self.encodeWithUTF8(relPath)
>>>          if verbose:
>>> -            size = int(self.stream_file['fileSize'])
>>> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
>>> +            size = file.get('fileSize', None)
>>> +            if size is None:
>>> +                sizeStr = ''
>>> +            else:
>>> +                sizeStr = ' (%i MB)' % (int(size)/1024/1024)
>>> +            sys.stdout.write('\r%s --> %s%s\n' % (file['depotFile'], relPath, sizeStr))
>>>              sys.stdout.flush()
>>>
>>>          (type_base, type_mods) = split_p4_type(file["type"])
>>> --
>>> 2.16.1
>>>
>> Thanks, that looks like a good fix to me.  Ack.



-- 
Thanks & Regards
Thandesha VK | Cellphone +1 (703) 459-5386
