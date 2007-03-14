From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git protocol over port-forwarding
Date: Thu, 15 Mar 2007 00:14:32 +0100
Organization: At home
Message-ID: <et9vkm$2j4$1@sea.gmane.org>
References: <17912.16608.852664.321837@lisa.zopyra.com> <Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk> <17912.29057.435478.123662@lisa.zopyra.com> <46a038f90703141514q5273e493r87f0ac7f52c1c216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 00:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRcgM-0000aG-Lm
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbXCNXO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbXCNXO4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:14:56 -0400
Received: from main.gmane.org ([80.91.229.2]:60198 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964788AbXCNXOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:14:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HRcg3-0001Eb-0z
	for git@vger.kernel.org; Thu, 15 Mar 2007 00:14:39 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 00:14:39 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 00:14:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42249>

Martin Langhoff wrote:

> On 3/15/07, Bill Lear <rael@zopyra.com> wrote:
>> On Wednesday, March 14, 2007 at 21:05:37 (+0000) Julian Phillips writes:
>>>...
>>>I don't think there is anything that needs changing with the git daemon
>>>... or at least I was able to successfully clone over an SSH port forward.
>>>
>>>I did get the same error as you originally, but this was due to SSH
>>>failing to setup the tunnel connection (checking the logs showed that I
>>>had got the hostname in the forward wrong).
>>
>> Ok, so were you doing something like this:
>>
>> % git clone git://localhost:5700/project
>>
>> etc.?  and not using the ssh protocol, like this:
>>
>> % git clone ssh://...
> 
> I think pure port forwarding won't support git+ssh. For that you need
> the proxycommand approach I mentioned. Actually, I think there's a
> more elegant approach just saying
> 
> Host fooproxied
>     ProxyCommand ssh -q -a foo.yourdomain nc -q0 %h 22

I think it could be done but with _two_ port forwarding, one from git
port to ssh port or 5700 port, on your computer (probably reverse tunnel),
second from 5700 port to git port... unless you configure git server
to use different port...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
