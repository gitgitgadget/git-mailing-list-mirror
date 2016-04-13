From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] gitk: Fix how remote branch names with / are drawn
Date: Wed, 13 Apr 2016 14:28:39 -0400
Message-ID: <CANoM8SXSW6QrhBhq1GCOv6h4cWs8+KrnPF+GAkMPmW1_+nTuRg@mail.gmail.com>
References: <1460512743-27100-1-git-send-email-odinguru@gmail.com>
 <CANoM8SXixymz3=NQWgG5vSo7XDNh18_OzrNXU4+Y8CQ0LkB6sw@mail.gmail.com> <CAE8SKAMgZzyzoiy4JsqONN4wVWgVq-YmMn1+j2ZtELx+wJ1xEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Holmer <OdinGuru@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:29:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqPXN-0003M4-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbcDMS3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 14:29:04 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35817 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcDMS3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 14:29:00 -0400
Received: by mail-ig0-f178.google.com with SMTP id gy3so128106276igb.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0t86eIf5gI7QTW81LyuUBesvN8d+99KHrb21nII5jX8=;
        b=uc0Tu7WD/wpl3IvbCTrLC1cSi6FjGaJrpWdGYMobKJ7bI3eMCcr2Sw9HMhhsOWHpHe
         fiR9v8Rf4bITxO7a/XLCJ/gPLCtu0xgISHthR/YrU4vjQy5smZd1eZadu6d4ik6P/MBj
         PKIjoTzMZ86ZIHta84T0C+Z7AhDHR8iQLBvDrkwky2D2vOT5IhwX3Ir2sIzkIng+JYBO
         gJr0pw0WItIu03UyeCvovdynPt4gDWobgVOzjOddd8obQ51dcFIb97a2PcyfWC5u4LCC
         LKjrMEH5jPNMHC1HzsJnmBq4R3OBHx6Dpj8E0snb+ZmDMbbHf602PXyT8gKtlkf/jxCX
         Qycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0t86eIf5gI7QTW81LyuUBesvN8d+99KHrb21nII5jX8=;
        b=i4RofU6rt4ga0Q1PAY/PsRrNRe64ERTlz2fYjmOES9b/sjp8SJJvC/9S6QRSHQzCyL
         7yJ0QCF0SMulGJbZyjJ5j2tV4G/KQwI2bPm7CQCq80Vop8ejxIyAZom5q2fpDQfn+m9U
         12L9p4sHE35pLRMz/N8Ae02FnA7xjn1TWATm5kZP7IpPfJh/jllmUuOrlRN3hf6dTJ4w
         UAhUuGo+cutcnVA7h+qiuECi+SpSzmTq8Qq+IF9+Zqd58taefe3YaJKoeqZqCAcQrtGA
         8xR15vAlQ2fTKTQGG0BnxNkvyUIxBqVX7JfFEydZ+ADgySIlM7O+NGXy2AeD9/h1xdhV
         ejJQ==
X-Gm-Message-State: AD7BkJJBKCRCYJ0OS4EyJcjGhN7zeIqvusLMiIfUeBLmP/o2eLGTz37yGMd13j2/fXcRvc/Uc/rlWaEtvZaGHg==
X-Received: by 10.50.40.6 with SMTP id t6mr30191978igk.86.1460572139165; Wed,
 13 Apr 2016 11:28:59 -0700 (PDT)
Received: by 10.107.7.193 with HTTP; Wed, 13 Apr 2016 11:28:39 -0700 (PDT)
In-Reply-To: <CAE8SKAMgZzyzoiy4JsqONN4wVWgVq-YmMn1+j2ZtELx+wJ1xEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291474>

On Wed, Apr 13, 2016 at 2:19 PM, David Holmer <odinguru@gmail.com> wrote:
> I agree that this switches the issue around and that a remote with a
> '/' in the name would be miss colored in the same way a branch with a
> '/' in the name is miss colored now. However, I would guess that
> branches with '/' are MUCH MUCH more common than remotes with '/', so
> like you say "this is a better state than the present". A "complete"
> solution would take iterating through the list of remotes and matching
> the explicit whole pattern (e.g. match
> "remotes/my/remote/with/slashes/" for remote "my/remote/with/slashes")
> but I doubt that is worth it for 99.9% of people.
>
> The alternative regex that you are asking about is either using some
> syntax I am not familiar with or isn't quite correct. I'm most
> familiar with grep command line format, so perhaps tcl regex is
> different.
>
> The original code does the equivalent of this:
>
> ~$ echo "remotes/origin/dev/test1" | grep -o "remotes/.*/"
> remotes/origin/dev/
>
> The issue is that the '.*/' part is greedy in that it will match all
> the way up to and including the last /
>
> My solution was to change the . to [^/] which means "any character but
> /". This stops the match at the first / after the remote name starts:
>
> ~$ echo "remotes/origin/dev/test1" | grep -o "remotes/[^/]*/"
> remotes/origin/
>
> The alternative you suggested with '.*?/' doesn't seem to work with grep:
>
> ~$ echo "remotes/origin/dev/test1" | grep -o "remotes/.*?/"
> (no output, i.e. does not match)

`.*?` is a lazy match. I think it is an extended-regex, and your
version is probably more efficient anyway.
echo "remotes/origin/dev/test1" | grep -Eo "remotes/.*?/"

>
>
> Thank you.
>

(Most people on this list don't like "top posting"), please try to
reply inline instead.


> On Wed, Apr 13, 2016 at 7:35 AM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>> On Tue, Apr 12, 2016 at 9:59 PM, David Holmer <odinguru@gmail.com> wrote:
>>> Consider this example branch:
>>>
>>> remotes/origin/master
>>>
>>> gitk displays this branch with different background colors for each part:
>>> "remotes/origin" in orange and "master" in green. The idea is to make it
>>> visually easy to read the branch name separately from the remote name.
>>>
>>> However this fails when given this example branch:
>>>
>>> remotes/origin/foo/bar
>>>
>>> gitk displays this branch with "remotes/origin/foo" in orange and "bar" in
>>> green. This makes it hard to read the branch name "foo/bar". This is due
>>> to an inappropriately greedy regexp. This patch provides a fix so the same
>>> branch will now be displayed with "remotes/origin" in orange and "foo/bar"
>>> in green.
>>>
>>> Signed-off-by: David Holmer <odinguru@gmail.com>
>>> ---
>>>  gitk | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/gitk b/gitk
>>> index 805a1c7..ca2392b 100755
>>> --- a/gitk
>>> +++ b/gitk
>>> @@ -6640,7 +6640,7 @@ proc drawtags {id x xt y1} {
>>>             set xl [expr {$xl - $delta/2}]
>>>             $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
>>>                 -width 1 -outline black -fill $col -tags tag.$id
>>> -           if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
>>> +           if {[regexp {^(remotes/[^/]*/|remotes/)} $tag match remoteprefix]} {
>>>                 set rwid [font measure mainfont $remoteprefix]
>>>                 set xi [expr {$x + 1}]
>>>                 set yti [expr {$yt + 1}]
>>> --
>>
>> This likely fixes the problem for most situations, but doesn't for a
>> remote with a '/' in the name.  Yet, I think this is a better state
>> than the present.
>>
>> Is the regex `[^/]*/` more efficient than '.*?/`?  Or do you find the
>> former more readable?
