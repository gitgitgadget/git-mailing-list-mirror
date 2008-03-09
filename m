From: Iustin Pop <iusty@k1024.org>
Subject: Re: [PATCH 2/2] Fix git pull handling of the quiet option
Date: Sun, 9 Mar 2008 11:31:35 +0100
Message-ID: <20080309103135.GF32019@teal.hq.k1024.org>
References: <1205020356-6682-1-git-send-email-iusty@k1024.org> <1205020356-6682-3-git-send-email-iusty@k1024.org> <7v8x0ssfud.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 11:32:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYIpJ-0000jr-1f
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYCIKbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 06:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbYCIKbl
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:31:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:54063 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYCIKbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 06:31:40 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1467843fga.17
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 03:31:39 -0700 (PDT)
Received: by 10.82.174.20 with SMTP id w20mr9318404bue.14.1205058698635;
        Sun, 09 Mar 2008 03:31:38 -0700 (PDT)
Received: from teal.hq.k1024.org ( [84.75.117.152])
        by mx.google.com with ESMTPS id s10sm8788386muh.11.2008.03.09.03.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 03:31:37 -0700 (PDT)
Received: by teal.hq.k1024.org (Postfix, from userid 4004)
	id 267F840A040; Sun,  9 Mar 2008 11:31:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8x0ssfud.fsf@gitster.siamese.dyndns.org>
X-Linux: This message was written on Linux
X-Header: /usr/include gives great headers
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76647>

On Sat, Mar 08, 2008 at 08:04:26PM -0800, Junio C Hamano wrote:
> Iustin Pop <iusty@k1024.org> writes:
> 
> > Although git pull has a documented quiet option,...
> 
> I think that is a documentation bug.  pull accepts all options for fetch
> for the sole purpose of passing them intact to underlying fetch, and some
> options to fetch does not even make much sense in the context of pull.
> 
> Also options to pull needs to come first; the options pull does not know
> about is a signal for pull that the rest is for consumption of underlying
> fetch.
Ah, I see. This is indeed not clear from the documentation.

> If you want to teach --quiet to pull, however, your patch is the right
> approach.  pull would eat --quiet and make a note for itself, and passes
> that to underlying fetch (and perhaps merge).
> 
> You also need to sign-off your patch and add tests to make sure that other
> people will not break your enhancement in the future.
Thanks, so the approach would be:
  - resend git merge patch including tests
  - and then resend git pull patch, again including tests.

Thanks for the feedback, I will try to see how the unittests are written
and hopefully come back with some more patches.

iustin
