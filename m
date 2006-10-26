X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: (unknown)
Date: Thu, 26 Oct 2006 15:22:44 +0200
Message-ID: <200610261522.44433.Josef.Weidendorfer@gmx.de>
References: <E1Gck2K-0003H4-00@dvr.360vision.com> <7v1wowm46j.fsf@assigned-by-dhcp.cox.net> <7vwt6okpgr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 13:23:02 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vwt6okpgr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30212>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5C9-0006sE-SJ for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423502AbWJZNWu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423510AbWJZNWu
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:22:50 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:1785 "EHLO
 tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1423502AbWJZNWu (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 09:22:50 -0400
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de
 [131.159.35.57]) by mail.in.tum.de (Postfix) with ESMTP id F24E02827; Thu, 26
 Oct 2006 15:22:44 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thursday 26 October 2006 00:20, Junio C Hamano wrote:
> Heh, I spoke too fast.
> 
> 	"git log origin..master"
> 
> If you do not have none of .git/origin

Really? I thought refs are always looked up in ".git/refs" only?

> , .git/refs/origin, 
> .git/refs/tags/origin, .git/refs/heads/origin, nor
> .git/refs/remotes/origin, then .git/refs/remotes/origin/HEAD is
> what "origin" means (see get_sha1_basic() in sha1_name.c).

Yes.

However, IMHO it really should be a alias to "remotes/origin/<branch>",
depending on current "<branch>" you are on. AFAI can remember,
when implementing it, HEAD was choosen as sha1_name.c should not
cope with porcelain issues (e.g. getting current branch name).
It was the intention to change remotes/origin/HEAD in the porcelain
command before actual use.

Is this still sensible?

