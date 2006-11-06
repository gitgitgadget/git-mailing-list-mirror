X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git bug? + question
Date: Mon, 6 Nov 2006 12:05:41 +0100
Message-ID: <200611061205.42062.Josef.Weidendorfer@gmx.de>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <200611041852.23867.Josef.Weidendorfer@gmx.de> <20061104190512.GA2517@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 11:08:02 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <20061104190512.GA2517@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31008>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh2KQ-0004to-EL for gcvg-git@gmane.org; Mon, 06 Nov
 2006 12:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751963AbWKFLGd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 06:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWKFLGc
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 06:06:32 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:19337 "EHLO
 mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1751963AbWKFLGP (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006
 06:06:15 -0500
Received: from dhcp-2s-4.lrr.in.tum.de (dhcp-2s-4.lrr.in.tum.de
 [131.159.35.4]) by mail.in.tum.de (Postfix) with ESMTP id 4E365214D; Mon,  6
 Nov 2006 12:05:44 +0100 (MET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Saturday 04 November 2006 20:05, Shawn Pearce wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> >
> >  	git checkout origin/vmdvt
> > 
> > should create a new local branch refs/heads/vmdvt which forks
> > from remotes/origin/vmdvt (and abort with
> > error if refs/heads/vmdvt already exists without being the local
> > development branch for remotes/origin/vmdvt)
> 
> Yes, that would work for our workflow.  I won't try to speak about
> anyone else's.
> 
> I'd also say that if the local branch (refs/heads/vmdvt) exists and
> if `git pull . origin/vmdvt` is going to be a fast-forward that the
> fast-forward should happen during the checkout.  That way after the
> checkout is complete you really do have what is in origin/vmdvt,
> but are sitting on a local branch.

Hmmm... But you are changing the tip of a local development branch,
which is probably not always the thing we want.

Thinking about it, we should always error out if a proposed branch
name for a read-only branch already exists.

Josef

