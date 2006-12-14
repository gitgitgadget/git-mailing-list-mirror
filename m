X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/1] Bypass expensive content comparsion during rename detection
Date: Thu, 14 Dec 2006 07:13:36 -0500
Message-ID: <20061214121336.GN1747@spearce.org>
References: <200612141126.kBEBQme7021704@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 12:13:50 +0000 (UTC)
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612141126.kBEBQme7021704@hera.kernel.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34330>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GupT6-0002W7-Lj for gcvg-git@gmane.org; Thu, 14 Dec
 2006 13:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932685AbWLNMNm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 07:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWLNMNm
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 07:13:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37786 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932685AbWLNMNl (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 07:13:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GupSw-0002CL-Iu; Thu, 14 Dec 2006 07:13:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D7C5820FB65; Thu, 14 Dec 2006 07:13:36 -0500 (EST)
To: Junio C Hamano <junio@hera.kernel.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junio@hera.kernel.org> wrote:
> estimate_similarity() is called after it has determined that one
> and two do not match exactly, and it relies on populate_filespec
> with at least size-only has been called on them so that it can
> reject filepair with vastly different sizes, still without
> looking at (thus without loading) the contents.

*ouch* That hurts.  OK, it makes a lot of sense, but its crazy.
About as crazy as the comment I put in my revised patch...  ;-)

-- 
