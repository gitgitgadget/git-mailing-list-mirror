From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Thu, 25 Feb 2016 22:27:00 +0100
Message-ID: <vpqmvqo1nx7.fsf@anie.imag.fr>
References: <56CFBF19.6040004@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@zoho.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 22:27:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ3RR-0001mM-36
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 22:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbcBYV1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 16:27:17 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47499 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbcBYV1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 16:27:16 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1PLQwE1015827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 22:26:59 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1PLR0ZA026275;
	Thu, 25 Feb 2016 22:27:00 +0100
In-Reply-To: <56CFBF19.6040004@zoho.com> (Pranit Bauva's message of "Fri, 26
	Feb 2016 02:57:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 22:27:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1PLQwE1015827
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457040423.289@YBQEIykTFE4AjCxUteaXaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287440>

Pranit Bauva <pranit.bauva@zoho.com> writes:

> From c273a02fc9cab9305cedf6e37422e257a1cc3b1e Mon Sep 17 00:00:00 2001
> From: Pranit Bauva <pranit.bauva@zoho.com>
> Date: Fri, 26 Feb 2016 07:14:18 +0530
> Subject: [PATCH/RFC] git-commit: add a commit.verbose config variable

These should not appear in the body of your message, but they should be
the actual headers of your email. Try sending such message to yourself,
and compare with what you see on the list.

Using "git send-email" normally does the right thing. You may want to
look at https://submitgit.herokuapp.com/ too.

> The variable `verbose` is changed instead of `s.verbose` as the method
> run_status() updates the `s.verbose` with the value of `verbose`. So in
> this way the change is reflected in both of them.

The commit message should not try to rephrase what the patch aleady
says.

>     This is a patch for the microproject of GSOC 2016. I have done the change
>     under careful consideration of where to place the line. I have to yet write
>     the tests for this.

If you know you haven't finished, you may use WIP (work in progress)
instead of RFC in the title.

> +commit.verbose::
> +	A boolean to specify whether to always include the verbose option

Boolean is usually written with a capital letter.

> +	with git-config.

Did you mean "git commit"?

> +	of the commit message. If this option is used always, it can

"If this option is used always" does not sound right. I'd write "To
activate this option permanently, ..."

> +	be set in the git-config with the boolean variable `commit.verbose`.

"the git-config" is not proper English. You mean "a configuration file".
I'd write "the configuration variable `commit.verbose` can be set to
true".

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1644,6 +1644,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>  	s.colopts = 0;
>  
> +	git_config_get_bool("commit.verbose", &verbose);

Doesn't this override any value that --verbose or --no-verbose may have
set before?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
