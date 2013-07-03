From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/7] git-remote-mediawiki: Update tests to run with the new bin-wrapper
Date: Wed, 03 Jul 2013 11:18:49 +0200
Message-ID: <vpqobakrog6.fsf@anie.imag.fr>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-5-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jul 03 11:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJDJ-0002uq-QC
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342Ab3GCJS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:18:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47679 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261Ab3GCJS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:18:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r639Im3g012895
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 11:18:48 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UuJD7-0000q9-IE; Wed, 03 Jul 2013 11:18:49 +0200
In-Reply-To: <1372804789-12732-5-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Wed, 3 Jul 2013 00:39:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Jul 2013 11:18:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r639Im3g012895
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373447931.95489@09LNCuPWO2grlslJ6skHnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229475>

benoit.person@ensimag.fr writes:

> --- a/contrib/mw-to-git/t/test-gitmw-lib.sh
> +++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
> @@ -62,12 +62,8 @@ test_check_precond () {
>  		test_done
>  	fi
>  
> -	if [ ! -f "$GIT_BUILD_DIR"/git-remote-mediawiki ];
> -	then
> -		echo "No remote mediawiki for git found. Copying it in git"
> -		echo "cp $GIT_BUILD_DIR/contrib/mw-to-git/git-remote-mediawiki $GIT_BUILD_DIR/"
> -		ln -s "$GIT_BUILD_DIR"/contrib/mw-to-git/git-remote-mediawiki "$GIT_BUILD_DIR"
> -	fi
> +	GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd "../.." && pwd)
> +	PATH="$GIT_EXEC_PATH"'/bin-wrapper:'"$PATH"
>  
>  	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ];
>  	then

Cool!

I like the way adding a new feature has positive side effects on the
rest of the code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
