From: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
Subject: Re: [PATCH] Make sure $PERL_PATH is defined when the test suite is
 run.
Date: Tue, 17 Nov 2009 01:17:01 +0100
Message-ID: <20091117001701.GB3608@plop>
References: <20091116234849.GA3608@plop>
 <1258415600-4656-1-git-send-email-book@cpan.org>
 <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:17:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABkx-0002bd-9S
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbZKQARD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZKQARC
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:17:02 -0500
Received: from mail-out3.booking.com ([91.195.237.20]:45602 "EHLO
	mail-out3.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbZKQARB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:17:01 -0500
Received: from corpds-102.ams4.corp.booking.com ([10.196.68.83])
	by mtx-101.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABkk-0002I9-0B; Tue, 17 Nov 2009 01:17:02 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-102.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABkj-0002R6-UO; Tue, 17 Nov 2009 01:17:01 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id B906CEF8005;
	Tue, 17 Nov 2009 01:17:01 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABkj-0001NL-Gl; Tue, 17 Nov 2009 01:17:01 +0100
Content-Disposition: inline
In-Reply-To: <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133044>

On Mon, Nov 16, 2009 at 04:10:13PM -0800, Junio C Hamano wrote:
> "Philippe Bruhat (BooK)" <book@cpan.org> writes:
> 
> > diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> > index 64f947d..dc710f8 100755
> > --- a/t/t9400-git-cvsserver-server.sh
> > +++ b/t/t9400-git-cvsserver-server.sh
> > @@ -20,7 +20,7 @@ then
> >      say 'skipping git-cvsserver tests, cvs not found'
> >      test_done
> >  fi
> > -perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
> > +$PERL_PATH -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
> >      say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
> >      test_done
> >  }
> 
> Shouldn't these $PERL_PATH all be quoted inside double-quotes?

I have no idea. I assume it's to protect against paths with a space in
them, so yes, probably.

Amending my patch and sending again.

-- 
 Philippe Bruhat (BooK)

 When you double-cross a friend, you triple-cross yourself.
                                     (Moral from Groo The Wanderer #8 (Epic))
