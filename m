X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Mon, 11 Dec 2006 16:07:05 +0100
Message-ID: <200612111607.06046.Josef.Weidendorfer@gmx.de>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <200612111313.34292.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0612111432520.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 15:07:37 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Kyle Moffett <mrmacman_g4@mac.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612111432520.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34010>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtmka-0000MA-4I for gcvg-git@gmane.org; Mon, 11 Dec
 2006 16:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936372AbWLKPHV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 10:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936337AbWLKPHV
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 10:07:21 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:57690 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S936389AbWLKPHT (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 10:07:19 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 43D1920E9; Mon, 11
 Dec 2006 16:07:18 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 14:33, Johannes Schindelin wrote:
> On Mon, 11 Dec 2006, Josef Weidendorfer wrote:
> 
> > On Monday 11 December 2006 11:39, Andreas Ericsson wrote:
> > > > Import/export scripts literally require wrapping every single GIT 
> > > > command with a script that changes directory a few times, reads from a 
> > > > different checked-out tree, and permutes some extended-attribute data 
> > > > slightly before storing it in the underlying GIT tree.  Even without 
> > > > adding any new functionality whatsoever that doubles the amount of code 
> > > > just for finding your repository and checking command-line arguments, 
> > > > and that's a crazy trade-off to make in any situation.
> > > > 
> > > 
> > > GIT_DIR=/some/where/else/.git git log -p
> > 
> > Doing this everytime you want to run a git command *is* a lot of time
> > wasted for typing.
> > 
> > The .gitlink proposal would come in handy here: you have a simple
> > file instead of .git/, which links to the real repository.
> 
> I beg your pardon; I'm just joining in. Why is a symbolic link for .git 
> inacceptable?

You are totally right.

The .gitlink thing is tailored to allow submodule support later. It includes
some smart searching for the git repository to allow moving the checkout in
some limits without breaking the link to the repository.

Aside from this, the proposal is more flexible in that you can specify not
only GIT_DIR (or the GIT_DIR_HINT to trigger smart search), but also
GIT_INDEX_FILE and GIT_HEAD_FILE, which allows different checkouts
(with different index state and HEAD) for the same repo easily.

Which is not needed in this case.
So, sorry for the noise ;-)

