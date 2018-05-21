Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125AE1F51C
	for <e@80x24.org>; Mon, 21 May 2018 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeEUWTO (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 18:19:14 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:42491 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeEUWTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 18:19:10 -0400
Received: by mail-oi0-f52.google.com with SMTP id t27-v6so14410335oij.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5L6VvgWjyzAtxT5tMiB+CDohoFJa39nW9UKdgHimznQ=;
        b=apjKPbWvdN+7U3tBXet19B4b9KO+kytgSGAcKj6C6Ej+me/SK8pG2t3mkuS9Lfneq9
         63VImawz8KTfa1DvS7gWqdKqfb8CJfv6qqmi1mJEDo7DuHNjR8f0fvFn99GI5VqQHe3L
         +flxK+VpdcHkblZI9mJkamkVbvhqYaqwFgICM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5L6VvgWjyzAtxT5tMiB+CDohoFJa39nW9UKdgHimznQ=;
        b=r3vXCTA7xJ8LxLPH6B5ZlH5WkRJabXycoJ1y2wN/M/CfiB1WKpkad3nZtCXTQVYpgE
         INJmLtLRkVwX4xfuF3Pi5baB/O1eu4XRWwvX+dEFahA9iTjDEsPtfWupHOblDAiqAJlZ
         rhEivtKMMaoi2f8qP9IjCohhfuvqDYnibsFm6GgWDbGvWGJ2AiBeHWtGyi0pvT/9tc9P
         aAgrsx5D4VlNFDJYRKpPXXyWLqkc0fNb6Z0vkhNDxGNDH2Q58yCCvzd+iQX3pkjkH3ky
         3yJra/zE9ULUROAe7Y0WjjzlDlKg2iFSrvCghynB+IA40xJ3rBh1ne7OiZcSHcv6fTpD
         1GSg==
X-Gm-Message-State: ALKqPwcBQk12V04kbxCQokUCYqSjsF6nh3yiYaKftSzoDlkEGx+ZM/M1
        jhr5os3DcqftnpcqibpCP2L54qETzGAdDq9hL/qnEw==
X-Google-Smtp-Source: AB8JxZqPIdGgEKazB3Eb1kS6SK1qFvcIQJRt6N6OplmVyqtD6vAZZyfle0GhArX8alribb/YGsQXbFJAUN+INATakmA=
X-Received: by 2002:aca:db44:: with SMTP id s65-v6mr13289495oig.157.1526941149319;
 Mon, 21 May 2018 15:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Mon, 21 May 2018 15:19:08
 -0700 (PDT)
In-Reply-To: <CAE5ih7-1LwLxndEdjtGEmoViiZYbspkjymTzWxnnMgVWfNW2_w@mail.gmail.com>
References: <20180519100020.616-1-luke@diamand.org> <20180519100020.616-2-luke@diamand.org>
 <20180521213924.4491-1-szeder.dev@gmail.com> <CAE5ih7-1LwLxndEdjtGEmoViiZYbspkjymTzWxnnMgVWfNW2_w@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 21 May 2018 23:19:08 +0100
Message-ID: <CAE5ih7_jgrTXv25hYqoq=95H0zArbJAeQO3gO_TRpyLHGfTWUg@mail.gmail.com>
Subject: Re: [PATCHv4 1/1] git-p4: add unshelve command
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 May 2018 at 23:09, Luke Diamand <luke@diamand.org> wrote:
> On 21 May 2018 at 22:39, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
>>> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
>
> ...
> ...
>
>>> +'
>>
>> This test fails on my box and on Travis CI (in all four standard Linux
>> and OSX build jobs) with:
>>
>>   + cd /home/szeder/src/git/t/trash directory.t9832-unshelve/cli
>>   + p4 edit file1
>>   //depot/file1#1 - opened for edit
>>   + echo a change
>>   + echo new file
>>   + p4 add file2
>>   //depot/file2#1 - opened for add
>>   + p4 delete file_to_delete
>>   //depot/file_to_delete#1 - opened for delete
>>   + p4 opened
>>   //depot/file1#1 - edit default change (text)
>>   //depot/file2#1 - add default change (text)
>>   //depot/file_to_delete#1 - delete default change (text)
>>   + p4 shelve -i
>>   Change 3 created with 3 open file(s).
>>   Shelving files for change 3.
>>   edit //depot/file1#1
>>   add //depot/file2#1
>>   delete //depot/file_to_delete#1
>>   Change 3 files shelved.
>>   + cd /home/szeder/src/git/t/trash directory.t9832-unshelve/git
>>   + last_shelved_change
>>   + p4 changes -s shelved -m1
>>   + cut -d   -f 2
>>   + change=3D3
>>   + git p4 unshelve 3
>>   Traceback (most recent call last):
>>     File "/home/szeder/src/git/git-p4", line 3975, in <module>
>>       main()
>>     File "/home/szeder/src/git/git-p4", line 3969, in main
>>       if not cmd.run(args):
>>     File "/home/szeder/src/git/git-p4", line 3851, in run
>>       sync.importChanges(changes, shelved=3DTrue,
>>   origin_revision=3Dorigin_revision)
>>     File "/home/szeder/src/git/git-p4", line 3296, in importChanges
>>       files =3D self.extractFilesFromCommit(description, shelved, change=
,
>>   origin_revision)
>>     File "/home/szeder/src/git/git-p4", line 2496, in
>>   extractFilesFromCommit
>>       not self.cmp_shelved(path, file["rev"], origin_revision):
>>     File "/home/szeder/src/git/git-p4", line 2467, in cmp_shelved
>>       return ret["status"] =3D=3D "identical"
>>   KeyError: 'status'
>>   error: last command exited with $?=3D1
>>   not ok 4 - create shelved changelist
>
> It works fine for me - but given where it's failing, my first
> suspicion would be p4 client version (or server) differences.
>
> I'm using 2015.1 for server and client. Could you check which version
> you are using?

In fact, no need. It works fine with 2015.1 but 2017.1 fails with this
error. Sigh. I'll reroll.

Luke


>
> Thanks,
> Luke
