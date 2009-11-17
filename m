From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make sure $PERL_PATH is defined when the test suite is
 run.
Date: Tue, 17 Nov 2009 09:30:17 +0100
Message-ID: <4B025F19.1050809@viscovery.net>
References: <7v1vjym2oq.fsf@alter.siamese.dyndns.org> <1258417206-5406-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAJSP-0004Dn-B6
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 09:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbZKQIaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 03:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbZKQIaX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 03:30:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62340 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbZKQIaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 03:30:22 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NAJS6-0004fA-4X; Tue, 17 Nov 2009 09:30:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ABC5B10541; Tue, 17 Nov 2009 09:30:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1258417206-5406-1-git-send-email-book@cpan.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133076>

Philippe Bruhat (BooK) schrieb:
> --- a/Makefile
> +++ b/Makefile
> @@ -1633,6 +1633,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>  # and the first level quoting from the shell that runs "echo".
>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
> +	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >$@

Make it: ... >>$@

>  	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
>  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@

>  test_external_without_stderr \
>      'Perl API' \
> -    perl "$TEST_DIRECTORY"/t9700/test.pl
> +    $PERL_PATH "$TEST_DIRECTORY"/t9700/test.pl

This one needs the double-quotes as well.

-- Hannes
