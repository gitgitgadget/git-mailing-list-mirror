Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E203B1F461
	for <e@80x24.org>; Wed, 15 May 2019 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEOHeS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 03:34:18 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:14033 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOHeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 03:34:18 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QoQahxJmrdraxQoQah014R; Wed, 15 May 2019 08:34:16 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=CS6mKoAcAAAA:20 a=xtxXYLxNAAAA:8 a=uPZiAMpXAAAA:8
 a=XUmnq7ZbDV200S5LnX0A:9 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Antw: Re: Missing branches after clone
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
 <5CDAAB56020000A100031334@gwsmtp.uni-regensburg.de>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <b75bd892-b216-3c7d-f9e7-4470300e02fc@iee.org>
Date:   Wed, 15 May 2019 08:34:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5CDAAB56020000A100031334@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDxMzG/IddDG9ZoQaBTn5th5q7ggLybrX9LQ28GDH/HL8xtTGC/bvIlAmw6V85D+cqOIm12b8//DJu4j+EHrhRNjoaLWkHDzx1mNHvSoUVWxE8kVtQRX
 vmwZFiqIFIJYCwMGiFoP+arwGorSRFLUbr3xwRigv6BU44dFoKOesY1lrzX3/ADMgf9LWMa/3ASkYfDZEeed4/KM+WOGUikxarS6/yLsc+R7mpINqYv1gPmN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/05/2019 12:49, Ulrich Windl wrote:
> Hi!
>
> The confusing part actually is for me:
> "git clone" does NOT "Clone a repository into a new directory", but "clone the current branch into a new directory" (IMHO).
> So I was surprised that I couldn't merge branches under the same name in the cloned "repository".
> Only "git clone --bare" actually seems to clone "the repository".
> I think this is very confusing to new users. At least I didn't quite get the reasoning for that.
It's that you are missing the idea behind the "Branches that track the 
remote", which are local copies, but not YOUR branches. see below.
I clone the GitHub test repo. I get (a copy of) it all (the rtb's). Git 
_creates_ a local branch 'master' for me. Git checks out the lead remote 
branch into it. Command prompt returns. I cd into the new repo. I ask 
what branches _I_ have - just 'master'. I ask about all the branches the 
repo has - voila, I see all those rtb's in _my_ repo. They are all 
perfectly valid branch refs.

It will take a little while to appreciate this extra layer and how to 
use it, and how Git can 'dwim' (do what I mean) the usage of shortened 
refs and branch names, so it you try checking out 'change-the-title', 
git will know to fall back to using the rtb if you haven't created a 
local version.
Hope That Helps.
Philip

phili@Philip-Win10 MINGW64 / (master)
$ cd usr/src

phili@Philip-Win10 MINGW64 /usr/src (master)
$ git clone https://github.com/octocat/Spoon-Knife.git
Cloning into 'Spoon-Knife'...
remote: Enumerating objects: 16, done.
remote: Total 16 (delta 0), reused 0 (delta 0), pack-reused 16
Unpacking objects: 100% (16/16), done.

phili@Philip-Win10 MINGW64 /usr/src (master)
$ cd Spoon-Knife/

phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
$ git branch
* master

phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
$ git branch -a
* master
   remotes/origin/HEAD -> origin/master
   remotes/origin/change-the-title
   remotes/origin/master
   remotes/origin/test-branch

phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
$

--
PS What change to the [clone?] man page would have helped you here?

>> Philip Oakley <philipoakley@iee.org> schrieb am 14.05.2019 um 12:33 in
> Nachricht <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>:
>> Hi Ulrich,
>> On 14/05/2019 11:12, Duy Nguyen wrote:
>>>> Then I
>> foundhttps://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branch
>> es  which handles the subject...
>>>> But still the most common solution there still looks like an ugly hack.
>>>> Thus I suggest to improve the man-pages (unless done already)
>>> Yeah I expected to see at least some definition of remote-tracking
>>> branches (vs local ones) but I didn't see one. Room for improvement.
>> Yes, the 'remote tracking branch' name [RTB] is very 'French' in its
>> backwardness (see NATO/OTAN).
>>
>> It is a 'branch which tracks a remote', and it is has the 'last time I
>> looked' state of the branch that is on the remote server, which may
>> have, by now, advanced or changed.
>>
>> So you need to have the three distinct views in your head of 'My branch,
>> held locally', 'my copy of Their branch, from when I last looked', and
>> 'Their branch, on a remote server, in a state I haven't seen recently'.
>>
>> Finding a better name for the "RTB", one with an easier cognitive load
>> for those trying to understand Git, would be an improvement.
>>
>> Though there has been a similar issue with 'staging the index'.
>> Ultimately it is a new way of thinking about artefacts (perfect
>> duplicates, no originals, no master, no copies, just verification
>> hashes) so needs new terms and a difficult learning experience.
>> -- 
>> Philip
>
>
>

