X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Tue, 19 Dec 2006 01:59:58 +0100
Message-ID: <200612190159.58658.Josef.Weidendorfer@gmx.de>
References: <20061218091206.GA11284@spearce.org> <7virg9xcvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612182135360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 01:00:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612182135360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34777>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTL9-0005hk-1G for gcvg-git@gmane.org; Tue, 19 Dec
 2006 02:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932575AbWLSBAP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 20:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWLSBAO
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 20:00:14 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:52462 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S932575AbWLSBAN (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 20:00:13 -0500
Received: from dhcp-3s-52.lrr.in.tum.de (dhcp-3s-52.lrr.in.tum.de
 [131.159.35.52]) by mail.in.tum.de (Postfix) with ESMTP id E02B92819; Tue, 19
 Dec 2006 02:00:11 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Monday 18 December 2006 21:43, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 18 Dec 2006, Junio C Hamano wrote:
> 
> > 	$ git pull second
> > ...
> >  (3) branch.$current.merge was a mistake.  It should have been
> >      branch.$current.merge.$remote.  In other words, the
> >      configuration should have been about the current branch and
> >      the remote repository pair.
> > 
> >  (4) the current configuration mechanism is fine, but the code
> >      is not.  We should forbid "the first branch listed" rule
> >      from being applied for "git pull second", and require the
> >      users to explicitly say which branch(es) to merge.

> I fetch/merge criss-crossed over my machines, so this affects me. Until 
> the recent changes, I _always_ fetched/merged with explicit remote and 
> branch. This keeps me unconfused about what I actually do.
> 
> With the options you list, I'd say (3) with (4) as a fallback is the way 
> to go.

I agree.
Despite of this, I just sent out the quick fix.

> However, I would actually reuse our versatile (often hated?) config  
> handling:
> 
> [branch "xyz"]
> 	remote = blabla # this is the default remote
> 	merge = master # this is the default branch for the default remote
> 	merge = pu for remote second # merge 'pu' if pulling from second

Looks a little bit confusing, but is fine with me.
I even would remove the need for the word "remote" in the second merge line.
Anybody using this has to look it up in the documentation, anyway.
Because these options are not really self-describing.

Josef
