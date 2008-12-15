From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 17:00:14 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812141655150.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com>
 <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm> <4944E7E1.2030907@siamect.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: martin <martin@siamect.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:00:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0st-0007en-T6
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 01:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbYLNX7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYLNX7J
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:59:09 -0500
Received: from mail.lang.hm ([64.81.33.126]:44760 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbYLNX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:59:08 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBENx1VJ003013;
	Sun, 14 Dec 2008 15:59:01 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4944E7E1.2030907@siamect.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103112>

On Sun, 14 Dec 2008, martin wrote:

> david@lang.hm wrote:
>> On Sun, 14 Dec 2008, martin wrote:
>> 
>>> Dear David.
>>> Why do you trust VPN more than the SSH?
>>> I ask because I have just removed the "first VPN then SSH" solution in 
>>> favor for a SSH only solution using Gitosis just to get rid of the VPN 
>>> which I believe is less secure than SSH (well until I read you comments 
>>> below).
>>> I thought I was doing something right for once but maybe I'm not?
>>> Thanks and best regards
>>> Martin
>> 
>> in part it's that a VPN is a single point of control for all remote access.
>> 
>> If you use ssh you end up exposing all the individual machines
>> 
>> 1. data leakage of just what machines exist to possibly hostile users.
>> 
>> 2. the many machines are configured seperatly, frequently by different 
>> people. this makes it far more likely that sometime some machine will get 
>> misconfigured.
>> 
>> 3. people who are focused on providing features have a strong temptation to 
>> cut corners and just test that the feature works and not test that 
>> everything that isn't supposed to work actually doesn't work. as a result, 
>> in many companies there is a deliberate seperation (and tension) between a 
>> group focused on controlling and auditing access and one that is focused on 
>> creating fucntionality and features.
>> 
>> also from a polical/social point of view everyone recognises that if you 
>> grant someone VPN access you are trusting them, but people don't seem to 
>> think the same way with ssh.
>> 
>> David Lang
>> 
>
> I opened port 22 in the firewall to just those hosts that I need to reach, 
> which is one in this case...the rest of the machines I cannot reach.
> I did a brief port scan and the thing is silent... so I don't think I reveal 
> any of the other hosts... but I should not say is it's secure with your 
> measures...
>
> Your point two I don't understand...   If you are in charge of the firewall 
> you also know what machines you let people reach. If these machines are 
> numerous then I think there is a management problem somewhere else...

two things here

1. if you are running multiple different applications that all want to be 
exposed via port 22 (like git for 'git push') then you may need to expose 
numerous machines. tools that use SSH don't tend to have the ability to 
use a gateway box before they start executing commands, they assume that 
you will SSH directly into the destination box.

2. many people take the attitude that SSH is secure, period, end of 
statement. so they think that every machine should be able to be contacted 
via SSH, and you can then use SSH to do any other functionality on any 
machine that you can dream up. a small minority of people try to minimize 
what boxes are exposed directly (you are one of them), but most don't

David Lang
