From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] git-branch -v: show the remote tracking statistics
Date: Wed, 02 Jul 2008 10:23:33 +0200
Message-ID: <486B3B05.4080006@viscovery.net>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net> <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org> <7vhcb8en92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxe3-0006PA-22
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770AbYGBIXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 04:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757375AbYGBIXk
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:23:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38467 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326AbYGBIXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:23:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KDxck-0006IJ-Vc; Wed, 02 Jul 2008 10:23:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B696C4FB; Wed,  2 Jul 2008 10:23:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcb8en92.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87100>

Junio C Hamano schrieb:
> This teaches "git branch -v" to insert the remote tracking statistics in
> the form of [ours/theirs] just before the one-liner commit log message
> for the branch.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   ... which means that you would see something like this.
> 
>   * jc/report-tracking        41666f7 [3/117] git-branch -v: show the remo...
> 
>   I did not think we want to spend extra columns to show the name of
>   remote branch each of them tracks, so I am showing only counts.

What makes the "tracking statistics" so useful, is that it explains the
situation in clear words. But here you throw in a few numbers without
explanation. It's practically undiscoverable what the numbers mean.
Therefore, I personally would prefer not to have them here and to save the
space for the commit summary.

What do you think about showing the tracking information only if --track
is supplied? But then even write more information:

* jc/report-tracking   41666f7 diverged 3 vs. 117
  foo                  1234567 behind 22
  bar                  fedcba9 ahead 6

and filter the output to show only tracking branches.

-- Hannes
