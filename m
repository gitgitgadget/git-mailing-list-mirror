From: Fahad Ashfaque <fahadash@gmail.com>
Subject: Re: Cannot set the commit-message editor
Date: Fri, 21 Nov 2014 14:51:23 -0500
Message-ID: <CAOmRNZ5PGWNM_+c_G_3ZfBnYqXTM-5WRBpK_z7Px6Jkae+CvRw@mail.gmail.com>
References: <CAOmRNZ4uJEoxroyCRUSDwSC3OAMKTSO0s91_uFDaUit3k8eJLg@mail.gmail.com>
	<F248C92A32904678A4E8E158A3518AA3@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Git Users <git-users@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 20:51:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XruEp-0004Uw-VL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 20:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbaKUTvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 14:51:25 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:62871 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaKUTvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 14:51:23 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so4340841obc.8
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BSy5JcyZST3KR+JiK7ubfQp7O1H3RXINpJQZDEPu9IE=;
        b=qjAANpRcx/Rgnc13Ms/0NNSKP2Gzs36s0ZbO2aBZQkddMvMBNkozqqeBOqCRN5Jzar
         gwBPQg5SiziOOrzVFMxfKtcuqFSfPlnyLOPK1Bz3aaipoicM3Y0qbYvSZ/wpl/oXNAbs
         d58rTHH3DM5v6Rhu0YMTQ3UE7gbaB7NZBBHmgVI+Lj2qyKhyODM18UB9+wavc+dx0tqV
         rT4zAu2wdMdM/rXVde5fcvxkNxxqF5SHCNlI98UB+qQJoKShkmXntkXA3jHVA2hFk4Js
         dWYLP/navuoKGk0VQD72VkDcK0FgSu7vaMSdZYGZTZqWN6S3BnREsxZpzRcptPpISIzP
         tSvg==
X-Received: by 10.202.211.204 with SMTP id k195mr4004636oig.53.1416599483249;
 Fri, 21 Nov 2014 11:51:23 -0800 (PST)
Received: by 10.202.75.5 with HTTP; Fri, 21 Nov 2014 11:51:23 -0800 (PST)
In-Reply-To: <F248C92A32904678A4E8E158A3518AA3@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

still don't get it.

I run /c/path/to/npp.sh just fine,.... Its only 'git commit' that is
teleporting me to a different world. So there is NO way I can refer to
folders outside of my repository in a shell script when it is used in
a config param ?

I will try setting the core.editor to the value you suggested.

On Fri, Nov 21, 2014 at 12:48 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Fahad Ashfaque" <fahadash@gmail.com>
>>
>> I have downloaded the latest git from git-scm on my windows machine.
>>
>> I am using git on windows, I am having trouble trying to get notepad++
>> as my commit message editor.
>>
>> I have created a shell script called npp.sh which has the following
>> content
>>
>> /c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe -multiInst
>> -nosession -noPlugin $1
>>
>>
>> I figured this is how paths are accepted in git-bash
>>
>> Now I configured core.editor this way
>>
>> git config --global core.editor /c/path/to/npp.sh
>>
>
> I simply have (from 'git config -l'):
> core.editor='C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar
> -nosession -noplugin
>
>>
>> when I try to commit, using the following command
>>
>> git commit
>>
>> I get the following error
>> $ git commit
>> error: cannot spawn c:/path/to/npp.sh: No such file or directory
>> error: unable to start editor 'c:/dev/tools/cmd/npp.sh'
>> Please supply the message using either -m or -F option.
>>
>> when I run the following command
>>
>> ls c:/
>>
>> I get the directory for my repository's root, not C drive's root
>>
>> When I run the following command through git-bash
>>
>> /c/path/to/npp.sh
>>
>> It works
>>
>> but when git commit invokes, it does not.
>>
>> Here is more of what I found
>>
>> when 'git commit' launches npp.sh, it changes /c/path/to/npp.sh to
>> c:/path/to/npp.sh
>>
>> c:/ is not the root of my C drive according to git-bash,
>
> Correct. The "Linux" bash is rooted, _usually_, at the base of your personal
> 'c:/documents and settings' (or whatever on your Windows version), with the
> MS drives under /c/ and /d/ etc. i.e. a load of virtualisation.
>
> use 'pwd -W' to get the true (Windows) path of your current/present working
> directory. (I had to ask just a few days ago ;-)
>
>> c:/ is root
>> of my repository because when I run 'ls c:/' I get files from root of
>> my repository.
>
> I wouldn't have expected that to play nice (confusion between windows and
> linux path styles).
>
>>
>> so may be if 'git commit' does not change /c/path/to/npp.sh to
>> c:/path/to/npp.sh, it would work... Or if git-bash does not mount c:/
>> to /c/path/to/myrepository and keep it to /c it would work too.
>>
>> Please let me know if you need more info on this
>
>
> I've also copied in the Git user / Git for Human beings list (for reference)
> which can be useful for Windows based issues.
>
>>
>> Thanks
>>
>> Fahad
>> --
>
>
