Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641B81F461
	for <e@80x24.org>; Fri,  3 May 2019 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfECPlD (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 11:41:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33057 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECPlC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 11:41:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id b188so5992249wmb.0
        for <git@vger.kernel.org>; Fri, 03 May 2019 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xf5sEuTrkyyQz0q/xMXIZ/TZhsXT5VBk2Z7VIWDuEh0=;
        b=d2KfBIC6VG917WYP/RMVNB+aspI/PQKOd/fEeRsPggEPuv+TNfOdiqv+tha6Q9XeLO
         pSe5M7T5x+eytBo0TKmsQhZC6DeLpt46inBuUsp3dMV0vUE/kWzWhzFCflLu24rpc/J5
         /vz4rn0zshU1Aii7Aom8m4c1J9oPjageZt/i9hw+TPyOJKJaEL3pZqsqLt7jrPUrxDxG
         eB6neXQ24ZaKbWbWVK29T3wazYc6BorOWabTA/t5g6/pK7Aj3Ll1FXnQpakEEGJ0hDof
         bsvyhNE4ysjH/rJ59yqERBh38stbVSUahaC7UGF/JAON2ihW86kmie/oyLp12APgeOS7
         rNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xf5sEuTrkyyQz0q/xMXIZ/TZhsXT5VBk2Z7VIWDuEh0=;
        b=pviDoZXsRpUeQE9yf4bhCQHgyomCdBKFRyI8hrEFFssaW9Kpwl8kvX9lCg4O6bQDuY
         Hv1LGbF0h6Ymsb89jSSbcEN0ci5Khtg+5VzEJZqSrMAIjUUoBrPAgmPPlkny5+4KInp5
         nX/SR/YmlIKzU8BGtTSPFtLJ8GAQ8mIERygXK1vnpXxl2gTq+rzwmevcc2oufd42TDVj
         iBPzP1TD5mMUsWs7ttjx4M/cYzo1/AQYO3X6uqBAFqMVI9qtzAM9POW8hLazMBzcfdgB
         fx1QDV75T3nPjSxeMmNFO2dozGNIWHrfw4PnhKJUCdtKOhu+QyDb9+lu/tsWB4fnLq72
         zksQ==
X-Gm-Message-State: APjAAAXsea7qCxpM5it8YEmSQ9r0rhLAvViCYfd+6caNZI9m++ZhpLjY
        fhIlkk4SnUAxWo2vYlQCkjfWpuGT
X-Google-Smtp-Source: APXvYqyfiS9Rmcr7uuTMmatODeut6kUcrMrnjgzVgxcHzE9+uPUGtyxlBzYCRs+C5uNNE306V9yO6g==
X-Received: by 2002:a7b:cd05:: with SMTP id f5mr6538173wmj.98.1556896203329;
        Fri, 03 May 2019 08:10:03 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id w15sm3744159wrg.43.2019.05.03.08.10.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 08:10:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: git pull may delete untracked files in submodule without
 notice
To:     Duy Nguyen <pclouds@gmail.com>,
        Christian Spanier <cspanier@boxie.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2e321dbe-42a3-7516-52aa-4bc50a3c403e@boxie.eu>
 <CACsJy8ArJ9Lc1pA7SbJ1OE6hK+rprXpZViLDPUKPMcWG7Bre3A@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6d985c61-d06f-b794-8533-c7f29444b148@gmail.com>
Date:   Fri, 3 May 2019 16:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8ArJ9Lc1pA7SbJ1OE6hK+rprXpZViLDPUKPMcWG7Bre3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/05/2019 11:28, Duy Nguyen wrote:
> On Fri, May 3, 2019 at 5:25 PM Christian Spanier <cspanier@boxie.eu> wrote:
>>
>> Hi,
>>
>> I found a bug where Git may delete untracked files without notice in
>> certain situations. This bug effects Git 2.21.0 both on Linux and Windows.
>> In summary this happens when git pull merges a commit that replaces a
>> submodule folder with a symlink. Any files within the folder are deleted
>> without notice.
> 
> Maybe it's not the same, maybe it is. But Phillip recently did some
> work protecting untracked files and I think he touched a test case
> about submodule. Adding him so he can check, if he has time.

That was a different case. I've just tried adding an untracked file to 
the submodule directory in the test that replaces a submodule with a 
file (patch below hopefully thunderbird does not break it) and it still 
passes when running t1013-read-tree-submodule.sh (it's test 8) - so I 
think there is something wrong with the detection of untracked files in 
a submodule directory when we replace it with a file. Normally I'd ping 
Stefan about submodules but he's not around at the moment.

Best Wishes

Phillip

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5b56b23166..618176ae54 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -735,6 +735,7 @@ test_submodule_recursing_with_args_common() {
                 reset_work_tree_to_interested add_sub1 &&
                 (
                         cd submodule_update &&
+                       echo untracked>sub1/untracked &&
                         git branch -t replace_sub1_with_file 
origin/replace_sub1_with_file &&
                         $command replace_sub1_with_file &&
                         test_superproject_content 
origin/replace_sub1_with_file &&


> 
>> Check out the script below for details.
>>
>> This happend on some developer's machine and deleted a repository
>> containing about 200GiB of files and tons of uncommited local scripts,
>> log files and whatever, just because some other dev accidentally
>> commited a temporary change.
>>
>> Greetings,
>> Christian Spanier
>>
>> ##### PREPARATION #####
>>
>> # New empty repository #1
>> mkdir rep1
>> cd rep1
>> git init --bare .
>> cd ..
>>
>> # New empty repository #2
>> mkdir rep2
>> cd rep2
>> git init --bare .
>> cd ..
>>
>> # Clone repository #1 and create initial commit
>> git clone rep1 clone_rep1_user1
>> cd clone_rep1_user1
>> touch README
>> git add README
>> git commit -m "initial commit"
>> git push
>> cd ..
>>
>> # Clone repository #2 and create initial commit
>> git clone rep2 clone_rep2
>> cd clone_rep2
>> touch README
>> git add README
>> git commit -m "initial commit"
>> git push
>> cd ..
>>
>> # Add repository #2 as a submodule to repository #1
>> cd clone_rep1_user1
>> git submodule add ../rep2
>> git commit -m "add submodule"
>> git push
>> cd ..
>>
>> # User 2 also clones repository #1 and #2 recursively
>> git clone --recursive rep1 clone_rep1_user2
>>
>> # User 2 starts working in his folder and adds an important local file
>> which is
>> # not yet committed inside the submodule folder.
>> cd clone_rep1_user2/rep2
>> echo "important work" > uncommitted_file
>> cd ../../
>>
>> # Meanwhile, user 1 temporarily switch out folder /clone_rep1_user1/rep2
>> with a
>> # symbolic link to a different folder (for whatever reason, maybe a copy
>> of an
>> # older version or anything).
>> mkdir rep2_alternative
>> cd clone_rep1_user1
>> mv rep2 ../rep2_backup
>> ln -s ../rep2_alternative rep2
>> # On Windows this can be done with 'mklink /D rep2 ../rep2_alternative',
>> # which requires admin privileges. The bug is not reproducible when
>> # using a directory junction with 'mklink /D /J ...'.
>>
>> # He does some work on rep1 but then accidently adds the symbolic link
>> to his
>> # next commit and pushes the changes. Notice the typechange of rep2.
>> echo "some" > work
>> git status
>> # On branch master
>> # Your branch is up to date with 'origin/master'.
>> #
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working
>> directory)
>> #
>> #         typechange: rep2
>> #
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #         work
>> #
>> # no changes added to commit (use "git add" and/or "git commit -a")
>> git add .
>> git commit -m "do some work"
>> git push
>> cd ..
>>
>> # NOW THE BUG:
>>
>> # User 2 pulls the changes and loses his important work in
>> # rep2/uncommitted_file because Git replaces the folder with a symlink
>> # without checking for modified or uncommited files!
>> # He should get an error in this case!
>> cd clone_rep1_user2
>> git pull
>> cat rep2/uncommitted_file
>> # cat: rep2/uncommitted_file: Not a directory
>> # "important work" in rep2/uncommitted_file is gone :(
> 
> 
> 
