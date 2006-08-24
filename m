From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email: threaded view issue with Thunderbird
Date: Thu, 24 Aug 2006 01:51:26 -0700
Message-ID: <7v64gibjox.fsf@assigned-by-dhcp.cox.net>
References: <20060824081228.69110.qmail@web25808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 10:51:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGAw1-0003K5-Cc
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 10:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWHXIv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 04:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWHXIv1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 04:51:27 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58032 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750905AbWHXIv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 04:51:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824085126.LPDL12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 04:51:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DkrR1V0284Noztg0000000
	Thu, 24 Aug 2006 04:51:26 -0400
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060824081228.69110.qmail@web25808.mail.ukl.yahoo.com> (moreau
	francis's message of "Thu, 24 Aug 2006 08:12:28 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25949>

moreau francis <francis_moreau2000@yahoo.fr> writes:

> Hi,
>
> Sometimes, actually most of the time, git-send-email _seems_ to not
> work properly with Thunderbird: for example if I send a patchset made
> up by 4 single patchs, then Thunderbird show me this patchset 'broken'
> that is [PATCH 2/4] is not shown as a reply to [PATCH 1/4].
> ...
> The strange thing is that all email headers are correct.

Then this is a wrong list perhaps ;-).

> I recently notice that someone has sent a patchset using
> git-send-email and I can see it 'broken' as well. The subject of the
> first email of the set is
>
> [PATCH 0/7] C cleanup series, mostly nasty shadowing
>
> Does anybody have an idea on what's going wrong ?

I see that 7+1 series as "broken"; #1 is not a reply to #0.
All others are reply to the previous one which is fine:

    Subject: [PATCH 0/7] C cleanup series, mostly nasty shadowing
    Message-ID: <200608231238.10963.madcoder@debian.org>

    Subject: [PATCH 1/7] avoid to use error that shadows the funct
    Message-ID: <11563295562072-git-send-email-madcoder@debian.org>
    In-Reply-To: 200608231238.10963.madcoder@debian.org

    Subject: [PATCH 2/7] git_dir holds pointers to local strings,
    Message-ID: <11563295562422-git-send-email-madcoder@debian.org>
    In-Reply-To: <11563295562072-git-send-email-madcoder@debian.org>

    Subject: [PATCH 3/7] missing 'static' keywords
    Message-ID: <1156329556788-git-send-email-madcoder@debian.org>
    In-Reply-To: <11563295562422-git-send-email-madcoder@debian.org>

    Subject: [PATCH 4/7] remove ugly shadowing of loop indexes in s
    Message-ID: <11563295573215-git-send-email-madcoder@debian.org>
    In-Reply-To: <1156329556788-git-send-email-madcoder@debian.org>

    Subject: [PATCH 5/7] missing #define DEBUG 0 that made the prep
    Message-ID: <11563295573035-git-send-email-madcoder@debian.org>
    In-Reply-To: <11563295573215-git-send-email-madcoder@debian.org>

    Subject: [PATCH 6/7] use name[len] in switch directly, 
    Message-ID: <1156329557424-git-send-email-madcoder@debian.org>
    In-Reply-To: <11563295573035-git-send-email-madcoder@debian.org>

    Subject: [PATCH 7/7] n is in fact unused, and is later shadowed.
    Message-ID: <1156329557613-git-send-email-madcoder@debian.org>
    In-Reply-To: <1156329557424-git-send-email-madcoder@debian.org>

Because #1 has a bogus In-Reply-To field, #0 and #1 would be
shown at the same level, but #2-7 would be staggered below #1.
