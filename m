From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] run-command: Redirect stderr to a pipe before redirecting
 stdout to stderr
Date: Wed, 05 Mar 2008 08:36:19 +0100
Message-ID: <47CE4D73.4050607@viscovery.net>
References: <20080305083516.e1a2a139.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	nanako3@bluebottle.com, pascal@obry.net,
	Xavier Maillard <xma@gnu.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWoBT-0001z4-RH
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 08:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbYCEHgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 02:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbYCEHgZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 02:36:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12941 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbYCEHgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 02:36:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWoA8-0004SA-W6; Wed, 05 Mar 2008 08:35:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A3CD86EF; Wed,  5 Mar 2008 08:36:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080305083516.e1a2a139.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76184>

Christian Couder schrieb:
> With this patch, in the 'start_command' function after forking
> we now take care of stderr in the child process before stdout.
> 
> This way if 'start_command' is called with a 'child_process'
> argument like this:
> 
> 	.err = -1;
> 	.stdout_to_stderr = 1;
> 
> then stderr will be redirected to a pipe before stdout is
> redirected to stderr. So we can now get the process' stdout
> from the pipe (as well as its stderr).
> 
> Earlier such a call would have redirected stdout to stderr
> before stderr was itself redirected, and therefore stdout
> would not have followed stderr, which would not have been
> very useful anyway.
> 
> Update documentation in 'api-run-command.txt' accordingly.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

FWIW:

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes

