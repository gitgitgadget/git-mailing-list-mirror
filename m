From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Mon, 09 Mar 2015 13:36:41 +0100
Message-ID: <vpqk2yqcppi.fsf@anie.imag.fr>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
	<1425801532-8483-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 13:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUwvd-0007ks-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 13:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbCIMg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 08:36:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43246 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbbCIMg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 08:36:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t29Cae2V011799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Mar 2015 13:36:40 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t29CafCZ010915;
	Mon, 9 Mar 2015 13:36:41 +0100
In-Reply-To: <1425801532-8483-5-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Sun, 8 Mar 2015 15:58:52 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Mar 2015 13:36:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t29Cae2V011799
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426509402.63751@ptnjm/mARGok4bgPmNW2jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265161>

Paul Tan <pyokagan@gmail.com> writes:

> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index f61b40c..7fe832d 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -5,5 +5,97 @@ test_description='credential-store tests'
>  . "$TEST_DIRECTORY"/lib-credential.sh
>  
>  helper_test store
> +test_expect_success '~/.git-credentials is written to when xdg credentials file does not exist' '
> +	test -s "$HOME/.git-credentials"
> +'
> +test_expect_success 'xdg credentials file will not be created if it does not exist' '

We usually put a blank line between tests.

> +helper_test store

That seems a bit "brute force" to me to re-run all tests several times.
It's probably OK since the tests are quite fast though.

> +test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
> +	XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
> +	mkdir -p "$HOME/xdg/git" &&

I'd spell that "$XDG_CONFIG_HOME"/git instead, but that's not really
important.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
