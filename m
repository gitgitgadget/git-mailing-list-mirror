Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D6C54FD0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 18:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D9E20BED
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 18:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDTSrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:47:03 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60370 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgDTSq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 14:46:56 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jQbRT-00062B-7G; Mon, 20 Apr 2020 19:46:51 +0100
Subject: Re: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
To:     Elijah Newren <newren@gmail.com>,
        "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <CABPp-BGis7wswAjwgTa84m-TsQznrQWQJVJZW0_MyN9ieFMzeA@mail.gmail.com>
 <CABPp-BHjF4AJdTrdqxvgsZq+UBZd06upFOHEx-8eQ8qKO-CtkA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9478ea01-8d1d-a897-48f1-813f88dde072@iee.email>
Date:   Mon, 20 Apr 2020 19:46:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHjF4AJdTrdqxvgsZq+UBZd06upFOHEx-8eQ8qKO-CtkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04/2020 18:24, Elijah Newren wrote:
> On Mon, Apr 20, 2020 at 9:53 AM Elijah Newren <newren@gmail.com> wrote:
>> On Mon, Apr 20, 2020 at 8:11 AM Kerry, Richard <richard.kerry@atos.net> wrote:
>>>
>>> This follows my earlier query for which the answer was "use git-filter-repo".
>>> I've cloned git-filter-repo from GitHub, and I've installed the latest Python (version 3.8).  I'm working on Windows.  Windows 10 if it makes any difference, so git is Git For Windows.
>>> The first instruction for git-filter-repo is to copy it into the "--exec-path" of git.  That fails, saying Access is Denied.  So leaving aside the option to change the permissions I've followed the second half of the sentence and added my git-filter-repo location to my Path (or PATH if it's in bash).  Now running "get filter-repo" gives:
>>> /usr/bin/env: 'python3.exe': No such file or directory
>>>
>>> My python executable is called python3.exe.  There is a note in the git-filter-repo project about certain Windows installations where it isn't called python3, but that now raises in my mind the question of whether I need to tweak git-filter-repo to look for "python3.exe" rather than just "python3".  Or can I take it that the Windows version of bash understands that it needs to add ".exe" automatically?
>>>
>>> Assuming that is handled automatically, what do I now need to do to satisfy the error message?  Do I need to put something in bash-for-Windows' /usr/bin/env directory?  Or is there something else entirely that I should be doing?
>>>
>>> And is it OK to ask about this on this list, or should I be going to a git-filter-branch resource?  Or for Git For Windows?
>>>
>>> Regards,
>>> Richard.
>> Emailing this list is fine.  You can also open an issue on GitHub for
>> the project if you prefer; I respond in both places.  I may have
>> limited ability to help with Windows issues since I don't have a
>> Windows system to use or test on, though I have succeeded in fixing a
>> few Windows bugs based on reporter feedback. (So maybe this list is
>> better because more people can chime in with Windows experience?)
>> I've got at least a dozen or so reports of people using it
>> successfully on Windows so someone has figured it out.  I'll try to
>> provide a few pointers that might help.
>>
>> You don't have to use "#!/usr/bin/env python3" or "#!/usr/bin/env
>> python".  I could have put "#!/usr/bin/python3" there, but that might
>> make it specific to my system.  I figured other systems installed
>> python3 somewhere other than /usr/bin/, but that /usr/bin/env should
>> be somewhat common and should find the python installation.  If
>> /usr/bin/env doesn't happen to exist on your system, though, it is
>> perfectly fine to have "#!/System/Commands/python3" or whatever is
>> needed.
>>
>> If installation is difficult, you could consider using a package
>> manager.  In particular, the scoop package manager, built for Windows,
>> was one of the first out there to package git-filter-repo -- it was
>> even ahead of most the linux package managers.  (And, yes, scoop can
>> also be used to install python3 as far as I understand.)  I haven't
>> used it myself (because I don't have a Windows system as I mentioned
>> before), but since they were so interested in packaging
>> git-filter-repo and making "scoop install git-filter-repo" part of the
>> instructions (https://github.com/newren/git-filter-repo/issues/20),
>> they look like a friendly bunch that are willing to help.
>>
>> I also looked through the issues and PRs related to Windows, and
>> thought that the following links particularly had interesting comments
>> that might be useful to someone running on Windows:
>>   * https://github.com/newren/git-filter-repo/issues/36
>>   * https://github.com/newren/git-filter-repo/pull/10
>>   * https://github.com/newren/git-filter-repo/issues/48
>> I don't know if any of them will solve your particular problem, but
>> they seemed more likely to be of interest or use than most.  Also,
>> I'll repeat the link for search for reports of Windows issues with
>> git-filter-repo in case I missed one that might be useful to you:
>>   * https://github.com/newren/git-filter-repo/issues?q=is%3Aissue+windows
> Oh, also https://github.com/newren/git-filter-repo/issues/56 which
> suggests PowerShell may mess things up (and in a different way than
> issue 36 showed).
A similar Python issue occurs on Windows, as reported at
https://github.com/git-for-windows/git/issues/2594

with a reply by dscho reminding that:

This issue is listed specifically in the Known Issues in our Release Notes:

        Some console programs, most notably non-MSYS2 Python, PHP, Node
and OpenSSL, interact correctly with MinTTY only when called through
winpty (e.g. the Python console needs to be started as winpty python
instead of just python).

The installer even suggests (on the page titled "Configuring the
terminal emulator to use with Git Bash") to

    Use Windows' default console window
    [...] which works well with Win32 console programs such as
interactive Python or node.js [...]

Hope that helps.
--
Philip

