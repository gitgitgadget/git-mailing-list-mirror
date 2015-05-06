From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Wed, 06 May 2015 22:58:44 +0200
Message-ID: <554A8084.10506@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com> <CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:58:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq6P7-0001Bj-Np
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbbEFU6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 16:58:49 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36520 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbEFU6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:58:48 -0400
Received: by wizk4 with SMTP id k4so217732884wiz.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g9rrmbCB+j8v/8lrKy5M3kl/6vHB6DaxVHDIs1LIObM=;
        b=Ljzhp6PwAvCISGNBnNb8YNlCswPL1HGKX7FE0aXoqjXCwCbMD3mXJamLa1Loh38SFi
         Gm67GA94Kuaikpgqqoe9PuQLYyCRtbKbH3od30BNcSKBIokxIxkhG7lmgjiAXvceGlY/
         Uuj6ScODfzIOr5AOkg6FcUki52vWF94UHJs25i81NMy8q/rY0OMOQ3qf6gC3+CwE8AvG
         6k4fBfpL6oJMi5S4RsE/+MowJ0XeFO9snqfj/tvl+wB1q1CA6sxvjrm4P0VupmshE/HI
         okPrGIy1lDk0+p1ZELE8/mAeaP2wCPSk0zobI/U1nbq/AjbLxhyGY0KymT2ihqxH6vJ3
         A8TA==
X-Received: by 10.180.80.10 with SMTP id n10mr636636wix.82.1430945926914;
        Wed, 06 May 2015 13:58:46 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id ex2sm4474456wjd.28.2015.05.06.13.58.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 13:58:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268498>

On 05/06/2015 08:57 AM, Eric Sunshine wrote:
> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> Declare groups for common commands in the [groups] block,
>> followed by group names and descriptions:
>>
>>     [groups]
>>     init                   starting a working area
>>     worktree               working on the current change
>>     remote                 working with others
>>     info                   examining the history and state
>>     history                growing, marking and tweaking your histor=
y
>>
>> Then, in the [commands] block, map all common commands with a group:
>>
>>     [commands]
>>     git-add        mainporcelain     common-worktree
>>     git-branch     mainporcelain     common-history
>>     git-checkout   mainporcelain     common-history
>>     [...]
>>
>> command names and groups are then parsed with generate-cmdlist.sh to
>> generate common-commands.h.
>>
>> Those commands are displayed in groups in the output of 'git help'.
>
> It probably also is important to mention that the order of the items
> in [groups] is the order in which groups are output by 'git help'

Yes. I'll add a comment in the file as well as in the commit.

>
> More below.
>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>> diff --git a/command-list.txt b/command-list.txt
>> index f1eae08..64394ca 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,29 +1,39 @@
>>   # List of known git commands.
>> -# command name                         category [deprecated] [commo=
n]
>> -git-add                                 mainporcelain common
>> +# only add group information for common commands
>
> Perhaps mention also that the order of groups here is the order in
> which they are output by 'git help'?

It wouldn't be necessary if we reorder alphabetically the content of
each group, no ?

>
>> +[groups]
>
> Thinking on this a bit more, perhaps [groups] is too generic. Maybe
> [common] or [commongroups] would be more descriptive?
>
>> +init                   starting a working area
>> +worktree               working on the current change
>> +remote                 working with others
>
> "collaborating with others" perhaps?

Yes, "groups" has been itching a bit. I thought about "theme", but
common just does the job too. "collaborating with others" sounds
redundant to me (but I'm being a grammar nazi here).

>> -git-fast-export                                ancillarymanipulator=
s
>> -git-fast-import                                ancillarymanipulator=
s
>> -git-fetch                               mainporcelain common
>> +git-fast-export                         ancillarymanipulators
>> +git-fast-import                         ancillarymanipulators
>
> Unintended whitespace changes for fast-export and fast-import lines? =
I
> wouldn't have expected to see these lines change in this patch.
>

All whitespace changes were intended to align the commands on the same
column. I realize this should be the object of a separate patch.

>> -git-grep                                mainporcelain common
>> +git-grep                                mainporcelain
>
> This change isn't mentioned anywhere, not even in the cover letter.
> Did you intend to drop 'grep' from the common command list?

It's a mistake in the cover letter. I indeed intended to propose to
remove grep and tag from the common commands.

>>   [...]
>> -git-write-tree                          plumbingmanipulators
>> +git-write-tree                          plumbingmanipulators
>> \ No newline at end of file
>
> Your editor is perhaps dropping the final newline in the file? This i=
s
> an undesirable change. Patch 2/3 exhibits the same problem.

As for the final newline, it was deliberately removed. I was not aware =
it
was necessary in text files. I'll correct this.

Thank you for the help,

S=C3=A9bastien
