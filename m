From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Tue, 3 Oct 2006 19:48:37 -0700 (PDT)
Message-ID: <20061004024837.4462.qmail@web31808.mail.mud.yahoo.com>
References: <7virj0lsua.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Oct 04 04:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUwoM-0002js-Qu
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 04:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWJDCsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 22:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030710AbWJDCsj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 22:48:39 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:413 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030451AbWJDCsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 22:48:38 -0400
Received: (qmail 4464 invoked by uid 60001); 4 Oct 2006 02:48:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mB8wPynE1jlernYjmXDYvWj2luDpbj8Zb0tvROy/Q97grC5AHTcTrVbKi6orQRcOTh5nvlhpoZZjuZzfzTM5w8iY1xkVrVmnEcZExL2w3vre/4UR4OMbLnyfjP+DBJamJukzLFd4iTW1u9klk+jvp6lypeKL5V87DD18A7X/rao=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Tue, 03 Oct 2006 19:48:37 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virj0lsua.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28313>

--- Junio C Hamano <junkio@cox.net> wrote:
> > I like the fact that the "data part" of blame is text, and
> > that the commit-8 is on the left, and color-chunked.  Sometimes
> > people simply _remember_ a number of commit-8's and thus the
> > layout of blame is intentional, since they can look to the left
> > and recognize a commit-8...
> 
> It is not only the initial commit.  A substantial rewrite and
> new development also has the same issue.
> 
> I think you are also contradicting yourself by saying that
> people would recognize a commit-8, and at the same time you do
> not like the chunk code that makes sure you do not get too few
> of them.  If people _do_ recognize commit-8 (I seriously doubt
> that), then wouldn't it help to make sure you have them on every
> couple-dozen lines so that the user would see the familiar one
> even when scrolled?

It is not that I don't like it.  For example if we didn't have
the block-per-commit-coloring, then we'd make use of this, but it
seems that the block-per-commit-coloring exists for the purpose to
show conglomerations of same-commit lines, thus obviating the need
to repeat it (commit-8) every so many lines.

The other question is how many lines should the repeat-chunk be?

In my case I'd like to set it to infinity, since the
block-per-commit-coloring gives me the same information.

The other extreme case is set it to 1, thus obviating the need to
use block-per-commit-coloring.

The middle ground as it seems to me, neither infinity nor 1, is
to just use the block-per-commit-coloring and use your idea of printing
the commit-8 only on the leading block row with mouse-over author
and date info. That's an excellent idea.*

    Luben
* I've three patches which implement your excellent idea but without
using a "stack-like" chunk, eliminating the concern of rare but present
files with 100s of 1000s of lines with only an initial commit.  Should I
post them?
