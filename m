From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: make test
Date: Mon, 15 Oct 2012 12:53:06 +0200
Message-ID: <507BEB12.9040101@viscovery.net>
References: <k5gov5$fe1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNiIZ-0004Mz-NG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 12:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab2JOKxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 06:53:11 -0400
Received: from so.liwest.at ([212.33.55.24]:58808 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab2JOKxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 06:53:10 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TNiIE-0001m7-K6; Mon, 15 Oct 2012 12:53:06 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 58BBF1660F;
	Mon, 15 Oct 2012 12:53:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <k5gov5$fe1$1@ger.gmane.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207732>

Am 10/15/2012 12:36, schrieb Joachim Schmitz:
> not ok 4 - pretend we have a known breakage # TODO known breakage
> 
>    This is expected, right?

Right.

>    the next is not though? Why might it be failing, where to check?
> 
> not ok - 12 tests clean up even on failures
> #
> #               mkdir failing-cleanup &&
> #...
> #               test_cmp expect out
> #               )
> #

First thing:

  ./t0000-basic.sh -v -i

and if that does not give sufficient clues,

  $SHELL_PATH -x ./t0000-basic.sh -v -i

(Beware, though: in some cases, the latter gives additional failures, in
particular, when the stderr of a command is checked for with test_cmp
instead of grep because the 'actual' results contain the shell command
logs, which are not in the 'expected' results.)

-- Hannes,
