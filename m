From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Tue, 02 Oct 2007 11:40:16 -0700
Message-ID: <7vr6kdl5rj.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	<11912513203420-git-send-email-tom@u2i.com>
	<7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
	<550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
	<87ejgescnb.wl%cworth@cworth.org>
	<550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
	<20071001223050.GE2137@spearce.org>
	<Pine.LNX.4.64.0710021056280.28395@racer.site>
	<550f9510710020329m7917dc9m2bb6cfc4055fea84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Carl Worth" <cworth@cworth.org>, git@vger.kernel.org
To: "Tom Clarke" <tom@u2i.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icmfa-0006Qy-3F
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 20:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXJBSkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 14:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbXJBSkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 14:40:25 -0400
Received: from rune.pobox.com ([208.210.124.79]:52918 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbXJBSkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 14:40:24 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id F3B4A140564;
	Tue,  2 Oct 2007 14:40:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 163991405A5;
	Tue,  2 Oct 2007 14:40:39 -0400 (EDT)
In-Reply-To: <550f9510710020329m7917dc9m2bb6cfc4055fea84@mail.gmail.com> (Tom
	Clarke's message of "Tue, 2 Oct 2007 12:29:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59708>

"Tom Clarke" <tom@u2i.com> writes:

> So it's perhaps the question is whether rebasing should be treated as
> a kind of merging, or as an alternative to merging when pulling.
> Incidentally, are there any other cases other than pulling where using
> rebase as an alternative merge strategy is useful?

Very well put; I like concise summary of the point in a
discussion thread like this.

And the question in your last sentence is not merely incidental,
but I think is the most crucial one to decide which way we
should proceed.

I do not offhand think of a place other than "git pull" that
would make sense to sometimes be able to rebase when you
normally use merge, so I am inclined to say it would be easier
to teach that "'git pull' is usually a 'git fetch' followed by
'git merge', but in certain workflow it is handier to 'git
fetch' and then 'git rebase', and here are the ways to get the
rebasing behaviour...".
