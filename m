From: Eric Wong <normalperson@yhbt.net>
Subject: Re: log --pretty accepts incomplete pre-defined formats
Date: Wed, 6 Apr 2016 21:03:39 +0000
Message-ID: <20160406210339.GA18799@dcvr.yhbt.net>
References: <5704A925.9030506@gmail.com>
 <xmqqinzuzs3d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sidhant Sharma <tigerkid001@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:03:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anucC-0001vb-3L
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 23:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbcDFVDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 17:03:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42668 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbcDFVDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 17:03:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7622044E;
	Wed,  6 Apr 2016 21:03:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqinzuzs3d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290868>

Junio C Hamano <gitster@pobox.com> wrote:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
> 
> > Recently while playing around with git log, I realized that it is possible to
> > pass incomplete (pre-defined) format names. For example, it is possible to use
> > `git log --pretty=one` instead of oneline and it would still output the logs in
> > oneline formatting. Same goes for other formats such as 'raw', 'short' and others.
> > I looked at the code and it seems that it is intentionally kept so. It this so?
> > I'm curious to know the reason behind keeping this so.
> 
> I actually am curious why somebody wants to know, as more modern
> parts of the system allow option names abbreviated to unique
> prefixes.  "Why can't I say 'log --pret=oneline' when I can say
> 'commit --ame'?" might be a more plausible puzzlement (and the
> answer is "hysterical raisins").  Anyway, this seems to come from
> 6cdfd179 (commit: allow --pretty= args to be abbreviated,
> 2006-05-14),

Yes, being able to abbreviate 'raw', 'short', etc is intentional
to save keystrokes since I was suffering from RSI at the time.

Being able to do "--pret=r" would be nice nowadays if the
parsing in revision.c were modernized.  However, the completions
in contrib/ also expands "--pretty=" nowadays, so now I care
less about shorthand options.

> which was slightly tightend by aacd404e (Fix some
> documentation typos and grammar, 2007-02-02).

Huh?
