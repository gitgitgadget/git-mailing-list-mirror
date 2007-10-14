From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 14/14] Use the asyncronous function infrastructure to run the content filter.
Date: Sun, 14 Oct 2007 11:39:31 +0200
Message-ID: <200710141139.31410.johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <1192305984-22594-15-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0710140404480.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 11:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igzwm-0004cb-RW
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbXJNJjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754583AbXJNJje
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:39:34 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:48775 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbXJNJjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:39:33 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 4B81F10A929;
	Sun, 14 Oct 2007 11:39:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0FA4F58CE9;
	Sun, 14 Oct 2007 11:39:32 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0710140404480.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60820>

On Sunday 14 October 2007 05:07, Johannes Schindelin wrote:
> Hi,
>
> On Sat, 13 Oct 2007, Johannes Sixt wrote:
> >  	status = finish_command(&child_process);
> >  	if (status)
> > -		error("external filter %s failed %d", cmd, -status);
> > +		error("external filter %s failed", params->cmd);
>
> Did you mean to remove the status from the output (it should probably read
> "(exit status %d)" instead of just "%d", but an exit status can help
> identify problems, right?

Oops, that looks like an artefact. Will correct.

> > +	if (start_async(&async))
> > +		return 0;	/* error was already reported */
>
> Please write "return NULL;"

Will do.

-- Hannes
