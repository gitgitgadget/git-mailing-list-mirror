From: "Denis Bueno" <denbuen@sandia.gov>
Subject: Re: Git clone error
Date: Thu, 02 Aug 2007 09:08:56 -0600
Message-ID: <C2D74FA8.2C06%denbuen@sandia.gov>
References: <Pine.LNX.4.64.0708012211040.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcIk-0005LO-4e
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbXHBPJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755889AbXHBPJQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:09:16 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:3623 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbXHBPJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:09:15 -0400
Received: from [134.253.164.156] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Thu, 02 Aug 2007 09:08:57 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from ES21SNLNT.srn.sandia.gov ([134.253.164.104]) by
 ES23SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Thu, 2
 Aug 2007 09:08:57 -0600
Received: from 134.253.202.158 ([134.253.202.158]) by
 ES21SNLNT.srn.sandia.gov ([134.253.164.116]) with Microsoft Exchange
 Server HTTP-DAV ; Thu, 2 Aug 2007 15:08:57 +0000
User-Agent: Microsoft-Entourage/11.3.3.061214
Thread-Topic: Git clone error
Thread-Index: AcfVFwupSlgFhEEKEdyUkAAX8tQlcQ==
In-Reply-To: <Pine.LNX.4.64.0708012211040.14781@racer.site>
X-OriginalArrivalTime: 02 Aug 2007 15:08:57.0536 (UTC)
 FILETIME=[0C945400:01C7D517]
X-TMWD-Spam-Summary: TS=20070802150858; SEV=2.2.2; DFV=B2007080213;
 IFV=2.0.4,4.0-9; AIF=B2007080213; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230312E34364231463338412E303030432C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007080213_5.02.0125_4.0-9
X-WSS-ID: 6AAF2C034Q42574004-02-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54558>

On 08/01/2007 15:12, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
wrote:
>> How difficult would it be to create a new git repo which is exactly the same
>> minus the initial condor-uninstall.sh commit?  That is, just to pretend the
>> initial import of condor-uninstall.sh never existed, and use the second
>> commit of the old repo the first commit of the new, and preserve the rest of
>> the history of the entire repo?
> 
> That would be even easier.  Just graft "nothingness" as parent of the
> second commit:
> 
> $ git rev-parse <second-commit> >> .git/info/grafts

I must be misunderstanding:

    scripts[] > git fsck --full
    error: b28b949a1a3c8eb37ca6eefd024508fa8b253429: object corrupt or
missing
    missing blob b28b949a1a3c8eb37ca6eefd024508fa8b253429

    # b2... should fill in your <second-commit>?

    scripts[30] > git rev-parse b28b949a1a3c8eb37ca6eefd024508fa8b253429 >>
.git/info/grafts

    scripts[31] > git fsck --full
    error: b28b949a1a3c8eb37ca6eefd024508fa8b253429: object corrupt or
missing
    missing blob b28b949a1a3c8eb37ca6eefd024508fa8b253429

If I try to clone the repo, I get the same error.

                      Denis
--
"Program testing can be used to show the presence of bugs, but never to show
their absence." -- Edsger Dijkstra
