From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 13:51:42 -0600
Message-ID: <CAMP44s1-pVDoLrEC9m0J+fRCxnvMb+P0ANMxS7vzBhFub_Yv6Q@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyHV-0006PJ-0E
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab3JaTvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:51:45 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:49038 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab3JaTvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:51:44 -0400
Received: by mail-lb0-f169.google.com with SMTP id p9so612819lbv.28
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xt1ZZ+n7H01mok7yAHfEiAkjIqhpN4pzq4AXlqsVOKw=;
        b=WUulCmagXZtP4EbtqWM/zyTv3+Jhcrx/7T0v8G7xftxzouNNRz6N3PmdVL259QVWyE
         Gm1VdCclkBiGZKVxqielKpPaP9iZcEr8Lekr2eku0Xx0xmVJwDxJKkcMOSdgyw+O5CyX
         K/Ee8wF781gUysGVhKmGqEJxIsL7LxCIKm28OEvs/2MOMDyADaQGQGTzdWB8KyXrEwP3
         GvCPPmMsuSDeDup/BzKptSThPazp/bv8Y+D9fZ1DLlAntu6OzSFJI5JSrUn9qNHwM3ua
         8AW3c2IDRaX/RITBIg5xAZDjvrbDJI8yKrutqKPO/aqWsyNbvHZ90FM5p28tL3oXRjo/
         qJUw==
X-Received: by 10.152.180.139 with SMTP id do11mr3069860lac.23.1383249102714;
 Thu, 31 Oct 2013 12:51:42 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 12:51:42 -0700 (PDT)
In-Reply-To: <xmqqob655kqi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237172>

On Thu, Oct 31, 2013 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Oct 31, 2013 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> --- a/Documentation/git-pull.txt
>>>> +++ b/Documentation/git-pull.txt
>>>> @@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
>>>>  "`master`":
>>>>
>>>>  ------------
>>>> -       A---B---C master on origin
>>>> +       A---B---C origin/master
>>>>        /
>>>>      D---E---F---G master
>>>>  ------------
>>>
>>> This change is wrong; the illustration depicts the distributed world
>>> (i.e. a fetch has not happened yet).
>>
>> That is an irrelevant implementation detail, specially at this high
>> level. In the user's mind origin/master means master on origin.
>
> You are wrong.  In the user's mind, origin/master means the commit
> that used to be at master on origin, and the point of this
> illustration is to make them understand that they live in a
> distributed world, where their last observation will go stale over
> time.

Wrong. That would make sense in 'git fetch', but here the point of the
illustration is to make them understand what 'git pull' will do,
namely a merge.

Which refs point to C at which points in time irrelevant information,
the user wants to know that 'git pull' will create a merge.

>> If you want to be pedantic, this is the "reality":
>>
>>   ------------
>>       D---E---F---G master
>>   ------------
>
> You are wrong again.  The "reality" is more like this:
>
>       origin/master in your repository
>       |
>       v
>       A---B---C master at origin
>      /
>     D---E---F---G master in your repository
>
> if you really want to write origin/master somewhere in this
> illustration.

Wrong. You probably mean:

------------
          A---B---C master on origin
         /
    D---E origin/master
         \
          F---G master
------------

But 'master on origin' doesn't exist in "reality" according to you, so:

------------
    D---E origin/master
         \
          F---G master
------------

-- 
Felipe Contreras
