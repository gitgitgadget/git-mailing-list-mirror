From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 14:43:36 +0200
Message-ID: <vpqhaeaasuf.fsf@anie.imag.fr>
References: <1377678752-16302-1-git-send-email-Matthieu.Moy@imag.fr>
	<521DD8EC.6050800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 28 14:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEf6B-0000WM-VD
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 14:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab3H1Mnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 08:43:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44136 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582Ab3H1Mnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 08:43:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7SChZt2006820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 14:43:35 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEf61-0006Gj-6d; Wed, 28 Aug 2013 14:43:37 +0200
In-Reply-To: <521DD8EC.6050800@viscovery.net> (Johannes Sixt's message of
	"Wed, 28 Aug 2013 13:03:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Aug 2013 14:43:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SChZt2006820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378298618.16443@Ok6OI84unvKvrzkz8WZQfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233184>

Johannes Sixt <j.sixt@viscovery.net> writes:

> How does your solution work when dirty submodules are involved and
> submodule status is included?f

Badly ;-).

I didn't notice the subcommand call for submodules summary. It's a bit
more tricky to get right, as the "git sumbodule summary --for-status"
call did not know whether it was called from commit or from status.

I fixed this by adding a --[no-]-display-comment-char to git submodule
summary.

>> +test_expect_success 'status with status.displayCommentChar=false' '
>> +	"$PERL_PATH" -pi -e "s/^\# //; s/^\#$//; s/^#\t/\t/" expect &&
>
> Perl's -i does not work on Windows when no backup file extension is given.
> Therefore, please use a temporary file or "... -pi.bak ..."

OK I didn't know that. I went the old good sed+mv way.

New series comming.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
