From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Tue, 06 Nov 2007 10:18:02 +0100
Message-ID: <4730314A.9010403@viscovery.net>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet> <Pine.LNX.4.64.0711052317170.4362@racer.site> <20071106091222.GE4435@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 10:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKZr-0006wZ-L6
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXKFJSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 04:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbXKFJSI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 04:18:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36757 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbXKFJSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 04:18:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IpKYy-0000bC-8d; Tue, 06 Nov 2007 10:17:36 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8BC0E54D; Tue,  6 Nov 2007 10:18:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071106091222.GE4435@artemis.corp>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63649>

Pierre Habouzit schrieb:
> Btw, I'm starting to work slowly on the diff_opt_parse conversion to the
> macro we discussed, and the need for new option parsing callbacks
> arised, and I've created a:
> 
>   parse_opt_mask_{or,and,xor} commands that you declare this way:
> 
>     OPT_MASK_OR('a', "all",         &mode, "...", MASK_ALL),
>     OPT_MASK_OR('i', "interactive", &mode, "...", MASK_INTERACTIVE),
>     ...
> 
> And if you chose MASK_ALL/INTERACTIVE/.. to be single bits,
> 
>     if (!!all + !!interactive ... > 1)
> 
> becomes[0]:
> 
>     if (mode & (mode - 1)) {
> 
>     }

This goes too far, IMHO. That's unnecessary cleverness/microoptimization at 
the expense of readability.

-- Hannes
