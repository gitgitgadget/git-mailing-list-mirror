From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 0/7] t5520: tests for --[no-]autostash option
Date: Mon, 04 Apr 2016 09:31:52 +0200
Message-ID: <vpqshz125jr.fsf@anie.imag.fr>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 09:32:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amyzk-0000af-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 09:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbcDDHcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 03:32:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51823 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbcDDHcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 03:32:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u347VqNG030822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 Apr 2016 09:31:52 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u347VqBm018260;
	Mon, 4 Apr 2016 09:31:53 +0200
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Sat, 2 Apr 2016 23:28:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 04 Apr 2016 09:31:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u347VqNG030822
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460359913.93604@E4V8QpsAmSeDQHlZ7keUYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290680>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> -test_rebase_autostash () {
> +test_pull_autostash () {
>  	git reset --hard before-rebase &&
>  	echo dirty >new_file &&
>  	git add new_file &&
> -	git pull --rebase --autostash . copy &&
> +	git pull $@ . copy &&

Not strictly needed here, but I'd write "$@" (with the double-quotes)
which is the robust way to say "transmit all my arguments without
whitespace interpretation".

I don't mind for this patch since there's no whitespace to interpret,
but some people (sysadmins ;-) ) have the bad habit of writting $@, $*
or "$*" in wrapper scripts and it breaks when you call them with spaces
so it's better to take good habits IHMO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
