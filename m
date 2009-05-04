From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Wrong conflicts on file splits
Date: Mon, 4 May 2009 11:30:47 -0400
Message-ID: <9e4733910905040830w1800d461udde3fa5b314e278f@mail.gmail.com>
References: <9e4733910905040553u377ab11n1609d980021be498@mail.gmail.com>
	 <49FEED2C.8010501@drmicha.warpmail.net>
	 <9e4733910905040642h5932e80ds5c467db90e03f40d@mail.gmail.com>
	 <49FEF25A.3090305@drmicha.warpmail.net>
	 <9e4733910905040652s60f0a229qef18b36d386905ee@mail.gmail.com>
	 <49FF01AA.9010301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 04 17:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M108C-0007BV-0a
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 17:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbZEDPau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 11:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZEDPau
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 11:30:50 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59670 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZEDPat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 11:30:49 -0400
Received: by fxm2 with SMTP id 2so3847943fxm.37
        for <git@vger.kernel.org>; Mon, 04 May 2009 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dYf1Oi6fF0pYKOPXmDfsM93TRMfE3Y/zri2InDzqWSg=;
        b=iFO/kL9wlY41Yd2MagQsxB4QAJ8MnG4HMzRpWTLFloGFDRuFG3hR6xI9DriTh9UV5s
         XRLdgjcyWCTETp0I/IM2MWIq2GKBxiLexTY72ne4wCog/s2Tt0hkDsgfCCHHmflQgCES
         Cumz7527ydEHjzOl92pnD8WiWnekCXAjl7tLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BF9wZribWXZ++NnbfeVuPrRCxu+0e4eH2W8VkCwO/ZXoxARJl5oN6HjmhQdkwWXlnB
         HipQhdJh7soX5ocWWsW7ih/iJI6WYTfCWDPoWnyUPt3kcuK/dv9Q9VYkpukdFkDbLn+X
         ZIlH2ADsYFnAVyzNL7pZ57ZYg/YH3LvXMnhUw=
Received: by 10.220.100.211 with SMTP id z19mr9399494vcn.53.1241451047886; 
	Mon, 04 May 2009 08:30:47 -0700 (PDT)
In-Reply-To: <49FF01AA.9010301@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118248>

On Mon, May 4, 2009 at 10:54 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jon Smirl venit, vidit, dixit 04.05.2009 15:52:
>> On Mon, May 4, 2009 at 9:49 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Jon Smirl venit, vidit, dixit 04.05.2009 15:42:
>>>> On Mon, May 4, 2009 at 9:27 AM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>> Jon Smirl venit, vidit, dixit 04.05.2009 14:53:
>>>>>> I keep running into this problem, is there anything I can do to make
>>>>>> it better? I'm using stgit but this is a problem in git itself.
>>>>>>
>>>>>> I have a patch that splits file A into two files, A and B.
>>>>>> Now I merge with another tree and bring in a one line fix to A.
>>>>>> The fix touches the pre-split file A in a section that is going to end up in B.
>>>>>> Next I re-apply the patch that splits A into A and B.
>>>>>>
>>>>>> This results in a large conflict in the post split file A.
>>>>>> And no patch being applied to file B which is where the fix belongs.
>>>>>>
>>>>>> Repeat this process with a multi-line fix and the whole automated
>>>>>> merge process breaks down and I have to carefully figure everything
>>>>>> out by hand.
>>>>>>
>>>>>> The merge process seems to be unaware of the newly created file B. No
>>>>>> patches or conflict ever end up in it.
>>>>>>
>>>>>
>>>>> Can you provide a test case or at least a list of commands which you are
>>>>> issuing? You complain about "merge", but you say you are "applying a
>>>>> patch". Are you merging that patch from another branch, or are you
>>>>> really applying it as a patch (git-apply/cherry-pick/rebase/what-not)?
>>>>
>>>> What git command does stgit use internally on push/pop?
>>>>
>>>> It's the stg push of a patch creating a split on top of a change to
>>>> the section that is going to end up in file B that causes the problem.
>>>
>>> I see. So it's really rebasing/applying here rather then merging. I
>>> don't think they have the necessary info in order to do content-based
>>> patching across file boundaries.
>>
>> Are there git commands that can do this properly? stgit is just a
>> bunch of Python executing git commands, they can change which commands
>> are getting called.
>
> OK, I checked the source, and in fact stgit uses git's merge strategies.
>
> I also checked a simple example (splitting `seq 1 20`) in two. It seems
> that git's rename detection does not detect that to be a rename/copy
> (split). As a consequence, the merge strategy performs only a file based
> merge between the versions of A. One would need to teach git about "a
> better split detection" in order to cope with such a situation.
>
> On the other hand, if you know the split, can't you redo that manually?
> I mean, checkout the new version (with the multi-line fixes), split it,
> git-add and git-commit to resolve.

I have 14 more patches layered on top of the split. Redoing the split
manually causes a cascade of conflicts. You get into this situation
when working on a large series that takes time to debug and get right.
 My current solution is to undo the fixes to the split files, apply
the split, and then manually make new patches to redo the fix. That
avoids the cascade problem triggered by changing the patch that
creates the split.

Does it really need to do rename detection? The fact that a new file
is created is recorded in the diff, there's no need to go searching
for it.

-- 
Jon Smirl
jonsmirl@gmail.com
