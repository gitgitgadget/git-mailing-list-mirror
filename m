Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498EBC432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3D32073F
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKXOx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:53:29 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:63247 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfKXOx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 09:53:29 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iYtGJ-00015G-45; Sun, 24 Nov 2019 14:53:20 +0000
Subject: Re: FW: unpacking error
To:     lyle.ziegelmiller@gmail.com, Git List <git@vger.kernel.org>
References: <004101d58d24$4daab5b0$e9002110$@gmail.com>
 <91e5f3d8-d2cf-363c-2407-4b4dfb75e5a8@iee.email>
 <005501d58e14$07504990$15f0dcb0$@gmail.com>
 <001a01d5a256$5e64d010$1b2e7030$@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <311399df-1fd9-41d9-8edc-2dc5486feb0c@iee.email>
Date:   Sun, 24 Nov 2019 14:53:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <001a01d5a256$5e64d010$1b2e7030$@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/11/2019 23:33, lyle.ziegelmiller@gmail.com wrote:
> Hi Philip
>
> Any updates on this?

I haven't seen anything on list 
(https://public-inbox.org/git/005501d58e14$07504990$15f0dcb0$@gmail.com/) 
and haven;'t looked any further myself.
cc'ing the list.

Have you managed any more investigation?
Or tried upgrading to the latest release v2.24.x (which may provide 
updated error messages)?

Have a careful review of error messages and see if you can correlate at 
least some of them with information you can find in your setup.

e.g. the first part of the error stream is "remote: fatal: not a git 
repository: '.'  "
This means the remote system is sending you a message that it is looking 
at '.' and hoping that it is a repository, but it isn't. So why is it 
looking (within the remote) at '.' - is that path something you sent?, 
it is a misconfiguration at the remote?, etc.

This may also be a bad interaction between cygwin and your Git (is it 
Git for Windows, or ..).

Philip
>
> Thanks
>
> Lyle
>
> -----Original Message-----
> From: lyle.ziegelmiller@gmail.com <lyle.ziegelmiller@gmail.com>
> Sent: Monday, October 28, 2019 9:48 PM
> To: 'Philip Oakley' <philipoakley@iee.email>; 'git bug report' <git@vger.kernel.org>
> Subject: RE: unpacking error
>
>
> From: Philip Oakley <philipoakley@iee.email>
> Sent: Monday, October 28, 2019 3:14 AM
> To: lyle.ziegelmiller@gmail.com; 'git bug report' <git@vger.kernel.org>
> Subject: Re: unpacking error
>
> Hi Philip.
>
> Thanks for writing back. Please see below.
>
> Regards
>
> Lyle
>
> On 28/10/2019 00:11, lyle.ziegelmiller@gmail.com wrote:
>> Hi
>>
>> I almost always get this error when pushing from my PC to the bare
>> repository on my laptop. I'm running Cygwin on Windows 10. I've tried
>> everything! chmod -R 777, chown -R <my user id>, etc.
>>
>> A few more details: I have a Git repository on my PC, and from that,
>> I've cloned a bare repository on my laptop,
> [Philip] "How did you clone that bare repository? In particular, how did you provide the path to that repo."
>
> I'm recreating the entire process below with a smaller repository on my PC (so it won't take hours to clone, etc):
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ git clone --bare . //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git
> Cloning into bare repository '//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git'...
> done.
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ echo "line1" > afile.txt
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ git add afile.txt
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ git commit -m 'Added afile.txt'
> [master 7fa616b] Added afile.txt
>   1 file changed, 1 insertion(+)
>   create mode 100644 afile.txt
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ git push
> Counting objects: 3, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 287 bytes | 287.00 KiB/s, done.
> Total 3 (delta 1), reused 0 (delta 0)
> remote: fatal: not a git repository: '.'
> error: remote unpack failed: unpack-objects abnormal exit To //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git
>   ! [remote rejected] master -> master (unpacker error)
> error: failed to push some refs to '//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git'
>
> Note: I'm able to access the remote repository using Cygwin Unix commands on Windows 10:
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ ls //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git
> config  description  HEAD  hooks  info  objects  packed-refs  refs
>
> ... and I do have write permission:
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ touch //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git/anotherFile.txt
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ echo "line2" >> //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git/anotherFile.txt
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ git remote -v
> origin  //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git (fetch) origin  //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository.git (push)
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $
>
> So, I can clone the repository, and I can still write to the remote directory using the "touch" and "echo" commands. But I can't push to it. It seems that "clone" can access (create, actually) the remote repository, but "push" cannot access it effectively.
>
> [Philip] "If I understand correctly it must be in a URL format (e.g. file://) to ensure that you get distinct repos, rather than two interrelated repos (thought the docs discuss the issue as being the transport mechanism)."
>
> "file://" is for referring to a local file from within a web browser. "//" is how to begin a path of a file on a remote machine in Windows.
>
> After doing all of this, I created another test file on my laptop (filename: afile2.txt) in the repository on my laptop made by cloning the bare repository that I just created on my laptop, and added the test file afile2.txt to the cloned non-bare git repository, and then did a "git push" on my laptop (the remote machine) to the bare repository on my laptop (the remote machine). Then, back on my PC, I was able to do a git pull even though earlier I could not do a git push:
>
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ git pull
> remote: Counting objects: 3, done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 3 (delta 1), reused 0 (delta 0) Unpacking objects: 100% (3/3), done.
>  From //lylez-laptop/Users/Administrator/bare-repositories/budget-bare-repository
>   + e9d5a3c...cd21f1d master     -> origin/master  (forced update)
> Merge made by the 'recursive' strategy.
>   afile2.txt | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 afile2.txt
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ ls
> afile.txt  afile2.txt  backup  Budget.xlsx  Joanne  Scotland.xlsx
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
>
>
> And there it is, the new file (afile2.txt).
>
> So Git is able to utilize the remote bare repository for cloning on the remote machine, and on the local machine (my PC) it can pull from the remote bare repository, but it can't push to it.
>
> [Philip] "The same issue probably applies to the subsequent clones of the bare repo."
>
> [Philip] "Perhaps focus on the error message and decide if "." is the correct way of thinking about the path."
>
> "." is the local directory on my PC that was initially cloned. It is where the Git repository reside:
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
> $ ls -a
> .  ..  .git  afile.txt  afile2.txt  backup  Budget.xlsx  Joanne  Scotland.xlsx
>
> lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
>
>>    which I then used to clone a regular repository on my laptop. The
>> error occurs when I attempt to push changes on my PC into the bare
>> repository on my laptop.
>>
>> If I delete the old bare repository on my laptop, I'm able to create a
>> new bare repository on my laptop from my pc, but then as soon as I try
>> to push to it, I get this error again. I've tried disabling the anti-virus, etc.
>> I've spent hours Googling solutions. Nothing works! Many others have
>> had this same issue. I never had this type of problem with SVN.
>>
>> It would be nice if Git would say what's failing when this happens,
>> and it would be nice to get this bug fixed. It happens with all my git
>> repositories. I don't think it's a network issue or I wouldn't be able
>> to create a new repository on my laptop from my PC, as that would
>> encounter the same permissions issues.
>>
>> The two machines are connected with an ethernet cable. I've done
>> everything I can to make sure all the Windows permissions are set correctly, etc.
>>
>> $ git push
>> Counting objects: 3, done.
>> Delta compression using up to 4 threads.
>> Compressing objects: 100% (3/3), done.
>> Writing objects: 100% (3/3), 331 bytes | 331.00 KiB/s, done.
>> Total 3 (delta 2), reused 0 (delta 0)
>> remote: fatal: not a git repository: '.'
> [Philip] "Why is the remote end of the connection reporting the error that it is looking at "." (as opposed to a proper path/repo)?"
>
> I'm not sure. I cloned ".". I think that's a legitimate thing to do.
>
> All this stuff has worked for me for years. I'm not sure why it's stopped working.
>
> [Philip] "I could easily be wrong - I haven't double checked the man pages at all, but thought a comment may help your research."
>> error: remote unpack failed: unpack-objects abnormal exit To
>> //lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-rep
>> ositor
>> y.git/
>>    ! [remote rejected] timestamp_testing -> timestamp_testing (unpacker
>> error)
>> error: failed to push some refs to
>> '//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-re
>> posito
>> ry.git/'
>>
>>
>> $ git --version
>> git version 2.17.0
>>
>> ------------------
>> System Information
>> ------------------
>>         Time of this report: 10/27/2019, 16:53:09
>>                Machine name: LJZ-DELLPC
>>                  Machine Id: {39BC0826-743F-4ECA-AFBE-66A14FBE533C}
>>            Operating System: Windows 10 Pro 64-bit (10.0, Build 17134)
>> (17134.rs4_release.180410-1804)
>>                    Language: English (Regional Setting: English)
>>         System Manufacturer: Dell Inc.
>>                System Model: Inspiron 3650
>>                        BIOS: BIOS Date: 06/17/16 21:14:07 Ver: 05.0000B (type:
>> BIOS)
>>                   Processor: Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (4
>> CPUs), ~2.7GHz
>>                      Memory: 8192MB RAM
>>         Available OS Memory: 8096MB RAM
>>                   Page File: 8076MB used, 7243MB available
>>                 Windows Dir: C:\WINDOWS
>>             DirectX Version: DirectX 12
>>         DX Setup Parameters: Not found
>>            User DPI Setting: 96 DPI (100 percent)
>>          System DPI Setting: 96 DPI (100 percent)
>>             DWM DPI Scaling: Disabled
>>                    Miracast: Available, with HDCP Microsoft Graphics Hybrid:
>> Not Supported
>>              DxDiag Version: 10.00.17134.0001 64bit Unicode
>>
>>
>> Regards,
>>
>> Lyle Ziegelmiller
>>
>>
> --
> Philip
>
>
>

