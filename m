X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Mon, 27 Nov 2006 01:41:14 +0100
Message-ID: <200611270141.14307.Josef.Weidendorfer@gmx.de>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 00:41:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32373>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoUYs-000763-21 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 01:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753513AbWK0AlS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 19:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbWK0AlS
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 19:41:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:3502 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1753513AbWK0AlR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 19:41:17 -0500
Received: (qmail invoked by alias); 27 Nov 2006 00:41:15 -0000
Received: from p5496967F.dip0.t-ipconnect.de (EHLO noname) [84.150.150.127]
 by mail.gmx.net (mp036) with SMTP; 27 Nov 2006 01:41:15 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Saturday 25 November 2006 22:53, Junio C Hamano wrote:
>  - merging the "primary" branch is good only when the user is on
>    the corresponding "primary" branch.  It is usually a wrong
>    thing to do when on another branch.

I vote for a config option

 core.pull.stopWithoutDefaultMerge

which would error out on a

 git pull

when no branch.<current branch>.merge is set with a message like

 "No default remote branch set to merge into current branch <branch>.
  Set branch.<branch>.remote/merge to make this work"

It is arguable if this option should change the behavior of
"git pull <repo>". Probably not: I would assume that the
user explicitly wants to merge the primary branch of <repo>.

Additionally, set branch.<primary>.remote/merge on git-clone,
together with core.pull.stopWithoutDefaultMerge=1.

