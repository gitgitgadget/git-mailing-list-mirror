From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 10 Nov 2009 13:26:53 +0100
Message-ID: <4AF95C0D.90605@viscovery.net>
References: <1257850011-7544-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 13:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7poT-0000EJ-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 13:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbZKJM06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 07:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbZKJM06
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 07:26:58 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42680 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZKJM05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 07:26:57 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N7poD-0007tx-TD; Tue, 10 Nov 2009 13:27:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A2E50BC81; Tue, 10 Nov 2009 13:26:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1257850011-7544-1-git-send-email-book@cpan.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132562>

Philippe Bruhat (BooK) schrieb:
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index 64f947d..dc710f8 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -20,7 +20,7 @@ then
>      say 'skipping git-cvsserver tests, cvs not found'
>      test_done
>  fi
> -perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
> +$PERL_PATH -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {

Shouldn't this be "$PERL_PATH", i.e., double-quoted? (Ditto in the other
cases that you replaced.)

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f2ca536..54dd4d5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -730,6 +730,8 @@ esac
>  
>  test -z "$NO_PERL" && test_set_prereq PERL
>  
> +test -z "$NO_PERL" && test -z "$PERL_PATH" && export PERL_PATH=/usr/bin/perl

Wouldn't

   ... && export PERL_PATH=perl

be a safer fall-back?

-- Hannes
