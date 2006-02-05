From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 23:08:05 +0100
Message-ID: <43E67745.2080302@gmail.com>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>	<e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com> <7v64ntindq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:08:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5s3a-0004An-As
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 23:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWBEWIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWBEWIL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 17:08:11 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:40111 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750756AbWBEWIK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 17:08:10 -0500
Received: by uproxy.gmail.com with SMTP id h2so546883ugf
        for <git@vger.kernel.org>; Sun, 05 Feb 2006 14:08:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BL47etURK3VovSDGNH6lhy7BKLpYgPaR16b3Ze8qu1cYUKNGtaokd2N3dH0eGofc2f0L/bxgipyXOM95Jyh0HqxkgNs3aGTugmZHKFoukgbWqU/N5Bjti9LTW/FLi1WvPxODBqJxulwOPHET2pZ6CLarUhXeZecOWpVrsycGY9k=
Received: by 10.49.80.10 with SMTP id h10mr1040691nfl;
        Sun, 05 Feb 2006 14:08:08 -0800 (PST)
Received: from ?10.0.0.13? ( [151.56.90.58])
        by mx.gmail.com with ESMTP id z73sm1918672nfb.2006.02.05.14.08.07;
        Sun, 05 Feb 2006 14:08:08 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.6-7.4.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ntindq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15639>

Junio C Hamano ha scritto:
> I was planning to think about the migration strategy _after_ I
> get the feeling that everybody who got confused by the current
> one thinks this is a good change, and I am glad you did that
> work for me ;-).
> 
> I think it is sane to add a no-op '--include' to the current
> version.
> 
> I am not sure if it is worth to take two-phased introduction of
> this new "temporary index" thing.  We could:
> 
>  * add '--only' that asks for the new "temporary index" thing.
> 
>  * initially make '--include' the default, not '--only'.
> 
>  * later switch the default to '--only'.
> 
> 

I think both are viable choices, with the second one better in
case the planned transition phase is going to be long, while the
first one is better if it is going to be short.

Because when, at last, you will switch the default to '--only', this option could be
removed. So it's a temporary option with, peraphs, a temporary documentation, and
a temporary user training to use it: IMHO has a meaning if the transition period is
long enough.

If we are talking about just one or two weeks, more then enough to update scripts, I think
the first approach is simpler.

In any case to let things more clear could be useful to tag a fresh new git version
for this commit semantics change.


Marco
