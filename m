From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 12 Nov 2013 21:43:57 +0100 (CET)
Message-ID: <20131112.214357.1022923291448967795.chriscool@tuxfamily.org>
References: <5281012D.4060708@op5.se>
	<20131112083240.GA1684@sigill.intra.peff.net>
	<xmqqy54timsm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, ae@op5.se, git@vger.kernel.org, apenwarr@gmail.com,
	Johannes.Schindelin@gmx.de, jrnieder@gmail.com, max@quendi.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 12 21:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKoj-00060t-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab3KLUoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:44:05 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:62278 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab3KLUoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:44:03 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 2242F65;
	Tue, 12 Nov 2013 21:43:58 +0100 (CET)
In-Reply-To: <xmqqy54timsm.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237736>

From: Junio C Hamano <gitster@pobox.com>
> 
> Even though we already added has_suffix() for tail matches, it is
> not too late to rethink, as it is not in 'master' yet.
> 
> One thing I noticed is that it is probably misnamed, or at least in
> a way that invites confusion.  Can people tell which one of these is
> correct without looking at existing callsites?
> 
>         has_suffix(filename, "txt");
>         has_suffix(filename, ".txt");
> 
> The semantics of the function we have is the latter and is better
> called endswith(), I suspect.  And the corresponding function to
> check for head matches should probably be called beginswith().

I don't know if has_suffix() is confusing for a native speaker.

After a look at some languages, Python has "startwith()" and
"endswith()", and Java has "startWith()" and "endsWith()".

So I agree that it is a good name. But while we are at it, why not
"ends_with()" and "begins_with()"? To me using an underscore seems
more consistent with what we are doing in Git.

Thanks,
Christian.
