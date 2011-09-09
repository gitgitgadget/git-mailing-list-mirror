From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Fri, 9 Sep 2011 15:25:24 +0200
Message-ID: <CAC9WiBj0TJa44Ay4e8=VyMzfUGxWd1NW8rjrxxkCSx5K6BthRw@mail.gmail.com>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
	<7v1uvta97o.fsf@alter.siamese.dyndns.org>
	<CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
	<4E676F6A.3060906@drmicha.warpmail.net>
	<CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com>
	<7vk49k48q4.fsf@alter.siamese.dyndns.org>
	<CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
	<alpine.DEB.2.00.1109080753460.12564@debian>
	<CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com>
	<alpine.DEB.2.00.1109082123300.12564@debian>
	<CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com>
	<alpine.DEB.2.00.1109090900301.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:25:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R215K-0006S9-D6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968Ab1IINZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:25:26 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54132 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758967Ab1IINZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 09:25:25 -0400
Received: by vxi9 with SMTP id 9so1079476vxi.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n5Nl69XiVe0pHZelhcbQkMQmeNSMrFU/8fsmX8NKyM4=;
        b=puCH4I/pTbDPPyjHaOTKHMPxQcICIMklU+Su49mr7jiY26jyIb/JF3t/7AznkLg8lG
         bCJsOOTOqIKT82743/cmPSX8V3KdRZC1g3QkfZJVU3mvQChr8Tp427J6PcycF4R53tFD
         JFIGb+NquYwHUaNTyZVp086ykBnhzwlw9KX+4=
Received: by 10.52.22.175 with SMTP id e15mr2019543vdf.280.1315574724873; Fri,
 09 Sep 2011 06:25:24 -0700 (PDT)
Received: by 10.52.108.227 with HTTP; Fri, 9 Sep 2011 06:25:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109090900301.12564@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181061>

On Fri, Sep 9, 2011 at 3:06 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Fri, 9 Sep 2011, Francis Moreau wrote:
>
>> On Fri, Sep 9, 2011 at 4:23 AM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>>
>> > you are right that
>> > "git rebase --onto master foo~10 foo" could potentially filter out
>> > patches already in foo..master, without calculating patch-ids for all
>> > commits in master..foo for that matter. I think that would make sense
>>
>> you meant master..foo~10, didn't you ?
>
> Yes. (I actually did mean "all commits in master..foo", but "_any_
> commits in master..foo~10" is more clear and exact.)
>
>> please let me know when you submitting your work, I'm interested to see it.
>
> Will do. It's not really that much work, but I'm not sure when I will
> have time for it. If you or anyone else is interested in doing it, you
> are of course welcome.

I'm a simple mortal user ;)

>
>> > necessary, we could have a flag to disable the filtering e.g. when the
>> > user knows that master is part of a completely separate history from
>> > foo.
>>
>> Can't git figure this out itself ? (I'm not saying the switch is useless)
>
> Yes, but this hypothetical flag would only be to speed things up by
> avoid going to the roots to find out that the histories are disjoint.

You're right but in my (mortal) experience, I'm always rebasing
branches onto another one which is not disjoint, so I'm assuming it's
the (very) common case, but I may be wrong. And what I'm assuming is
correct, I think it's make more sense to do the filtering by default
unless the flag tells to do otherwise.

Thanks
-- 
Francis
