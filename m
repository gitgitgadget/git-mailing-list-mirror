From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Mon, 13 Aug 2007 09:22:24 -0400
Message-ID: <30e4a070708130622l7558230cpb870378aeba537fb@mail.gmail.com>
References: <1186952583887-git-send-email-mdl123@verizon.net>
	 <18111.39773.231609.306547@cargo.ozlabs.ibm.com>
	 <46BFAF8E.1000508@verizon.net> <46BFB908.7050000@gmail.com>
	 <18111.54668.327095.685366@cargo.ozlabs.ibm.com>
	 <30e4a070708130604g5b848b2fm4b42e145384c0ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mdl123@verizon.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 15:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKZsy-0005KO-Sc
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 15:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S972890AbXHMNWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 09:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S972886AbXHMNWa
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 09:22:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:55246 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S972839AbXHMNW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 09:22:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so569469ugf
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 06:22:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rvtIelUjfMAhmIQcvY4lf74YLEPtc1q01MEWw4MBRnFwEhKM/x6nG2BHjYhf+3SpivsA1Zin/YFU6/MEAfdA1TZNqxA87HUr27Tcz0z5U9HHz4qniasXI24tGxTslHvYcslMAk58XVBf7zPvEH+q1dZRyLSSO904DDV/Yz5deDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SV3oVmUuyheH9GKTVj1MvYoPeXEmdnLWJQV08M6oPGwwboPne/tx8ijbPUD8TKF8OO654+NIkKnYeFzaPTMBwfXjJ9aGb2Ga5WHxRjS4sD+VgOy/AlqxpGcTPtaXnKEc2zWwSAQ03hkngfaarK7GYEkfd1hO8fwaXiBuNQnf1wU=
Received: by 10.78.162.4 with SMTP id k4mr2172161hue.1187011344611;
        Mon, 13 Aug 2007 06:22:24 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Mon, 13 Aug 2007 06:22:24 -0700 (PDT)
In-Reply-To: <30e4a070708130604g5b848b2fm4b42e145384c0ba4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55763>

On 8/13/07, Mark Levedahl <mlevedahl@gmail.com> wrote:
> On 8/12/07, Paul Mackerras <paulus@samba.org> wrote:
> > It does load the full repository DAG - that's how it gets the
> > information for the Precedes:, Follows: and Branch(es): fields in the
> > commit display.  It's true that that can be turned off, though, and in
> > that case an "are you sure" dialog would be appropriate.
> >
> > Paul.
>

Double groan - I hit the wrong key (send rather than abort) with a
partially written incorrect message. Drat.

I was fooled as the "Precedes:" entry is blank if I do, for instance:
   git checkout -b foo master~1
   gitk
even though HEAD=foo which precedes master. However, master shows up
in the list of branches containing the commit. So yes, I see that gitk
has the full DAG available and could therefore generate a useful
warning when deleting a branch would leave dangling commits.

Mark
