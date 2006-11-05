X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Include -lz when linking git-daemon.
Date: Sat, 04 Nov 2006 23:14:25 -0800
Message-ID: <7vveluuzzi.fsf@assigned-by-dhcp.cox.net>
References: <20061105053615.GB4193@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:14:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061105053615.GB4193@spearce.org> (Shawn O. Pearce's message of
	"Sun, 5 Nov 2006 00:36:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30952>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgcDB-0005WY-7j for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161188AbWKEHO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWKEHO0
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:14:26 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32224 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1161188AbWKEHO0
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:14:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105071425.BSCE12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 02:14:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ivEW1V00E1kojtg0000000 Sun, 05 Nov 2006
 02:14:30 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Some platforms (Solaris in particular) appear to require -lz as
> part of the link line for git-daemon, due to it linking against
> sha1_file.o and that module requiring inflate/deflate support.

We once tried to stay away from linking sha1_file into daemon,
but it appears we were not successful.

Honestly speaking, I think SIMPLE_PROGRAMS outlived its
usefulness.  How about moving git-daemon to PROGRAMS list and
get rid of SIMPLE_ stuff from the Makefile?
