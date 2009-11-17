From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] Make sure $PERL_PATH is defined when the test suite is
 run.
Date: Tue, 17 Nov 2009 09:35:57 +0100
Message-ID: <20091117083557.GC3608@plop>
References: <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
 <1258417206-5406-1-git-send-email-book@cpan.org>
 <4B025F19.1050809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:36:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAJXl-0006AB-OU
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 09:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZKQIf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 03:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbZKQIf5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 03:35:57 -0500
Received: from mail-out4.booking.com ([91.195.237.21]:43478 "EHLO
	mail-out4.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZKQIf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 03:35:57 -0500
Received: from corpds-102.ams4.corp.booking.com ([10.196.68.83])
	by mtx-102.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NAJXb-00086G-1F; Tue, 17 Nov 2009 09:35:59 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-102.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NAJXa-0003Iu-U8; Tue, 17 Nov 2009 09:35:58 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id B63A9EF80B5;
	Tue, 17 Nov 2009 09:35:58 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NAJXZ-0002sp-Kk; Tue, 17 Nov 2009 09:35:57 +0100
Content-Disposition: inline
In-Reply-To: <4B025F19.1050809@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133077>

On Tue, Nov 17, 2009 at 09:30:17AM +0100, Johannes Sixt wrote:
> Philippe Bruhat (BooK) schrieb:
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1633,6 +1633,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
> >  # and the first level quoting from the shell that runs "echo".
> >  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
> >  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
> > +	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >$@
> 
> Make it: ... >>$@

This proves late commits needs many extra pair of eyes. :-)

> >  	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
> >  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
> >  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
> 
> >  test_external_without_stderr \
> >      'Perl API' \
> > -    perl "$TEST_DIRECTORY"/t9700/test.pl
> > +    $PERL_PATH "$TEST_DIRECTORY"/t9700/test.pl
> 
> This one needs the double-quotes as well.

Thanks. Sending again. (sorry for the noise)

-- 
 Philippe Bruhat (BooK)

 "Did I err?"      (Groo, in too many issues to count - ...and *YES* he did!)
