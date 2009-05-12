From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 18:16:32 +0200
Message-ID: <4A09A0E0.6010102@op5.se>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Brisbin <jon.brisbin@npcinternational.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uf9-00076N-9o
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbZELQQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbZELQQg
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:16:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27374 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282AbZELQQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:16:35 -0400
Received: by fg-out-1718.google.com with SMTP id d23so813392fga.17
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:16:34 -0700 (PDT)
Received: by 10.86.59.18 with SMTP id h18mr44289fga.14.1242144993726;
        Tue, 12 May 2009 09:16:33 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d6sm115827fga.17.2009.05.12.09.16.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 09:16:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118916>

Jon Brisbin wrote:
> 
> Today, an RPG programmer can "check out" a source member and SEU won't 
> let anyone else check that same member out (and it tells the developer 
> who has it locked). The C++ programmers here also use Visual SourceSafe, 
> with this same setting turned on. They are open to shifting paradigms 
> away from this development methodology (the "I'm working on this source 
> file and I don't want anyone else changing it until I'm done") but keep 
> in mind that AS400 programmers are NOT cutting-edge and don't keep up 
> with the latest development trends. Since we're not going to fire every 
> RPG developer we have, we need an upgrade or transition path away from 
> the SEU mindset to a more laissez-faire development approach like that 
> encouraged by using Git. But one of the first roadblocks is going to be 
> this notion that someone else can work on the same file I'm working on 
> and that this lack of control invites errors and introduces unnecessary 
> complexity.
> 

At $dayjob, we do daily standups at the start of each day. Each developer
speaks for a maximum of two minutes of what they intend to work on that
day. This prevents double-work and usually causes 2-man teams to form
spontaneously when two developers need something changed in either the
same or conflicting ways.

This way, conflicts rarely happen and when they do crop up, developers
don't even have to watch git to find out who wrote the changes that
conflicted with them (although some will learn to do that very quickly).

> How do I argue that a more open, Git-based approach to development is 
> "better" than the traditional, SEU-based methodology they use today?

Tough one. It might not be, even. If what they do now "just works", I
expect many of them will consider it useless toolchurn just for the hype
of it. Old programmers rarely enjoy that sort of thing.

> It 
> may be an "old" way of doing things, but SEU works for them and, more 
> importantly, they can understand the process. We don't share any of our 
> source code outside our organization and no one who would potentially 
> work on the source code is farther than a cubicle or two away, so our 
> needs in no way extend to what OpenSource projects require, with their 
> large and distributed developer base. Using Git seems so open that its 
> difficult to explain and even more difficult to defend against 
> traditions that are 20 years old and have an entire industry of momentum 
> behind them.

Well, lots of communication is easier to achieve in a small team than in a
large one, so try to get the people talking to each other. The only trouble
we have at my workplace is when conflicts crop up. They will do that at
your place too, and when they do it's likely they'll need some help
resolving them. However, communication and the mantra "useless codechurn is
useless" will assist you quite neatly there.

> 
> I'm just wondering what the Git experts would say to someone wanting to 
> transition from say, Visual SourceSafe, and expecting the predictability 
> of having source files "locked out" while a developer is making changes 
> to them?
> 

I'd say: Hey, coders. If you want locking, we can write a small tool for
that. To make it a learning process too, that tool will be versioned by
git. We need a small (and stupid) server and a small (and stupid) client.
Locking will be advisory, so you can stick to it if you like, and you get
a nice reason to yell at whoever ignored your lock in case of conflicts.

But that's just me, I guess. I've actually wanted such a tool as a sort
of "I'm working from home on *this* and *this*", but haven't been able
to muster the energy to work on it, especially since most of us where I
work are reasonably comfortable in the face of merge-conflicts.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
