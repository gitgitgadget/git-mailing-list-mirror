From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 23 Jun 2008 21:20:19 -0700
Message-ID: <7vtzfjea64.fsf@gitster.siamese.dyndns.org>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com>
 <1214183688-8544-1-git-send-email-LeWiemann@gmail.com>
 <200806231531.13082.jnareb@gmail.com> <485FE3F7.4040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 06:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB025-0004pS-Aw
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 06:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYFXEUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 00:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYFXEUd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 00:20:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYFXEUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 00:20:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 648D212329;
	Tue, 24 Jun 2008 00:20:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6BE2612328; Tue, 24 Jun 2008 00:20:27 -0400 (EDT)
In-Reply-To: <485FE3F7.4040102@gmail.com> (Lea Wiemann's message of "Mon, 23
 Jun 2008 19:57:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E20E0A2C-41A4-11DD-B2D8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85986>

Lea Wiemann <lewiemann@gmail.com> writes:

>> How it is different from PERL_PATH?
>
> Right, I didn't think of that.  PERL_PATH isn't available in the tests
> though, it's only used internally by the Makefile to generate (among
> other things) gitweb.cgi.  This means that while we can control under
> which Perl version gitweb.cgi runs, we cannot control under which Perl
> version the test suite runs (at least without $PATH trickery).  Does
> this bother us?
>
> If yes, I'd suggest we keep GITPERL but rename it to GIT_TEST_PERL,
> because that's what it's about.  If not, I'll rip it out and simply
> call 'perl' in the test shell script, whatever version it may be.

That sounds wrong, as the point of tests would be to make sure the stuff
you are going to install would work with what you thought will be used
from the system.

If "isn't available in the tests" is the problem, is it possible to make
it available?  We are passing down SHELL_PATH from primary Makefile to t/
and you should be able to do the same for Perl path...

About the Test::WWW:Mechanize::CGI thing, how widely available is it?  I
do not think it is packaged for Debian nor Ubuntu, for example.
