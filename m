X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: More merge-recursive woes
Date: Wed, 13 Dec 2006 15:28:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131526180.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061213073639.GA9289@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 14:28:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061213073639.GA9289@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34220>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuV5w-0004Wk-BD for gcvg-git@gmane.org; Wed, 13 Dec
 2006 15:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964807AbWLMO2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 09:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWLMO2Z
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 09:28:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:46280 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964807AbWLMO2Y
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 09:28:24 -0500
Received: (qmail invoked by alias); 13 Dec 2006 14:28:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp028) with SMTP; 13 Dec 2006 15:28:22 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Shawn Pearce wrote:

> Bug #1: If one branch renames a file which existed in the merge base, 
> when we merge that change into a different branch the old version of the 
> file is not deleted from the working directory.  The attached test 
> script shows this ("BAD: A still exists in working directory").

You miss a ":" at the end of the test script, BTW.

This bug is fixed by your patch, which makes remove_file() update the 
working directory in the last stage.

> Bug #2: In that horrible repository that I have where I ran into the
> empty tree missing bug I now have a pair of commits which when merged
> together cause git-merge-recursive to go into an infinite loop,
> or least burn CPU for hours on end without doing squat.  I have
> not been able to get enough data to even write a good analysis
> of it yet.  I'll try to do that this week, as I cannot share the
> repository itself.  It just happens to be two new commits along
> the same two branches however.  :-(

Could you please send me the rev-list output for this test case?

Ciao,
