From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Pulling tags from git.git
Date: Tue, 07 Mar 2006 20:32:00 -0800
Message-ID: <440E5E40.7090700@gmail.com>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net> <440D7A7D.8070507@op5.se> <440D9AB0.4070305@gmail.com> <440DA82D.3060909@op5.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 05:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGqLL-0007Cb-Vv
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 05:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWCHEcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 23:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWCHEcI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 23:32:08 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:2981 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751510AbWCHEcH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 23:32:07 -0500
Received: by zproxy.gmail.com with SMTP id 14so93392nzn
        for <git@vger.kernel.org>; Tue, 07 Mar 2006 20:32:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=e3ubB9iEfVbGzcjRyn/xe4RliqCQ0zQmMtfbr1IHe+MJ7gplEzOYygSdA4dvCelCgwYcZ59Jesx2MUdtcKeDfynP9sLRlboPzYGaEGD8H2/oxE4gB+JRiN6zhjRK7WWpSGc8y6z+AF//espCSBDAXb29pYMK++rEs3VeJokMFZQ=
Received: by 10.37.22.65 with SMTP id z65mr1576119nzi;
        Tue, 07 Mar 2006 20:32:06 -0800 (PST)
Received: from ?192.168.1.2? ( [209.79.152.188])
        by mx.gmail.com with ESMTP id 15sm675854nzo.2006.03.07.20.32.05;
        Tue, 07 Mar 2006 20:32:06 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440DA82D.3060909@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17363>

Andreas Ericsson wrote:
> A Large Angry SCM wrote:
>> Andreas Ericsson wrote:
>>
>>> Junio C Hamano wrote:
>>>
>>>> Andreas Ericsson <ae@op5.se> writes:
>>>>
>>>>
>>>>> With the git or git+ssh protocol, tags will be autofollowed
>>>>> when you do a pull (only signed tags, I think).  The
>>>>> auto-following is done by detecting tags that are fetched,
>>>>
>>>>
>>>>
>>>> Ah, you are correct.  We do not follow lightweight tags; I am
>>>> not sure if we should.
>>>>
>>>
>>> I'm fairly sure we shouldn't. The default update-hook prevents them 
>>> (if enabled), and I can't for the life of me think of why anyone 
>>> would want to distribute such tags.
>>>
>>> OTOH, preventing unannotated tags from being pushed seems like a 
>>> better way than to not have the ability to auto-follow those same 
>>> tags. After all, it's better to discourage than to disallow.
>>>
>>
>> Before you do this, please explain why unannotated tags are not 
>> useful, and so should not be allowed to be pushed.
> 
> 
> Imagine Linus, getting his "please pull" emails and doing so only to 
> find dozens of temporary tags fetched by the pull. Junio's patch (if I 
> read it correctly) unconditionally fetches *ALL* tags reachable from the 
> top of the commit-chain, which means there is no longer any way to keep 
> temporary tags in a repo from which someone else will pull.

Why is a "pull" bothering with tags? A "fetch" yes, but not a pull.

> I for one riddle my repos with temporary tags whenever I'm trying 
> something I'm not so sure of, or find an interesting bug or a design 
> decision I'm not 100% sure of. Perhaps I should rather do this with 
> branches, but imo branches are for doing work, whereas tags just mark a 
> spot in the development so I easily can find them with gitk or some such.
> 
> I may be biased by the way we do things at work. In our workflow, all 
> tags meant to be distributed have a short note in them which explains 
> the rationale of the tag. For example, new versions have a very brief 
> changelog that sales-people get on email (a blessing, that, since we 
> devs no longer have to update feature-lists and such).
> 
> Tags not meant to be distributed are unannotated, and unannotated tags 
> are kept out of published repos which are always stored at a central 
> server. Everybody synchronize to those central repos, so nobody pulls 
> from each other. Perhaps this is how the kernel devs work too, but if it 
> ever changes the update hook will no longer be able to safeguard from it 
> and the, in my eyes, temporary tags will be distributed in a 
> criss-crossing mesh so no-one will ever know where it came from or who 
> created it or why. I.e. a Bad Thing.

The distinction here is not annotated tags or temporary tags but _local_ 
tags. _Your_ workflow conventions treat unannotated tags as local tags 
but declaring that unannotated tags can not be pushed is imposing _your_ 
conventions on other groups. Just as branch names, themselves, can be 
meaningful, so can tag names.
