From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/6] Test environment of git-remote-mediawiki
Date: Wed, 13 Jun 2012 09:56:35 +0200
Message-ID: <vpqtxyfk5l8.fsf@bauges.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
	<1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 13 09:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeiRr-0003Y6-CS
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 09:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776Ab2FMH4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 03:56:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56716 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2FMH4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 03:56:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5D7lc94027476
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2012 09:47:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeiRR-0001bC-0G; Wed, 13 Jun 2012 09:56:37 +0200
In-Reply-To: <1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr>
	(Simon Cathebras's message of "Tue, 12 Jun 2012 23:12:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Jun 2012 09:47:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5D7lc94027476
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340178459.46412@LqEokYFPc6oAZm/mIiqNpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199878>

Simon Cathebras <simon.cathebras@ensimag.imag.fr> writes:

> +# Check the preconditions to run git-remote-mediawiki's tests
> +test_check_precond () {

This is a very generic name (with risk of name clash in future versions
of test-lib.sh). This checks the git-mediawiki preconditions, so how
about test_check_wiki_precond?

> +	if ! test_have_prereq PERL
> +	then
> +		skip_all='skipping gateway git-mw tests, perl not available'
> +		test_done
> +	fi
> +
> +	if [ ! -f $GIT_BUILD_DIR/git-remote-mediawiki ];

"" around $GIT_BUILD_DIR

But why $GIT_BUILD_DIR ? git-remote-mediawiki usually doesn't go there,
it is either as source in contrib/, or installed in the $PATH.

> +	then
> +		skip_all='skipping gateway git-mw tests, no remote mediawiki for git found' \
> +		'please try: cp git/contrib/mw-to-git/git-remote-mediawiki git/'

Don't you have a "make install" target for that now?

+	$CURR_DIR/test-gitmw.pl getallpagename

Here and elsewhere, "" around "$CURR_DIR"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
