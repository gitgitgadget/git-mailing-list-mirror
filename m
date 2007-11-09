From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 09 Nov 2007 09:57:34 +0100
Message-ID: <473420FE.7010807@viscovery.net>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711090225110.4362@racer.site> <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Nov 09 09:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPgj-00007t-5q
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 09:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXKII5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 03:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXKII5j
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 03:57:39 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63312 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbXKII5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 03:57:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IqPfl-0001Sq-MS; Fri, 09 Nov 2007 09:57:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 266516C4; Fri,  9 Nov 2007 09:57:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64142>

Benoit Sigoure schrieb:
> Off topic question: why do you guys always do this instead of doing, 
> say, this:
> 
> INTERACTIVE=false
> 
> case $1 in
>   --interactive|-i)
>     INTERACTIVE=:
>     ... ;;
> esac
> if $INTERACTIVE; then
>   git_editor "$TODO" || die ...
> fi

Because in some shells 'false' is not a built-in.

But then this might do it without the extra process:

	INTERACTIVE="! :"	# false

	case $1 in
	--interactive|-i)
	    INTERACTIVE=:
	    ... ;;
	esac
	if $INTERACTIVE; then
	  git_editor "$TODO" || die ...
	fi

-- Hannes
