From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2] run-command (Windows): Run dashless "git <cmd>"
Date: Tue, 29 Jul 2008 10:39:57 +0200
Message-ID: <1217320797.488ed75ddb14b@webmail.nextra.at>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de> <1217224228-31303-2-git-send-email-prohaska@zib.de> <1217277453.488e2e0db0f41@webmail.nextra.at> <7v8wvlmf6k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:41:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNklV-0008Ur-Tt
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYG2IkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbYG2IkF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:40:05 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:60420 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbYG2IkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:40:03 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp2.srv.eunet.at (Postfix) with ESMTPS id 324EDBEE1B;
	Tue, 29 Jul 2008 10:40:01 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6T8dvce028296;
	Tue, 29 Jul 2008 10:39:59 +0200
Received: from 77.118.250.127 ([77.118.250.127]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Tue, 29 Jul 2008 10:39:57 +0200
In-Reply-To: <7v8wvlmf6k.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.118.250.127
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90603>

Zitat von Junio C Hamano <gitster@pobox.com>:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
>
> > Zitat von Steffen Prohaska <prohaska@zib.de>:
> > ...
> >> The patch below might fix the problem by always calling 'bin/git'
> >> for builtin commands.  The computation in system_path() would
> >> always start from 'bin' and thus yields predictable results.  I
> >> am not sure however if it fully solves the problem because other
> >> code paths might run the dashed forms directly.
> >
> > This paragraph should go into the commit message.
>
> > ...
> > Your patches make a lot of sense.
>
> I was almost going to suggest doing this everywhere not just on Windows,
> but execv_git_cmd() on the POSIX side already runs "git" wrapper, so this
> patch makes them in line, finally.

For this reason I'm in favor of these patches. I didn't run the full test suite
with them, yet, (you know, that takes a while on Windows), but "make *clone*
*fetch* *pack*" worked out OK.

-- Hannes
