X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 12:49:39 -0500
Message-ID: <20061114174939.GB4299@spearce.org>
References: <20061114134958.5326.qmail@science.horizon.com> <200611141815.24236.jnareb@gmail.com> <20061114173657.GC5453@diana.vm.bytemark.co.uk> <200611141845.18930.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 17:50:04 +0000 (UTC)
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611141845.18930.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31357>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk2Pr-0008UA-E0 for gcvg-git@gmane.org; Tue, 14 Nov
 2006 18:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966223AbWKNRto convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 12:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966225AbWKNRto
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 12:49:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:17342 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S966223AbWKNRtn
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006
 12:49:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gk2Pe-0001XA-84; Tue, 14 Nov 2006 12:49:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2E7DF20FB0B; Tue, 14 Nov 2006 12:49:39 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Dnia wtorek 14. listopada 2006 18:36, Karl Hasselstr=F6m napisa?:
> >
> > For example, we could skip the "bisect" branch, since
> > you aren't supposed to commit to that anyway.
>=20
> Well, to have "branch" to which you could not commit, just put ref
> outside refs/heads.=20
>=20
> Another solution would be to be able to put non-head ref in HEAD,
> but allow to commit only if the prefix is refs/heads/

That's not a bad idea.  Then you can checkout a tag and have
'ref: refs/tags/v1.11' in HEAD, which means anyone who puts
$(git-symbolic-ref) calls into their PS1 will see "refs/tags/v1.11"
as their current branch, reminding them they are looking at the past.

Doing bisect branch in refs/bisect rather than refs/heads/bisect
would then likewise remind the user that they are bisecting, and
since neither matches refs/heads/* you cannot commit.

--=20
